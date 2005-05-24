From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 01:25:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>
  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com>
 <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 10:29:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaUmM-00062P-Fy
	for gcvg-git@gmane.org; Tue, 24 May 2005 10:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVEXI1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 04:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVEXI0h
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 04:26:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:5536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261442AbVEXIX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 04:23:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O8NGjA000378
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 01:23:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O8NEbg016228;
	Tue, 24 May 2005 01:23:15 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Linus Torvalds wrote:
> 
> I've gotten side-tracked with purely git issues, and since I don't 
> actually have any CVS archives, the cvs->git translation will be on the 
> back-burner for a while, but your "Ancestor branch" patch seems to at 
> least solve the problem that cvsps didn't show all the information that 
> was there.

Naff.

I just checked in a "cvs2git.c" file in the "tools" project (which has my 
patch application stuff).

It's still buggy, and it's hacky as hell, but you can basically do 
something like this:

	cvsps | cvs2git > script

with the normal setup for "cvsps", and "cvs2git" needs one additional
stage, namely it wants to know the RCSDIR where to find the RCS files
(that should be basically "$CVSROOT/module").

That _script_ then creates a git archive. Very hacky. So after you've 
successfully created the conversion script, check it to see that it looks 
sane, and then do

	sh script

and the end result is a git'ified version of your CVS repo (and a 
corrupted working directory, btw, so look out. It _shouldn't_ corrupt 
your old CVS repo, though, so it should be ok).

It has the logic for branches, but it doesn't work, and I'm fed up enough
with CVS and RCS for the moment that I'm not going to work on it any more
tonight. I don't know what stupid bug I have (I've had about a million of
them on this silly program), but it's at a point where I think others
might find it interesting, and it's probably/hopefully some really
embarrassing typo or something and easily fixed.

It converted Peter's "syslinux" repository in a couple of minutes, 
resulting in 1038 commits (it _should_ have resulted in 1046 commits, 
that's the branch thing afaik) and most of it looks sane:

	diff-tree cfb715c827e19226a446d47c98a7460fd94633ff (from a809559323f1b370717e475dd252b24686f97727)
	Author: hpa <hpa>
	Date:   Thu May 19 22:30:50 2005 -0700
	    
	    gcc4 compilation fix
	
	
	diff-tree a809559323f1b370717e475dd252b24686f97727 (from 4d65331b50a7b5ce858bb55a58f37b17ebc26c72)
	Author: hpa <hpa>
	Date:   Sun May 8 22:47:03 2005 -0700
	    
	    New Multiboot module; increase command line limit to 1023
	
	
	diff-tree 4d65331b50a7b5ce858bb55a58f37b17ebc26c72 (from e88244753d528f695790adc96f0542d20dc33882)
	Author: hpa <hpa>
	Date:   Fri Apr 29 07:08:03 2005 -0700
	    
	    Don't clobber live registers, it's not nice
	
	
	diff-tree e88244753d528f695790adc96f0542d20dc33882 (from a49e189e35d208648a0d0b52ff652a5f3f8a707e)
	Author: hpa <hpa>
	Date:   Fri Apr 29 07:05:52 2005 -0700
	    
	    Use the correct register

	...
	...
	...

	diff-tree 350772d45425a85dae86ec721d6bd3fde5595d50 (from 47ee894e7821f50cb83ea14b08132337577b2a1e)
	Author: hpa <hpa>
	Date:   Sat Jan 31 13:24:35 1998 -0800
	    
	    Slightly less ugly Id tag.
	
	
	diff-tree 47ee894e7821f50cb83ea14b08132337577b2a1e (from a8b52f1c31055049b276d14c67436d06dd7757aa)
	Author: hpa <hpa>
	Date:   Sat Jan 31 13:22:38 1998 -0800
	    
	    Added Id tags.
	
	
	diff-tree b924672aadb2c3b7f3cac1aaf52fbb4a1ed86b8d (from root)
	Author: hpa <hpa>
	Date:   Sat Jan 31 13:16:05 1998 -0800
	    
	    Initial revision

And btw, it's definitely cvsps that does all the heavy lifting here. 
"cvs2git" itself is 255 lines of horrid crud, and should have been 
written in perl, except I only do C..

		Linus
