From: Baruch Even <baruch@ev-en.org>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 21:28:52 +0100
Message-ID: <425D8104.9030109@ev-en.org>
References: <20050412224027.GB20821@elte.hu> <Pine.LNX.4.58.0504121554140.4501@ppc970.osdl.org> <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu> <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:26:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLoQq-00082T-SA
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDMU3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDMU3H
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:29:07 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:56976
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261187AbVDMU3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 16:29:01 -0400
Received: by galon.ev-en.org (Postfix, from userid 105)
	id 3DBA411A5D1; Wed, 13 Apr 2005 23:29:00 +0300 (IDT)
Received: from [10.220.3.66] (hamilton.nuim.ie [149.157.192.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by galon.ev-en.org (Postfix) with ESMTP id 23C6E11A5CE;
	Wed, 13 Apr 2005 23:28:56 +0300 (IDT)
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050413182909.GA25221@elte.hu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on galon.ev-en.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:
> with a plaintext repository we could do the 'hardlink trick' (which 
> brings in other manageability problems and limitations but is at least a 
> partially good idea), which would make the working tree and the 
> repository share the same inode in most cases.
> 
> While in the compressed case we'd have a separate compressed inode 
> (taking up RAM with all its contents) and the working directory inode 
> (taking up RAM) - summing up to more RAM than if we only had a single 
> inode per object.
> 
> furthermore, when generating/destroying large trees (which is a quite 
> common thing), a hardlinked solution is faster, as it doesnt create 
> 250MB+ of dirty RAM. In some cases (e.g. handling dozens of 'merge 
> trees') it's dramatically faster.

You could still have the hardlink way by way of a .git/cache that keeps 
uncompressed files, keep the files with their hash names but uncompressed.

It will be easy to find, fully hard-linkable, only keep the needed files 
  uncompressed and the three year old file compressed. The

You can even save some CPU time by checking if the file is in the cache 
before decompressing it, though it does cost you with an extra disk 
access to see if it's there or not. If you repeat the operation enough 
you'll have the uncompressed version in the cache most of the times anyway.

Clear the cache weekly or so to avoid stale files from an ancient version.

Baruch
