From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Don't recurse into parents marked uninteresting.
Date: Wed, 8 Mar 2006 21:48:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603082144450.32577@g5.osdl.org>
References: <pan.2006.03.08.20.04.24.62170@smurf.noris.de>
 <pan.2006.03.09.04.04.34.617873@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 06:48:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHE0g-00048H-Sx
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 06:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWCIFsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 00:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWCIFsY
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 00:48:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932658AbWCIFsX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 00:48:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k295m2DZ016771
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Mar 2006 21:48:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k295m0HX016264;
	Wed, 8 Mar 2006 21:48:01 -0800
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2006.03.09.04.04.34.617873@smurf.noris.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17399>



On Thu, 9 Mar 2006, Matthias Urlichs wrote:
>
> revision.c:make_parents_uninteresting() is exponential with the number
> of merges in the tree. That's fine -- unless some other part of git
> already has pulled the whole commit tree into memory ...

Good call.

However, I would have expected the normal case to be that we haven't even 
parsed the parent yet (as per the comment), so the parent normally 
shouldn't even have the parent pointer (due to not having been parsed).

So what was it that triggered this "parents had already been parsed" 
situation? Is it because we've generated a huge list of "I have it" 
objects when pulling? That would explain it..

		Linus
