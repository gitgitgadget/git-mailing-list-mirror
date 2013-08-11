From: Andres Perera <andres.p@zoho.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 19:01:07 -0430
Message-ID: <CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
	<CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
	<20130811180915.390d660a@sh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 01:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8f6l-0007HJ-S7
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 01:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab3HKXbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 19:31:10 -0400
Received: from mail-vb0-f42.google.com ([209.85.212.42]:47776 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab3HKXbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 19:31:08 -0400
Received: by mail-vb0-f42.google.com with SMTP id e12so5343209vbg.29
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EqBX1rjqb2twWfFfYkS9Q2FVlcIyzgP+1djyoAf/cTk=;
        b=eFI9HPam+OaZBmMMhtfzIBXoYDZ7cWWThssbJiQ3i3zt3XR4tjFE8poOjepu+cGnt+
         u+hAmr68sY/CH+mNyWM0RnLTf+ETu3daw90Jf1WvpJm/RVTGhnbd7FWCEa8JIqARzAcA
         MkguV8+FSvzG9zUirp/DmSiHQ9Io78mJsjvq3J/9sUiPJvocA9axmSfkcoI1xk32ag3I
         JtUPBzhKe95FVAGj4k63xy2iOIDM5eIkkG8GU4ZOprOW+hYZ1sJvpNWK9pbaJVA/ncB6
         eC/TeUjudSOf3YnMZVvsQhY0GaK2IUdcj1iKmzyn9ETqj098orDbfCJMNFwE0Mq73lzN
         pTgw==
X-Received: by 10.52.175.232 with SMTP id cd8mr8587770vdc.84.1376263867226;
 Sun, 11 Aug 2013 16:31:07 -0700 (PDT)
Received: by 10.58.207.110 with HTTP; Sun, 11 Aug 2013 16:31:07 -0700 (PDT)
In-Reply-To: <20130811180915.390d660a@sh9>
X-Google-Sender-Auth: i0UGA0JFrWlyZid-Hw-gjH-3ghM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232144>

On Sun, Aug 11, 2013 at 6:39 PM, Stephen Haberman
<stephen@exigencecorp.com> wrote:
>
>> 1. i'm not sure why you are testing $3 == preserve. it looks like a
>> typo
>
> Yes, good catch. I've added a test that fails, and will fix that.
>
>> 2. clearer than a string of yoda conditions:
>>
>> case $2 in
>> true|false|preserve)
>
> Makes sense, will change.
>
>> 1. in the error message you say that rebase should be a trystate of
>> true, false, or preserve. why then do you allow $rebase == '' ?
>
> Because it may be unset, like if the user ran "git pull . copy" and
> the pull.rebase setting was not set.
>
>> 2. clearer than a string of yoda conditions:
>
> Will change again.
>
> I'll wait to see if I get any more feedback and then will send out
> another version.

i just realized that there are ambiguities:

pull -r (true|false|preserve) foo

there are 2 ways to interpret this:

pull --rebase=(true|false|preserve) foo # pull from remote named foo

pull --rebase (true|false|preserve) foo # pull from remote named
(true|false|preserve), branch foo

options with optional operands usually require that the operands be
concatenated with the option argument, so that

pull --rebase[=(true|false|preserve)] | -r[(true|false|preserve)]

avoids the ambiguity of

pull --rebase [(true|false|preserve)] | -r [(true|false|preserve)]

1. you can make it a disambiguation by appending ? to the optspec
(according to man git-rev-parse)

2. you could also disambiguate by testing if the argument is a
configured remote and warn the user, but this makes option parsing
inconsistent, requires additional logic, and is overall inelegant

>
> Thanks!
>
> - Stephen
>
>
>
