From: George Papanikolaou <g3orge.app@gmail.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect
 line-ending-like chars
Date: Sat, 22 Mar 2014 11:33:56 +0200
Message-ID: <CAByyCQAqZnnc91ZgmxdKgc7T0POLqd+iXmKvaKEPMOx6CNQkKQ@mail.gmail.com>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
	<CAPig+cTw8pyRVOHToGRPBdxv+TX8Vcj5OrX-CmLWRCigZRS4MA@mail.gmail.com>
	<CAByyCQBmCTfW0HBL04MMqwm+bDe4Rb6n+MfWdYUQ6M6yW_u=yw@mail.gmail.com>
	<CAPig+cTct-42w5S=OUS_DQ2cD5X9nWa_eUVoFBGTT7nAEahi5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 10:34:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRIJV-0003CB-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 10:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbaCVJd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 05:33:58 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:44507 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaCVJd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 05:33:57 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so3686694veb.29
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xDqoYP9rdPmSEonTdXfOXmjwsQASKEqPf2S0VyRcIyE=;
        b=axgUg6JkkdGcV3kgNzH/SL92nlkXb10HpI+5uola8uzg4QcN5uU5N6KtReJyqlUywC
         ZNcE8NGST9Zf1AmdkFBG9K/j81OSerVItRYyz2UyzI0iUfj/mUNdSuk/Qz9m/2bgWWht
         pZmtjU9IUM7ih3qFKk9wiUZdwmU/C1i0yfa9qY6+/PiOdtRVsZt2PPqmGtmK9GSGxNOW
         iLzXfhbapinhzpEbvZjD4di2HlysFQMEE106Kxg/rMIdJ6g7p+Pij5p5caT6ujd3VyxE
         uDgS9qPe6z1PUem3ebXl4zDwHCVHFYVUv0jFe6IQvVahIBvtSl8e7OconEyfXkaYnZKY
         7RVg==
X-Received: by 10.58.162.168 with SMTP id yb8mr20538508veb.9.1395480836226;
 Sat, 22 Mar 2014 02:33:56 -0700 (PDT)
Received: by 10.58.29.48 with HTTP; Sat, 22 Mar 2014 02:33:56 -0700 (PDT)
In-Reply-To: <CAPig+cTct-42w5S=OUS_DQ2cD5X9nWa_eUVoFBGTT7nAEahi5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244765>

On Sat, Mar 22, 2014 at 12:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Because it's unnecessary and invites confusion from people reading the
> code since they now have to wonder if there is something unusual and
> non-obvious going. Worse, the two loops immediately below the ones you
> changed, as well as the rest of the function, use plain isspace(),
> which really ramps up the "huh?"-factor from the reader.
>
> The original code has the asset of being clear and obvious. Changing
> these two loops to use a wide-character function makes it less so.
>

Yes I understand it does add a factor of ambiguity.

>
> Neither the function comment nor the existing code implies that it is
> checking for "any non-readable characters". (I'm not even sure what
> that means.) The only thing the existing code says at that point is
> that it is ignoring line-endings.
>

I mean characters that are not printable like letters, numbers, dots etc

>
> You're changing the behavior of the function (assuming I'm reading it
> correctly), which is why I asked if you verified that doing so was
> safe. The existing code considers "foo bar" and "foo bar " to be
> different. With your change, they are considered equal, which is
> actually more in line with what the function comment says.
> Nevertheless, callers may be relying upon the existing behavior.
>
> At the very least, the unit tests should be run as a quick check of
> whether if this behavior change introduces problems. Manual inspection
> of callers also wouldn't hurt.
>

I did not think about that possibility, because I ran `make` and the
tests passed so I thought that that would be ok.

Anyway, do you have any ideas on how to improve that function?

Thanks again for the feedback.

-- 
papanikge's surrogate email.
I may reply back.
http://www.5slingshots.com/I did not think about that possibility.
