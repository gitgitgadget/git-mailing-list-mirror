From: th.acker66@arcor.de
Subject: Aw: Re: Large repo and pack.packsizelimit
Date: Wed, 9 May 2012 11:29:05 +0200 (CEST)
Message-ID: <952610093.980980.1336555745003.JavaMail.ngmail@webmail11.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de, git@vger.kernel.org
To: nico@fluxnic.net, peff@peff.net
X-From: git-owner@vger.kernel.org Wed May 09 11:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS3Cw-0008WM-CA
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 11:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122Ab2EIJ3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 05:29:11 -0400
Received: from mail-in-18.arcor-online.net ([151.189.21.58]:34268 "EHLO
	mail-in-18.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759116Ab2EIJ3I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 05:29:08 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 1357E3DC8AE;
	Wed,  9 May 2012 11:29:05 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 0D1629DB71;
	Wed,  9 May 2012 11:29:05 +0200 (CEST)
Received: from webmail11.arcor-online.net (webmail11.arcor-online.net [151.189.8.83])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 04FC6107D9B;
	Wed,  9 May 2012 11:29:05 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 04FC6107D9B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1336555745; bh=0TjdlB22T5z8dcRfFpqF7aKfDIbAudljK2QZzsyXIjU=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=hJYkvXYfz9gzW5vdVy7i6J0XKXuv4sQyImucTlNElIO0Ckvc3uaYmFNwCKMqoHMGU
	 FGHi42RQ24P1/NPEzaMPTDagH9jl6wZndhauOIeZqB9o1ryTd6eEI+jViwkufmtH+S
	 2MTNXT2mvz8+cPHhWMumJIKYN0ymntapEVlALgWU=
Received: from [194.138.39.61] by webmail11.arcor-online.net (151.189.8.83) with HTTP (Arcor Webmail); Wed, 9 May 2012 11:29:04 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197463>

 
> On Tue, 8 May 2012, Jeff King wrote:
> 
> > On Tue, May 08, 2012 at 05:13:13PM -0400, Nicolas Pitre wrote:
> > 
> > > > This should be fixed in git. Unfortunately, I don't know that it is
> as
> > > > trivial as just splitting the incoming stream; we would also have to
> > > > make sure that there were no cross-pack deltas in the result.
> > > 
> > > IMHO this is the wrong fix.  The pack size limit was created to deal 
> > > with storage media with limited capacity.  In this case, the repack 
> > > process should be told to limit its memory usage, and pack-index should
> 
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

To be exact I did the clone locally on the same machine and so the clone itself worked
but I got the OOM during the first fetch. I "fixed" this by setting transfer.unpacklimit=100000
which caused only loose objects to be transfered. 
So in this case I think the OOM was on the remote side. But there is another OOM if I try to repack locally.
It seems to me that neither pack-objects nor index-pack respekt pack.packsizelimit and always
try to pack all objects to be transferred resp. all local loose objects in one pack.
I could live wth the transfer.unpacklimit=100000 but the local OOM stops me from using the cloned repo.


---
Thomas
