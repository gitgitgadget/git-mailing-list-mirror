From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Fix the rename detection limit checking
Date: Fri, 14 Sep 2007 11:49:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709141146110.16478@woody.linux-foundation.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
 <20070906022539.GG18160@spearce.org> <20070906101648.GD6665@basalt.office.altlinux.org>
 <20070909044648.GH18160@spearce.org> <7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
 <20070913035137.GM3099@spearce.org> <7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
 <20070914000108.GE3619@basalt.office.altlinux.org> <7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
 <20070914024303.GH3619@basalt.office.altlinux.org>
 <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141017450.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141132250.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWGGS-0006IB-7d
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbXINSvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbXINSvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:51:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46874 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756468AbXINSvI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 14:51:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EInp7M018245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2007 11:49:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EInoUV019256;
	Fri, 14 Sep 2007 11:49:51 -0700
In-Reply-To: <alpine.LFD.0.999.0709141132250.16478@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58180>



On Fri, 14 Sep 2007, Linus Torvalds wrote:
> 
> but the patch I sent out was the "obvious" first one that at least avoided 
> the overflow for the triggerable case that Dmitry had, and as per above 
> likely in all reasonable cases...

Final note (I promise): the patch I sent out took "git runstatus" times on 
the workload I replicated from Dmitry down from "so long you'd ^C it" to 
about two seconds..

So I wanted to point out that this was not just the correctness issue of 
the overflow, but that the rename limiting really does need to be done for 
purely practical time reasons - doing the math in 64 bits would have 
avoided the overflow, but wouldn't have avoided the real reason for not 
wanting to do these kinds of things in the first place!

		Linus
