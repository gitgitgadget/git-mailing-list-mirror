From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic
 operations with the equivalent shell builtin
Date: Thu, 4 Feb 2016 12:14:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041204430.2964@virtualbox>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRHrz-0005d7-1u
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 12:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbcBDLOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 06:14:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:51894 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932869AbcBDLOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 06:14:30 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MJjvw-1aSOKO1eYm-0016hM; Thu, 04 Feb 2016 12:14:28
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rSPsKjwNT9oKob8+/ZHBhYAExpx5XWu5gWNsse+2Vn4sQGtqwcQ
 SkAE+TfElBz9qSkk6S/7E3upHiwxZ20+WK7Nu6Xnqdf8TI/WKbRVJvwgO6Wd6QcE2a6QTyP
 EZA/C5dWQrqaVSIOjrO885QLuDvTQ9pV+PL+lqgCA0CZndTCoiMbA+23DY66WMPs3x4VoLQ
 TR2dog/C0vWg6j8c+UuyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kA008DqigjU=:bB9qEKQ/GOv42YHYAaMwhW
 kWwQ5IEC4PYvjG2SJZqMVor1AFWzLRIBzMc6jtqUUaCBqBdoJ9Hwj56De0g3OwmOon2EY47rp
 0Ke0A41TSI/iPfaLmQw54wFJHhLlQB5vTF5zim36EqfsIzn5YE/KlpzGkJRuYkErkDiO7FOFy
 awHV3wUnDJKLU+vr9IZNLGToamCEdr/dBV2yXnKdJzGPAviYfGhk0zkY310LQiX35j9DAXXLe
 pooBygQDwdywPxXiWDKjIFvNnfXZdOWRCdlXjAV0boVI3BmVz5pjlLgGmgKMWj5wXl1Lpk3i6
 eZSaebyu9COQy8o2aAttggpPaJmiHjPNnRxV1oTQm4HPvgYspAvBs0pP+wZqKPkMb5XLiNrPN
 EOc53l0GMJAsz/RUUuYUvP6morBAvFkprxGBq4FE9sX5yJa57r5v/5a6bGIftUbUnbqjohDLl
 deKY9xbXUZwRqE8dZEr7/sTu9rwj6QZNBO6o89PRYYf8I0PIRjeDHx60bpd8Wc49oFrTuH9yC
 KXVEscf/T5JwUbZjPNVrMjJAoXx2d6lohAkvmJsWCk8Hh/V22ynfJAdxk+o2SaA+qXNZvut21
 gxaCz0VtpM3Jxr3L6v4r8QYGzhDiiRXELEhedVbvnIVHC8VZ4Qodb1bmBwSxm6wnrbaeVRnw8
 M0Oj9z8fGBH/Rhi5FrNntAh+kZXt3Jy2XJw+6yvu/vMGdBopzL6ZH4jp/raOvxO6iSNkhXYmg
 Xq/zNpyzYrkN78G340woMKuau0K3TwwJeScASKYGxw9/BeuNEL2ot5D2mBs3gYKp5uLfZGip 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elia,

On Thu, 4 Feb 2016, Elia Pinto wrote:

> -			this=$(expr "$this" + 1)
> +			this=$(( "$this" + 1 ))

Why the funny spaces? We do not do that anywhere in the existing code
except in three places (2x filter-branch, 1x rebase--interactive, all
three *not* my fault) and in some tests.

Also, I am *pretty* certain that the quotes break this code:

	me@work MINGW64 /usr/src/git (master)
	$ this=1

	me@work MINGW64 /usr/src/git (master)
	$ this=$(( "$this" + 1 ))
	bash: "1" + 1 : syntax error: operand expected (error token is ""1" + 1 ")

Whereas if you do *not* add the superfluous spaces and quotes, it works:

	me@work MINGW64 /usr/src/git (master)
	$ this=1

	me@work MINGW64 /usr/src/git (master)
	$ this=$(($this+1))

	me@work MINGW64 /usr/src/git (master)
	$ echo $this
	2

Maybe this is only a problem with Bash 4.3.42 in MSYS2, but I do not think
so.

*Clicketyclick*

Nope. It also happens in Ubuntu's Bash 4.3.42:

	me@ubuntu-vm  ~/git (master)
	$ this=1

	me@ubuntu-vm  ~/git (master)
	$ this=$(( "$this" + 1 ))
	bash: "1" + 1 : syntax error: operand expected (error token is ""1" + 1 ")

	me@ubuntu-vm  ~/git (master)
	$ bash --version
	GNU bash, version 4.3.42(1)-release (x86_64-pc-linux-gnu)
	Copyright (C) 2013 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later
	<http://gnu.org/licenses/gpl.html>

	This is free software; you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.

... which makes me wonder in which environment you tested this?

Ciao,
Dscho
