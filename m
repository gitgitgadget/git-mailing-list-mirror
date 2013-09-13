From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Fri, 13 Sep 2013 12:09:35 +0200
Message-ID: <20130913100934.GE14259@raven.wolf.lan>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <20130912103531.GD14259@raven.wolf.lan>
 <20130912194453.GD32069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 12:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKQKN-0006xW-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 12:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab3IMKKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 06:10:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:45902 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683Ab3IMKKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 06:10:10 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VKQKH-0004qS-8E; Fri, 13 Sep 2013 12:10:09 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 634D57638E; Fri, 13 Sep 2013 12:09:35 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130912194453.GD32069@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234739>

On Thu, Sep 12, 2013 at 03:44:53PM -0400, Jeff King wrote:
> On Thu, Sep 12, 2013 at 12:35:32PM +0200, Josef Wolf wrote:
> 
> > I'm not sure I understand correctly. I see that bitmaps can be used to
> > implement set operations. But how comes that walking the graph requires a lot
> > of CPU? Isn't it O(n)?
> 
> Yes and no. Your "n" there is the entirety of history.

Is this really true?

> (and each one needs to be pulled off of the disk,
> decompressed, and reconstructed from deltas).

While you need to unpack commits/trees to traverse further down, I can't see
any reason to unpack/reconstruct blobs just to see whether you need to send
it. The SHA is all you need to know, isn't it?

> Secondly, the graph traversal ends up seeing the same sha1s over and
> over again in tree entries (because most entries in the tree don't
> change from commit to commit).

Whenever you see an object (whether commit or tree) that you already have
seen, you can stop traversing further down this part of the graph/tree, as
everything you will see on this part has already be seen before.

Why would you see the same commits/trees over and over again? You'd stop
traversing on the boundary of the already-seen-territory, leaving the vast
majority of the "duplicated" structure under the carpet. Somehow I fail to see
the problem here.

-- 
Josef Wolf
jw@raven.inka.de
