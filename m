Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E261FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 08:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbcFVIcf (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 04:32:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:61785 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcFVIcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 04:32:23 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M6eTo-1bcpBo1gDE-00wTMI; Wed, 22 Jun 2016 10:25:32
 +0200
Date:	Wed, 22 Jun 2016 10:25:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows
 paths
In-Reply-To: <xmqqk2hiqwpb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606220927350.10382@virtualbox>
References: <cover.1466246919.git.johannes.schindelin@gmx.de> <a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de> <xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606211356170.22630@virtualbox>
 <xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com> <xmqqk2hiqwpb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JyMQr5yTJsW0d+dfpjJa4Nou6hVHiAeB7koiy2E3/WACqLrfdfB
 yVYs7pw2ILt09ah8zilEZXJKU+oDCNV9ouhk3xkfnqh/GbuKSuBGGw8FDgjC6Shrzhfgy+X
 7ED4J6xvudoL8w6zH1pSv5kx6ctYq7DkNvyuDxkK697aePpBNaBp7NONWRV8f6N67aaGx8U
 4bVW/wCw4sM29wdfolQ8w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:tJ+EkNyLCQo=:wT/4On21X2aAkXC8zk6Cg4
 CKMTtKQj8mwLOBwFjGukDWmn2GsvnBrPCEZq6pvmyMZTE/gmPg50kSxf3gsG7CVTsmvhoH3iX
 K/yQUuBdqR1ubjC/NXz2ukNfTWUzAEeDjDwMglOOsEJdgEScv6K6xKKk2WFCPi3ONgbNO6hiG
 PrUY1kQ/n8Et8A1QDzkmHGLZ0Dz9mVNDnRpIwOlLq/boBgaOyDu5CP4bJuma9mNJWBIm7SRuD
 iXCMftyLeS9R596JwyGaAhXPZREG9he2CyFAqyWl2EPhdl/J/GkxZanGyZTSR3wRVCMdYoG72
 5OA41FjfZmQJPlotV4C3xsZERWUT80FRgXNKynfqPg9WwftNfcVKRujYOu4QexNa2SFx4RnVt
 jbWh+A5t50BSbHxGzvgSASA1fwkFcJz/uptpiShROYplW92MtQbtjE9sUKDdCLijRTqdDo158
 gFzrAZjN02d9UgScMlYAA8hPvJ6atQZNz7IFPoFEthZMB4CA0Cp1dh7eG/jhCt/aZpQmpTG7B
 v82k3y1k2FYrfSHYQ5F5nl2CGVJFuGamVL6siGBKBgZilu/z1JLAQ1Inj6gKb7SntLs14TOmp
 sY42xkdZovAKlrGPpevoYHE5vckrg1inkJx+6TRlcqiMaWOWz9ZcTfEftIwU0uwR+xbs+IKPr
 R/w1ea1NLPwv5Wu90nIQnhDm5C6O9a4FwXKat2QyQvW+XvHcZDcNQQsnCS+VdtGTQeSSIR23P
 nYCSp05rmXCI/BU0Bd5oNMEl5c7tUt0mRVRTyepmKGj+xqZhhOg6rjJ8UwIPdUziwhHshLLvD
 YEgOgPz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 21 Jun 2016, Junio C Hamano wrote:

> I said $PATH because --exec-path does not care what you do with
> %PATH% but it deeply cares that its output is usable in $PATH.

The really, really, really important part to keep in mind is that there is
no $PATH on Windows.

Seriously, there is not.

There is a %PATH% because the scripting language native to Windows is the
Windows batch language, which works with native Windows paths.

The same holds true for Git, BTW: all of the C code we have handles
Windows paths just fine, as tedious as it is to keep this support intact.

Now, all of the troubles enter with Git's relying on shell and Perl
scripts. That is not a fault of the platform, of course, it is Git's
fault. It is cute and convenient when your entire world is the Linux
command-line, and when you do not really care about performance, either.

And these shell scripts have a different idea about paths than Windows, or
even the Git executable for that matter!

Now, the big question is: how much do you want to cast this reliance on
shell and Perl scripts in stone? That is an important question, and
affects directly the answer to the related question: Should `git
--exec-path` cater to POSIX shell scripts, or to scripts native to the
current platform?

Personally, I am not a fan of casting this in stone so much.

You see, shell scripts are as foreign to Windows as Windows batch scripts
are to Linux. I doubt that you would accept any patch that would change
all scripts to accept Windows-style paths even on Linux. Yet, the reverse
is true: Git for Windows is expected to accept non-Windows paths.

And all this talk did not even scratch the most important point. When I
say "POSIX paths" I know fully well that this is incorrect. POSIX paths
are not required to use a forward slash as directory separator and a colon
as path separator.

Think VAX.

I see the discussion veering into the wrong direction here. I am not
prepared to accept the notion of shell scripting as portable, certainly
not when we rely on so many Unix-isms.

So unless we come up with a truly portable way to test Git, and to
implement scripted parts of Git, I am convinced that our best course of
action is to continue to work around Git's erroneous assumption that shell
scripting is as native to the current platform as the Git executable
itself, and to continue to introduce glue code to keep things running
relatively smoothly.

Of course, if you have a splendid idea how to fix the underlying issue, I
am more than just eager to go there.

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think you would need something similar to "pwd -W", that is, leave
> > "git --exec-path" as a way to give shell scripts people have written
> > over the years that allows them to say "git-cmd" as long as they do
> > PATH="$(git --exec-path):$PATH" upfront.  And for Windows scripts,
> > introduce a new option "git --exec-path-windows" that can give
> > C:/git-sdk-64/usr/src/git (or even using backslash).
> 
> Of course we could go the other way.  We can declare that the output
> of "git --exec-path" is the format that is platform-native pathname
> to the directory [*1*], introduce a new option that is better
> named than "--exec-path-to-include-in-PATH-in-shell-scripts" that
> does the "convert C:/ to /c/ on Windows before showing" thing, and
> rewrite all the references that does PATH=$(git --exec-path):$PATH
> in scripts to use that new option.

I see your smirking when you wrote this.

> The fact remains that on some platforms two variants are needed.  We
> can update our test scripts with "convert C:/ to /c/ on Windows" to
> work around a test failure like the patch under discussion did, but
> that approach would not scale to fix real world scripts that people
> already have, which is what I am trying to see if we can address in
> these two messages.

This overstates the importance of shell scripting in general Git usage,
methinks, and certainly the importance of --exec-path with regards to the
PATH variable.

Git's own shell scripts do not need to extend the PATH to include Git's
exec path (when they are called, the PATH is already extended
appropriately). And neither do other shell scripts: the dashed
invocations are deprecated for way too long a time already.

Performance characteristics as well as quite serious portability problems
(just how much time do we still have to spend just to bend over backwards
for KSH, for example?) are simply not in favor of using shell scripting
for any serious Git operation.

Of course, it is not as bad for Linux users because shell scripts have
decent performance characteristics there (at least if you work with
projects at most the size of the Linux kernel), and you always have
at least a Dash, if not a Bash. But already going to MacOSX, shell scripts
are not so much fun anymore.

> *1* ...instead of "it is suitable for PATH=$(git --exec-path):$PATH
> in your shell scripts", which was the definition I used in the
> message I am responding to.  "The name '--exec-path' implies it is a
> path to the directory, and it is more natural for that to be platform
> native" is a valid argument (and that is why I am saying "we could
> go the other way" here), but I am not convinced that the conclusion
> that the argument leads to is a better one in the practical sense.

Yes, the practical issue at hand is: we are pretty much stuck with shell
scripting for Git's test suite (which is not nice for me: on the same
machine where the test suite requires an already painful 10 minutes to
complete in a Linux VM, it requires 45 minutes to complete in the
POSIX-emulating Bash).

And I would rather keep this test suite working on Windows using
work-arounds such as the patch in question than to spend a lot of effort
to support portable scripting, when scripting does not really matter all
that much in practice to begin with.

Ciao,
Dscho
