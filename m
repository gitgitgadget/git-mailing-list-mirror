From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Fri, 23 Sep 2005 15:44:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <ud5mznc1x.fsf@peter-b.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 15:45:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EInqf-0001KG-OQ
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 15:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVIWNoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVIWNoP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 09:44:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62108 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750989AbVIWNoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 09:44:14 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 70990E2752; Fri, 23 Sep 2005 15:44:11 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 55CD39D9DF; Fri, 23 Sep 2005 15:44:11 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4450E9D9D1; Fri, 23 Sep 2005 15:44:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E0FF7E286F; Fri, 23 Sep 2005 15:44:08 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Peter TB Brett <peter@peter-b.co.uk>
In-Reply-To: <ud5mznc1x.fsf@peter-b.co.uk>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9192>

Hi,

On Fri, 23 Sep 2005, Peter TB Brett wrote:

> I wanted to use git on a Windows-based project (yes, there are some
> out there still), so I fired up my Cygwin xterm, untarred the git
> sources and totally failed to succeed in building them:

Also see my mail regarding cygwin:

http://www.gelato.unsw.edu.au/archives/git/0508/7956.html

> gcc -o connect.o -c -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' connect.c
> connect.c: In function `git_tcp_connect':
> connect.c:298: error: storage size of 'hints' isn't known
> connect.c:322: warning: implicit declaration of function `getaddrinfo'
> connect.c:324: warning: implicit declaration of function `gai_strerror'
> [...]

This is the IPv6 stuff. There are patches to cygwin to support IPv6 
somewhere, but they haven't made it into mainline.

As for the other problem I mentioned in my original mail:

It seems that the fixup of the mmap()ed regions after a fork() does not 
work properly in cygwin. Remember that cygwin just wraps the non-POSIX 
Win32API and tries to make it sort of POSIX compliant. The problem is that 
Win32API lacks a proper fork(). This is therefore emulated, and after 
that, all the mmap()ed regions have to be mapped again. That fails.

Sidenote: I ran it inside gdb, and it worked fine! So I tried to recompile 
the cygwin1.dll, but that wrecked my whole installation of cygwin and I 
spent 2 hours just to be able to "gcc -o" again.

Ciao,
Dscho
