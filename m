From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: repository of handy git aliases?
Date: Fri, 19 Aug 2011 16:15:37 +1000
Message-ID: <CAH3AnrpBE+xDfQ=mPDcFRx+C+b9SHS7T9njA8A6Xu4m82vu1Xw@mail.gmail.com>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com>
	<CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com>
	<CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com>
	<CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
	<4E4A76E7.2090100@drmicha.warpmail.net>
	<CAH3AnrpahkHtnu5QTRns-vVcCoj3Q8JM-mzytYF2ZC_EXjU7Xw@mail.gmail.com>
	<4E4D3281.2050600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 08:15:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuIMq-000402-Lh
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 08:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab1HSGPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 02:15:39 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56261 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab1HSGPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 02:15:38 -0400
Received: by vxi9 with SMTP id 9so2353895vxi.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dh+g8oLYDYOc5r7ZQRc3wGJw94FcWJ+SDCFGb+GQtFw=;
        b=QVJ+dlUSoazMaLyIkObtBS52/bmuW9ZjLPYZUUKjk1ozG3wxrQVYEFCq0K1IVyKuRB
         vInjsuumHStGaBc2PWo+u8oMDudGxwAcEanI0KvkyPttQJSPdSChoWlU6DDld+9dAwBW
         DPzxHmSx3NA/vQ79wnc4ehg5pBPaj4FVyi9AU=
Received: by 10.52.19.139 with SMTP id f11mr1716284vde.131.1313734537739; Thu,
 18 Aug 2011 23:15:37 -0700 (PDT)
Received: by 10.52.181.97 with HTTP; Thu, 18 Aug 2011 23:15:37 -0700 (PDT)
In-Reply-To: <4E4D3281.2050600@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179680>

On Fri, Aug 19, 2011 at 1:40 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Is this a typo or do you have an xargs which understands "1m"? My point
> was that you can feed all tips to "log" at once, as long as you don't
> exceed the argument list limits, of course.

Yeah, meant -L1, not -L1m.

Ok, so you are suggesting something like: git oneline $(git tips
origin/pu ^ origin/next) instead of

    git tips origin/pu ^origin/next | git oneline

I guess it comes down to a preference thing, but it is good to know
that with --no-walk I can do it either way, so thanks!

Here's a alias definition for oneline that does it both ways,
depending on preference...

[alias]
        oneline ="!_() { if test $# -eq 0; then xargs -L1 git log
--no-walk --decorate --oneline; else git log --no-walk --decorate
--oneline \"$@\"; fi; }; _"

>>
>> Not sure what you mean by not being standard? The main idea about
>> using --decorate here is to get a dump of any refs that might describe
>> the identified tips.
>
> Just compare your output with this:
>
> git log --decorate --no-walk --oneline origin/{master,next,pu}
> a46e511 (origin/pu) Merge branch 'fg/submodule-git-file-git-dir' into pu
>
> 0e3f8f0 (origin/next) Merge branch 'master' into next
>
> 4bfe7cb (origin/master, origin/HEAD) Sync with "maint"
>
> That is, I get the branch decorations there; you use the same format but
> don't get any. But I may be misunderstanding completely what you are
> trying to achieve. I guess I have to reread your extended use case
> description...
>

Ok, so the only reason my output didn't show any tags is that there
didn't happen to be any.

With a local integration branch, there usually will be local
references that explain each tip. So, for example, git tips master for
me currently shows:

git tips master | git oneline  shows:

f85a051 (kernel/master) Update draft release notes to 1.7.7
9e90d12 (refactor) rename auto-edit -> refactor.
e586f2e (gitwork-dist) Regenerate git-work.zip
dbb64d9 (tag: gitwork-v0.0.11, public/gitwork, gitwork) git-work:
update documentation.
272277f (bisect-gettextln) bisect: take advantage of gettextln, eval_gettextln.

So this does show helpful decorations. The reason git tips origin/pu
^origin/next | git oneline doesn't show any decorations is simply
because I don't have any tags or branches that represent those tips -
Junio presumably does, for example.

Note also that git tips doesn't show merge commits.

The best way to understand what git tips does is to do this:

     gitk origin/pu ^origin/next --no-merges

The commits reported by git tips are the tips of each linear stream of
development you see in gitk.

jon.
