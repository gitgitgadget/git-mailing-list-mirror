From: Alexey Spiridonov <snarkmaster@gmail.com>
Subject: Re: "git am" crash (builtin/apply.c:2108) + small repro
Date: Wed, 3 Oct 2012 08:44:54 -0700
Message-ID: <CAOKKMFFGz5Waz3OV4_uTgwDaL=S9NWAnLnACPzSkGpu_rrChvQ@mail.gmail.com>
References: <CAOKKMFG4JsNyMY7=SB6EuR8_GnpAu-ysH02J5pwD1cNzUgaieQ@mail.gmail.com>
	<CACsJy8B9NDmGnopoFEAA0T4mgG+54npYnbb_d4tihRNB=xrGnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 17:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJR8H-0003Tn-LO
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 17:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361Ab2JCPo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 11:44:57 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41656 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256Ab2JCPoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 11:44:55 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1740800qad.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OOqn+JXlN5pjiJGyFsBGfrBaWCNrUPgqSEDjgWHAFAo=;
        b=Ov8A18u2gYOKrf7WtwiYm22xrpjn0j1qya73I7zSadcUtvBa7Z9FqAUux0Jxe7a4ug
         fNOM4gYE7Wv7Ndp9N+SztL5Pc76d7OwPewlOPC/MSZNR3s0Z0LF8vp39/WmNtT/aZrGs
         rMaPLUzi9wo4QE1Okky1R8djdHDMqQ+i9WmxDQ4tlBHYDmpm3clP8EttuRHcPry0ZyXl
         Tjm6HUVsRxOyCSOMmkrANNPWYyf2Rd2qLvduCwcAI+/8o70zTWMUFFeWAiNjGahnj/8T
         BwYguzjq7KNpmWbgWAY9EhqPsD/r9Vol+ToM1Tz09Udjd2eizZnTeiou52SU1P12zjYY
         /fVA==
Received: by 10.49.71.107 with SMTP id t11mr12759684qeu.13.1349279094915; Wed,
 03 Oct 2012 08:44:54 -0700 (PDT)
Received: by 10.49.95.225 with HTTP; Wed, 3 Oct 2012 08:44:54 -0700 (PDT)
In-Reply-To: <CACsJy8B9NDmGnopoFEAA0T4mgG+54npYnbb_d4tihRNB=xrGnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206908>

Thanks a lot for trying this.

My hashes match. I just re-reproduced it on two flavors of Linux (64
and 32-bit), with two different Git versions (see below). What
platform are you using?


lesha@buryonka-ubuntu32:~$ mkdir GIT-AM-CRASH
lesha@buryonka-ubuntu32:~$ cd GIT-AM-CRASH
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ mv ../crashy.patch ../__init__.py .
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ git init .
Initialized empty Git repository in /home/lesha/GIT-AM-CRASH/.git/
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ mkdir -p meep/spork
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ mv __init__.py meep/spork
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ git add meep/spork/__init__.py
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ git ci -am 'moo'
[master (root-commit) fa8f8fd] moo
 1 file changed, 6 insertions(+)
 create mode 100644 meep/spork/__init__.py
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ git am crashy.patch
Applying: Git crash bug
git: builtin/apply.c:1990: update_pre_post_images: Assertion
`fixed_preimage.nr == preimage->nr' failed.
Aborted (core dumped)
Patch failed at 0001 Git crash bug
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ sha1
sha1pass  sha1sum
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ sha1sum crashy.patch
meep/spork/__init__.py
3d4711cd15d9617e0d3a52bbcd7def898c12c328  crashy.patch
fd63cc32338823f216a6684ce5118a69113968c8  meep/spork/__init__.py
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ git --version
git version 1.7.9.5
lesha@buryonka-ubuntu32:~/GIT-AM-CRASH$ uname -a
Linux buryonka-ubuntu32 3.2.0-31-generic #50-Ubuntu SMP Fri Sep 7
16:17:36 UTC 2012 i686 i686 i386 GNU/Linux


[lesha@dev037 ~/GIT-AM-CRASH] git init .
Initialized empty Git repository in /home/lesha/GIT-AM-CRASH/.git/
[lesha@dev037 ~/GIT-AM-CRASH] mkdir -p meep/spork
[lesha@dev037 ~/GIT-AM-CRASH] mv __init__.py meep/spork
[lesha@dev037 ~/GIT-AM-CRASH] git add meep/spork/__init__.py
[lesha@dev037 ~/GIT-AM-CRASH] git ci -am 'moo'
[master (root-commit) 4c3fe5f] moo
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 meep/spork/__init__.py
[lesha@dev037 ~/GIT-AM-CRASH] git am crashy.patch
Applying: Git crash bug
git: builtin/apply.c:1989: update_pre_post_images: Assertion
`fixed_preimage.nr == preimage->nr' failed.
/usr/libexec/git-core/git-am: line 789: 32074 Aborted
git apply --index "$dotest/patch"
Patch failed at 0001 Git crash bug
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
[lesha@dev037 ~/GIT-AM-CRASH] git --version
git version 1.7.8.4
[lesha@dev037 ~/GIT-AM-CRASH] uname -a
Linux dev037 2.6.38.4 #63 SMP Mon Feb 13 16:22:45 PST 2012 x86_64
x86_64 x86_64 GNU/Linux
[lesha@dev037 ~/GIT-AM-CRASH] sha1sum crashy.patch meep/spork/__init__.py
3d4711cd15d9617e0d3a52bbcd7def898c12c328  crashy.patch
fd63cc32338823f216a6684ce5118a69113968c8  meep/spork/__init__.py

-a

On Wed, Oct 3, 2012 at 4:27 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Oct 2, 2012 at 1:33 AM, Alexey Spiridonov <snarkmaster@gmail.com> wrote:
>> This reproduces in trunk, 1.7.8.4, and 1.7.9.5.
>
> fwiw, I cannot reproduce it (git-apply does not crash). I tried both
> versions and 1.8.0-rc1. Just in case the attached files are somehow
> corrupted, this is sha1sum from my side:
>
> 3d4711cd15d9617e0d3a52bbcd7def898c12c328  crashy.patch
> fd63cc32338823f216a6684ce5118a69113968c8  meep/spork/__init__.py
>
>> I suspect this has to do with a whitespace + no trailing newline
>> issues. The patch was generated by 1.7.9.5. I mangled it by hand to
>> get it to be small, but the initial crash happened on a large,
>> real-world output of "git format-patch".
>>
>> Error messages:
>>
>> ~/GIT-AM-CRASH$ ../git/git am crashy.patch
>> Applying: Git crash bug
>> git: builtin/apply.c:2108: update_pre_post_images: Assertion
>> `fixed_preimage.nr == preimage->nr' failed.
>> /home/lesha/GIT-AM-CRASH/../git/git-am: line 811: 23819 Aborted
>>          git apply --index "$dotest/patch"
>> Patch failed at 0001 Git crash bug
>> The copy of the patch that failed is found in:
>>    /home/lesha/GIT-AM-CRASH/.git/rebase-apply/patch
>> When you have resolved this problem, run "git am --resolved".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>>
>> Repro steps:
>>
>> mkdir GIT-AM-CRASH
>> cd GIT-AM-CRASH
>> # download files into this directory
>> git init .
>> mkdir -p meep/spork
>> mv __init__.py meep/spork
>> git add meep/spork/__init__.py
>> git ci -am 'moo'
>> git am crashy.patch
>>
>> Hope this helps!
>>
>> Alexey
> --
> Duy
