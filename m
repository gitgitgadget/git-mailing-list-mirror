From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 8 Jan 2010 17:07:46 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001081701570.7821@localhost.localdomain>
References: <4B474C73.8080100@mtu.net> <4B4751EA.8060707@drmicha.warpmail.net> <20100108162404.GA5799@coredump.intra.peff.net> <7vr5q05z74.fsf@alter.siamese.dyndns.org> <20100108164132.GA6171@coredump.intra.peff.net> <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org> <7vvdfcfjxo.fsf@alter.siamese.dyndns.org> <7veim0w68q.fsf_-_@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain> <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain> <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPoS-0001Q3-Cc
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 02:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab0AIBH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 20:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775Ab0AIBH7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 20:07:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41301 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754172Ab0AIBH6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 20:07:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0917kQI017764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jan 2010 17:07:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0917krp025342;
	Fri, 8 Jan 2010 17:07:46 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v8wc8kshh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.446 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136507>



On Fri, 8 Jan 2010, Junio C Hamano wrote:
> 
> Yes, and the previous patch wasn't adding what is ignored to the array, so
> here is a re-roll to fix that in addition to the fix to "should the loop
> start from checking an empty path?" issue you noticed.

Ack. Looks ok to me, and I think it's a lot more obvious.

> But I am starting to wonder if we might be better off restructuring
> read_directory_recursive().  Currently it assumes that the path it was
> given _must_ be of interest (i.e. not ignored) and runs excluded() on
> subdirectories it finds to make that same decision before recursing into
> them or skipping them.  It might make more sense if it first checked if
> the path given by the caller should be ignored and act accordingly.

Hmm. I can't make myself care one way or the other, I have to admit.  I 
assume you mean basically taking the path and using the first component of 
it _instead_ of doing a readdir() - and getting rid of the simplification 
up front?

I agree that that should work. Would it be simpler and cleaner? Perhaps. 
I'd have to see both patches to be able to tell. I do admit that while I 
acked your patch, it sure ain't _pretty_ to do that special odd 
"has_leading_ignored_dir()" thing.

		Linus
