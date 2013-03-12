From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Tue, 12 Mar 2013 08:53:28 +0100
Message-ID: <vpqwqtdkq9z.fsf@grenoble-inp.fr>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>
	<vpq8v5uueug.fsf@grenoble-inp.fr> <513E3190.20100@gmail.com>
	<20130312013736.GB7105@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Manlio Perillo <manlio.perillo@gmail.com>,
	git <git@vger.kernel.org>, felipe.contreras@gmail.com
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 08:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFK29-00054Z-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 08:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab3CLHxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 03:53:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38299 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab3CLHxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 03:53:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2C7rSaL002900
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Mar 2013 08:53:28 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UFK1Z-0003iL-13; Tue, 12 Mar 2013 08:53:29 +0100
In-Reply-To: <20130312013736.GB7105@unpythonic.net> (Jeff Epler's message of
	"Mon, 11 Mar 2013 20:37:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Mar 2013 08:53:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2C7rSaL002900
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363679609.92525@IJu/bsAWyDp7juQT5t8iQw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217936>

Jeff Epler <jepler@unpythonic.net> writes:

> If it's dependent on eval "`dircolors`", it suggests it might be
> dependent on the size of the environment.  Maybe try with FOO=`perl -e
> 'print "x"x1000'` for various values of 1000...

It's not this, but I could reduce the problem to a slightly simpler
.zshrc:

-----------------------------------------------------------------
fpath=(${HOME}/usr/etc/zsh ${fpath})

autoload -Uz compinit
compinit

zstyle ':completion:*' list-colors 'rs=0' 'di=01;34' 'ln=01;36' \
 'mh=00' 'pi=40;33' 'so=01;35' 'do=01;35' 'bd=40;33;01' 'cd=40;33;01' \
 'or=40;31;01' 'su=37;41' 'sg=30;43' 'ca=30;41' 'tw=30;42' 'ow=34;42' \
 'st=37;44' 'ex=01;32' '*.tar=01;31' '*.tgz=01;31' '*.arj=01;31'  \
 '*.taz=01;31' '*.lzh=01;31' '*.lzma=01;31' '*.tlz=01;31' '*.txz=01;31' \
 '*.zip=01;31' '*.z=01;31' '*.Z=01;31' '*.dz=01;31' '*.gz=01;31'  \
 '*.lz=01;31' '*.xz=01;31' '*.bz2=01;31' '*.bz=01;31' '*.tbz=01;31'  \
 '*.tbz2=01;31' '*.tz=01;31' '*.deb=01;31' '*.rpm=01;31' '*.jar=01;31' \
 '*.rar=01;31' '*.ace=01;31' '*.pgm=01;35' '*.ppm=01;35'  \
 '*.tga=01;35' '*.xbm=01;35' '*.zoo=01;31' '*.cpio=01;31' '*.7z=01;31' \
 '*.rz=01;31' '*.jpg=01;35' '*.jpeg=01;35' '*.gif=01;35' \
 '*.bmp=01;35' '*.pbm=01;35'
-----------------------------------------------------------------

The problem disapears if I remove one of the arguments after list-colors
(I didn't try with each of them, but picking 5 of them randomly and
removing it worked), so it seems to be a matter of number of arguments.

On git-completion.bash's side, it's really strange. If I comment out the
"case" statement in _git_mv like this, the problem disapears:


_git_mv ()
{
	# case "$cur" in
	# --*)
	# 	__gitcomp "--dry-run"
	# 	return
	# 	;;
	# esac

	if [ $(__git_count_arguments "mv") -gt 0 ]; then
		# We need to show both cached and untracked files (including
		# empty directories) since this may not be the last argument.
		__git_complete_index_file "--cached --others --directory"
	else
		__git_complete_index_file "--cached"
	fi
}

If I add a simple 'echo "$cur" >&2' instead of the case, the problem
reappears. Somehow, the fact that I'm accessing $cur seems to create the
segfault. Actually, the minimalistic _git_mv reproducing the problem is:

_git_mv ()
{
	echo "$cur"
	[ $(__git_count_arguments "mv") = 1 ]
	__git_complete_index_file "--cached --others --directory"
}

gdb doesn't say much interesting since my ZSH isn't compile with debug:

(gdb) r
Starting program: /usr/bin/zsh 
anie$ cd /tmp/git
anie$ git mv subdir/
Program received signal SIGSEGV, Segmentation fault.
__strlen_sse2 () at ../sysdeps/i386/i686/multiarch/strlen.S:87
87	../sysdeps/i386/i686/multiarch/strlen.S: No such file or directory.
	in ../sysdeps/i386/i686/multiarch/strlen.S
Current language:  auto
The current source language is "auto; currently asm".
(gdb) where
#0  __strlen_sse2 () at ../sysdeps/i386/i686/multiarch/strlen.S:87
#1  0x080ae31d in ztrdup ()
#2  0xb7b9d287 in permmatches () from /usr/lib/zsh/4.3.10/zsh/complete.so
#3  0xb7b9a22e in ?? () from /usr/lib/zsh/4.3.10/zsh/complete.so
#4  0x08098f33 in getstrvalue ()
#5  0x08099e9d in ?? ()
#6  0x0809acd7 in getindex ()
#7  0x0809b3d9 in fetchvalue ()
#8  0x080b0f84 in ?? ()
#9  0x080b49a7 in prefork ()
#10 0x08066cb9 in ?? ()
#11 0x08067151 in ?? ()
#12 0x0806cfc0 in execlist ()
#13 0x0808984c in execif ()
#14 0x080670c6 in ?? ()
#15 0x0806cfc0 in execlist ()
#16 0x0806d69a in execode ()
#17 0x0806d785 in runshfunc ()
#18 0xb7b99a7a in ?? () from /usr/lib/zsh/4.3.10/zsh/complete.so
#19 0x0806d724 in runshfunc ()
#20 0x0806db92 in doshfunc ()
#21 0xb7ba3363 in ?? () from /usr/lib/zsh/4.3.10/zsh/complete.so
#22 0xb7ba44dc in do_completion () from /usr/lib/zsh/4.3.10/zsh/complete.so
#23 0xb7bdaf47 in ?? () from /usr/lib/zsh/4.3.10/zsh/zle.so
#24 0xb7bd5b40 in completecall () from /usr/lib/zsh/4.3.10/zsh/zle.so
#25 0xb7bc6f6e in execzlefunc () from /usr/lib/zsh/4.3.10/zsh/zle.so
#26 0xb7bc72a2 in zlecore () from /usr/lib/zsh/4.3.10/zsh/zle.so
#27 0xb7bc78d5 in zleread () from /usr/lib/zsh/4.3.10/zsh/zle.so
#28 0xb7bc96ff in ?? () from /usr/lib/zsh/4.3.10/zsh/zle.so
#29 0x0807d462 in zleentry ()
#30 0x08080a31 in ingetc ()
#31 0x0807b03c in ?? ()
#32 0x08087fb6 in zshlex ()
#33 0x080a3b4a in parse_event ()
#34 0x0807f2f1 in loop ()
#35 0x080800c6 in zsh_main ()
#36 0x08054cbb in main ()

I can't reproduce the problem with the exact same config and a freshly
compiled ZSH (so it's no use reporting the issue to the ZSH developers).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
