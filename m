From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance problem, long run of identical hashes
Date: Mon, 10 Dec 2007 11:30:10 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712101129050.555@xanadu.home>
References: <9e4733910712100707i66e185bofe22805b8e0ba4d8@mail.gmail.com>
 <alpine.LFD.0.99999.0712101037270.555@xanadu.home>
 <9e4733910712100820k1bd0959fsdfae92727826c6db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:30:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lWc-0002mT-J8
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbXLJQaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbXLJQaN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:30:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30646 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbXLJQaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:30:11 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU00JGJDUAEO70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 11:30:11 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712100820k1bd0959fsdfae92727826c6db@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67731>

On Mon, 10 Dec 2007, Jon Smirl wrote:

> On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 10 Dec 2007, Jon Smirl wrote:
> >
> > > Running oprofile during my gcc repack shows this loop as the hottest
> > > place in the code by far.
> >
> > Well, that is kind of expected.
> >
> > > I added some debug printfs which show that I
> > > have a 100,000+ run of identical hash entries. Processing the 100,000
> > > entries also causes RAM consumption to explode.
> >
> > That is impossible.  If you look at the code where those hash entries
> > are created in create_delta_index(), you'll notice a hard limit of
> > HASH_LIMIT (currently 64) is imposed on the number of identical hash
> > entries.
> 
> On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 12/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > +               if (victim) {
> > > > +                       sub_size = victim->remaining / 2;
> > > > +                       list = victim->list + victim->list_size - sub_size;
> > > > +                       while (sub_size && list[0]->hash &&
> > > > +                              list[0]->hash == list[-1]->hash) {
> > > > +                               list++;
> > >
> > > I think you needed to copy sub_size to another variable for this loop
> >
> > Copying sub_size was wrong. I believe you are checking for deltas on
> > the same file. It's probably that chain of 103,817 deltas that can't
> > be broken up.
> 
> At the end of multi-threaded repack one thread ends up with 45 minutes
> of work after all the other threads have exited. That's because it
> hits this loop and can't spit the list any more.
> 
> If the lists can't be over 64 identical entries, why do I get caught
> in this loop for 50,000+ iterations? If remove this loop the threads
> are balanced right to the end.

Completely different issue.

Please read my other answers.


Nicolas
