From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Thu, 26 Nov 2015 06:21:40 +0100
Message-ID: <CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
	<CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
	<CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 06:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1p07-0004KF-ER
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 06:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbbKZFVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2015 00:21:44 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34054 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbKZFVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2015 00:21:42 -0500
Received: by lffu14 with SMTP id u14so84764340lff.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 21:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CjWRy4ONBLyy4TX5707Vcd4dSkfYe/r4+CaVweujn4Y=;
        b=TC3SF6bZ7F200Wz6s2A3sE6NpDsk/x9ILe+G2qK5KnjKMtGZh/z6gHvITfq8lUAeYe
         l0qdNJoJjFpQQX89ZnmjVgMybfUCARiHbRW2mCe2LJBhWuVDhDXBZrQx8JAW3y2wOzdY
         h+/gB0N/W/bE4LA90CuZkEdzlzcIMol9T0vlFE3Fih3hdT+wfKXnzKK7pb/7Y6bz1YIp
         2RE5un4vMENtfzdd0x0ViZF5z1zmzudAKpKQPZfzHQm9tEpdyH1DvVx3jlp+wl1sGrdw
         qoICy9DjmNesFNYAycyFIWLzqxJfEq8R0RoOi01ECXpqxh00A7EoQU6200Fcf4qQYa5O
         1+GA==
X-Received: by 10.112.39.5 with SMTP id l5mr16558711lbk.101.1448515300878;
 Wed, 25 Nov 2015 21:21:40 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 25 Nov 2015 21:21:40 -0800 (PST)
In-Reply-To: <CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281757>

Hi Duy,

On Wed, Nov 25, 2015 at 8:51 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Nov 25, 2015 at 10:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:
>> On Wed, Nov 25, 2015 at 7:35 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> At Booking.com we know that mtime works everywhere and we don't
>>> want the untracked cache to stop working when a kernel is upgraded
>>> or when the repo is copied to a machine with a different kernel.
>>> I will add tests later if people are ok with this.
>>
>> I bit more info: I rolled Git out internally with this patch:
>> https://github.com/avar/git/commit/c63f7c12c2664631961add7cf3da901b0=
b6aa2f2
>>
>> The --untracked-cache feature hardcodes the equivalent of:
>>
>>     pwd; uname --kernel-name --kernel-release --kernel-version
>>
>> Into the index. If any of those change it prints out the "cache is
>> disabled" warning.
>>
>> This patch will make it stop being so afraid of itself to the point =
of
>> disabling itself on minor kernel upgrades :)
>
> The problem is, there's no way to teach git to know it's a "minor"
> upgrade.. but if there is a config key to say "don't be paranoid, I
> know what I'm doing", then we can skip that check, or just warn
> instead of disabling the cache.

Yeah, in my patch if core.trustmtime is set to true or false the check
is skipped.

I am wondering why you didn't make it by default run the mtime checks
when a kernel change is detected. Maybe that would be better than
disabling itself.

>> A few other issues with this feature I've noticed:
>>
>>  * There's no way to just enable it globally via the config. Makes i=
t
>> a bit of a hassle to use it. I wanted to have a config option to
>> enable it via the config, how about "index.untracked_cache =3D true"=
 for
>> the config variable name?
>
> If you haven't noticed, all these experimental features have no real
> UI (update-index is plumbing). I have been waiting for someone like
> you to start using it and figure out the best UI (then implement it)
> ;)

Ok, we are happy to do that (including implementing it) :-)

I will take a look at something like index.untracked_cache. It will
probably also be a tristate like this:

- true: always enable it; die if core.trustmtime is false otherwise
warn if it is not true
- default/unset: same as current behavior
- false: die if it is enabled or when trying to enable to it

>>  * Doing "cd /tmp: git --git-dir=3D/git/somewhere/else/.git update-i=
ndex
>> --untracked-cache" doesn't work how I'd expect. It hardcodes "/tmp" =
as
>> the directory that "works" into the index, so if you use the working
>> tree you'll never use the untracked cache. I spotted this because I
>> carry out a bunch of git maintenance commands with --git-dir instead
>> of cd-ing to the relevant directories. This works for most other
>> things in git, is it a bug that it doesn't work here?
>
> It needs the current directory at --untrack-cache time to test if the
> directory satisfies the requirements. So either you cd to that
> worktree, or you have to specify --worktree as well. Or am I missing
> something?

Maybe it could print out a message saying "Testing mtime in directory
$(pwd)" and if that works then "Untracked cache is enabled for
$(pwd)". That would make it clear that it will not work in other
directories.

Also maybe the mtime checks could be run when a directory change is det=
ected.

>>  * If you "ctrl+c" git update-index --untracked-cache at an
>> inopportune time you'll end up with a mtime-test-XXXXXX directory in
>> your working tree. Perhaps this tempdir should be created in the .gi=
t
>> directory instead?
>
> No because in theory .git could be on a separate file system with
> different semantics. But we should probably clean those files at ^C.

Ok, I will have a look at cleaning the files at ^C.

>>  * Maybe we should have a --test-untracked-cache option, so you can
>> run the tests without enabling it.
>
> I'd say patches welcome.

Ok, I wll have a look at that too.

>> Aside from the slight hassle of enabling this and keeping it enabled
>> this feature is great. It's sped up "git status" across the board by
>> about 40%. Slightly less than that on faster spinning disks, slightl=
y
>> more than that on slower ones.
>
> I'm still waiting for the day when watchman support gets merged and
> maybe poke Facebook guys to compare performance with Mercurial :)
> Well, we are probably still behind Mercurial on that day.

Yeah, it could be interesting to compare performance with Mercurial as
we move forward :-)

> Also, there's still work to be done. Right now it's optimized for
> whole-tree "git status", Doing "git status -- abc" will not benefit
> from untracked cache, similarly "git add" with pathspec..

Thanks for these details. Yeah, it might be interesting to look at
"git add" too.

Best,
Christian.
