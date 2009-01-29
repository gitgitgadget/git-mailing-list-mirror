From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Valgrind updates
Date: Wed, 28 Jan 2009 17:56:05 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901281751580.3123@localhost.localdomain>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain> <alpine.DEB.1.00.0901272241250.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: zlib@gzip.org, valgrind-users@lists.sourceforge.net,
	Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMAs-0004HE-AT
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZA2B5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbZA2B5H
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:57:07 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51729 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753059AbZA2B5G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 20:57:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0T1u6eU000627
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Jan 2009 17:56:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0T1u5bn025629;
	Wed, 28 Jan 2009 17:56:05 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0901272241250.14855@racer>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107611>



On Tue, 27 Jan 2009, Johannes Schindelin wrote:
> 
> To help ye Gods, I put together this almost minimal C program:

This one is buggy.

> 	out = fopen("/dev/null", "w");
> 	fwrite(compressed + 51, 51, 1, out);
> 	fwrite(compressed + 51, 1, 1, stderr);
> 	fflush(out);
> 	fclose(out);

The problem is that the first argument to that first "fwrite()" is simply 
wrong. It shouldn't be "compressed + 51", it should be just "compressed". 
As it is, you're writing 51 bytes, starting at 51 bytes in, and that's 
obviously not correct (you only got 58 bytes from deflate()).

So valgrind does complain about it, but for a perfectly valid reason.

So I think your minimal C program isn't actually showing what you wanted 
to show, and isn't showing the behaviour you see in git.

			Linus
