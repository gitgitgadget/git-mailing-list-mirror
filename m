From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] tests: scrub environment of GIT_* variables
Date: Tue, 15 Mar 2011 10:20:46 -0700
Message-ID: <7v4o74b8r5.fsf@alter.siamese.dyndns.org>
References: <20110315064909.GA25738@elie> <20110315070445.GC29530@elie>
 <20110315073718.GB11754@sigill.intra.peff.net> <20110315100846.GB3923@elie>
 <20110315101045.GD3923@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:21:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzXvi-00035V-QF
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab1CORVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 13:21:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab1CORVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 13:21:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CE294CD1;
	Tue, 15 Mar 2011 13:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PeIz+2/foPgEfs9y2npbETEp+Cs=; b=lYuS2x
	r1Hdm1zRpq1iSjxcwdZ4e1Ky2qGdkIWTOcSv5PjpoVBRSidXsTi6G3dVqPvXGXnu
	MQRJephT7wLTbki2cDy8WFk1R34CerfxFvSDnPQjFUMEwcLxjw25XybV5w9TO7Gp
	CB9THsKW9gh4Mq76K3VKGfYupt7rt7oTUIDUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v8WIISohLQcpSW9iXz/uQXr0dhPMJpsR
	AqDW9cAm3tEIXPlgUWGLi+2/YflBMyzynuFTwimRC3ZADiwjY/BRs9EZgi0jpDOg
	9Q1sfSnzbAkUtrtfv4DfQ+JxMnJeqpGCR5APDn5ZHHRT4UTHGSasAOdsYAs9Q5oT
	1jwz+EH7q1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C1834CD0;
	Tue, 15 Mar 2011 13:22:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7083B4CCF; Tue, 15 Mar 2011
 13:22:20 -0400 (EDT)
In-Reply-To: <20110315101045.GD3923@elie> (Jonathan Nieder's message of "Tue,
 15 Mar 2011 05:10:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC85A5C2-4F28-11E0-A257-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169079>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Variables from the inherited environment that are meaningful to git
> can break tests in undesirable ways.  For example,
>
> 	GIT_PAGER=more sh t5400-send-pack.sh -v -i
>
> hangs.  So unset all environment variables in the GIT_ namespace in
> test-lib, with a few exceptions:
>
> - GIT_TRACE* are useful for tracking down bugs exhibited by a failing
>   test;
>
> - GIT_DEBUG* are GIT_TRACE variables by another name, practically
>   speaking.  They should probably be tweaked to follow the
>   GIT_TRACE_foo scheme and use trace_printf machinery some time.
>
> - GIT_USE_LOOKUP from v1.5.6-rc0~134^2~1 (sha1-lookup: more memory
>   efficient search in sorted list of SHA-1, 2007-12-29) is about
>   trying an alternate implementation strategy rather than changing
>   semantics and it can be useful to compare performance with and
>   without it set.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thanks again.

Sounds sane.

I am perfectly fine with the use of perl but do we know the "perl" binary
found on $PATH (as opposed to $PERL_PATH) is good to use for this purpose?
The features used in the scriptlet seem so bread-and-butter that I don't
think it would make too much of a difference, but we may want to be
consistent.

I personally think USE_LOOKUP outlived its usefulness. It was meant to be
an easy way to experiment if the sha1_entry_pos() lookup gives better
performance while looking up a pack entry, to choose one implementation
and discard the other, but I don't think anybody actually did meaningful
benchmarks to decide which one to keep.

Perhaps we should discard the codepath USE_LOOKUP turns on, which I
suspect hasn't been exercised since v1.5.6 days by anybody. An obvious
alternative is for somebody to try using USE_LOOKUP and see if it really
gives a better performance with large packs (and if so, always use it and
discard the other codepath).

Obviously that is outside the scope of this patch series, but I thought I
should mention it before I forget.
