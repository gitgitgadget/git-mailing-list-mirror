From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: proper pack time stamping with
 --max-pack-size
Date: Fri, 14 Mar 2008 00:39:02 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803140035260.2947@xanadu.home>
References: <alpine.LFD.1.00.0803131440590.2947@xanadu.home>
 <7vmyp1vsa7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1iL-0007Kz-Fb
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbYCNEji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbYCNEji
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:39:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28703 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbYCNEjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:39:37 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXP006PPE92N9N0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 14 Mar 2008 00:39:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vmyp1vsa7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77170>

On Thu, 13 Mar 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Runtime pack access is done in the pack file mtime order since recent 
> > packs are more likely to contain frequently used objects than old packs.
> > However the --max-pack-size option can produce multiple packs with mtime 
> > in the reversed order as newer objects are always written first.
> >
> > Let's modify mtime of later pack files (when any) so they appear older 
> > than preceding ones when a repack creates multiple packs.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > ---
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > index f504cff..4c2ed70 100644
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > @@ -17,6 +17,8 @@
> >  #include "progress.h"
> >  #include "refs.h"
> >  
> > +#include <utime.h>
> > +
> 
> Hmmm.  Shouldn't this go to git-compat-util.h?

Maybe... if you say so.

The whole header file arrangement logic is somewhat escaping my mind, so 
I simply decided to do the same as in test-chmtime.c.


Nicolas
