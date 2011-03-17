From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and
 --merges-only
Date: Thu, 17 Mar 2011 12:23:05 -0700
Message-ID: <7vwrjx361y.fsf@alter.siamese.dyndns.org>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:23:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0In4-0001LP-0Z
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab1CQTXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:23:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab1CQTXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:23:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AC9436D9;
	Thu, 17 Mar 2011 15:24:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6WViKFgXUd2ir3lfyk7foZfaOCU=; b=fkhVZe
	HOj7NGSEPrJEflhN+7I9sKmegQqj5xlNSThGiAYHW56+QKJByZ8z31KyufzEpfUi
	JCC5mPlExrsfQexZ1/26gEVPKiYj1hjXPysVlifddnQJO6LxguSuWDtW9jcOBWQJ
	ilN/5olxggojsvpHsEPO2/32buh1bLUlpMk3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BEvPzbqIrtq/zUpZUoJf3lAidhTJlLLf
	9iWusoXN9xCvnZQT0m9LojgTPLH/FnzPNphXrsYewRgF+HfMYzpOc2VPsygfBndn
	2YtFaviIGCXFtrYGt6MbGgYdtuf5ThEZUXBRg53bsOa4FPWk0+6HqVzYvD/6i5ed
	2MBiSQ+KzGg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6784C36D8;
	Thu, 17 Mar 2011 15:24:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 73DF736D5; Thu, 17 Mar 2011
 15:24:40 -0400 (EDT)
In-Reply-To: <cover.1300359256.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Thu, 17 Mar 2011 12:33:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 362AACE4-50CC-11E0-8DD8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169260>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This mini series makes it so that --no-merges undoes --merges
> and vice versa, as the user should be able to expect,
> and that --merges-only is a separate option.

Nice to see the series marked as RFD, but it would have been much better
what aspect of the series you wanted to be discussed.

I know that you have been here long enough to know that an outright
breakage of backward compatibility does not deserve a discussion, and that
you are feeling to see if people consider it is worth to design and
implement a migration path that is not fully specified by this series to
eventually give us the end result that is hinted by this series.

But I suspect some other readers on the list don't (and that is why I am
spelling it out).

As to the eventual goal, I think two modes "show me only merge commits",
"show me only commits that are not merges" are absolute nesessity no
matter how they are named, and as a uniformity bonus, "earlier I might
have said 'show me only merges' but I take it back" and its counterpart
might be good things to have.

But.

If a script writer wants to futureproof his script against later
introduction of configuration variables to trigger 'no-merges' and/or
'merges-only', what should she say?  "git log --no-merges-only --merges"?

Shouldn't the choice offered by the eventual end result of this topic,
perhaps two years down the road after migration period, not two seemingly
independent options as hinted with the series, but an enum with three
values (any commit, non-merge commit only, merge commit only)?

IOW, wouldn't it be a more logical thing to do to add a new option with
three values --show-commit={all,merges,no-merges}, if we were adding the
feature to filter commits by number of parents?

If we come up with a nicer name for the --show-commit example above (both
the name of the variable and the enum value) and promote it, the migration
would go smoothly without giving much pain to the existing users and
scripts, as it will not _have to_ involve touching the existing merges and
no-merges options at all, even though we can make them less visible.
