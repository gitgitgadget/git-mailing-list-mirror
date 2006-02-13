From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 08:44:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602130838010.3691@g5.osdl.org>
References: <20060213002502.5c23122c.akpm@osdl.org> <7virrj1v44.fsf@assigned-by-dhcp.cox.net>
 <20060213013205.4ba47836.akpm@osdl.org> <20060213093938.GC11053@mythryan2.michonline.com>
 <20060213015146.26e6c09d.akpm@osdl.org> <20060213101443.GD11053@mythryan2.michonline.com>
 <20060213022527.3f888666.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 17:45:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8gpK-0007jR-Di
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 17:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBMQpX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 11:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBMQpX
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 11:45:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932138AbWBMQpW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 11:45:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DGihDZ009635
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 08:44:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1DGigxx025972;
	Mon, 13 Feb 2006 08:44:42 -0800
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213022527.3f888666.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16076>



On Mon, 13 Feb 2006, Andrew Morton wrote:

> Ryan Anderson <ryan@michonline.com> wrote:
> > 
> > git format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20
> 
> That worked.

Well, really, it's much nicer these days to just say

	git show 386093ef9

and you're done.

For me, it gives a nice

	diff-tree 386093ef9a6c88576d8b418bf1c8616d5e410a20 (from ce5f8d70ba6e3d7ffcaff86b2cf91a42c27f77af)
	Author: Alexey Dobriyan <adobriyan@gmail.com>
	Date:   Wed Feb 1 03:04:57 2006 -0800
	
	    [PATCH] ipw2200: fix ->eeprom[EEPROM_VERSION] check
	    
	    priv->eeprom is a pointer.
	    
	    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
	    Acked-by: Yi Zhu <yi.zhu@intel.com>
	    Cc: James Ketrenos <jketreno@linux.intel.com>
	    Signed-off-by: Andrew Morton <akpm@osdl.org>
	    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
	
	diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
	index 916b24c..14beab4 100644
	--- a/drivers/net/wireless/ipw2200.c
	+++ b/drivers/net/wireless/ipw2200.c
	@@ -2456,7 +2456,7 @@ static void ipw_eeprom_init_sram(struct 
	           copy.  Otherwise let the firmware know to perform the operation
	           on it's own
	         */
	-       if ((priv->eeprom + EEPROM_VERSION) != 0) {
	+       if (priv->eeprom[EEPROM_VERSION] != 0) {
	                IPW_DEBUG_INFO("Writing EEPROM data into SRAM\n");
	 
	                /* write the eeprom data to sram */

which looks sane.

> I'm still not having much success geting a string of patches out of it.
> 
> git format-patch -o ~/a d834a41c966c6a20368fadb59248740935e6fbae..826eeb53a6f264842200d3311d69107d2eb25f5e

well, that's 1003 patches you're asking for. 

That's almost certainly _not_ what you want.

Do "gitk ..args.." to visually see what you're doing. Or, what I did:

	git-rev-list d834a41c966c6a20368fadb59248740935e6fbae..826eeb53a6f264842200d3311d69107d2eb25f5e |
		wc -l

which is how I got the 1003.

I'm pretty sure it wasn't what you meant to do.

> How do I get the IPW patches out of Jeff's tree, in order?
> 
> I guess since I found a command which actually works, I can type that
> 20-odd times.

"git show". Much simpler. HOWEVER. Doing that 20-odd times sounds insane. 
Just use gitk to see that you actually have the right starting and ending 
points.

Visualizing the history really is very important. If you had tried gitk, 
you'd have immediately seen what you were doing, and that it wasn't what 
you wanted.

Only after you're really comfortable with git should you do anything at 
all without looking at it visually first.

(After you've done that a few months, you won't need it any more - your 
brain will be able to visualize things on its own. gitk is just the 
training wheels).

			Linus
