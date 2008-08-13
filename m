From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 10:35:24 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:36:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHSo-0003rG-Tp
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYHMOff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYHMOff
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:35:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31292 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbYHMOfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:35:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5J00LT2N73WP40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Aug 2008 10:35:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92220>

On Tue, 12 Aug 2008, Geert Bosch wrote:

> I've always felt that keeping largish objects (say anything >1MB)
> loose makes perfect sense. These objects are accessed infrequently,
> often binary or otherwise poor candidates for the delta algorithm.

Or, as I suggested in the past, they can be grouped into a separate 
pack, or even occupy a pack of their own.  As soon as you have more than 
one revision of such largish objects then you lose again by keeping them 
loose.

> Many repositories are mostly well-behaved with large number of text
> files that aren't overly large and compress/diff well. However, often
> a few huge files creep in. These might be a 30 MB Word or PDF documents
> (with lots of images of course), a bunch of artwork, some random .tgz files
> with required tools or otherwise.
> 
> Regardless of their origin, the presence of such files in real-world SCMs
> is a given and can ruin performance, even if they're hardly ever accessed
> or updated. If we would leave such oddball objects loose, the pack would
> be much smaller, easier to generate, faster to use and there should be no
> memory usage issues.

You'll have memory usage issues whenever such objects are accessed, 
loose or not.  However, once those big objects are packed once, they can 
be repacked (or streamed over the net) without really "accessing" them.  
Packed object data is simply copied into a new pack in that case which 
is less of an issue on memory usage, irrespective of the original pack 
size.


Nicolas
