From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] branch: restructure -v vs. -vv
Date: Thu, 25 Aug 2011 12:02:15 -0700
Message-ID: <7v8vqhl3go.fsf@alter.siamese.dyndns.org>
References: <4E5607E0.1050300@drmicha.warpmail.net>
 <f471a616e4f08e729384138d8cb8afff4e9dbcbf.1314259226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 21:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwfC8-0003Ch-GB
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 21:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1HYTCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 15:02:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270Ab1HYTCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 15:02:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2286421D;
	Thu, 25 Aug 2011 15:02:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=toNkNII/h//CBBslLYHwDWY9TJ0=; b=I9AMpy
	YGe6IqKi02OKSHDvGSwcbQXWZW6oMS+kmpQ7h+dq69+10EGBWeveKBFNig6KWTNg
	docMrS2CcGCazr6za8yGeGGzYOH2gCXbbJl1TlfZUYN09yqwVFnpr10g73QlYZ44
	e6FteVuDkh0xYyCkYcpBgY+umRi9rQbl/YIiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wERcL4T2sjsJqEM1ZiLk4MDlQhKQmvPC
	uXVlcaq1NFpx9ECy/5+OiOK7Q2vw3tMRBD+AQskvKT4iujfHDV26553TXiEIqGy2
	BRkMUmiGA9gdmkTv2CuoA13UwfFvusYtVmzV1MIS3gF0fP2sHWFRg7s6gfZKxss3
	97x+722pvlI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8EA4421C;
	Thu, 25 Aug 2011 15:02:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 625C4421B; Thu, 25 Aug 2011
 15:02:17 -0400 (EDT)
In-Reply-To: <f471a616e4f08e729384138d8cb8afff4e9dbcbf.1314259226.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 25 Aug 2011 10:30:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0700AEE-CF4C-11E0-9907-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180101>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ahead/behind info is expensive, upstream name info cheap. Therefore,
> make -v output the upstream branch name and -vv add the ahead/behind
> info.

While I do not care too much about the end result, and I even suspect that
swapping the meaning might be better at the semantic level, I do not agree
with the above line of reasoning. It is not based on what the end user
wants at all, but is based on how easily you can produce results.

If a relatively expensive information is what is more often wanted and the
users are willing to pay the price to compute it, it is very reasonable to
use short-and-sweet -v for showing only that information, and have them
type -vv to ask for a less common information.

I also suspect that "ahead/behind" and "who-is-upstream" may be orthogonal
and we may not tie these to degree of verbosity. Jeff's suggestion to
teach these to for-each-ref may be along a similar thought.

You however may be able to argue "When the user wants A/B, s/he always
wants who-is-upstream, and asking for A/B and not wanting who-is-upstream
is insane". If "A/B" does not make sense without seeing "who-is-upstream",
but if seeing "who-is-upstream" alone makes sense without seeing "A/B",
then you can argue that these two are indeed degrees of verbosity, and it
may be justifiable to make -v give "who-is-upstream", and make -vv give
"A/B and who-is-upstream".

But I suspect that much more people have more than one topics cooking on
top of upstream (i.e. need for A/B) than people who work with these topics
based on different upstreams (i.e. need for "who-is-upstream"). People who
base their topics on only one upstream do not need "who-is-upstream" to
understand A/B.

I am wondering if "branch -v=<comma separated tokens>", where currently
available tokens are "sha1", "upstream", "ahead/behind", is the right way
to keep these orthogonal and extensible (of course you would want a
shorter mnemonic). Then existing -v and -vv can be understood as aliases
to:

	-v   ===  -v=sha1,ahead/behind
        -vv  ===  -v=sha1,upstream,ahead/behind

and you can naturally extend the vocabulary with "patchsame" to define
your -vvv introduced in [5/5].
