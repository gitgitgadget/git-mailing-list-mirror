From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 8 Aug 2013 11:34:35 -0600
Organization: CAF
Message-ID: <201308081134.35735.mfick@codeaurora.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com> <7v61vgazp5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 19:34:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7U6k-0002qH-OB
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965858Ab3HHRej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:34:39 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:34081 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965827Ab3HHRei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:34:38 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED9FD13EC8D;
	Thu,  8 Aug 2013 17:34:37 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id E087813EF89; Thu,  8 Aug 2013 17:34:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 9479F13EC8D;
	Thu,  8 Aug 2013 17:34:37 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7v61vgazp5.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231906>

On Thursday, August 08, 2013 10:56:38 am Junio C Hamano 
wrote:
> I thought the discussion was about making the local gc
> cheaper, and the "Imagine we have a cheap way" was to
> address it by assuming that the daily "pack young
> objects into a single pack" can be sped up if we did not
> have to traverse history.  More permanent packs (the
> older ones in "set of packs staggered by age" Martin
> proposes) in the repository should go through the normal
> history traversal route.

Assuming I understand what you are suggesting, would these 
"young object" likely still get "deduped" in an efficient 
way without doing history traversal (it sounds like they 
would)?  In other words, if I understand correctly, it would 
save time by not pruning unreferenced objects, but it would 
still be deduping things and delta compressing also, so you 
would still likely get a great benefit from creating these 
young object packs?  In other words, is there still a good 
chance that my 317 new pack files which included a 33M pack 
file will still get consolidated down to something near 8M?  

If so, then yeah this might be nice, especially if the 
history traversal is what would speed this up.  Because 
today, my solution mostly saves IO and not time.  I think it 
still saves time, I believe I have seen up to a 50% savings, 
but that is nothing compared to massive, several orders of 
magnitude IO savings.  But if what you suggest could also 
give massive time (orders of magnitude) savings along with 
the IO improvements I am seeing, then suddenly repacking 
regularly would become very cheap even on large repos.  

The only time consuming piece would be pruning then?  Could 
bitmaps eventually help out there?

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
