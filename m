From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write
 failures
Date: Wed, 06 Feb 2008 14:31:47 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802061420510.2732@xanadu.home>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
 <e1dab3980802061110p2c1dad1ep8a46eeda93839bb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Steven Tweed <d.s.tweed@reading.ac.uk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMq0M-00045y-CW
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYBFTbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYBFTbt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:31:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49082 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYBFTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:31:48 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVU00I1W0WZOZ80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 14:31:47 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e1dab3980802061110p2c1dad1ep8a46eeda93839bb9@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72830>

On Wed, 6 Feb 2008, David Tweed wrote:

> I guess the -n ought to be honoured. However, unless I'm missing
> something, the case of expiring objects is different. The primary
> reason is that objects can get orphaned by "semantic" decisions
> (delete this branch, rewind, etc) so they contain valid content that
> you might want to later rescue (using low-level command like git cat
> if necessary).

You can also get loose unconnected objects when fetching and the number 
of objects is lower than the transfer.unpackLimit value.

> In contrast, the only way to get a temporary pack when
> the repository is quiescent is resulting from a _write error_ and thus
> is a corrupt entity which it would take a great deal of work to
> extract any valid data from.

Or when a fetch is in progress, just like the case above, but with the 
number of objects greater than transfer.unpackLimit.

This is uncommon to have a prune occurring at the same time as a fetch, 
but the --expire argument is there if for example you do a prune from a 
cron job but still want to be safe by giving a grace period to garbage 
files which might not be so after all.


Nicolas
