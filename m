From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Tue, 18 Oct 2011 21:31:07 -0700
Message-ID: <7v8vohfvqs.fsf@alter.siamese.dyndns.org>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
 <20111017171041.GA12837@sigill.intra.peff.net>
 <7vipnnmppx.fsf@alter.siamese.dyndns.org> <4E9CA5E2.2020701@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 06:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGNoB-0001xS-VD
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 06:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab1JSEbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 00:31:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab1JSEbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 00:31:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 703EB661B;
	Wed, 19 Oct 2011 00:31:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=S7gZjSCm6AAospz6KFYBxYLa2Qs=; b=RGqZ4/6+BxqOC8UTYXrD
	NAndEn0Mgwp6fpTIQAqHhnM1Oa+zErxF2CROMlpW0gxGZ58BNyodBAWj0tHD52DS
	8oWbb9lNxn43JKWLpnxTNZU6FhXgoMfwfaIgLHNM6RSD9bwhva9QsbB2832iBAYU
	3+lF0kig6Wogi2ci5d1fIVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XeewxLzwefvj5LWz7BIAfyu+NNyEI4kRuSAXbp+5/kfaNx
	RT6mlQLnif2d+IiB1l452cOPAT5R6tsddIr0ZJHtYhO5ou5pAdqeszUdxKenmMeG
	Pg5MYMZqfgAtyfzuncWShmmZc8ejIusDKWaXrHNsVJMScWCNQ/uXkjPQfDZ2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 682E9661A;
	Wed, 19 Oct 2011 00:31:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF7E56619; Wed, 19 Oct 2011
 00:31:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ABFCE1E-FA0B-11E0-B3AC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183914>

Marc Branchaud <marcnarc@xiplink.com> writes:

> In all cases if the command-line refspec has no RHS then git should try to
> figure out which local ref to update from the config, and it should die if it
> can't figure out a local ref to create or update.  (As I said above, maybe
> allow "git fetch origin foo:" to let the user put the tip of origin's foo ref
> into FETCH_HEAD.)

I'd agree with everything you said in your message, except for the above
"it should die" part.

You are assuming that the user knows what his configured refspecs would
normally do and that is the whole reason why "git fetch origin next" that
would update the remote tracking branch specified for the upstream's next
might feel more natural than the current behaviour. I too think that is a
reasonable assumption.

With the same assumption, if you said "git fetch origin frotz" when you
know you are not usually tracking the remote 'frotz' branch, the command
just should store what is fetched in FETCH_HEAD (and nowhere else) without
dying. I do not think how it helps the user to die in that situation.

> All this gets a bit more complicated if the user has currently checked out
> the a ref that should be updated (regardless of the presence of a LHS +).

That "do not update the currently checked out branch" already exists and
is correctly handled by "git fetch", I think.
