From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 10:11:47 -0800
Message-ID: <7v4onoywws.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net> <4B274C3A.4060808@viscovery.net>
 <4B2B5085.1050906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:13:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLhKS-0004U4-J2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 19:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbZLRSMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 13:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbZLRSMJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 13:12:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbZLRSL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 13:11:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77AC2A7FEB;
	Fri, 18 Dec 2009 13:11:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Za2PUAapdt5rtTK+ybI2x9zWqc4=; b=WpPGzd
	L6/LFLbBcdYycP7+rcwShYFQWkxD/q0hEBaCQBRqG88IVL1N/Ywu3Uoh68dJd2MN
	+8wGqEBnWb1/kP9CYzRP+Orqakd2ogg1VgWG0bJXHvlZtmQzWUKlRfTylHMAWhUB
	5cpd+CuYUCZVMaATlJFT5Kj4RAGYBiHNUM4kY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TrJmRuUgyXYcm5kB28joGkb1nktGFFIu
	b9x7sOP1fvC+obq/X1kIe5FQow9FWIBx7xQ9OJ6+aSWgS5naUhjbQuUl1xcirZwe
	MTdNtcmjl9WsO/qNbjOlSsZXUHP0rukms39FF7TW6KY55NEFZDTCqZzLptvS5w0J
	BDe+nPI+lXI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5660EA7FE9;
	Fri, 18 Dec 2009 13:11:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4547BA7FE5; Fri, 18 Dec 2009
 13:11:48 -0500 (EST)
In-Reply-To: <4B2B5085.1050906@viscovery.net> (Johannes Sixt's message of
 "Fri\, 18 Dec 2009 10\:51\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1498448-EC00-11DE-8B7C-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135423>

Johannes Sixt <j.sixt@viscovery.net> writes:

> You have queued 1/2 (filter-branch: remove an unnecessary use of
> 'git read-tree') of this 2-patch series, but I haven't seen any comments
> about this 2/2 nor is it queued. Did it fall through the cracks?

No.  I think saying "is not allowed" is going a bit too far [*1*].  The
documentation does not list it as a commonly useful thing, that's all.

When a user wants to have an empty index, and does not want to touch files
under $GIT_DIR with any non-git tools (e.g. "rm -f $GIT_DIR/index) for
some religious reasons, "read-tree" without a tree would be one valid way
to do so [*2*].  That is not documented (the synopsis section even hints
that read-tree wants to take at least one tree), and I think it is a
problem that the documentation does not match what the program actually
allows.

The approach taken by [2/2] is to match the program to the documentation
by forbidding what has been allowed and what people may have been relying
on being able to do,

It was obvious that the line removed by [1/2] was a no-op not only in the
usual case but also in an error case (i.e. when the user does not have
write access to the repository), as I wrote in my review of the patch.
Compared to that, I do not think it is cut-and-dried clear that [2/2] is
the right kind of improvement.  An alternative approach to document the
zero-tree case would be a valid way to address the documentation mismatch
problem.

We need to make arguments like "'read-tree' given by mistake to empty the
index is risky", "'read-tree' as 'rm -f $GIT_DIR/index' replacement has
little value", and "'read-tree' as 'rm -f $GIT_DIR/index' replacement is
the best way to get an empty index" to weigh pros and cons between two
possible approaches before deciding which way to go, but in a pre-release
freeze, I wasn't in the mood to be one who is doing the arguments myself.


[Footnote]

*1* Didn't I say that somewhere?

*2* I suspect "rm --cached ." might be another, but it would probably be
much more expensive.
