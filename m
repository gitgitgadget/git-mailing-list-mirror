From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sat, 18 May 2013 22:42:29 -0400
Message-ID: <CAPig+cRtdtqyh5=ENf9UrfTOUtzL2Ut+neXRJqRBFgVKxObyiw@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 04:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdtaE-00089I-81
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 04:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3ESCme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 22:42:34 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:40193 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3ESCmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 22:42:33 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so5422218lab.37
        for <git@vger.kernel.org>; Sat, 18 May 2013 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=qiIb2GY7/mAv5VgL6ByvjyHrcxWHxmUNuWhuPEwfAQA=;
        b=dKTaiVKQ1stcH59kcTvEMpDeyD6C/pJxrPE64Me70HBiyHlqAB9leFLEzFciWmn8wL
         F/6IearvuInuH6yXHsodxL+JE9tkJvH43rN12Ibnm1DSW8FoH1jhq6qtJyRiCqE9X1LR
         gqdfQEZ9uJQ0CuPo3Iu9X8Zya4G/JTT1/Wppjty8FOx6x54/vcdJgFCoSB4wwCTFKke5
         B9LJQ9r0zT2NW/dPKUlQtXZVU+t885C/4GP/U+bASHE+IQgQcky7CycGbDuqvM/KiL24
         6L1oKUJeI/0qd8tl6pyi8Pw41Z8cYWhnDtgX6oX5RlqYEQyED3uiw83b73rr/eDqQtQr
         ZrNg==
X-Received: by 10.112.157.231 with SMTP id wp7mr17582195lbb.91.1368931349545;
 Sat, 18 May 2013 19:42:29 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sat, 18 May 2013 19:42:29 -0700 (PDT)
In-Reply-To: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: bp8U7dxDMp8trUUmsWAY_xicIDY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224815>

On Fri, May 17, 2013 at 10:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> When the user has an upstream branch configured to track a remote
> tracking branch:
>
>   % git checkout --set-upstream-to github/master
>
> Doing a 'git fetch' without any arguments would try to fetch 'github',
> because it's configured as current branch's remote
> (branch.<current>.remote).
>
> However, if we do something slightly different:
>
>   % git checkout --set-upstream-to master
>
> Doing a 'git fetch' without any arguments would try to fetch the remote
> '.', for the same reason.
>
> But, unlike the in the first instance, the second command would not
> update any remote tracking branch, in fact, it would not update any
> branch at all. The only effect is that it would update FETCH_HEAD.
>
> FETCH_HEAD is a special symbol that is used to store the result of a
> fetch. It can be used by other commands of git, specially 'git merge'.
>
> It is however, barely mentioned in the documentation, and can be
> considered a plumbing concept at best, that few Git users would benefit
> from using, and indeed, quite likely very few use it, or are even aware
> of it.
>
> So when the user is presented with a message like this:
>
>   % git fetch
>   From .
>    * branch            master     -> FETCH_HEAD
>
> The vast majority of them would have absolutely no idea what's going on.
> Many of them would probably just shrug, and manually specify the remote
> the want to fetch from, which is 'origin' in many cases.

s/the/they/

> If the user has say, twenty branches, ten with a local upstream
> (branch.<name>.remote = '.'), and ten without an upstream. The user
> might get used to typing 'git fetch' and expect Git to fetch from
> 'origin' which would happen 50% of the time, but the other 50%, the user
> would be forced to specify the remote.
>
> This inconsistency would be simply one more to join the list of
> incomprehensible quirks the user has to put up when using Git, so quite

s/up/up with/

> likely (s)he simply gets used to it, only to complain later in forums or
> social media, outside of the dwelling distance of the typical Git
> developer.
>
> But we can do better.
>
> We can add a new 'fetch.default' configuration variable (one more to
> join the many necessary to force Git to behave in sane manner), so the
> user can specify what (s)he wants to be performed when the remote is not
> specified in the 'git fetch' command.
>
> This configuration would probably be welcome by 99% of the user
> population, who have no clue what FETCH_HEAD is, and do set local
> upstream branches, only to find out weird inconsistent behavior
> depending on which branch the happen to be sitting at.

s/the/they/

> We add documentation and testing as expected, and also introduce other
> changes necessary to make the configuration enter into effect when it's
> needed.
>
> The default (FETCH_DEFAULT_UNSPECIFIED), allows the current behavior to
> be unmodified, so remote_get(NULL) is called, and the current rules to
> determine the default branch remain.
>
> The new option "simple" allows Git to always fetch from "origin", which
> is what most users would expect, and it's 100% consistent.
>
> Alternatively, the user can manually specify the current behavior with
> "current" (alluding to the current branch), so that the behavior changes
> depending on which branch the user happens to be sitting at. This would
> allow the user to retain this behavior, if (s)he so wishes,
> in case Git developers regain their sense and set a default that most
> users would appreciate ("simple").
>
> If the user wants, for whatever strange reason swimming in his/her head,
> (s) can still fetch from a local ('.') remote (even stating that as an

s/(s)/(s)he/

> English sentence doesn't make any sense).
>
>   % git fetch .
>   From .
>    * branch            master     -> FETCH_HEAD
>
> And to any number of weird hacks with FETCH_HEAD.
>
> The average user lucky enough to find the 'fetch.default' configuration,
> however, would never have to enter the word of "local remote"
> strangeness, and would remain comfortably in the place where locals are
> locals, and remotes are remotes, and 'git fetch' is always consistent,
> and always does something useful.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
