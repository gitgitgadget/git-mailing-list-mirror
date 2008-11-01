From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 09:50:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0811010944000.13034@xanadu.home>
References: <20081031213114.GA21799@artemis.corp>
 <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
 <20081031232829.GC14786@spearce.org>
 <7v63n872bs.fsf@gitster.siamese.dyndns.org>
 <20081101001300.GE14786@spearce.org>
 <alpine.LFD.2.00.0810312106310.13034@xanadu.home>
 <20081101011910.GH14786@spearce.org>
 <alpine.LFD.2.00.0810312135190.13034@xanadu.home>
 <20081101015217.GJ14786@spearce.org>
 <alpine.DEB.1.00.0811010320370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081101110120.GA3819@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 14:52:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwGte-0008SZ-KH
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 14:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbYKANuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYKANuy
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 09:50:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32079 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYKANux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 09:50:53 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9N006YMQFJDRA0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 01 Nov 2008 09:50:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081101110120.GA3819@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99743>

On Sat, 1 Nov 2008, Pierre Habouzit wrote:

> Well, you can't return _sanely_ an error through a pointer. The &1
> method is broken as soon as you return a char* (there is an alignment
> requirement for malloc, not for any pointer out there), hence shall not
> be used, as it would not be the sole way to test for error.
> 
> Another option, that is _theorically_ not portable, but is ttbomk on all
> the platforms we intend to support (IOW POSIX-ish and windows), is to
> use "small" values of the pointers for errors. [NULL .. (void *)(PAGE_SIZE - 1)[
> cannot exist, which gives us probably always 512 different errors, and

4095 actually.  You don't need to align error codes.

> the test is ((uintptr_t)ptr < (PAGE_SIZE)) which is cheap. It's butt
> ugly, but encoding errors into pointers is butt ugly in the first place.

Or use "negative" pointers.  Again, please have a look at 
include/linux/err.h.  The pointer range from 0xffffffff (or 
0xffffffffffffffff on 64-bit machines) down to the range you want is for 
errors, and the top of the address range is almost certain to never be 
valid in user space either.


Nicolas
