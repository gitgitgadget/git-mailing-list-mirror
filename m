From: Mike Hommey <mh@glandium.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 07:33:06 +0200
Organization: glandium.org
Message-ID: <20080513053306.GA18232@glandium.org>
References: <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home> <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home> <20080512202414.GA8620@mithlond.arda.local> <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org> <20080513001252.GB29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 13 07:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvn9U-0000JB-Rb
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 07:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbYEMFd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 01:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbYEMFd0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 01:33:26 -0400
Received: from vuizook.err.no ([194.24.252.247]:60123 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833AbYEMFdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 01:33:25 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1Jvn8R-0003zQ-Ec; Tue, 13 May 2008 07:33:17 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Jvn8M-00051E-M4; Tue, 13 May 2008 07:33:06 +0200
Content-Disposition: inline
In-Reply-To: <20080513001252.GB29038@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81989>

On Mon, May 12, 2008 at 08:12:52PM -0400, Shawn O. Pearce wrote:
> Mike Hommey <mh@glandium.org> wrote:
> > On Mon, May 12, 2008 at 11:03:04PM +0200, Mike Hommey wrote:
> > > On Mon, May 12, 2008 at 11:24:14PM +0300, Teemu Likonen wrote:
> > > > But I have experienced the same earlier with some other post-1.5.5
> > > > version so I believe you can reproduce this yourself. After cloning
> > > > Linus's linux-2.6 repo its .git directory weights 209MB. After single
> > > > "git pull" and "git gc" it was 298MB in my test.
> > > 
> > > I noticed that a while ago: when repacking multiple packs when one has a
> > > .keep file, the resulting additional pack contains too many blobs and
> > > trees, contrary to when only packing loose objects:
> > (...)
> > 
> > That is, it seems to also contain all the blobs and subtrees for all the
> > commits the pack contains, even when they already are in the pack having
> > a .keep file.
> 
> I've noticed this too.  Like since day 1 when we added .keep.
> But uh, nobody else complained and I forgot about it.
> 
> My theory (totally unproven) is that the new pack has objects we
> copied from the .keep pack, because those objects were the best
> delta-bases for the loose objects we have deltafied and want to
> store in the new pack.  Except they aren't yet packed in the new
> pack, so we pack them too.  Tada, duplicates.  :-\

Well, that does not seem delta related, since my testcase doesn't show
deltas in the second pack.

Mike
