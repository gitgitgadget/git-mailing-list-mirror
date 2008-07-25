From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 07:54:49 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807250751220.9968@xanadu.home>
References: <alpine.DEB.1.00.0807241821440.8986@racer>
 <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807251219530.11976@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 13:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLts-000526-0W
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbYGYLy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 07:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYGYLy4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:54:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33810 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbYGYLyz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:54:55 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4K007LG93D9H20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Jul 2008 07:54:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0807251219530.11976@eeepc-johanness>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90039>

On Fri, 25 Jul 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 24 Jul 2008, Junio C Hamano wrote:
> 
> > The function does not seem to use type (which the patch is also setting) 
> > nor real_type (which the patch does not set).
> > 
> > However, the code checks objects[nth].real_type all over the place in 
> > the code.  Doesn't the lack of real_type assignment in 
> > append_obj_to_pack() affect them in any way?
> 
> >From staring at the code, I thought that real_type was set in 
> resolve_delta(), but I may be wrong.
> 
> The safer thing would be to set it, but I am not quite sure if we can use 
> "type" directly, or if type can be "delta" for an object that is used to 
> complete the pack, and therefore stored as a non-delta.

Objects to complete the pack are always non delta, so the type and 
real_type should be the same.  However that shouldn't matter since at 
that point the object array is not walked anymore, at least not for 
appended objects, and therefore initializing the type at that point is 
redundant.


Nicolas
