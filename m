From: Thomas <th.acker66@arcor.de>
Subject: Re: Large repo and pack.packsizelimit
Date: Wed, 9 May 2012 09:36:10 +0000 (UTC)
Message-ID: <loom.20120509T113505-740@post.gmane.org>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net> <20120508203137.GA15707@sigill.intra.peff.net> <alpine.LFD.2.02.1205081709010.21030@xanadu.home> <20120508212012.GA20044@sigill.intra.peff.net> <alpine.LFD.2.02.1205081751011.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 12:35:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS4Et-0006ip-TB
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 12:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab2EIKfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 06:35:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:51043 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772Ab2EIKfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 06:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SS4Ea-0006bt-Mt
	for git@vger.kernel.org; Wed, 09 May 2012 12:35:04 +0200
Received: from proxy31.sbs.de ([194.138.39.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2012 12:35:04 +0200
Received: from th.acker66 by proxy31.sbs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2012 12:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.138.39.61 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.168 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197464>

Nicolas Pitre <nico <at> fluxnic.net> writes:

> 
> On Tue, 8 May 2012, Jeff King wrote:
> 
> > On Tue, May 08, 2012 at 05:13:13PM -0400, Nicolas Pitre wrote:
> > 
> > > > This should be fixed in git. Unfortunately, I don't know that it is as
> > > > trivial as just splitting the incoming stream; we would also have to
> > > > make sure that there were no cross-pack deltas in the result.
> > > 
> > > IMHO this is the wrong fix.  The pack size limit was created to deal 
> > > with storage media with limited capacity.  In this case, the repack 
> > > process should be told to limit its memory usage, and pack-index should 
> > > simply be taught to cope.
> > 
> > Hmm, you're right. I was thinking it helped to deal with memory
> > addressing issues for 32-bit systems, but I guess
> > core.packedGitWindowSize should be handling that. IOW, the 10G packfile
> > should work just fine for normal access.
> > 
> > However, the OP did say he got an "out of memory" error during the
> > clone. So maybe there is a problem to be fixed in index-pack there.
> 
> Was the OOM on the remote side (pack-objects) or on the local side 
> (index-pack) ?
> 
> Nicolas
> 
To be exact I did the clone locally on the same machine and so the clone itself 
worked
but I got the OOM during the first fetch. I "fixed" this by setting 
transfer.unpacklimit=100000
which caused only loose objects to be transfered. 
So in this case I think the OOM was on the remote side. But there is another OOM 
if I try to repack locally.
It seems to me that neither pack-objects nor index-pack respekt 
pack.packsizelimit and always
try to pack all objects to be transferred resp. all local loose objects in one 
pack.
I could live wth the transfer.unpacklimit=100000 but the local OOM stops me from 
using the cloned repo.
---
Thomas
