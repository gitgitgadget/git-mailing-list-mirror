From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Ideas to speed up repacking
Date: Tue, 3 Dec 2013 12:26:51 -0700
Organization: CAF
Message-ID: <201312031226.52033.mfick@codeaurora.org>
References: <201312021630.45767.mfick@codeaurora.org> <CACsJy8CBOp_5nwm=WWBG_AZ+h6M7L6WpdX4ACeJxwuJ0kqu0Gw@mail.gmail.com> <xmqqhaapq0xc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvcZ-0008DA-2a
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab3LCT0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:26:55 -0500
Received: from smtp.codeaurora.org ([198.145.11.231]:59336 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab3LCT0y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 14:26:54 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3965413EF21;
	Tue,  3 Dec 2013 19:26:54 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 2AFF513F01C; Tue,  3 Dec 2013 19:26:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id AFDA213EF21;
	Tue,  3 Dec 2013 19:26:53 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <xmqqhaapq0xc.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238722>

> Martin Fick <mfick@codeaurora.org> writes:
> > * Setup 1:
> >   Do a full repack.  All loose and packed objects are
> >   added
...
> > * Scenario 1:
> >   Start with Setup 1.  Nothing has changed on the repo
> > contents (no new object/packs, refs all the same), but
> > repacking config options have changed (for example
> > compression level has changed).


On Tuesday, December 03, 2013 10:50:07 am Junio C Hamano 
wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> > Reading Martin's mail again I wonder how we just
> > "grab all objects and skip history traversal". Who will
> > decide object order in the new pack if we don't
> > traverse history and collect path information.
> 
> I vaguely recall raising a related topic for "quick
> repack, assuming everything in existing packfiles are
> reachable, that only removes loose cruft" several weeks
> ago.  Once you decide that your quick repack do not care
> about ejecting objects from existing packs, like how I
> suspect Martin's outline will lead us to, we can repack
> the reachable loose ones on the recent surface of the
> history and then concatenate the contents of existing
> packs, excluding duplicates and possibly adjusting the
> delta base offsets for some entries, without traversing
> the bulk of the history.

>From this, it sounds like scenario 1 (a single pack being 
repacked) might then be doable (just trying to establish a 
really simple baseline)?  Except that it would potentially 
not result in the same ordering without traversing history?  
Or, would the current pack ordering be preserved and thus be 
correct?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
