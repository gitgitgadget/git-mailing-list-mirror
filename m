From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Tue, 26 Apr 2005 20:18:02 +0200
Message-ID: <E1DQUdL-0000rx-P3@be1.7eggert.dyndns.org>
References: <3X9X6-5JP-27@gated-at.bofh.it> <3Xdel-8u2-43@gated-at.bofh.it> <3XfpD-21C-11@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 26 20:18:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUca-0007Ve-6B
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVDZSVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZST0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:19:26 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:42453 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261670AbVDZSTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 14:19:12 -0400
Received: from be3.lrz.7eggert.dyndns.org (dsl-213-023-007-254.arcor-ip.net [213.23.7.254])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP
	id 97A7623DA8; Tue, 26 Apr 2005 20:17:48 +0200 (CEST)
Received: from be1.lrz ([192.168.1.201] helo=be1.7eggert.dyndns.org)
	by be3.lrz.7eggert.dyndns.org with esmtp (Exim 4.43)
	id 1DQUih-0002Hk-RZ; Tue, 26 Apr 2005 20:23:39 +0200
Received: from localhost ([127.0.0.1] helo=be1)
	by be1.7eggert.dyndns.org with smtp (Exim 4.22)
	id 1DQUdL-0000rx-P3; Tue, 26 Apr 2005 20:18:07 +0200
To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
User-Agent: KNode/0.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias-Christian Ott <matthias.christian@tiscali.de> wrote:

> And if you think "register" variables are outdated, please remove the
> CONFIG_REGPARM option from the Kernel source.

Register variables are outdated because they hinder the compiler from
optimizing by taking away 1/7 of the usable registers on x86. Use six
register variables and you're back to a accumulator-machine.
Use -O2 or -Os instead, the compiler is smarter than you.

The regparm calling convention will change the
load value -> store value on stack -> call sequence into
load value -> call -> store if needed
Obviously the second form can be better optimized than the first one.
Therefore it's a gain instead of a loss.

If you really want to help the compiler, look for something like repeated
pointer dereference or access to global variables and cache them in block-
local variables (pointers, int and uint only, even for caching chars).
Beware of volatile variables, and don't forget to look at the assembler code.
-- 
The generation of random numbers is too important to be left to chance. 

