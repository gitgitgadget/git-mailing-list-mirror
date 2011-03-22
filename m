From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Tue, 22 Mar 2011 12:18:48 -0700
Message-ID: <7vtyevj753.fsf@alter.siamese.dyndns.org>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
 <20110320234420.GA1919@sigill.intra.peff.net>
 <op.vsq9o4mz2m56ex@localhost.localdomain>
 <20110322184737.GB22534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Raiskup <xraisk00@gmail.com>,
	Vicent Marti <vicent@github.com>, git@vger.kernel.org
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:19:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q276j-0002mA-3X
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1CVTTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 15:19:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1CVTTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:19:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4FB83340;
	Tue, 22 Mar 2011 15:20:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1jtxnSVOWHGkNZs7/+TkbRDQhY=; b=LbqNY3
	LvLeZDv///W0QZ5xH033EDSsayPUfPdRmmaEEG/toMy+3rUt/oE3HwD+BZ0s8Y0q
	bimay6Yvt50keIyCWJ0qm60lRofCZJJ47PAljbaVN1CMnlbMb8uwAtJT6VhaEgkS
	K+VHjLnA4h6Si34G8VJ31Wlbn5+pKIY3wlryo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lize1dRj+Cb/j36M6PSv+/5pFtVKEKku
	7DXG4RK5dDlm+iIplNK4NU38Oqf6IVcP7dT7YOpjkaY7RcXQaFuEoRLIU2SOwIwj
	WiZ1iJef4gNZEZDo5Q/m7emkWxPQqneqGrGUf3d/ixlh2Nl/c4NOvlx/UQtGOiFE
	XFjRG1X5lmk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75407333E;
	Tue, 22 Mar 2011 15:20:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BA43333D; Tue, 22 Mar 2011
 15:20:28 -0400 (EDT)
In-Reply-To: <20110322184737.GB22534@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 Mar 2011 14:47:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75D9C80C-54B9-11E0-9671-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169766>

Jeff King <peff@github.com> writes:

> It may also be necessary to use a mixture of git and libgit2 commands to
> finish tests. For example, a test which is really about checking "log"
> might use "commit", but "commit" hasn't been implemented yet. But it is
> still useful information if we cheat and use regular git's "commit", but
> test the libgit2 log command.

Absolutely, and I don't even think that is "cheating"; it is merely a
natural way to work incrementally.

> As far as which commands to start with, I would start with plumbing
> commands like "update-index", "commit-tree", "update-ref", "rev-list",
> etc.  Those are basic building blocks that have reasonably simple
> interfaces, and they're easy to test. And once you start, I think it
> will become more obvious where to go next (because some of the commands
> build on the results of others).
>
>> This probably will lead to some test suite changes, is it truth?

Some tests _might_ depend on implementation detail that we would rather
not, but I don't think there are too many of them, unless you count the
stuff that use "test-<something>" helper binary that link with libgit.a to
make direct calls to the internal.  I would suggest to consider a failure
an uncovered bug in the new implementation by default, and discuss the
tests that do depend on the implementation detail of C git on case-by-case
basis to be fixed.
