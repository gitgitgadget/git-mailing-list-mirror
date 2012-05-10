From: Thomas <th.acker66@arcor.de>
Subject: Re: Large repo and pack.packsizelimit
Date: Thu, 10 May 2012 11:42:09 +0000 (UTC)
Message-ID: <loom.20120510T133639-197@post.gmane.org>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net> <20120508203137.GA15707@sigill.intra.peff.net> <alpine.LFD.2.02.1205081709010.21030@xanadu.home> <20120508212012.GA20044@sigill.intra.peff.net> <alpine.LFD.2.02.1205081751011.21030@xanadu.home> <loom.20120509T113505-740@post.gmane.org> <CACsJy8BhSn+PB5tXME-w_cq4DVd2BULNRNLV-vk1_6yWKy+fNg@mail.gmail.com> <loom.20120509T131228-943@post.gmane.org> <7vlil1tg7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 13:42:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSRlL-00031q-07
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 13:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759294Ab2EJLmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 07:42:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:36905 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab2EJLmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 07:42:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SSRlC-0002ya-7q
	for git@vger.kernel.org; Thu, 10 May 2012 13:42:18 +0200
Received: from proxy36.sbs.de ([194.138.39.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2012 13:42:18 +0200
Received: from th.acker66 by proxy36.sbs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 May 2012 13:42:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.138.39.56 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.168 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197556>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Thomas <th.acker66 <at> arcor.de> writes:
> 
> > (1) all objects to be transferred to another repo 
> > (2) all loose objects when starting a local repack
> > Case (1) can be fixed by transfer.unpacklimit but there is no fix for (2).
> 
> Technically (1) is putting everything in a single pack to transfer, and it
> is only the receiving end that does the chopping.
> 
> For (2), you could do something like
> 
> 	keep=$( git rev-list --objects $some_rev |
> 	        git pack-objects --delta-base-offset pack ) &&
> 	mv pack-$keep.pack pack-$keep.idx .git/objects/pack/ &&
> 	echo "keep $some_rev" >.git/objects/pack/pack-$keep.keep
> 
> after finding a suitable $some_rev that is old enough so that it will be
> an ancestor of anything that matters in the future and gives small enough
> packfiles.  You may want to try doing the above multiple times, by picking
> a few strategic ranges, e.g.
> 
> 	for some_rev in v1.0 v1.0..v2.0 v2.0..v2.4 v2.4..v3.0
> 	do
> 		... the above four lines come here ...
> 	done
> 

Not really a porcelain-level solution ;-) but I will try it.
Thanks!
Is there any chance that (1) and (2) will be solved by using packsizelimit
in the future?
Will there be any porcelain/plumbing commands for creating/deleting
.keep files for packs?
---
Thomas
