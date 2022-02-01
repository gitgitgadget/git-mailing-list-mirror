Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1456C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 22:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiBAWHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 17:07:35 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:63257 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbiBAWHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 17:07:35 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JpJvS0DLYz5tlP;
        Tue,  1 Feb 2022 23:07:31 +0100 (CET)
Message-ID: <d9275c31-7558-fc9c-9eb3-2a0cb81a8259@kdbg.org>
Date:   Tue, 1 Feb 2022 23:07:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 1/2] patch-id: Fix antipatterns in tests
Content-Language: en-US
To:     Jerry Zhang <jerry@skydio.com>
References: <20220131232529.8484-1-jerry@skydio.com>
 <20220131235218.27392-1-jerry@skydio.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220131235218.27392-1-jerry@skydio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.22 um 00:52 schrieb Jerry Zhang:
> Clean up the tests for patch-id by moving file preparation
> tasks inside the test body and redirecting files directly into
> stdin instead of using 'cat'.

You announce that `cat` is about to be removed...

>  test_expect_success 'patch-id handles no-nl-at-eof markers' '
> -	cat nonl | calc_patch_id nonl &&
> -	cat withnl | calc_patch_id withnl &&
> +	cat >nonl <<-'EOF' &&

... but it is still here...

> +	diff --git i/a w/a
> +	index e69de29..2e65efe 100644
> +	--- i/a
> +	+++ w/a
> +	@@ -0,0 +1 @@
> +	+a
> +	\ No newline at end of file
> +	diff --git i/b w/b
> +	index e69de29..6178079 100644
> +	--- i/b
> +	+++ w/b
> +	@@ -0,0 +1 @@
> +	+b
> +	'EOF'
> +	cat >withnl <<-'EOF' &&

... and here, although...

> +	diff --git i/a w/a
> +	index e69de29..7898192 100644
> +	--- i/a
> +	+++ w/a
> +	@@ -0,0 +1 @@
> +	+a
> +	diff --git i/b w/b
> +	index e69de29..6178079 100644
> +	--- i/b
> +	+++ w/b
> +	@@ -0,0 +1 @@
> +	+b
> +	'EOF'
> +	calc_patch_id nonl <nonl &&
> +	calc_patch_id withnl <withnl &&

... you could in fact just redirect the here-documents into these commands.

>  	test_cmp patch-id_nonl patch-id_withnl
>  '
>  test_done

-- Hannes
