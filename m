From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Thu, 26 Nov 2015 18:53:40 +0100
Message-ID: <CACsJy8CNRbvsDY+ucFZGcO4+tE9Ud_QNr1k4D=+utawSCrc+Sg@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org>
 <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
 <CACsJy8DhAfu7J=WpPAp8HYGLuFQC5+DZyZj6Hs6vruEJEeVKig@mail.gmail.com> <CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 18:54:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a20kI-00054X-0j
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 18:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbKZRyN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2015 12:54:13 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35489 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbbKZRyL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2015 12:54:11 -0500
Received: by lfdl133 with SMTP id l133so104780137lfd.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2015 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=e7iigZHin36kBzmJAdUVLMGIUNfa0sFC31i8LhRXQe8=;
        b=bC5DieloOQ0SEZsKiMjHgV8VawHx1DCsloeaMPYaIrYV9f8nudavnnDYOcdReHsWrI
         A769qrTexbe4MjIIo4i62YNBMxJE4GHkoxLYk7+wA/EoxKC9UpcqTt8NUl9Kacn6OLCp
         /tve3887lrYlBKoSlpkV5yMyc42G1IkumS2TFdo4PrX4kYiu6wxrIP5A/UGmGVTRs2G/
         fUm7uI029Om4eE5RGgJpNJp0F4CDrc4lTX38CyuNM+0lSQWzz168WEfTWWCXW0yITk8V
         ua1cb6HrYnF3rAGEGFBMOJV0tOxlDj5gt5u+CGOFRGxtT48hoc40okeX9wwVQJ4ViXVv
         W6mQ==
X-Received: by 10.112.134.169 with SMTP id pl9mr18144043lbb.145.1448560449726;
 Thu, 26 Nov 2015 09:54:09 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Thu, 26 Nov 2015 09:53:40 -0800 (PST)
In-Reply-To: <CAP8UFD2V3nbY2-abW6cGDtB2PR9Q+sN+d0RgTVJORCPg6TPMcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281763>

On Thu, Nov 26, 2015 at 6:21 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi Duy,
>
> On Wed, Nov 25, 2015 at 8:51 PM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>> On Wed, Nov 25, 2015 at 10:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason
>> <avarab@gmail.com> wrote:
>>> On Wed, Nov 25, 2015 at 7:35 AM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> At Booking.com we know that mtime works everywhere and we don't
>>>> want the untracked cache to stop working when a kernel is upgraded
>>>> or when the repo is copied to a machine with a different kernel.
>>>> I will add tests later if people are ok with this.
>>>
>>> I bit more info: I rolled Git out internally with this patch:
>>> https://github.com/avar/git/commit/c63f7c12c2664631961add7cf3da901b=
0b6aa2f2
>>>
>>> The --untracked-cache feature hardcodes the equivalent of:
>>>
>>>     pwd; uname --kernel-name --kernel-release --kernel-version
>>>
>>> Into the index. If any of those change it prints out the "cache is
>>> disabled" warning.
>>>
>>> This patch will make it stop being so afraid of itself to the point=
 of
>>> disabling itself on minor kernel upgrades :)
>>
>> The problem is, there's no way to teach git to know it's a "minor"
>> upgrade.. but if there is a config key to say "don't be paranoid, I
>> know what I'm doing", then we can skip that check, or just warn
>> instead of disabling the cache.
>
> Yeah, in my patch if core.trustmtime is set to true or false the chec=
k
> is skipped.
>
> I am wondering why you didn't make it by default run the mtime checks
> when a kernel change is detected. Maybe that would be better than
> disabling itself.

It takes about 10 seconds to go through the mtime check. Imagine you
have to wait 10s for some random "git status".. Plus I didn't want to
do anything fancy.

>
>>> A few other issues with this feature I've noticed:
>>>
>>>  * There's no way to just enable it globally via the config. Makes =
it
>>> a bit of a hassle to use it. I wanted to have a config option to
>>> enable it via the config, how about "index.untracked_cache =3D true=
" for
>>> the config variable name?
>>
>> If you haven't noticed, all these experimental features have no real
>> UI (update-index is plumbing). I have been waiting for someone like
>> you to start using it and figure out the best UI (then implement it)
>> ;)
>
> Ok, we are happy to do that (including implementing it) :-)
>
> I will take a look at something like index.untracked_cache. It will

Nit. untrackedCache (underscores are avoided for config keys) and it's
probably core.untrackedCache instead..

> probably also be a tristate like this:
>
> - true: always enable it; die if core.trustmtime is false otherwise
> warn if it is not true
> - default/unset: same as current behavior
> - false: die if it is enabled or when trying to enable to it

There could be a fourth option: let a hook do the checking. If the
hook returns ok, all is good.

>>>  * Doing "cd /tmp: git --git-dir=3D/git/somewhere/else/.git update-=
index
>>> --untracked-cache" doesn't work how I'd expect. It hardcodes "/tmp"=
 as
>>> the directory that "works" into the index, so if you use the workin=
g
>>> tree you'll never use the untracked cache. I spotted this because I
>>> carry out a bunch of git maintenance commands with --git-dir instea=
d
>>> of cd-ing to the relevant directories. This works for most other
>>> things in git, is it a bug that it doesn't work here?
>>
>> It needs the current directory at --untrack-cache time to test if th=
e
>> directory satisfies the requirements. So either you cd to that
>> worktree, or you have to specify --worktree as well. Or am I missing
>> something?
>
> Maybe it could print out a message saying "Testing mtime in directory
> $(pwd)" and if that works then "Untracked cache is enabled for
> $(pwd)". That would make it clear that it will not work in other
> directories.
>
> Also maybe the mtime checks could be run when a directory change is d=
etected.

Yeah.. and we could also have a hook to do this test your own way too,
if you already know your system supports it, so you wait no time at
all.
--=20
Duy
