From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 16:59:57 -0600
Message-ID: <557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com> <20140324225434.GB17080@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Scott Sandler <scott.m.sandler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:00:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSDqa-0006W9-GL
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 00:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbaCXW7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:59:55 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:45950 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaCXW7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:59:54 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7686613ED8D;
	Mon, 24 Mar 2014 22:59:54 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 6AB7E13F02B; Mon, 24 Mar 2014 22:59:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from nasserg1-mac.qualcomm.com (nasserg1-mac.qualcomm.com [129.46.10.100])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nasser@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5762313ED8D;
	Mon, 24 Mar 2014 22:59:53 +0000 (UTC)
In-Reply-To: <20140324225434.GB17080@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1874)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244896>

On Mar 24, 2014, at 4:54 PM, Jeff King <peff@peff.net> wrote:

> On Mon, Mar 24, 2014 at 03:18:14PM -0400, Scott Sandler wrote:
> 
>> I've noticed that a few times in the past several weeks, we've had
>> events where pushes have been lost when two people pushed at just
>> about the same time. The scenario is that two users both have commits
>> based on commit A, call them B and B'. The user with commit B pushes
>> at about the same time as the user who pushes B'. Both pushes are
>> determined to be fast-forwards and both succeed, but B' overwrites B
>> and B is no longer on origin/master. The server does have B in its
>> .git directory but the commit isn't on any branch.
> 
> What version of git are you running on the server? Is it possible that
> there is a simultaneous process running `git pack-refs` (e.g., a `git
> gc` run by a cron job or similar)?

`git gc --auto` could be getting triggered as well, so if you suspect
that you could set gc.auto=0 on the server side.

> 
> There were some race conditions fixed last year wherein git could see
> stale values of refs, but I do not think they could impact writing to a
> ref like this.  When we take the lock on the ref, we always go straight
> to the filesystem, so the value we see is up-to-date.
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora 
Forum, hosted by The Linux Foundation
