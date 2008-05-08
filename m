From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Thu, 08 May 2008 16:23:53 -0500
Message-ID: <48236F69.2060900@nrlssc.navy.mil>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDbm-0004JW-9H
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbYEHVYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbYEHVYI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:24:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47139 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbYEHVYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:24:07 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m48LNrVI029964;
	Thu, 8 May 2008 16:23:53 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 May 2008 16:23:53 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080508211734.GA819@sigill.intra.peff.net>
X-OriginalArrivalTime: 08 May 2008 21:23:53.0867 (UTC) FILETIME=[D11A05B0:01C8B151]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81568>

Jeff King wrote:
> On Thu, May 08, 2008 at 05:15:34PM -0400, Nicolas Pitre wrote:
> 
>>> According to that commit message, prune is now a no-op. However, it
>>> looks like it is still used for trigger a "repack -a" rather than
>>> "repack -A". I don't know if it is worth making that behavior available
>> Well, actually this is a problem.
>>
>> I think it is a good thing to deprecate gc --prune.  but if that means 
>> that repack -a is never used then unreferenced and expired objects will 
>> never be pruned if they're packed if one is always using 'git gc' as we 
>> are advocating.
> 
> I thought that -A would eventually put them all into a single pack,
> killing off the old packs.

'-a' puts everything in a single pack and kills off old packs. Anything that
was unreachable is not repacked in the new pack.

'-A' does the same thing but it also repacks the unreachable objects that were
previously packed.

So if something gets packed that subsequently becomes unreachable it will never
be removed unless 'repack -a' is used.

Possibly --keep-unreachable should instead unpack the unreachable items which would
allow them to eventually be pruned based on pruneExpire. Then we could indeed
get rid of the --prune option to git-gc.

-brandon
