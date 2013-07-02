From: Martin Fick <mfick@codeaurora.org>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 2 Jul 2013 10:58:58 -0600
Organization: CAF
Message-ID: <201307021058.58563.mfick@codeaurora.org>
References: <201307012102.31384.mfick@codeaurora.org> <51D29C3E.5070600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 02 18:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu3v1-00039s-0C
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 18:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab3GBQ7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 12:59:01 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:50286 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab3GBQ7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 12:59:00 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EFF913F092;
	Tue,  2 Jul 2013 16:59:00 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 0070013F05D; Tue,  2 Jul 2013 16:58:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id B8F0513F05D;
	Tue,  2 Jul 2013 16:58:59 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <51D29C3E.5070600@alum.mit.edu>
X-Length: 2178
X-UID: 254
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229402>

On Tuesday, July 02, 2013 03:24:14 am Michael Haggerty 
wrote:
> > git rev-list HEAD | for nn in $(seq 0 100) ; do for c
> > in $(seq 0 10000) ; do  read sha ; echo $sha
> > refs/c/$nn/$c$nn ; done ; done > .git/packed-refs
> 
> I believe this generates a packed-refs file that is not
> sorted lexicographically by refname, whereas all
> Git-generated packed-refs files are sorted.  


Yes, you are indeed correct.  I was attempting to be too 
clever with my sharding I guess.  Thanks.

> There are
> some optimizations in refs.c for adding references in
> order that might therefore be circumvented by your
> unsorted file.  Please try sorting the file by refname
> and see if that helps.  (You can do so by deleting one
> of the packed references; then git will sort the
> remainder while rewriting the file.)

A simple git pack-refs seems to clean it up.

The original test did complete in ~77mins last night.  A 
rerun with a sorted file takes ~61mins,

-Martin


PS: This test was performed with git version 1.8.2.1 on 
linux 2.6.32-37-generic #81-Ubuntu SMP 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
