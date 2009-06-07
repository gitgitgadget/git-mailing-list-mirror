From: Nicolas Pitre <nico@cam.org>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 07 Jun 2009 12:41:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLRt-0002tZ-1O
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbZFGQmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 12:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbZFGQmI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:42:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34681 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbZFGQmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 12:42:08 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKV0070UNPKT7C0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Jun 2009 12:41:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120980>

On Sun, 7 Jun 2009, Nick Edelen wrote:

> I'm using the --revs flag in pack-objects, which causes it to use
> get_object_list().  you'll notice, regardless of whether --thin is
> set, this function still calls
> 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
> which sets uninteresting objects as preferred bases, which I'd think
> would create a thin pack.  I could be wrong though...

Look at the arguments passed to setup_revisions().
When --thin is set, the --objects-edge flag is passed instead of 
--objects.  Now see what effect this has on the third argument of 
mark_edges_uninteresting().

> as I mentioned in the comment and above, it's an easy fix, but even 
> then I wasn't sure what to do with commit grafts.  as use_thin_pack 
> seemed to be predominantly set on shallow interactions, I just didn't 
> bother seperating the cases 'normal but thick pack' and 'shallow 
> stuff'.

Please do separate them.  In theory you could use thin packs with a 
relative deepening of a shallow clone.  In other words, !thin and 
shallow is a wrong association to make.


Nicolas
