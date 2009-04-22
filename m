From: Nicolas Pitre <nico@cam.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 13:39:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
 <20090422152719.GA12881@coredump.intra.peff.net>
 <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwgRf-0000B6-IU
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 19:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbZDVRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 13:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZDVRj2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 13:39:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54138 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbZDVRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 13:39:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII00G2WJPLPLP0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 13:39:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117221>

On Wed, 22 Apr 2009, Brandon Casey wrote:

> Jeff King wrote:
> > On Tue, Apr 21, 2009 at 05:46:16PM -0400, John Dlugosz wrote:
> > 
> >> Immediately after doing a git gc, a git fsck --full reports dangling
> >> objects.  Is this normal?  What does dangling mean, if not those things
> >> that gc finds?
> > 
> > gc will leave dangling loose objects for a set expiration time
> > (defaulting to two weeks). This makes it safe to run even if there are
> > operations in progress that want those dangling objects, but haven't yet
> > added a reference to them (as long as said operation takes less than two
> > weeks).
> > 
> > You can also end up with dangling objects in packs. When that pack is
> > repacked, those objects will be loosened, and then eventually expired
> > under the rule mentioned above. However, I believe gc will not always
> > repack old packs; it will make new packs until you have a lot of packs,
> > and then combine them all (at least that is what "gc --auto" will do; I
> > don't recall whether just "git gc" follows the same rule).
> 
> 'git gc' (without --auto) always creates one new pack.
> 
> I've often wondered whether a plain 'git gc' should adopt the behavior
> of --auto with respect to the number of packs.  If there were few packs,
> then 'git gc' would do an incremental repack, rather than a 'repack -A -d -l'.

Why so?  Having fewer packs is always a good thing.  Having only one 
pack is of course the optimal situation.  The --auto version doesn't do 
it in the hope of being lightter and less noticeable by the user.  
However the user manually invoking gc should be expecting some work is 
actually happening.  If you don't want the whole repo read from one pack 
just to be written in another pack (say the repo is huge and waiting 
after the IO is not worth it) then just mark such a pack with a .keep 
file.


Nicolas
