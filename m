From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Sat, 10 Nov 2007 15:04:41 +0100
Message-ID: <4735BA79.5020102@op5.se>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se> <47359C44.6090903@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 15:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqqxJ-0001oA-4Q
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 15:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbXKJOEp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2007 09:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXKJOEp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 09:04:45 -0500
Received: from mail.op5.se ([193.201.96.20]:52055 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbXKJOEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 09:04:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 62F9A1F0873B;
	Sat, 10 Nov 2007 15:04:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6S37pFnpMbd; Sat, 10 Nov 2007 15:04:42 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 5B9721F0873A;
	Sat, 10 Nov 2007 15:04:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <47359C44.6090903@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64349>

Ren=E9 Scharfe wrote:
> =20
> -#ifdef NO_STRCHRNUL
> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)

This will break things for users of glibc-2.1.1 (the first release stil=
l
available from ftp://sources.redhat.com/pub/glibc/old-releases that
includes the strchrnul() function), since __GLIBC_PREREQ() was invented
after strchrnul() was introduced.

Replacing __GLIBC__ with __GLIBC_PREREQ (as in the original patch) will
solve it nicely. Users of glibc-2.1.1 will be the odd minority where
strchrnul() is available in their libc but not used.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
