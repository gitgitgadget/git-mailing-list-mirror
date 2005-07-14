From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 08:37:00 +0100
Message-ID: <20050714083700.A26322@flint.arm.linux.org.uk>
References: <20050713135052.C6791@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:37:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsyHd-0007K1-3H
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVGNHhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVGNHhG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:37:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56594 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262942AbVGNHhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:37:04 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DsyHF-0005Yr-Mr; Thu, 14 Jul 2005 08:37:02 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DsyHE-0006x7-HM; Thu, 14 Jul 2005 08:37:00 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org>; from torvalds@osdl.org on Wed, Jul 13, 2005 at 01:28:18PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 01:28:18PM -0700, Linus Torvalds wrote:
> On Wed, 13 Jul 2005, Russell King wrote:
> > This says it all.  1min 22secs to generate a patch from a locally
> > modified but uncommitted file.
> 
> No, there's something else going on.
> 
> Most likely that something forced a total index file re-validation, and
> the time you see is every single checked out file having its SHA1
> re-computed.
> 
> Was this a recently cloned tree, or what was the last operation you did on
> that tree before that command? Something must have invalidated the index.

cg-update origin
and then I edited drivers/serial/8250.c

As discovered using:

	sh -x /usr/bin/cg-diff drivers/serial/8250.c

it appears that cg-diff does a

	git-update-cache --refresh >/dev/null

each time it's run, which is taking the bulk of the time.  Also note
that curiously, it exits with status 1.

-- 
Russell King
