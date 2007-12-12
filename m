From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid dates in git log
Date: Wed, 12 Dec 2007 10:57:51 -0800
Message-ID: <7v8x3z91w0.fsf@gitster.siamese.dyndns.org>
References: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
	<20071212092304.GA20799@coredump.intra.peff.net>
	<7vejds8ddf.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712121457280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Eirik =?utf-8?B?QmrDuHJzbsO4cw==?= <eirbjo@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Wn1-0007R4-RR
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXLLS6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbXLLS6L
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:58:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbXLLS6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:58:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 410814FD8;
	Wed, 12 Dec 2007 13:57:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E3164FD3;
	Wed, 12 Dec 2007 13:57:54 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712121457280.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 12 Dec 2007 14:59:31 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68088>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 12 Dec 2007, Junio C Hamano wrote:
>
>>     Author:     Len Brown <len.brown@intel.com>
>>     AuthorDate: Fri Apr 5 00:07:45 2019 -0500
>>     Commit:     Len Brown <len.brown@intel.com>
>>     CommitDate: Tue Jul 12 00:12:09 2005 -0400
>> 
>>     author Len Brown <len.brown@intel.com> 1554440865 -0500
>>     committer Len Brown <len.brown@intel.com> 1121141529 -0400
>> 
>> [...] It looks like quite a random timestamp, and committer timestamp 
>> look reasonable, relative to the other commits around it.
>
> It is quite possible that Len Brown had a similar problem to what I 
> experienced yesterday: my clock was set one hour and 22 years into the 
> future, but I have no idea how that happened.  My only guess is a 
> half-succeeded ntpdate call, but somehow I doubt that.

But how would you explain the more reasonable committer date?

I am guessing that this particular commit was rebased (using rebase,
rebase -i, stgit, guilt or something else), and whatever tool that was
used had some thinko that broke the author timestamp (and zone).

Nah, exonerate guilt and rebase -i from the list.  The commit is from
July 2005 which means there wasn't much usable tool for rebasing in the
core distribution.  Interactive rebase did not exist back then, and
rebase was done with "git-commit-script -m", which took an existing
commit and used its metainformation when creating a commit.  This was
almost totally different codepath from what we have now.  Not even
format-patch nor applymbox existed.

StGIT 0.4 (initial) was Jul 10, 2005, so it is _possible_ (I do not know
about plausibility) that it had an early bug that caused this, but if we
really want to figure it out we need to ask Len what was used, and I
suspect the most likely answer is "are you crazy enough to expect me to
remember?".

I am personally more interested in the other one, which was much more
recent incident, though.
