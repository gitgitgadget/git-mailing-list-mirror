From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
	significantly speed up packing/walking
Date: Thu, 6 Aug 2009 16:37:39 -0700
Message-ID: <20090806233739.GL1033@spearce.org>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de> <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com> <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com> <20090806203223.GK1033@spearce.org> <4A7B68C4.8070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Edelen <sirnot@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCWo-00013x-UA
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936AbZHFXhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756934AbZHFXhk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:37:40 -0400
Received: from george.spearce.org ([209.20.77.23]:50225 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756930AbZHFXhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 19:37:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9431E381FD; Thu,  6 Aug 2009 23:37:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A7B68C4.8070406@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125142>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Shawn O. Pearce wrote:
>> Nick Edelen <sirnot@gmail.com> wrote:
>>> Hrmm, I just realized that it dosn't actually cache paths/names...
>>
>> You may not need the path name, but instead the hash value that
>> pack-objects computes from the path name.
>
> Please do NOT expose the hash values. The hash used by pack-objects is  
> an implementation detail of the heuristics used by the _current_ object  
> packing code. It would be a real shame to have to maintain backward  
> compatibility with it at some future date after the packing machinery  
> has changed.

This is a local cache.  If there was a version number in the header,
and the hash function changes, we could just bump the version number
and invalidate all of the caches.

No sense in storing (and doing IO of) huge duplicate string values
for something where we really only need 32 bits, and where a
recompute from scratch only costs a minute.

-- 
Shawn.
