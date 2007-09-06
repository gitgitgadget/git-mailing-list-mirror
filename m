From: Steven Grimm <koreth@midwinter.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 06 Sep 2007 11:29:07 -0700
Message-ID: <46E046F3.9000703@midwinter.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709061651550.28586@racer.site> <7vk5r3adlx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITM6N-0008Ts-Mj
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 20:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbXIFS3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbXIFS3J
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 14:29:09 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:54217 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756253AbXIFS3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 14:29:08 -0400
Received: (qmail 10252 invoked from network); 6 Sep 2007 18:29:08 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=KgyQDDBTfUCTFMo/MPnutMs5K79bk246Ox+M8illK8AEX+X/wR6LiAFXpgjHNer7  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Sep 2007 18:29:08 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57925>

Linus Torvalds wrote:
> IOW, if you get lots of small incrmental packs, after a while you really 
> *do* need to do "git gc" to get the real pack generated.
>   

I wonder if it makes sense to repack just the small incremental packs 
into a large (but still incremental) pack, rather than repacking the 
entire repository. Presumably that would be a lot faster than a full 
"git gc", while still giving you reasonably good packing (at least, if 
the threshold is set to a hugh enough number of small packs) and keeping 
things fast. That could run as a second phase of "git gc --auto" -- it 
should be quick enough to not be too terribly annoying since we're not 
running it in the background.

Yeah, if you use the same repo for a long time, you'll accumulate a ton 
of medium-sized packs this way, but (a) that's much better than the 
situation we have today, and (b) it puts off the performance degradation 
for long enough that it becomes more reasonable to expect people to find 
out about running the full "git gc" in the meantime, or for git to 
further evolve to not need it.

-Steve
