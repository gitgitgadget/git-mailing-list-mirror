From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 09:10:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
References: <20070319051437.GA22494@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKRb-0007lb-HT
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbXCSQKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbXCSQKp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:10:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39966 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030310AbXCSQKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:10:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JGAecD029624
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 09:10:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JGAdAh010579;
	Mon, 19 Mar 2007 08:10:39 -0800
In-Reply-To: <20070319051437.GA22494@spearce.org>
X-Spam-Status: No, hits=-2.478 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42635>



On Mon, 19 Mar 2007, Shawn O. Pearce wrote:
>
> Round two, based on comments on IRC from Junio:

One more change: please don't even *add* objects to the cache that are 
bigger than 10-20% of the cache limit!

If you start adding big objects, and you have some cache limit, that will 
make the cache seriously less useful by causing eviction of potentially 
much more interesting objects, and also obviously causing the cache code 
itself to spend much more time picking objects (since it's enough to have 
just a few big objects to make the cache eviction decide it needs to 
evict).

Limiting by size is also effective since anything that is more than a 
megabyte is likely to be a blob anyway, and thus much less useful for 
caching in the first place. So there are just tons of reasons to say 
"don't even add it in the first place" if you decide to go with any limit 
at all.

		Linus
