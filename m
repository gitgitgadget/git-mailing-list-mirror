From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Build configuration to skip ctime for modification test
Date: Wed, 23 Jul 2008 21:16:47 +0200
Message-ID: <20080723191647.GF5283@blimp.local>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjqR-00044N-Gu
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbYGWTQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYGWTQw
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:16:52 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:25444 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:16:51 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5EC7
Received: from tigra.home (Faf34.f.strato-dslnet.de [195.4.175.52])
	by post.webmailer.de (mrclete mo11) (RZmta 16.47)
	with ESMTP id 0063d5k6NFE4D3 ; Wed, 23 Jul 2008 21:16:48 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id D1EEB277BD;
	Wed, 23 Jul 2008 21:16:47 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id CAD6636D18; Wed, 23 Jul 2008 21:16:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231757550.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89749>

Johannes Schindelin, Wed, Jul 23, 2008 18:59:02 +0200:
> On Wed, 23 Jul 2008, Alex Riesen wrote:
> 
> > Because exactly the file mode (the executable bit) is the reason for
> > checking ctime.
> 
> But ctime is broken on Windows.  Because ctime is supposed to change 
> whenever the _inode_ changes.

It is not that it is broken. We just don't need it, because the st_mode
is not used, and the rest of inode information is not used anyway.

> You have to admit that saying "I ignore the ctime because the executable 
> bit is broken" must leave the reader puzzled.

This is conclusion. I said "file mode" and "file attributes", which
is how reason for ctime update is defined in SUSv3. man 2 stat says:

       The field st_ctime is changed by writing or by setting  inode
       information (i.e., owner, group, link count, mode, etc.).

Not just "inode" but "inode information". Only mode is used, and even
that is ignored on Windows.
