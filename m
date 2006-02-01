From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 08:04:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602010800090.21884@g5.osdl.org>
References: <20060201070847.2021.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 17:05:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4KTQ-0007Ur-1D
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 17:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWBAQE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWBAQE1
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 11:04:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422659AbWBAQE0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 11:04:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11G4KDZ008037
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 08:04:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11G4Iwd011869;
	Wed, 1 Feb 2006 08:04:19 -0800
To: linux@horizon.com
In-Reply-To: <20060201070847.2021.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15423>



On Tue, 1 Feb 2006, linux@horizon.com wrote:
> 
> At the risk of complicating something already very complicated, and
> possibly breaking on Microsoft file systems, that case can be detected
> by reading the directory and noticing that the inode number changed.
> 
> Would it be worth validating the inode numbers (which can be retrieved
> in a batch) even if you don't do a full lstat()?

I don't think it's worth it. It's the unusual case anyway, and it doesn't 
even really guarantee anything either (the person _could_ just have marked 
the inode writable - not understanding what is going on, he could have 
just done a "chmod +w" behind git's back).

Together with the fact that it might not work everywhere, and that I could 
well imagine that "readdir()" is slow on cygwin too (how does it do 
"d_ino"? Maybe it has to do a stat() to emulate unix behaviour?), I'm not 
convinced it's worth it.

I think the whole "assume it's valid" is a crutch - but if we do it, we 
should make it _really_ fast, because it's also useful for automated 
procedures that _know_ which files they touch. So we should make it have 
minimal impact.

		Linus
