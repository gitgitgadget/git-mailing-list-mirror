From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Thu, 08 May 2008 16:40:20 -0500
Message-ID: <48237344.6070405@nrlssc.navy.mil>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDrm-0003ww-H4
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684AbYEHVkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757551AbYEHVkg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:40:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41204 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbYEHVke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:40:34 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m48LeLw6030334;
	Thu, 8 May 2008 16:40:21 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 May 2008 16:40:21 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080508213107.GA1016@sigill.intra.peff.net>
X-OriginalArrivalTime: 08 May 2008 21:40:21.0405 (UTC) FILETIME=[1DB85CD0:01C8B154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81572>

Jeff King wrote:
> On Thu, May 08, 2008 at 04:23:53PM -0500, Brandon Casey wrote:
> 
>>> I thought that -A would eventually put them all into a single pack,
>>> killing off the old packs.
>> '-a' puts everything in a single pack and kills off old packs. Anything that
>> was unreachable is not repacked in the new pack.
>>
>> '-A' does the same thing but it also repacks the unreachable objects that were
>> previously packed.
> 
> Ah, indeed. I hadn't looked closely at the -A behavior before. So yes,
> we are never killing off prunable packed objects. Probably we could use
> the same solution as "git prune --expire"; perhaps a
> "--keep-unreachable=2.weeks.ago"?

The 'prune --expire' behavior is based on object mtime (i.e. file modification time).
That is lost once something is packed right?

I was thinking that either repack or pack-objects could be modified to unpack those
unreachable objects and leave them loose, and also give them the timestamp of the
pack file they came from. Then the --expire behavior of git-prune could work normally
and remove them. This seems like it would work nicely since prune follows repack in
git-gc.

-brandon
