From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sat, 11 Sep 2010 15:56:13 +0000
Message-ID: <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
	<20100830030819.GA25415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 11 17:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuSRC-0005XR-QY
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 17:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0IKP4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 11:56:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60163 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0IKP4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 11:56:14 -0400
Received: by iwn5 with SMTP id 5so3342475iwn.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FypByW72cX2x1FX+/PKEIbT2ymnR2YqDAf5D6JLE7KU=;
        b=A8Guwh3HZd9hbC1byanPE4vgoFbp2WTbZFZIF108IDStpbjgR3rQI6X65bzRhJ0L+g
         9ceUOsXSJ42B0nWr8w1RFb8cSibJK1q51zMVBqupCS6GfUurCmXDuuLmlGQ45qAH5Zh0
         h2kwxKUaaOPln1BUWC6CUgg2u9P1ux6tYs35o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E70ZP8KoChFrcycvVxJZB3G8cCU+k2QfOBrig3w8/1b+p/BzaOMj3yzy2S7/K/slXD
         OjwkcvqWNmpO+KXbPQ7tzLqXqtD8x4DY7NT3DEJKWrFV5r7hKyAOOqbUPlNw8tTsj0Wc
         OL2fmyiFGSc5C30cbcOCkmv5Mm4XB1Fm07bDw=
Received: by 10.231.59.13 with SMTP id j13mr3045836ibh.77.1284220574066; Sat,
 11 Sep 2010 08:56:14 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 11 Sep 2010 08:56:13 -0700 (PDT)
In-Reply-To: <20100830030819.GA25415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155991>

`On Mon, Aug 30, 2010 at 03:08, Jeff King <peff@peff.net> wrote:

Sorry for not replying to this earlier.

> On Sun, Aug 29, 2010 at 08:30:15PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> I have this alias in my .gitconfig:
>>
>> =C2=A0 =C2=A0 review =3D "!f() { for rev in $(git rev-list --reverse=
 \"$@\"); do
>> git show $rev; done; }; f"
>>
>> I use it after I "git pull" to see what changed, e.g.:
>>
>> =C2=A0 =C2=A0 git review 49ea7b8..e1ef3c1
>
> It took me a minute of reading this to see why you would want to call
> "git show" in a loop when you could have the same data from "git log"
> all at once (and much faster, too).

I just like the UI of having each commit "pop up" where I can either
page up/down within the commit, or dismiss it with "q" and go to the
next one.

You can't do both of those in a pager, up/down goes across commits,
and "q" quits the whole pager.

> But I guess you like having an individual less invocation for each
> commit. Have you tried "tig", which might suit your purpose even
> better?

I haven't tried tig, but "git review" as I implement it (below) is
sufficient for my needs.

>> But sometimes I find that I want to do that for other things too, so=
 I
>> have these hacks:
>>
>> =C2=A0 =C2=A0 review-grep =3D "!f() { for rev in $(git log --reverse
>> --pretty=3Dformat:%H --grep=3D\"$@\"); do git show $rev; done; }; f"
>> =C2=A0 =C2=A0 review-file =3D "!f() { for rev in $(git log --reverse
>> --pretty=3Dformat:%H \"$@\"); do git show $rev; done; }; f"
>>
>> But just now I wanted to use -S instead of grep, but adding aliases
>> like this is a bit silly.
>
> I don't understand why you have these at all. Just use "git log
> --format=3D%H" in your git review above (instead of rev-list), and th=
en
> you can just do:
>
> =C2=A0git review --grep=3Dwhatever
> =C2=A0git review -Sfoo
> =C2=A0git review file
>
> Or am I missing something subtle?

You're not missing something, my alias was silly because I brainfarted
and didn't realize I could do $@, not "$@", so now it's:

    review =3D "!f() { for rev in $(git log --reverse --format=3D%H $@)=
;
do git show $rev; done; }; f"

Which means I can do all of the commands you suggested above, thanks!

> You wouldn't even need to switch to log over rev-list, except that
> rev-list misses log's useful "default to HEAD if no revisions given"
> behavior.
>
>> Maybe we should have something like:
>>
>> =C2=A0 =C2=A0 git log --for-each=3Dless a..b
>>
>> To call "less" for each commit, what do you think?
>
> I think it is not very Unix-y. We already have many ways to to call a
> command once per commit, including:
>
> =C2=A0- for i in `git rev-list "$@"`; do git show $i; done
>
> =C2=A0- git rev-list "$@" | xargs -n 1 git show
>
> =C2=A0- git log -z "$@" | perl -0ne 'open(LESS, "|less"); print LESS'
>
> What does your solution offer that the other do not? Because you are
> actually reinvoking git for each commit, it is more efficient than th=
e
> first two (as you seem to assume that the --for-each command will
> receive the entire log output). But the third one should be more or l=
ess
> equivalent to what you want (though note: if you want tty-ish things
> like color on, you should set GIT_PAGER_IN_USE=3D1 so git knows outpu=
t is
> eventually going to a pager). Sure, yours is slightly less typing, bu=
t
> it's _way_ less flexible, and that typing should probably be hidden
> behind an alias anyway.

Yeah, it's not very Unixy, I just find it so useful that I thought
there might be interest in adding it to Git. It's easily in the list
of top 5 git commands that I use.

But just using the pipe is more flexible I guess.
