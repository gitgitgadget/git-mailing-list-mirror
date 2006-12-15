X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 21:26:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612142125460.18171@xanadu.home>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se>
 <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
 <20061214194636.GO1747@spearce.org>
 <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 02:26:45 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34463>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv2mZ-0003Az-6A for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965042AbWLOC0k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWLOC0k
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:26:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52258 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965042AbWLOC0j (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:26:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA002RUMSE4RG0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 21:26:39 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 14 Dec 2006, Shawn Pearce wrote:
> 
> > Geert Bosch <bosch@adacore.com> wrote:
> > > Such special magic based on filenames is always a bad idea. Tomorrow  
> > > somebody
> > > comes with .zip files (oh, and of course .ZIP), then it's .jpg's other
> > > compressed content. In the end git will be doing lots of magic and  
> > > still perform
> > > badly on unknown compressed content.
> > > 
> > > There is a very simple way of detecting compressed files: just look  
> > > at the
> > > size of the compressed blob and compare against the size of the  
> > > expanded blob.
> > > If the compressed blob has a non-trivial size which is close to the  
> > > expanded
> > > size, assume the file is not interesting as source or target for deltas.
> > > 
> > > Example:
> > >    if (compressed_size > expanded_size / 4 * 3 + 1024) {
> > >      /* don't try to deltify if blob doesn't compress well */
> > >      return ...;
> > >    }
> > 
> > And yet I get good delta compression on a number of ZIP formatted files 
> > which don't get good additional zlib compression (<3%). Doing the above 
> > would cause those packfiles to explode to about 10x their current size.
> 
> A pity. Geert's proposition sounded good to me.
> 
> However, there's got to be a way to cut short the search for a delta 
> base/deltification when a certain (maybe even configurable) amount of time 
> has been spent on it.

Yes! Run git-repack -a -d on the remote repository.


