From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC assembly implementation of SHA1
Date: Sun, 24 Apr 2005 12:49:28 +1000
Message-ID: <1114310968.5444.24.camel@gaston>
References: <20050423124246.30071.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 04:40:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPX2s-0000RZ-3Y
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVDXCpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 22:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVDXCpN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 22:45:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:10161 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262234AbVDXCpH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 22:45:07 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j3O2dngJ000404;
	Sat, 23 Apr 2005 21:39:52 -0500
To: linux@horizon.com
In-Reply-To: <20050423124246.30071.qmail@science.horizon.com>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 12:42 +0000, linux@horizon.com wrote:

> - You don't need to decrement %r1 before saving registers.
>   The PPC calling convention defines a "red zone" below the
>   current stack pointer that is guaranteed never to be touched
>   by signal handlers or the like.  This is specifically for
>   leaf procedure optimization, and is at least 224 bytes.

On ELF ppc32 ABI ? Hrm... the SysV ABI document says

"The only permitted references with negative offsets from the stack
pointer are those described here for establishing a stack frame."

I know MacOS had a red zone, but do we ?

> - Is that many stw/lwz instructions faster than stmw/lmw?
>   The latter is at least more cahce-friendly.

More cache friendly ? Hrm.. I wouldn't be sure. Also, I remember readind
a while ago that those store/load multiple instructions aren't that
recommended. They aren't very good on some CPU models. I would expect
the bus/cache bandwidth to be the limiting factor here anyway, and as
you point out below, the they don't deal with unaligned access very well
in all cases.
 

