From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC v2] git-p4: stream from perforce to speed up clones
Date: Sat, 25 Jul 2009 10:23:29 -0400
Message-ID: <20090725142329.GA3841@arf.padd.com>
References: <1247301071-9541-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:33:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiJm-0007R3-Eb
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbZGYOdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbZGYOdL
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:33:11 -0400
Received: from marge.padd.com ([99.188.165.110]:39112 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbZGYOdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:33:04 -0400
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id 6B020121A646;
	Sat, 25 Jul 2009 07:23:33 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 341013E40FE; Sat, 25 Jul 2009 10:23:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1247301071-9541-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124013>

luke@diamand.org wrote on Sat, 11 Jul 2009 09:31 +0100:
> Change commit() to stream data from Perforce and into fast-import
> rather than reading into memory first, and then writing out. This
> hugely reduces the memory requirements when cloning non-incrementally.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> I've modified git-p4 so that it streams/pipes data into fast-import rather
> that reading everything into memory first. The old scheme meant that
> for a large repository (mine is around 2G) my PC just grinds to a
> halt and never actually finishes. With this change it takes around ten
> minutes.
> 
> This is a resend of a patch I sent earlier, which my MUA helpfully
> managed to word-wrap.

This is definitely good stuff.  While I'd like to get Daniel's
native transport code working in my environment, I had a need to
import some big trees quickly from p4 to git.  Usually I resort to a
rare big-memory machine to do the git-p4 import, but with your
change, I can use my laptop without going into swap or
out-of-memory.

For the content, I would recommend some changes.  Here are some
patches on top of yours:

    [PATCH 1/5] git-p4 stream: remove unused function
    [PATCH 2/5] git-p4 stream: do not pass branchPrefixes so much
    [PATCH 3/5] git-p4 stream: show relative path in debug messages
    [PATCH 4/5] git-p4 stream: check apple file type
    [PATCH 5/5] git-p4 stream: use existing p4CmdList with callback

They clean up the code and change your main iterator loop to reuse
the existing p4CmdList.

I'd suggest you merge these into your patch and send it back out.
It's a worthwhile change and we should get Simon to review it.

		-- Pete
