From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 11:07:51 -0700
Message-ID: <7vk42kh11k.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org> <20120316172013.GA8119@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8bZI-00078m-EW
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 19:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab2CPSHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 14:07:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167Ab2CPSHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 14:07:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BCA16C97;
	Fri, 16 Mar 2012 14:07:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNwScTEO5T8aWaGNJzoaN4j8RQ4=; b=EE8dAb
	tEzK+ErGCu7Pqf4XsluZFyh3gOulAh0DXsusJ/BsnfMiL0PgDigL2jX+0sccxjVk
	bFjm5CF+H8pbPTec2ttsRQYxStaa4U5WIyrMGPttT6DXfCBguASLnLVS9bampzP/
	QXHXaYLS9l8AE2gxP2udC+w9aX8Lg6/cEQQSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOtvSM1xS4y26ESAiUJWx443ybrJC3IH
	u5ScgN4iVnijGD4dmyQ0iirpW3RNfFPB8nCkjP6Sj4CPw8UExxuLLy7NLB/bv91G
	kLuVbbeIL2/b5oMM69G/ujLbJyCw2LoNG/brIRKC13VJFesDvWre5zUCb/rQe/i1
	AK7Kuu/afWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 831526C95;
	Fri, 16 Mar 2012 14:07:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFAAA6C94; Fri, 16 Mar 2012
 14:07:52 -0400 (EDT)
In-Reply-To: <20120316172013.GA8119@gmail.com> (Christopher Tiwald's message
 of "Fri, 16 Mar 2012 13:20:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2EC5766-6F92-11E1-8435-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193280>

Christopher Tiwald <christiwald@gmail.com> writes:

> One quick, slightly-off-topic question: I'd like to take another crack
> at the patch's commit message, to implement some of your language
> suggestions and clean it up further. Is it reasonable for me to wait a
> few days for additional comments or updates, squash together these
> fixups into a single v2 patch (assuming one patch is a logical unit for
> it), then resubmit?

Surely.

After reading the fix-up patch again, I actually have a couple of
comments/reservations myself.

 (1) I suggested (and the fix-up patch does so) to use a single existing
     advice configuration, but if you read the description in my response
     to Clemens carefully, you may realize that at least the configuration
     for "Here is how to deal with your current branch" and "Here is how
     for the rest of your branch" might be better if they are separate
     variables. The user may fix current branch (i.e. "pull then push"),
     set the advice.pushNonFastForward to false thinking that he learned
     everything there to know about non fast-forward, and then get another
     failure from "git push" because other branches are still behind, but
     with my "fix-up" patch, we would no longer give advice to him.

 (2) The advice to "Your current branch is OK but you are also pushing
     others that do not fast-forward" only talks about "check out, pull
     and then push", but an equally plausible solution may be "don't push
     other branches---you are not working on them right now".  Both of our
     versions have this issue.

     I didn't trace the logic flow, though. If this advice is issued only
     to the user who explicitly said he wants to push these other branches
     (e.g. has "push.default = matching" in the config and gave no command
     line options, or gave refspec on the command line to tell us to push
     these other branches), then the wording is OK.

     But for the purpose of helping people who may be surprised by the
     current "matching" default, I think we should detect this very narrow
     case:

     - The user did not give us any refspec from the command line; and

     - The user does not have push.default set to matching (either the
       user does not have any push.default, or it is set to something
       else); and

     - The remote.$name.push would not push the branch other than the
       current branch.

     When these three conditions hold, we can be sure that the user worked
     on more than one branch and did "git push $there" without telling us
     what to push, and we defaulted to push "matching" and failed on stale
     branches that the user hasn't been working on.  In that case, "don't
     push other branches---perhaps push.default needs to be set" may be a
     far more appropriate advice.

     So, the third case may have to be split further into two.
