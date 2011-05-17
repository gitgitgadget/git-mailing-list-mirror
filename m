From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [BUG] rebase -p loses commits
Date: Tue, 17 May 2011 12:07:38 -0400
Message-ID: <4DD29D4A.8090703@sohovfx.com>
References: <20110516103354.GA23564@sigill.intra.peff.net> <7vfwoel6vw.fsf@alter.siamese.dyndns.org> <4DD1C277.9070605@sohovfx.com> <20110517054432.GC10048@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 17 18:08:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMoU-0000B3-0t
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 18:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab1EQQH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 12:07:57 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:63143 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755341Ab1EQQH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 12:07:56 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1QMMo7-000LXV-Fe
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta01.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QMMo7-000LXV-Fe; Tue, 17 May 2011 12:07:39 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <20110517054432.GC10048@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173811>

On 05/17/2011 01:44 AM, Jeff King wrote:
> Is it really the first-parentness here that is important to the
> asymmetry? I thought it was more the fact that "feature" has the merge,
> but "master" does not.
To know the fact that "feature" has the merge, don't we need to know
that "feature" is the first parent of the merge? For example, if "F" is
the head of "feature" and we're on "*" as a detached head, then we can
only say "feature" has the merge if we know "feature" is the first parent.
> So the outcomes are the same, but the reasoning is different. And isn't
> that what happens with Junio's patch (I tried a simple test and it
> seemed to be)?
I agree that the outcome of both should be the same. Junio's patch will
fix the case when we do "git rebase -p", but the bug will still appear
as soon as we do "git rebase -p -i", which I think is where the source
of the problem is. So we should be looking to fix the issue with "git
rebase -p -i", which will also fix "git rebase -p" too.

I think it's pretty reasonable for "rebase -p -i" to pick the merge
commit, which is already happening with "git rebase -p F". A possible
use case for picking the merge commit is to do a fixup/squash/reword on
"G" in the following graph:

      F---G---H
     /   /
    B---M
