From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 0/3] avoid quadratic behavior in fetch-pack
Date: Tue, 2 Jul 2013 11:45:07 -0600
Organization: CAF
Message-ID: <201307021145.07726.mfick@codeaurora.org>
References: <201307012102.31384.mfick@codeaurora.org> <20130702052827.GA10626@sigill.intra.peff.net> <20130702061149.GB1206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 19:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu4dh-0000zI-23
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab3GBRpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 13:45:10 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:52509 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab3GBRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:45:09 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 20DE413ED2A;
	Tue,  2 Jul 2013 17:45:09 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 14C9A13F092; Tue,  2 Jul 2013 17:45:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id C7CF313ED2A;
	Tue,  2 Jul 2013 17:45:08 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20130702061149.GB1206@sigill.intra.peff.net>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229409>

On Tuesday, July 02, 2013 12:11:49 am Jeff King wrote:
> Here are my patches to deal with Martin's pathological
> case, split out for easy reading. I took a few timings
> to show that the results of the 3rd patch are noticeable
> even with 50,000 unique refs (which is still a lot, but
> something that I could conceive of a busy repo
> accumulating over time).
> 
>   [1/3]: fetch-pack: avoid quadratic list insertion in
> mark_complete [2/3]: commit.c: make
> compare_commits_by_commit_date global [3/3]: fetch-pack:
> avoid quadratic behavior in rev_list_push
> 
> And here's the diffstat to prove it is really not scary.
> :)
> 
>  commit.c     |  2 +-
>  commit.h     |  2 ++
>  fetch-pack.c | 16 ++++++++--------
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> -Peff

I applied these 3 patches and it indeed improves things 
dramatically.  Thanks Peff, you are awesome!!!


The synthetic test case (but sorted), now comes in at around 
15s.  The more important real world case (for us), fetching 
from my production server, which took around 12mins 
previously, now takes around 30s (I think the extra time is 
now spent on the Gerrit server, but I will investigate that 
a bit more)!  That is very significant and should make many 
workflows much more efficient.  +1 for merging this. :)

Again, thanks,

-Martin


Note, I tested git-next 1.8.3.2.883.g27cfd27 to be sure that 
it is still problematic without this patch, it is (running 
for 10mins now without completing).


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
