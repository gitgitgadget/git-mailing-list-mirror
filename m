From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC2014] changed logical chain in branch.c to lookup tables
Date: Mon, 10 Mar 2014 18:39:05 -0400
Message-ID: <CAPig+cTOZrQY1azPCmzdrfut0S_-8ZDoob3cEqT7Z1kDpj+PQw@mail.gmail.com>
References: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
	<CAPig+cS3H_8gZOuyro_Vt0ay3xphvsB92zFgwFfCdgKsXjU0Gg@mail.gmail.com>
	<1394488063227-7605372.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Tamer TAS <tamertas@outlook.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 23:39:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN8qm-0002ij-UH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 23:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbaCJWjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 18:39:07 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:45678 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaCJWjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 18:39:06 -0400
Received: by mail-yh0-f52.google.com with SMTP id c41so1229569yho.25
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1rocsOGZLJQdFDZBFOAOwYgXIN1FNXoVoe/EMVmgWTY=;
        b=agnBUse2dMZJgomynK3qSm+dHD14KIp6Zz8afLTTij5V7cTuQW3thIT3RxF2xwrL9j
         K2Lk5/Cmz65LqmwXJVoh/+p0eJsKJqYxBTPx72Jaw2wGkjdWsJOuwf6JjoPj9uKT+JQP
         NMf/8fxY0MS5zYqnEP3DfbPXK50XncShMrYvTJc1nMG0qxijFTehyQ0i7hJmifctU2H8
         Yj9hnygcv3mzGhq95fNoz1jdtgHIZ93vLjOXBh54Z/WbetKhj6SMnbMRkd1nIq1RRZZ5
         a3yu/2wUD6wzDcBlglyEzRLSzUn3/PqIkjptaLGVe3FMWBrRCQXNDU3aknOUMrTVFuGz
         Cbyg==
X-Received: by 10.236.231.234 with SMTP id l100mr4760096yhq.135.1394491145465;
 Mon, 10 Mar 2014 15:39:05 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 15:39:05 -0700 (PDT)
In-Reply-To: <1394488063227-7605372.post@n2.nabble.com>
X-Google-Sender-Auth: gduCZAvpMx_Xp7Siozcqnpb2s5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243824>

On Mon, Mar 10, 2014 at 5:47 PM, Tamer TAS <tamertas@outlook.com> wrote:
> Eric Sunshine wrote
>> Even allowing internationalization of them (via N_() in the location[]
>> and type[] tables) might not be sufficient since grammatical rules
>> differ from language to language.
>
> I didn't fully understand what you meant by that. Since they were being
> internationalized before using _() in the if-else bodies, wouldn't it
> produce
> the same output if I were to use the same method for location[] and type[]
> tables?

In the original code, the person translating the text has the full context:

    "Branch %s set up to track remote ref %s."

With your revision, the translator has to translate standalone words
"local", "remote", "branch", "ref" without context about how they are
used. He then has to translate:

    "Branch %s set up to track %s %s %s."

without context of the words being inserted, which, depending upon
grammatical rules of the language can result in a different (and
perhaps worse) translation than the original full-context translation.

Section 4.3 of the GNU gettext manual [1] explains the issues in more
detail. I urge you to read it. The upshot is that translators fare
best when handed full sentences.

Note also that your change effectively reverts d53a35032a67 [2], which
did away with the sort of string composition used in your patch.

[1]: http://www.gnu.org/software/gettext/manual/gettext.html#Preparing-Strings
[2]: https://github.com/git/git/commit/d53a35032a67fde5b59c8a6a66e0466837cbaf1e
