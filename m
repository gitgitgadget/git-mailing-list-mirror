From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Tue, 12 Feb 2008 16:51:12 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802121645121.2732@xanadu.home>
References: <20080210175812.GB12162@auto.tuwien.ac.at>
 <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802101929310.2732@xanadu.home>
 <20080211195623.GA21878@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802111513360.2732@xanadu.home>
 <20080211215806.GA24971@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802120937330.2732@xanadu.home>
 <20080212190411.GA23837@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802121507310.2732@xanadu.home>
 <20080212213858.GA29151@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:52:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP32r-0006pv-4r
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYBLVv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYBLVv0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:51:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62181 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbYBLVvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:51:25 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW5009ZYBDCC761@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 16:51:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080212213858.GA29151@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73699>

On Tue, 12 Feb 2008, Martin Koegler wrote:

> On Tue, Feb 12, 2008 at 03:22:17PM -0500, Nicolas Pitre wrote:
> > On Tue, 12 Feb 2008, Martin Koegler wrote:
> > > We will need some additional memory for struct blob/tree/tag/commit
> > > even for this check.
> > 
> > Why so?
> > 
> > Each received object is stored in memory when received, so why can't you 
> > simply validate it in place?  No need to keep trace of them afterward.
> 
> Freeing the data is not my problem.

Well, I would say it is now.  ;-)

> Many validations are in parse_XXX_buffer, which are also used by
> fsck. This returns a struct commit/tree/tag/blob.
> 
> I have not found any code in git to free them. 

Maybe we should add it then.  Especially in the usual case where we want 
incoming objects to be validated.

> Same for pack-objects, e.g. add_objects_in_unpacked_packs allocates
> many struct object via lookup_unknown_object. As far as I understand
> the code, they are never freed, even if they are not needed later.

Hmmm, that's bad.


Nicolas
