From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sun, 19 May 2013 07:15:33 -0500
Message-ID: <CAMP44s1rV+Pe_58qZLvTDt-r7XkDAinh3npY-dr+W5vnfNk4NA@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com>
	<CAMP44s3pZYw87awogjjOdFRP39Ou0=td2erhV2-aC-9_A_Z75A@mail.gmail.com>
	<CALkWK0nQzEK6-E7aMnGg6eYZJ_=XsE6FBmRgu9_8jBGkYmJe+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:15:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Wa-00066z-8f
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab3ESMPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:15:35 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38069 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab3ESMPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:15:35 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so5741166lbd.34
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9uWuZGMaYPsSGCF44iIycmavL/hyen5/yh6rZNib0D4=;
        b=HEJvekW5jaK6lmo0CD/enTROwegDJ0tJZKIFd5HWOWl2v1SBsiLFJJwqmF5qf0k1Q3
         stZvOYJrkG86BQuRfZfGDR3h29/mzPWlGPj9guZiKFq2MwnCKosnGU0eibh3PtcR0OZL
         Qm9nsYl/52IIu0vhxnJ4IQwcZUM0Ap48sXG3fvPK+avGga0VGlKFW8RJZlc+MOJJmsiq
         KMF+cvwDWp6U37wvbcTGUmECJ83GtLe0ARxprBpopXQs1HS4ia5vHaebkzDp0Qd/9Fzn
         DgjREmByOaXb8CuwLPT5wxCJAV5YB999rkBlKtRHd2vkr72/5hgk46cVkAyahgNiTfjP
         A2Tw==
X-Received: by 10.112.163.71 with SMTP id yg7mr16313634lbb.8.1368965733219;
 Sun, 19 May 2013 05:15:33 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 05:15:33 -0700 (PDT)
In-Reply-To: <CALkWK0nQzEK6-E7aMnGg6eYZJ_=XsE6FBmRgu9_8jBGkYmJe+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224880>

On Sun, May 19, 2013 at 6:51 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> % git checkout fc/remote/hg-next
>> % git rebase -i # rebase to master
>> % git checkout fc/remote/hg-notes
>> % git rebase -i # rebase to fc/remote/hg-next
>> % git checkout fc/remote/hg-gitifyhg-compat
>> % git rebase -i # rebase to fc/remote/hg-notes
>
> So it is rebase, but rebase.defaultUpstream = origin won't suffice.
> You want to specify a custom base.  What I don't understand is why
> you're abusing @{u},

There's no abuse; 'upstream' is meant *exactly* for this: rebase, and pull.

It's called upstream because that's where eventually all the code must
go, so semantically it's *exactly* correct: 'origin/master' is the
upstream of 'master' which is the upstream of 'fc/remote/hg-next',
which is the upstream of 'fc/remote/hg-notes', and so on.

And if I where to merge a branch from 'master', it make sense that the
default is 'origin/master', because that's the upstream.

Literally each and every way in which 'upstream' is used remains the
same for local branches, except for 'git push'.

> and crippling remote (by hard-interpreting it as
> "origin") to achieve this.

More false rhetoric; "origin" is *ALREADY* the default.

Show me the output of these:

%git clone --origin foobar git://git.kernel.org/pub/scm/git/git.git /tmp/git
%cd /tmp/git
%git fetch -v
%git checkout --no-track -b test master
%git fetch -v

> For the record, I didn't think your
> branch.<name>.base was a bad idea at all (re-visiting now).

It makes sens for rebase, but what happens when you do 'git pull' and
you don't have an upstream configured, only a base? Why would you want
'git pull' to fail? In which instances would you want to have a
'base', but not an 'upstream'?

Think about it.

-- 
Felipe Contreras
