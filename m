From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: epic fsck SIGSEGV!
Date: Thu, 11 Dec 2008 09:33:36 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812110928060.3340@localhost.localdomain>
References: <1228867861.14165.19.camel@starfruit.local> <7vd4g051ax.fsf@gitster.siamese.dyndns.org> <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net> <1228949523.27061.20.camel@starfruit.local> <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home> <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain> <alpine.LFD.2.00.0812101930590.3340@localhost.localdomain> <7v63lrupxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 18:35:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LApRn-0007io-JR
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbYLKReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 12:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756651AbYLKReS
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 12:34:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54006 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756645AbYLKReR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 12:34:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBBHXd3L008263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Dec 2008 09:33:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBBHXaQD006865;
	Thu, 11 Dec 2008 09:33:37 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v63lrupxk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102807>



On Wed, 10 Dec 2008, Junio C Hamano wrote:
> 
> I'll consider this signed-off and do the usual forging

Yea. I've even tested it a bit now:

	[torvalds@nehalem git]$ ulimit -s 1024
	[torvalds@nehalem git]$ git fsck --full
	Segmentation fault
	[torvalds@nehalem git]$ ./git-fsck --full
	dangling commit 3d00b49495ceff119de52dc5443731e2d8d84b6b
	dangling commit 4e0a3c7de9af3cbb53cc421329f0579679edbb51
	...

so it does seem to fix the issue, and the patch looks safe enough.

It passes all the tests, and works fine on the kernel repo too (ugh, four 
minutes! I used to run git-fsck religiously every day back in the early 
days, now I realized that I must not have done so in _months_, and my 
kernel tree has grown and so has fsck time).

But obviously the true test for fsck is some complex corruption, and I 
didn't test that. I can't imagine that it introduces any new problems 
though - but the bugs you can't imagine are always the worst ones ;)

			Linus
