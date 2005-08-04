From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: bisect gives strange answer
Date: Thu, 04 Aug 2005 18:41:41 +0100
Message-ID: <E1E0jiv-0003c4-00@skye.ra.phy.cam.ac.uk>
References: <20050804172635.GA14144@kroah.com>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 19:44:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0jlJ-0005JM-QO
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 19:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVHDRnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 13:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVHDRnI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 13:43:08 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:45518 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261920AbVHDRlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 13:41:49 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1E0jiv-0006MJ-KC; Thu, 04 Aug 2005 18:41:41 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1E0jiv-0003c4-00; Thu, 04 Aug 2005 18:41:41 +0100
To: Greg KH <greg@kroah.com>
In-Reply-To: Your message of "Thu, 04 Aug 2005 10:26:35 PDT."
             <20050804172635.GA14144@kroah.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> By any chance, is this patch causing you problems?

No, sadly.  But I had hopes!  As I think about it more, there's no way
it could, since I have CONFIG_HOTPLUG=y, so moving the CONFIG_HOTPLUG
would not change anything (for those who don't know the patch, it is
appended below).  

My latest theory is that I fed bisect incorrect good/bad data.
Perhaps If I had checked out and compiled those intermediate versions
from scratch, each version in a separate directory, then I would have
got different answers.  Two possible reasons:

1. The kernel Makefiles ar do not understand every subtle dependency.
   So they might get confused by updating to different tree states (as
   the bisect progresses) because those updates change Makefiles and
   include files.  In other words, I should have done 'make clean' or
   'make mrproper' before each kernel compile.

2. git-bisect-script doesn't use -f when it does 'git checkout', so
   files that should be updated are not.  Right now I'm in the middle
   of recollecting the data with git-bisect-script using -f in all
   uses of git checkout (unless that is a really silly idea).

-Sanjoy


git diff a18bcb7450840f07a772..3d3c2ae1101c1f2dff7e2f9d514769779dbd2737
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -17,13 +17,13 @@
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
 
-#ifdef CONFIG_HOTPLUG
-
 struct pci_dynid {
	struct list_head node;
	struct pci_device_id id;
 };
 
+#ifdef CONFIG_HOTPLUG
+
 /**
  * store_new_id
  *
