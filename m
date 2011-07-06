From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] t4033-diff-patience: factor out tests
Date: Wed, 06 Jul 2011 11:04:15 -0700
Message-ID: <7vhb6zmgkg.fsf@alter.siamese.dyndns.org>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1309970337-6016-2-git-send-email-rctay89@gmail.com>
 <1309970337-6016-3-git-send-email-rctay89@gmail.com>
 <1309970337-6016-4-git-send-email-rctay89@gmail.com>
 <1309970337-6016-5-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 20:04:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeWSX-0003xN-HG
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 20:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab1GFSET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 14:04:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab1GFSES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 14:04:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E70E5209;
	Wed,  6 Jul 2011 14:04:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0peMC4jD3Zzx9T4gF01LCu022DE=; b=szRQXK
	h57xymoh8KxwT3rZYUSvl2MegPU7WxDvpHrShxRU0a0SgDQ6tGVvB9x59Jhp2Lro
	c4qoiJKeP7ntf1RB7ynXbK9ZkhlFdzABAkP8Oj+ZL+MvK+f3tP7sCa5DWkzVbACT
	XVWVRfkmaNDDPE44EGSWFLuVSKwt+uIkqHF6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+f7sQxEjIeJJ+8YR84fGyiPIHy3ufiG
	v7roicLm8Ojr7iqLsNA3Ihq2EVdGDHrQQcreRSU+CRwSjzyCBtA+NoX6cLitgDxk
	oCJroVQmevZC9glLaLDWfwULtEBi1kZ0I75G3JYTmv9oycOf1p7W1eGmcUi0y1DH
	j4Ty0tM4VN4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 982D85208;
	Wed,  6 Jul 2011 14:04:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DB7EA5207; Wed,  6 Jul 2011
 14:04:16 -0400 (EDT)
In-Reply-To: <1309970337-6016-5-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 7 Jul 2011 00:38:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D3D4C76-A7FA-11E0-9BA5-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176720>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Group the test cases into two functions, test_diff_(frobnitz|unique).
> This in preparation for the histogram diff algorithm, which would also
> re-use these test cases.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
> Ram: the rename is detected in git-log, but not in the diffstat. The
> expected and actual content, which makes up the bulk of content, is
> unchanged, but the 'surrounding' changes should be pretty easy to spot.
>
>  t/lib-diff-patience.sh   |  163 ++++++++++++++++++++++++++++++++++++++++++++++

Perhaps name this "t/lib-diff-alternative.sh" (or "strategy"), as this
will soon be for testing non-default diff backend algorithms, not just
patience diff?

>  t/t4033-diff-patience.sh |  162 +--------------------------------------------
>  2 files changed, 166 insertions(+), 159 deletions(-)
>  create mode 100644 t/lib-diff-patience.sh
>
> diff --git a/t/lib-diff-patience.sh b/t/lib-diff-patience.sh
> new file mode 100644
> index 0000000..761bb09
> --- /dev/null
> +++ b/t/lib-diff-patience.sh
> @@ -0,0 +1,163 @@
> ...
> +	STRATEGY=$1
> +
> +	test_expect_success "$STRATEGY diff" '
> +		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
> +		test_cmp expect output
> +	'
> +
> +	test_expect_success "$STRATEGY diff output is valid" '
> +		mv file2 expect &&
> +		git apply < output &&
> +		test_cmp expect file2
> +	'
> +}
