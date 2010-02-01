From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 01 Feb 2010 11:11:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
References: <loom.20100201T101056-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 17:12:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbysd-0003DI-3W
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 17:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab0BAQL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 11:11:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40871 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab0BAQL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 11:11:56 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX6009ZQ7NVC8K0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 11:11:55 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <loom.20100201T101056-232@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138619>

On Mon, 1 Feb 2010, Sergio wrote:

> Hi,
> 
> documentation about pack.packSizeLimit
> 
> says:
> 
> The default maximum size of a pack. This setting only affects packing to a file,
> i.e. the git:// protocol is unaffected. It can be overridden by the
> --max-pack-size option of git-repack(1).
> 
> I would suggest clarifying it into
> 
> The default maximum size of a pack in bytes. This setting only affects packing
> to a file, i.e. the git:// protocol is unaffected. It can be overridden by the
> --max-pack-size option of git-repack(1).
> 
> Since --max-pack-size takes MB and one might be tempted to assume that the same
> is valid for pack.packSizeLimit.

Grrrrr.  This is a terrible discrepency given that all the other 
arguments in Git are always byte based, with the optional k/m/g suffix, 
by using git_parse_ulong().  So IMHO I'd just change --max-pack-size to 
be in line with all the rest and have it accept bytes instead of MB.  
And of course I'd push such a change to be included in v1.7.0 along with 
the other incompatible fixes.

Your suggested precision above is still worth it of course.

> Also note that some safety check on pack.packSizeLimit could probably be
> desirable to avoid an unreasonably small limit. For instance:
> 
> Assume that pack.packSizeLimit is set to 1 (believing it would be 1MB, but it is
> in fact 1B). With this at the first git gc every object goes in its own pack.
> You realize the mistake, you fix pack.packSizeLimit to 1000000, but at this
> point you cannot go back since git gc cannot run anymore (too many open files).

That's a totally orthogonal issue.  There are other ways to get into 
trouble with too many open files and that deserves a fix of its own 
(such as limiting the number of simultaneous opened packs).


Nicolas
