From: Russell King <rmk@arm.linux.org.uk>
Subject: Is cogito really this inefficient
Date: Wed, 13 Jul 2005 13:50:52 +0100
Message-ID: <20050713135052.C6791@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 13 14:53:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsgjv-0006Q2-8W
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 14:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVGMMwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 08:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVGMMwF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 08:52:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30739 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262639AbVGMMu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 08:50:56 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DsghS-0004de-7h
	for git@vger.kernel.org; Wed, 13 Jul 2005 13:50:54 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DsghR-00032D-2f
	for git@vger.kernel.org; Wed, 13 Jul 2005 13:50:53 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This says it all.  1min 22secs to generate a patch from a locally
modified but uncommitted file.

cp, edit, diff would be several orders of magnitude faster.  What's
going on?

$ /usr/bin/time cg-diff drivers/serial/8250.c > o
Command exited with non-zero status 1
14.40user 17.47system 1:22.96elapsed 38%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (180major+14692minor)pagefaults 0swaps

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2333,6 +2333,7 @@ static int __devinit serial8250_probe(st
 			dev_err(dev, "unable to register port at index %d "
 				"(IO%lx MEM%lx IRQ%d): %d\n", i,
 				p->iobase, p->mapbase, p->irq, ret);
+			printk(KERN_ERR "uartclk was %d\n", port.uartclk);
 		}
 	}
 	return 0;

-- 
Russell King
