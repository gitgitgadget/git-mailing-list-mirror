From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 4/8] bisect: introduce support for --no-checkout
 option.
Date: Tue, 02 Aug 2011 11:00:18 -0700
Message-ID: <7vr553elsd.fsf@alter.siamese.dyndns.org>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
 <1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoJGU-0001Ig-RF
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab1HBSAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 14:00:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab1HBSAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 14:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C2F33A73;
	Tue,  2 Aug 2011 14:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=81YSLIi3vzJ7HMpD3Amc0CnA3RU=; b=NJuVkG
	rrr5a8vqDpM3dtPoe52ou7LdECwJcVEa3PBwZi0bcYXB7Ck7moyxc+SWUItR2Ha6
	uIwdE5WRgZRgY/KOkaWLJEFD5OsGkJvk2mPmW5iKBX3thwV/QfJSjCfSWq6S6jsM
	/LyRBsrjwKCKe46lTR0tlopL2w5O4o5lKFKTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r+aX9qnfX8lTW7FlU0srqJiCIujlL15j
	/DVYVhHQxDwEgU6OLJ9DXOGV/nw9gFEEyRrUbLUv19/tngVw6OeV3/kNRZXSalTE
	/QeIH3RXmuQlqXrL+1qbY3F+GfdiXK9XiwbtMykrg90sPVYE51bgpC3JstTEGSWg
	r6gFIaHKDxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 227BA3A72;
	Tue,  2 Aug 2011 14:00:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82F303A6E; Tue,  2 Aug 2011
 14:00:19 -0400 (EDT)
In-Reply-To: <1312284545-2426-5-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Tue, 2 Aug 2011 21:29:01 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48EA49EE-BD31-11E0-AA8A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178491>

Jon Seymour <jon.seymour@gmail.com> writes:

> If --no-checkout is specified, then the bisection process uses:
>
> 	git update-ref --no-deref HEAD <trial>
>
> at each trial instead of:
>
> 	git checkout <trial>
> ...

Ok.

>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	int next_all = 0;
> +	int no_checkout = 0;
> +	char *bisect_mode=NULL;
>  	struct option options[] = {
>  		OPT_BOOLEAN(0, "next-all", &next_all,
>  			    "perform 'git bisect next'"),
> +		OPT_STRING(0, "bisect-mode", &bisect_mode, "mode",
> +			    "the bisection mode either checkout or update-ref. defaults to checkout."),

I think this is a regression from naming perspective from the previous
round. You would be either the normal (checkout) mode or no-checkout mode,
and honestly, --no-checkout would be understood by anybody while update-ref
would be understood only by Gitz.
