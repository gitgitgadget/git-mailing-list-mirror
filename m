From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 08:45:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604220835190.2215@localhost.localdomain>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
 <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
 <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
 <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 21:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXO8S-0004cK-1z
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWDVTvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWDVTvN
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:51:13 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58051 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751090AbWDVTvN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 15:51:13 -0400
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MCmjWF004809
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 12:48:46 GMT
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY400H9BJF09Z80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 22 Apr 2006 08:45:00 -0400 (EDT)
In-reply-to: <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19047>

On Sat, 22 Apr 2006, Junio C Hamano wrote:

> Geert Bosch <bosch@adacore.com> writes:
> 
> > BTW. It's a shame that we don't reuse the index when comparing one
> > source
> >      against multiple targets. Creating the index takes about 70% of
> > the time.
> 
> I think we tried that with Nico/Davide's delta already, and IIRC
> we had mixed results.

Well, actually I was measuring a 10% speed improvement with a quick and 
naive (not memory efficient) approach for pack-objects with the current 
algorithm.

> It really depends on how big an index for a source is.  Keep in
> mind that we keep --window (default=10) of the source text
> in-core, and you are suggesting to keep index in-core as well,
> so we need to take memory pressure into account.

The idea to avoid memory pressure is to reverse the window processing 
such that the object to delta against is constant for the entire window 
instead of the current logic where the target object is constant.  This 
way there would be only one index in memory at all time.


Nicolas
