From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sat, 11 Apr 2009 13:24:14 -0400
Message-ID: <grqjo1$at2$1@ger.gmane.org>
References: <20090404220743.GA869@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 19:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsh3l-0003cT-LQ
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 19:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbZDKRYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZDKRYe
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 13:24:34 -0400
Received: from main.gmane.org ([80.91.229.2]:57203 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbZDKRYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 13:24:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LsgwR-0003fX-Fu
	for git@vger.kernel.org; Sat, 11 Apr 2009 17:24:31 +0000
Received: from pool-173-79-135-88.washdc.fios.verizon.net ([173.79.135.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 17:24:31 +0000
Received: from mlevedahl by pool-173-79-135-88.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 17:24:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-79-135-88.washdc.fios.verizon.net
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116303>

Robin H. Johnson wrote:

> Hi,
> 
> This is a first in my series of mails over the next few days, on issues
> that we've run into planning a potential migration for Gentoo's
> repository into Git.
> 
> Our full repository conversion is large, even after tuning the
> repacking, the packed repository is between 1.4 and 1.6GiB. As of Feburary
> 4th, 2009, it contained 4886949 objects. It is not suitable for
> splitting into submodules either unfortunately - we have a lot of
> directory moves that would cause submodule bloat.
> 
> During an initial clone, I see that git-upload-pack invokes
> pack-objects, despite the ENTIRE repository already being packed - no
> loose objects whatsoever. git-upload-pack then seems to buffer in
> memory.
> 

Have you considered using a bundle as part of the initial clone process? The 
idea would be to periodically create a bundle

	git bundle create <somename>.bundle [list of refs]

and publish that on your website. A new user would then do

	wget $uri-of-bundle
	git clone <somename>.bundle
	cd $somename
	git remote add origin $origin
	git fetch

and they have the current repo. As the bundle is a file, it can be 
distributed by torrent or other method. The expense of creating the pack in 
the bundle is paid exactly once when the bundle is created.

Mark
