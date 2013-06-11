From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] status: introduce status.short to enable --short by default
Date: Tue, 11 Jun 2013 14:38:52 -0700
Message-ID: <7v1u889vkj.fsf@alter.siamese.dyndns.org>
References: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 11 23:39:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWHR-0004yy-12
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab3FKVjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:39:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849Ab3FKVi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 17:38:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CAED2781B;
	Tue, 11 Jun 2013 21:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5W/5SUVdChWOvZrfSPO8of19cYw=; b=aiBsUq
	gHRaIdfgUPoc4hTuqIu1wg0PwLVTFaYTBN5gXSML+NCxadjBsEqd5iVAT3aKG4GQ
	QEpAfv5W7hd8F8OuXmeVFMvoTwkK25wx44iIpiGFbjMJaTrsCHCdcxxRJaUB+YJr
	BC2Qu3Ol9LWCGJmG0x1wyntRVOx43v3fGQQ4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vt3LyLfdf4NpMVEMADvA6yXk8BABzx0V
	WNXTowApk0reYERMkGAaIvP/LI9mFXGpcqfBbrOo8vjU3BtHNjk+buBCWaIHO+VQ
	uhMprklhkSGbscUVYhw6fbCvfTmiZW5hPCYfSJbfDWymlBm72CD6gHOoH8ZhebPX
	/4eNCcBWLQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5825D27819;
	Tue, 11 Jun 2013 21:38:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B3C827815;
	Tue, 11 Jun 2013 21:38:54 +0000 (UTC)
In-Reply-To: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge-Juan Garcia-Garcia's message of "Tue, 11 Jun 2013 15:34:04
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50921544-D2DF-11E2-B868-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227518>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr writes:

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index e2ffdac..3c0818b 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1335,4 +1335,39 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
>  	git config -f .gitmodules  --remove-section submodule.subname
>  '
>  
> +test_expect_success 'Setup of test environment' '
> +	git config status.showUntrackedFiles no
> +'
> +
> +test_expect_success '"status.short=true" same as "-s"' '
> +	git -c status.short=true status >actual &&
> +	git status -s >expected_short &&
> +	test_cmp expected_short actual
> +'
> +
> +test_expect_success '"status.short=true" different from "--no-short"' '
> +	git status --no-short >expected_noshort &&
> +	test_must_fail test_cmp expected_noshort actual
> +'

I am not sure if "must be different, and I do not care what kind of
difference we get" is a good test.

> +test_expect_success '"status.short=true" weaker than "--no-short"' '
> +	git -c status.short=true status --no-short >actual &&
> +	test_cmp expected_noshort actual
> +'
> +
> +test_expect_success '"status.short=false" same as "--no-short"' '
> +	git -c status.short=false status >actual &&
> +	git status -s >expected_short &&
> +	test_cmp expected_noshort actual
> +'

I think the second line in this test is unwanted.

> +
> +test_expect_success '"status.short=false" weaker than "-s"' '
> +	git -c status.short=false status -s >actual &&
> +	test_cmp expected_short actual
> +'
> +
> +test_expect_success 'Restore default test environment' '
> +	git config --unset status.showUntrackedFiles
> +'
> +
>  test_done

I'll queue this patch after tweaking the test part like this.

Thanks.

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e2ffdac..33cadd0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1335,4 +1335,34 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'setup of test environment' '
+	git config status.showUntrackedFiles no &&
+	git status -s >expected_short &&
+	git status --no-short >expected_noshort
+'
+
+test_expect_success '"status.short=true" same as "-s"' '
+	git -c status.short=true status >actual &&
+	test_cmp expected_short actual
+'
+
+test_expect_success '"status.short=true" weaker than "--no-short"' '
+	git -c status.short=true status --no-short >actual &&
+	test_cmp expected_noshort actual
+'
+
+test_expect_success '"status.short=false" same as "--no-short"' '
+	git -c status.short=false status >actual &&
+	test_cmp expected_noshort actual
+'
+
+test_expect_success '"status.short=false" weaker than "-s"' '
+	git -c status.short=false status -s >actual &&
+	test_cmp expected_short actual
+'
+
+test_expect_success 'Restore default test environment' '
+	git config --unset status.showUntrackedFiles
+'
+
 test_done
