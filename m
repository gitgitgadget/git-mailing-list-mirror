From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it
	is too restricting
Date: Fri, 22 Dec 2006 12:55:05 +0000
Organization: Berlin University of Technology
Message-ID: <20061222125505.GB3773@peter.daprodeges.fqdn.th-h.de>
References: <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl> <20061221112835.GA7713@fiberbit.xs4all.nl> <7v64c492fv.fsf@assigned-by-dhcp.cox.net> <20061222075142.GA9595@fiberbit.xs4all.nl> <7v4pro5nsa.fsf@assigned-by-dhcp.cox.net> <20061222114722.GA11274@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 13:55:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxjvg-0003eA-V8
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbWLVMzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbWLVMzM
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:55:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:40630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754826AbWLVMzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:55:10 -0500
Received: (qmail invoked by alias); 22 Dec 2006 12:55:09 -0000
Received: from cable-62-117-24-190.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.24.190]
  by mail.gmx.net (mp001) with SMTP; 22 Dec 2006 13:55:09 +0100
X-Authenticated: #1642131
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP
	id F2F5320F02; Fri, 22 Dec 2006 12:55:06 +0000 (UTC)
To: Marco Roeland <marco.roeland@xs4all.nl>
Mail-Followup-To: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>,
	Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061222114722.GA11274@fiberbit.xs4all.nl>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-PRERELEASE i386)
User-Agent: Mutt/1.5.13-pdmef (2006-11-28)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35171>

Hi,

* Marco Roeland [06-12-22 12:47:22 +0100] wrote:

>In fact on FreeBSD the problem seems to be only that when _XOPEN_SOURCE
>is defined, than the macro __BSD_VISIBLE is unset or 0. Adding just

>#ifdef __FreeBSD__
>#define __BSD_VISIBLE   1
>#endif

The first patch I sent in did exactly that via -D__BSD_VISIBLE set in 
the Makefile and Junio correctly complained that the __-prefix is meant 
to be for internal use only. I bet he'll say the same about this flavour 
of defining __BSD_VISIBLE. :)

I was just too lazy to recursively go through the #define/#ifdef parts 
of header files to find why __BSD_VISIBLE is needed.

Second, in <sys/cdefs.h> _XOPEN_SOURCE indirectly influences 
__BSD_VISIBLE through _POSIX_C_SOURCE. The latter is defined for values 
of >=500 for _XOPEN_SOURCE so that even

   #define _XOPEN_SOURCE 499

works fine on FreeBSD.

I'm still in favour of simply adding '!defined(__FreeBSD__)' to 
git-compat-util.h as soon as possible to push out a maintaince release 
that at least compiles (on FreeBSD)...

   bye, Rocco
-- 
:wq!
