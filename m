From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: allow -E and -n to be turned on by default via
 configuration
Date: Mon, 28 Mar 2011 15:14:32 -0700
Message-ID: <7v7hbix587.fsf@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 00:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Khz-0002cn-F6
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 00:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab1C1WOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 18:14:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab1C1WOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 18:14:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD4115398;
	Mon, 28 Mar 2011 18:16:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vS8n8trXjONBZwSqCwopnohaXJo=; b=QguWxX
	9ip1tP0BGPw+36sh9gXDhHRKGO7M8RnXAhjMGQkgH45cgcG1lK2a+eBW+CmAhcAE
	7ezS9ErP6+RxmH5TXvBmi6gSOUcKvksGMJ9C5E5LSNxDaG8BUtERytRivQVMR7aE
	zCQbkhrIfWPI3Vntc1UrsQXOBsubopXpqySPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQ3D1l+WeT9omVZl3rOI89oVtofwPpYX
	Qe+CR8NP0dGJJ72HYxY6IN8ZbW/Kb/kEvIVL3DZpW6VdULO21NfpYclNICgUou1W
	2QoBoyHwjkQAc+vMNX4fDqfGq+ZnY/nutglIN3e8HZeey017wyADcEebV6B488Pr
	AefeeldT5SE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB8855397;
	Mon, 28 Mar 2011 18:16:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9E9BE5396; Mon, 28 Mar 2011
 18:16:20 -0400 (EDT)
In-Reply-To: <7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Mar 2011 15:12:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04C058AA-5989-11E0-B76F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170195>

Junio C Hamano <gitster@pobox.com> writes:

> +	if (!strcmp(var, "grep.extendedregexp")) {
> +		opt->regflags |= git_config_bool(var, value) ? REG_EXTENDED : 0;
> +		return 0;
> +	}

Heh, I am an idiot.  This should be more like

	if (git_config_bool(var, value))
        	opt->regflags |= REG_EXTENDED;
	else
        	opt->regflags &= ~REG_EXTENDED;
	return 0;
