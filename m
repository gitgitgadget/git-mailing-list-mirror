From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 10:07:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191004560.6730@woody.linux-foundation.org>
References: <20070319051437.GA22494@spearce.org>
 <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 18:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTLL7-0002ws-Nr
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 18:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966030AbXCSRIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966032AbXCSRIH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 13:08:07 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41953 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966029AbXCSRIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 13:08:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JH7icD031435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 10:07:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JH7h3n011849;
	Mon, 19 Mar 2007 09:07:43 -0800
In-Reply-To: <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
X-Spam-Status: No, hits=-2.478 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42645>



On Mon, 19 Mar 2007, Nicolas Pitre wrote:
> 
> In fact, the bigger is the object, the more effective will be the cache.  

Yes. BUT ONLY IF THE CACHE ISN'T SIZE-LIMITED!

Once you limit the size of the cache, you change the whole equation.

It's usually *more* expensive to re-parse two half-sized objects than it 
is to parse one large object. So if you have to choose between 
throwing out two small objects or throwing out one large one, you 
should choose the single large one.

Which totally throws your argument out of the window. It's simply not true 
any more: the cache will *not* be more effective the larger the objects 
are, because you are ignoring the fact that adding a large object will 
*remove* many small ones.

So if I were Junio, I wouldn't accept your patch as it is now. Your 
argument is simply fundamentally flawed.

		Linus
