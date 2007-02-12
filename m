From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC] Speeding up a null fetch
Date: Mon, 12 Feb 2007 00:14:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702120005530.5695@beast.quantumfyre.co.uk>
References: <200702112332.14698.julian@quantumfyre.co.uk>
 <Pine.LNX.4.63.0702120045320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 01:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOq3-0004ms-F8
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 01:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbXBLAOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 19:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbXBLAOO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 19:14:14 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:51927 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbXBLAON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 19:14:13 -0500
Received: (qmail 28178 invoked by uid 103); 12 Feb 2007 00:14:12 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2551. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032266 secs); 12 Feb 2007 00:14:12 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 12 Feb 2007 00:14:12 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.63.0702120045320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39342>

On Mon, 12 Feb 2007, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 11 Feb 2007, Julian Phillips wrote:
>
>> An artifical test repository that has similar features (~25000 commits,
>> ~8000 tags, ~900 branches and a 2.5Gb packfile) when running locally
>> takes ~20m to clone and ~48m to fetch (with no new commits in the
>> original repository - i.e. the fetch does not update anything) with a
>> current code base (i.e. newer than 1.5.0-rc4).
>
> Ouch.
>
> I hope you packed the refs?

Unfortunately packing only makes things slower ... as it then becomes 
impossible to directly access a particular ref directly, which some of the 
calls to show-ref do.

>
> BTW your patch
> - was not minimal (and therefore it takes longer than necessary to find
>  what you actually fixed),
> - it does not show where and how the call to show-ref is avoided (I
>  eventually understand that you avoid calling update_local_ref early, but
>  you sure could have made that easier), and

Ah yes, sorry.  I seem to have managed to forget to include the paragraph 
explaining what I had done ... :$

(That'll teach me to trying doing too many things at once.)

> - it uses Pythong.
>
> Also, it touches a quite core part of git, which will hopefully be
> replaced by a builtin _after_ 1.5.0.

Indeed, I would never propose what I have done so far as a fix.  I am 
definitely still in the investigation phase.

>
>> However, this seems more band-aid than fix, and I wondered if someone
>> more familiar with the git internals could point me in the right
>> direction for a better fix, e.g. should I look at rewriting fetch in C?
>
> Look into the "pu" branch of git. There are the beginnings of a builtin
> (written in C) fetch.

Ah - this I didn't know.  I shall have to have a play with that, I did 
notice that there is internal caching of the ref list that might magically 
solve the problem if fetch was a builtin (but I have a feeling that it 
won't be that simple).

>
> But this _will_ have to wait until after 1.5.0.

I hope so.  1.5 is looking very nice, and I really don't think that many 
people have such a stuipdly large repository ...

>
> Ciao,
> Dscho
>

-- 
Julian

  ---
You are in a maze of little twisting passages, all alike.
