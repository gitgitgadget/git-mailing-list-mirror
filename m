From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 08:24:51 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807250819100.9968@xanadu.home>
References: <alpine.DEB.1.00.0807241821440.8986@racer>
 <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807251219530.11976@eeepc-johanness>
 <alpine.LFD.1.10.0807250751220.9968@xanadu.home>
 <20080725120102.GB32487@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Acq+bGOlAjAhZvbu1TxRqQ)"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, spearce@spearce.org,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 14:26:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMMMy-000717-3T
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 14:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbYGYMY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 08:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYGYMY6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 08:24:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58237 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbYGYMY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 08:24:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4K00AMKAHFXZD0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Jul 2008 08:24:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080725120102.GB32487@atjola.homenet>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90042>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Acq+bGOlAjAhZvbu1TxRqQ)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Fri, 25 Jul 2008, Björn Steinbrink wrote:

> On 2008.07.25 07:54:49 -0400, Nicolas Pitre wrote:
> > On Fri, 25 Jul 2008, Johannes Schindelin wrote:
> > 
> > > Hi,
> > > 
> > > On Thu, 24 Jul 2008, Junio C Hamano wrote:
> > > 
> > > > The function does not seem to use type (which the patch is also setting) 
> > > > nor real_type (which the patch does not set).
> > > > 
> > > > However, the code checks objects[nth].real_type all over the place in 
> > > > the code.  Doesn't the lack of real_type assignment in 
> > > > append_obj_to_pack() affect them in any way?
> > > 
> > > >From staring at the code, I thought that real_type was set in 
> > > resolve_delta(), but I may be wrong.
> > > 
> > > The safer thing would be to set it, but I am not quite sure if we can use 
> > > "type" directly, or if type can be "delta" for an object that is used to 
> > > complete the pack, and therefore stored as a non-delta.
> > 
> > Objects to complete the pack are always non delta, so the type and 
> > real_type should be the same.  However that shouldn't matter since at 
> > that point the object array is not walked anymore, at least not for 
> > appended objects, and therefore initializing the type at that point is 
> > redundant.
> 
> Is that still true when the object has been pruned due to memory
> constraints set by deltaBaseCacheLimit? AFAICT when reloading the data
> for the object, we end up in get_base_data, which at least checks
> obj->type.

yeah, true.  I don't really have this new code path in my head yet.

In any case, appended objects should have type = real_type = non delta 
type.


Nicolas

--Boundary_(ID_Acq+bGOlAjAhZvbu1TxRqQ)--
