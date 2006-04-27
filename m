From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 15:18:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604271515490.3701@g5.osdl.org>
References: <20060427213207.GA6709@steel.home> <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 28 00:18:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZEom-00063S-6M
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWD0WSd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWD0WSd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:18:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751758AbWD0WSd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 18:18:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RMINtH004443
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 15:18:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RMIMrG014696;
	Thu, 27 Apr 2006 15:18:23 -0700
To: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19248>



On Thu, 27 Apr 2006, Linus Torvalds wrote:
> 
> I wonder if the _pack-file_ itself might be ok, and the problem is an 
> index file corruption.

Hmm. verify_pack() actually checks that the index file matches its own 
SHA1 earlier, so the index file will have passed (my suggested patch is 
still correct: the same way we check the index file internal integrity 
first, we should also check the pack-file internal integrity before we 
bother to cross-check them with each other).

Anyway, the index file SHA1 check means that it's unlikely that the index 
file was corrupt. But it would be interesting to hear if the pack-file was 
internally consistent or not.. (Something that git-pack-check didn't check 
in your case, because it checked the pack-file against the index file data 
first).

		Linus
