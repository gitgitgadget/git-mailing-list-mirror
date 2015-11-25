From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Wed, 25 Nov 2015 20:51:57 +0100
Message-ID: <CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org> <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:52:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1g7D-0008ET-5S
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 20:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbbKYTwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 14:52:30 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34668 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbbKYTw2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 14:52:28 -0500
Received: by lffu14 with SMTP id u14so73580509lff.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 11:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FwX5nPLZhSdJ9F4gk8gd9yDUq+ix8pwMK9jAUtEhju8=;
        b=tpwigmpBPWOp1Xp9i/EA3R18W8ldh4uu2sCacO/4laKtk44gJtg7XPnu3OeZjRaLLl
         NdgvnXsNy4YlKf9UIySLgK89wS/HswnX4fsNzYJlLBTHf3n4JYU85K2bwYVThLDbiZ7W
         hWdVteP5ayeFxprLAEtLjtgAeJ2rXMHNz9taD/XElQfZFQKu+Jm7J8HqyEklhm1ufQR4
         tqg8MuKLouqWXk+/ceToc4MojpL+tOIIHWa2BSguKNkZgHS18UIH3p/VF5DX/XYV7C6u
         ekBYmoortMvmm8zkWDwx73O0J6DrS29wZvnelb/G0RlpR/HgLCN6SgY2XYen9+SHdPTL
         Y7qA==
X-Received: by 10.112.171.74 with SMTP id as10mr15614369lbc.137.1448481146740;
 Wed, 25 Nov 2015 11:52:26 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 25 Nov 2015 11:51:57 -0800 (PST)
In-Reply-To: <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281735>

On Wed, Nov 25, 2015 at 10:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> On Wed, Nov 25, 2015 at 7:35 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> At Booking.com we know that mtime works everywhere and we don't
>> want the untracked cache to stop working when a kernel is upgraded
>> or when the repo is copied to a machine with a different kernel.
>> I will add tests later if people are ok with this.
>
> I bit more info: I rolled Git out internally with this patch:
> https://github.com/avar/git/commit/c63f7c12c2664631961add7cf3da901b0b=
6aa2f2
>
> The --untracked-cache feature hardcodes the equivalent of:
>
>     pwd; uname --kernel-name --kernel-release --kernel-version
>
> Into the index. If any of those change it prints out the "cache is
> disabled" warning.
>
> This patch will make it stop being so afraid of itself to the point o=
f
> disabling itself on minor kernel upgrades :)

The problem is, there's no way to teach git to know it's a "minor"
upgrade.. but if there is a config key to say "don't be paranoid, I
know what I'm doing", then we can skip that check, or just warn
instead of disabling the cache.

> A few other issues with this feature I've noticed:
>
>  * There's no way to just enable it globally via the config. Makes it
> a bit of a hassle to use it. I wanted to have a config option to
> enable it via the config, how about "index.untracked_cache =3D true" =
for
> the config variable name?

If you haven't noticed, all these experimental features have no real
UI (update-index is plumbing). I have been waiting for someone like
you to start using it and figure out the best UI (then implement it)
;)

>  * Doing "cd /tmp: git --git-dir=3D/git/somewhere/else/.git update-in=
dex
> --untracked-cache" doesn't work how I'd expect. It hardcodes "/tmp" a=
s
> the directory that "works" into the index, so if you use the working
> tree you'll never use the untracked cache. I spotted this because I
> carry out a bunch of git maintenance commands with --git-dir instead
> of cd-ing to the relevant directories. This works for most other
> things in git, is it a bug that it doesn't work here?

It needs the current directory at --untrack-cache time to test if the
directory satisfies the requirements. So either you cd to that
worktree, or you have to specify --worktree as well. Or am I missing
something?

>  * If you "ctrl+c" git update-index --untracked-cache at an
> inopportune time you'll end up with a mtime-test-XXXXXX directory in
> your working tree. Perhaps this tempdir should be created in the .git
> directory instead?

No because in theory .git could be on a separate file system with
different semantics. But we should probably clean those files at ^C.

>  * Maybe we should have a --test-untracked-cache option, so you can
> run the tests without enabling it.

I'd say patches welcome.

> Aside from the slight hassle of enabling this and keeping it enabled
> this feature is great. It's sped up "git status" across the board by
> about 40%. Slightly less than that on faster spinning disks, slightly
> more than that on slower ones.

I'm still waiting for the day when watchman support gets merged and
maybe poke Facebook guys to compare performance with Mercurial :)
Well, we are probably still behind Mercurial on that day.

Also, there's still work to be done. Right now it's optimized for
whole-tree "git status", Doing "git status -- abc" will not benefit
from untracked cache, similarly "git add" with pathspec..
--=20
Duy
