From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 10:08:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004070952290.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
 <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E15.9040403@gmail.com>
 <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Vitaly Berov <vitaly.berov@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:09:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzVwG-0007ga-8G
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718Ab0DGOI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:08:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32499 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab0DGOI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:08:56 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I00314FAV6K90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 10:08:56 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144219>

On Wed, 7 Apr 2010, Ilari Liusvaara wrote:

> On Wed, Apr 07, 2010 at 09:54:29AM +0400, Vitaly Berov wrote:
> > I suspected the security reasons.
> > 
> > Ok, we work in trusted environment. How can we turn this behavior off?
>  
> It can't be turned off. Protocol requires client to recompute hashes
> as they are not explicitly available in transport stream (must be inferred
> instead).
> 
> > >This being said, you should never have to wait 6 hours for that phase to
> > >complete.  It is typically a matter of minutes if not seconds.
> 
> The reasons why it might take 6 hours (offhand from memory):
> 
> - Extremely large repo

Six hours is still way out of the expected computational requirement.  
That's an expected time for an aggressive repack for example, where 
_each_ delta is attempted against a different base up to 250 times.  
But when indexing a fetched pack, each delta is expected to be computed 
only once.

> - Very large files in repo pushing client into swap.

This shouldn't happen since commit 92392b4a which provide a cap on 
memory usage during the delta resolution process.

So without a look at the actual repository causing this pathological 
behavior it is hard to guess what the issue and the required fix might 
be.


Nicolas
