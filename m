From: Mike Hommey <mh@glandium.org>
Subject: Re: Why Git is so fast
Date: Fri, 1 May 2009 11:42:21 +0200
Message-ID: <20090501094221.GB13264@glandium.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no> <20090501052434.GA4750@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 11:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzpGL-000113-U7
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 11:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbZEAJmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 05:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbZEAJmZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 05:42:25 -0400
Received: from vuizook.err.no ([85.19.221.46]:56842 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbZEAJmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 05:42:25 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LzpG8-0007w3-19; Fri, 01 May 2009 11:42:22 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LzpG9-0003Td-5f; Fri, 01 May 2009 11:42:21 +0200
Content-Disposition: inline
In-Reply-To: <20090501052434.GA4750@dpotapov.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118070>

On Fri, May 01, 2009 at 09:24:34AM +0400, Dmitry Potapov wrote:
> On Thu, Apr 30, 2009 at 10:36:03PM +0200, Kjetil Barvik wrote:
> >      4) The "static inline void hashcpy(....)" in cache.h could then
> >         maybe be written like this:
> > 
> >   static inline void hashcpy(unsigned long sha_dst[5], const unsigned long sha_src[5])
> >   {
> >        sha_dst[0] = sha_src[0];
> >        sha_dst[1] = sha_src[1];
> >        sha_dst[2] = sha_src[2];
> >        sha_dst[3] = sha_src[3];
> >        sha_dst[4] = sha_src[4];
> >   }
> > 
> >         And hopefully will be compiled to just 5 store/more
> >         instructions, or at least hopefully be faster than the currently
> >         memcpy() call. But mabye we get more compiled instructions compared
> >         to a single call to memcpy()?
> 
> Good compilers can inline memcpy and should produce more efficient code
> for the target architecture, which can be faster than manually written.
> On x86_64, memcpy() requires only 3 load/store operations to copy SHA-1
> while the above code requires 5 operations.

I guess, though, that some enforced alignment could help produce
slightly more efficient code on some architectures (most notably sparc,
which really doesn't like to deal with unaligned words).

Mike
