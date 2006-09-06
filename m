From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file rename causes history to disappear
Date: Wed, 6 Sep 2006 08:38:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
References: <44FEE0BB.2060601@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 17:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKzUQ-0000JT-7V
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 17:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWIFPiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 11:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWIFPiz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 11:38:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbWIFPiy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 11:38:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86FcfnW005646
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 08:38:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86FcecG013405;
	Wed, 6 Sep 2006 08:38:40 -0700
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44FEE0BB.2060601@garzik.org>
X-Spam-Status: No, hits=-0.483 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26535>



On Wed, 6 Sep 2006, Jeff Garzik wrote:
>
> I moved a bunch of SATA drivers in the Linux kernel from drivers/scsi to
> drivers/ata.
> 
> When I tried to look at the past history of a file using git-whatchanged,
> post-rename, it only shows the history from HEAD to the point of rename.
> Everything prior to the rename is lost.
> 
> I also tried git-whatchanged on the old path, but that produces an error.

For filenames that don't exist right now, you need to clearly separate the 
revision name from the filename (ie you need to use "--").

There were patches to do "--follow-rename" which I don't think got applied 
yet, but in the meantime, just do

	git whatchanged -M -- drivers/ata/filename.c drivers/scsi/filename.c

where the "-M" means "show diffs as renames if possible" (which is 
different from having the history actually _follow_ them), and the "--" is 
the filename separator to tell git that the nonexistent 
"drivers/ata/filename.c" file isn't a (currently) nonexistent revision 
name, it's a (currently) nonexistent _filename_.

		Linus
