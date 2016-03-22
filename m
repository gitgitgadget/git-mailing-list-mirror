From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Make t1300-repo-config resilient to being run via 'sh -x'
Date: Tue, 22 Mar 2016 11:01:42 -0700
Message-ID: <xmqq7fguie7t.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:01:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQcn-0000ar-SF
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbcCVSBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:01:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666AbcCVSBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:01:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5F194EED9;
	Tue, 22 Mar 2016 14:01:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=njXuMjpLkZullWFoFPEiXs5QDqQ=; b=Dup1Uw
	aGDVJP64D9Ud+hijr7CRBI9PyadfOdqRhLBfq8xKLWFREPbaZQaAPbnHbN0o/SfS
	RLg1BmAz/d7sNlPfvVkrk8n4bQocNSXgHPJhlhHSlQ8F6DTKPYdByXox6InEXfyA
	nhKDUFVT0cvn3WbeBOZzaO0BDrztKNvLa9pkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BsRXFLT0LKlW0rVB50a3X98UULngmmKQ
	SGZaSNKG65tr3iBYM/q9hkGDEx5k2GWRJ33MPMwHqLYmhDgqh8SlU0NX46osw9HT
	TEDeJssmX8ro6M3niHXxG8jFq6zOXhkzXFfRh0+ROoy93kh1/FKkFd45fPMwvLFs
	tTtK4upPoQM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDBAA4EED8;
	Tue, 22 Mar 2016 14:01:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42B654EED6;
	Tue, 22 Mar 2016 14:01:43 -0400 (EDT)
In-Reply-To: <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 22 Mar 2016 18:42:49 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22A33A02-F058-11E5-B351-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289537>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> One of this developer's primary tools to diagnose broken regression
> tests is to run the test script using 'sh -x t... -i -v' to find out
> *which* call *actually* demonstrates the symptom.
>
> Hence it is pretty counterproductive if the test script behaves
> differently when being run via 'sh -x', in particular when using
> test_cmp or test_i18ncmp on redirected stderr.
>
> So let's use grep instead of test_cmp/test_i18ncmp to verify that stderr
> looks as expected.

In the modern world, I would probably described the problem as
"tXXXX -i -v -x", though, not "sh -x tXXXX", but they both exhibit
the same symptom.

I wonder if "tXXXX -i -v -x" can be made not to contaminate the
standard error stream of the test, but that would be a larger change
we probably would not have time for 2.8 final anyway.

Will queue.  Thanks.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1300-repo-config.sh | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 8867ce1..0236fe2 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -699,17 +699,13 @@ test_expect_success 'invalid unit' '
>  	echo 1auto >expect &&
>  	git config aninvalid.unit >actual &&
>  	test_cmp expect actual &&
> -	cat >expect <<-\EOF &&
> -	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in file .git/config: invalid unit
> -	EOF
>  	test_must_fail git config --int --get aninvalid.unit 2>actual &&
> -	test_i18ncmp expect actual
> +	grep "^fatal: bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit$" actual
>  '
>  
>  test_expect_success 'invalid stdin config' '
> -	echo "fatal: bad config line 1 in standard input " >expect &&
>  	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
> -	test_cmp expect output
> +	grep "^fatal: bad config line 1 in standard input $" output
>  '
>  
>  cat > expect << EOF
