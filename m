From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Sun, 25 Apr 2010 21:40:23 +0100
Message-ID: <g2r5b9751661004251340k862172bflc99106ed1cf20921@mail.gmail.com>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com> 
	<20100425194800.GB14736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 25 22:40:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O68dH-0006UB-Dx
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0DYUkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 16:40:46 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62627 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0DYUkp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 16:40:45 -0400
Received: by bwz19 with SMTP id 19so81735bwz.21
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DeEGM+F5aVsYqlDQ4o6wyZKyxmvA+zcvOCeBGGVdNkU=;
        b=gX3/AgL3245SA9TFYu45WCdJwNNav+/xAzZsym1QPWNEtnv9pNCIktjx1sVrOtlqFJ
         2u7dRyaaXHkrGGNozdG9rvjotL2yHcAERGYMAZYG6dcSZ6vGiWCD1QivePtdztDCtWqB
         3IEOykTGRoA3wILHvRAnifc4e+yNgERk14qmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vgAmWQxn+2cPsfUOsLg20r+awY2Gf9TuYzebKbLgT7Sl9eBTJ2pTXlarpaESv6k5U0
         dE2KNGBrR1NoYaVDrs37rEFmWGwr6lF8hc/JzLlYZeFe2Cpp7ElbfI5BNLuXJoJL30Bg
         r1pX90grAaQkWac0hAiETFwy/uDkxtzlUjNeE=
Received: by 10.102.165.3 with SMTP id n3mr1735007mue.21.1272228043064; Sun, 
	25 Apr 2010 13:40:43 -0700 (PDT)
Received: by 10.103.239.12 with HTTP; Sun, 25 Apr 2010 13:40:23 -0700 (PDT)
In-Reply-To: <20100425194800.GB14736@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145767>

On Sun, Apr 25, 2010 at 8:48 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 25, 2010 at 04:42:52PM +0100, Will Palmer wrote:
> Interesting idea. I think right now most people just want to use thei=
r
> format with "log", so they would do something like:
>
> =A0git config alias.mylog "log --format=3D'...'"
>
> Your method allows the same format to be used with multiple commands,
> which is more flexible. But I wonder how many people would find it
> useful in practice. I can think of only "log" and "show" that I would
> really want to share between.

Indeed, this is what I do now, and I really wasn't expecting anyone to
use it for a command other than log. There are three main
justifications:
 1) I hope to eventually have all builtin formats converted to use
this mechanism, and this is a good stepping-stone.
 2) defining a git alias to "log" when I really just want a shorter
way to type a format has always felt horribly clunky to me.
 3) it's so easy to add it's essentially free.

as you might guess, #2 is what really started the itch, and #3 is what
encouraged me to scratch it. #1 was more a side-effect when I realized
(when first trying to implement things) that it's not how things are
currently done.

>
> I skimmed your patches and have included a few comments below, as I
> don't have time at the moment to do a thorough review.
>
Thank you, any input is greatly appreciated.

> I think that makes some sense. The "diff" color option was the first,
> and so the commit-coloring in "git log" follows that already. So shor=
t
> of making a new "color.log" variable, that makes the most sense.
>
following the "diff" color seemed to be the right thing in most
places, but for some things it looked as if there may be more-specific
not-diff-related color options being passed int, which is why I
changed the show_log() calls. Looking back over the patch now, it
seems that the only place left which doesn't reference a rev_info
struct is show-branch.c, which doesn't even have a --format option. So
I suppose that can all get ripped out and replaced with a single check
of the diff options in  the next version of the patch.

> This is really a variation on the first one. And there are more
> variations, like %T/%t, %P/%p, etc. I'm a little hesitant to just cha=
nge
> the meaning of "%H", which has always explicitly meant the full sha1.
> Should we perhaps introduce some universal syntax for "abbreviate if
> --abbrev was given, otherwise full sha1". Like "%?H" as you did above=
,
> except that "?" doesn't really make sense.
>
This one I was also a bit iffy on, but in my mind the fact that %H
currently completely ignores the --abbrev-commit option feels like a
bug to me. One of those "if it has no effect, there should be a
warning", things.
We can at least be assured that as --abbrev[-commit] previously had no
effect on --format options, that the only people who would have used
them together have probably been disappointed at the results, and did
not continue to do so.
There /are/ a couple of places in-code which use %H to fetch a
commit-hash-string, and I made sure to avoid modification of rev_info
when I spotted that, but really that feels like something that should
be using a wrapper get_commit_hash_string() function.

> The config variables format.* are traditionally about format-patch. I
> see we have format.pretty these days, too. I'm not sure if that is a
> deliberate attempt to make format.* more inclusive, or simply an erro=
r.
> If the latter, we should probably not make it worse with
> format.pretty.name.

I was writing them as pretty.<name>, until I saw that format.pretty
was already there. I'm not sure which is the weirder of the two.

>
> -Peff
>
> PS Welcome to the git list. It is nice to see a submission from a
> newcomer who has clearly read SubmittingPatches, and that even has
> appropriate documentation and test updates. :)
>

Nice to be welcome. You may have seen a test-run I did to get my
confidence up by submitting a two-line documentation change a week or
so ago ;)
--=20
Will Palmer
wmpalmer@gmail.com
