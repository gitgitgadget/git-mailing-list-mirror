From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git import of the recent full enwiki dump
Date: Fri, 16 Apr 2010 17:53:42 -0700
Message-ID: <20100417005342.GA8475@spearce.org>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com> <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com> <20100417004852.GA32053@post.servercare.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Sam Vilain <sam@vilain.net>
To: Sebastian Bober <sbober@servercare.de>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:02:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2wQC-0001ll-4s
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694Ab0DQBCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:02:00 -0400
Received: from mail-yx0-f195.google.com ([209.85.210.195]:45147 "EHLO
	mail-yx0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758595Ab0DQBB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:01:59 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2010 21:01:59 EDT
Received: by yxe33 with SMTP id 33so1640519yxe.15
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:01:59 -0700 (PDT)
Received: by 10.101.136.33 with SMTP id o33mr4714225ann.63.1271465624742;
        Fri, 16 Apr 2010 17:53:44 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 34sm886629yxf.18.2010.04.16.17.53.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 17:53:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100417004852.GA32053@post.servercare.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145102>

Sebastian Bober <sbober@servercare.de> wrote:
> The question would be, how the commits and the trees are laid out.
> If every wiki revision shall be a git commit, then we'd need to handle
> 300M commits. And we have 19M wiki pages (that would be files). The tree
> objects would be very large and git-fast-import would crawl.
> 
> Some tests with the german wikipedia have shown that importing the blobs
> is doable on normal hardware. Getting the trees and commits into git
> was not possible up to now, as fast-import was just to slow (and getting
> slower after 1M commits).

Well, to be fair to fast-import, its tree handling code is linear
scan based, because that's how any other part of Git handles trees.

If you just toss all 19M wiki pages into a single top level tree,
that's going to take a very long time to locate the wiki page
talking about Zoos.

> I had the idea of having an importer that would just handle this special
> case (1 file change per commit), but didn't get around to try that yet.

Really, fast-import should be able to handle this well, assuming you
aren't just tossing all 19M files into a single massive directory
and hoping for the best.  Because *any* program working on that
sort of layout will need to spit out the 19M entry tree object on
each and every commit, just so it can compute the SHA-1 checksum
to get the tree name for the commit.

-- 
Shawn.
