From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interactive rebase with pre-built script?
Date: Tue, 11 Sep 2012 08:35:16 -0700
Message-ID: <7vliggk1xn.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Sep 11 17:35:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSUs-0003UA-OG
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab2IKPfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 11:35:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756483Ab2IKPfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 11:35:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6540A6182;
	Tue, 11 Sep 2012 11:35:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yrM17y7eaxqAVBl5dPm+G5vuL4M=; b=Zxhbj6
	73WCQCdBaLpR8bn86AAqpncBPTqTzJGCHQzueLGEctFWk+5JC6Wcbb4wUh2DHNX1
	I3nayD0Mwj0C5F9rO2as+bSRzER0KN2GvR1Z3pjOfeXRe60vBd/2JrHC0tPrb6ZV
	2O3uYv7pJgQxyGsaSR+aW0PA7mNfGwUYTCiGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HwpOqxjNoaLP10I1Dvwj8zu7HB6W2Y+a
	nXWjA1NyR0l+zHErefUfcP/2wy8iPdZ4Hf5/r/vK8nYI1VlTYHo6rW7ld7KT0snI
	a+BtCC/nTcvqRpkybsYLY1YlTsj5zgc4ogrWXE/uO8aytNUZnbMi8SQrO2CcCUDY
	TOT4p9ythRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5252D6181;
	Tue, 11 Sep 2012 11:35:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6246617F; Tue, 11 Sep 2012
 11:35:17 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se> (Peter
 Krefting's message of "Tue, 11 Sep 2012 07:32:34 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49FE7E56-FC26-11E1-88D3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205237>

Peter Krefting <peter@softwolves.pp.se> writes:

> I was thinking about using git cherry-pick with a list of commits,
> rebase is better at helping with conflicts and such.

Because the three-way merge done by rebase is exactly the same as
cherry-pick, I do not think I understand the reasoning behind this
statement at all.  After the command gives you control back asking
for your help to resolve conflicted merge, the sequencing "rebase"
gives is certainly better than a hand-rolled loop:

	git rev-list --reverse ..... |
	while read commit
        do
        	git cherry-pick "$commit" || break
	done

though.

Using "git cherry-pick $(git rev-list --reverse .....)" ought to
work.  It may misbehave only if you have a time skewed commits, but
the 'mz/cherry-pick-cmdline-order' topic recently fixed (it is in
'master' and will be in 1.8.0).
