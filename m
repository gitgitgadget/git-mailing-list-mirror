From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] demonstrate broken 'git cherry-pick three one
 two'
Date: Thu, 30 Aug 2012 14:02:05 -0700
Message-ID: <7vehmoqek2.fsf@alter.siamese.dyndns.org>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
 <1346220956-25034-3-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:02:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7BsX-0001uX-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 23:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab2H3VCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 17:02:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab2H3VCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 17:02:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D5C686AC;
	Thu, 30 Aug 2012 17:02:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lf3oNEI52cNny1jcSmx6ojATxE8=; b=ibvDJk
	E6665CAp5KHb72Wc0hKJaSeFd2Vx2jl1WMORFF4UVRuVf1EdZvvDnvcFXk9/FkqB
	rhNQ1+S7x3Pr6TWVNlPMk4OQPG84aibQjJdhWUni3GsBPwoiSNRCIWahS/vKMq5S
	gV4DryiNhhDLWS8OOtgYB/SdNUWrxTtbmhS7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DsKNZhwwXZ3ULeyUNObbRVo+jRpSMBs+
	4oBxogPNr6asrC0tk/UCNcNvAtddp/aI3VfAFXLbJWPCHPIHKJvtOTSPSaJrfoXZ
	yTvgY5lC4oh4oF3u5RrjitfnQdzvIHGYZ9lRTa96PHbncGhA/UV+8XspkvFZTEWD
	p+6wuyBOcaU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B94386AB;
	Thu, 30 Aug 2012 17:02:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFEB286A9; Thu, 30 Aug 2012
 17:02:07 -0400 (EDT)
In-Reply-To: <1346220956-25034-3-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Tue, 28 Aug 2012 23:15:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F57E15C4-F2E5-11E1-800E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204565>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Cherry-picking commits out of order (w.r.t. commit time stamp) doesn't
> currently work. Add a test case to demonstrate it.
>
> Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
> ---
>  t/t3508-cherry-pick-many-commits.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
> index 75f7ff4..fff20c3 100755
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -44,6 +44,21 @@ test_expect_success 'cherry-pick first..fourth works' '
>  	check_head_differs_from fourth
>  '
>  
> +test_expect_failure 'cherry-pick three one two works' '
> +	git checkout -f first &&
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three &&
> +	git checkout -f master &&
> +	git reset --hard first &&
> +	git cherry-pick three one two &&
> +	git diff --quiet three &&
> +	git diff --quiet HEAD three &&
> +	test "$(git log --reverse --format=%s first..)" == "three
> +one
> +two"
> +'

"test $A == $B" is not POSIX.  I'll drop '=' when queuing, so no
need to resend.

Thanks.

> +
>  test_expect_success 'output to keep user entertained during multi-pick' '
>  	cat <<-\EOF >expected &&
>  	[master OBJID] second
