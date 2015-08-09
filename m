From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 9 Aug 2015 13:45:45 -0400
Message-ID: <CAPig+cQvu82JzdDDBuzeTvhhEfhULky-q8D0OPqH-Nzmev_bdA@mail.gmail.com>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
	<CAPig+cRenkDWeQWR_QFvy_mrH=n5=hz6kaB3PMd_LLbPWN3U1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 19:45:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOUfP-0004hS-Lb
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 19:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142AbbHIRpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 13:45:47 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33795 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933105AbbHIRpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 13:45:46 -0400
Received: by ykdt205 with SMTP id t205so43299784ykd.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lpDfjkIrJ3mnFWFrxIiMYxi6N0FGOsefjEpVSyrjk1Q=;
        b=dlAFha//trbEeeyMu4tnf6MO2vdRQLULtv9hl26TuFccaexoByzXqYtDle9WEDK7MR
         8++esMZqb9nuaHrrG88sRZh6KlWWSXCnshI/of5yfh9YbLqXRKCkKzKdvQ31GX2w1aJH
         smlfoBYHGv9RCHwXPfKhrFfB0VzYVSr4zjIQMWAWIIbLEncGNH4eZ2zoZAHSSGWR6FN2
         UlnGQNXAqS9ixlJAu7yG0fFf06RyCdVobHd5DGmRF6UyMgVrk2FKZWsfMMivVhOSs/G/
         71P/LiyvfBZLizRqvHgh1KDLEoK3OO6QwwpMxJlNQFqM0i/1O9xYXFjB9P1WzSqd7WNE
         OrpQ==
X-Received: by 10.129.91.87 with SMTP id p84mr18076825ywb.95.1439142345862;
 Sun, 09 Aug 2015 10:45:45 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 9 Aug 2015 10:45:45 -0700 (PDT)
In-Reply-To: <CAPig+cRenkDWeQWR_QFvy_mrH=n5=hz6kaB3PMd_LLbPWN3U1g@mail.gmail.com>
X-Google-Sender-Auth: ta39rVwQDXm0iT5gZdJV6jCTF8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275554>

On Sun, Aug 9, 2015 at 1:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 2, 2015 at 2:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Aug 2, 2015 at 12:42 PM, Jan Viktorin <viktorin@rehivetech.com> wrote:
>>> @@ -1136,6 +1141,10 @@ sub smtp_auth_maybe {
>>>                 Authen::SASL->import(qw(Perl));
>>>         };
>>>
>>> +       if($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
>>> +               die "invalid smtp auth: '${smtp_auth}'";
>>> +       }
>>
>> Style: space after 'if'
>
> By the way, I notice that Authen::SASL::Perl implementation itself
> normalizes the incoming mechanism to uppercase, if necessary:
>
>     $mechanism =~ s/^\s*\b(.*)\b\s*$/$1/g;
>     $mechanism =~ s/-/_/g;
>     $mechanism =  uc $mechanism;
>
> Since it doesn't require uppercase, it's not clear how much benefit
> there is to adding a strict regex check to git-send-email.

Hmm, perhaps I was looking at the wrong chunk of code. You had already
referenced the real code here[1], and it doesn't appear to do any case
transformation (it only replaces "-" with "_").

[1]: http://article.gmane.org/gmane.comp.version-control.git/275161
