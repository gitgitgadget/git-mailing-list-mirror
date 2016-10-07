Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0977820986
	for <e@80x24.org>; Fri,  7 Oct 2016 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941241AbcJGRIL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 13:08:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:48712 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGRIK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 13:08:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3srGDl2Sn1z5tlG;
        Fri,  7 Oct 2016 19:08:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A04455326;
        Fri,  7 Oct 2016 19:08:06 +0200 (CEST)
Subject: Re: [PATCH 3/4] mergetool: honor diff.orderFile
To:     David Aguilar <davvid@gmail.com>
References: <1475797679-32712-1-git-send-email-davvid@gmail.com>
 <1475797679-32712-3-git-send-email-davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Luis Gutierrez <luisgutz@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b75fce03-644b-cc27-a61a-aad5ab2d4b50@kdbg.org>
Date:   Fri, 7 Oct 2016 19:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1475797679-32712-3-git-send-email-davvid@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2016 um 01:47 schrieb David Aguilar:
> @@ -606,4 +606,37 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
>  	git reset --hard master >/dev/null 2>&1
>  '
>
> +test_expect_success 'diff.orderFile configuration is honored' '
> +	test_config diff.orderFile order-file &&
> +	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
> +	test_config mergetool.myecho.trustExitCode true &&
> +	echo b >order-file &&
> +	echo a >>order-file &&
> +	git checkout -b order-file-start master &&
> +	echo start >a &&
> +	echo start >b &&
> +	git add a b &&
> +	git commit -m start &&
> +	git checkout -b order-file-side1 order-file-start &&
> +	echo side1 >a &&
> +	echo side1 >b &&
> +	git add a b &&
> +	git commit -m side1 &&
> +	git checkout -b order-file-side2 order-file-start &&
> +	echo side2 >a &&
> +	echo side2 >b &&
> +	git add a b &&
> +	git commit -m side2 &&
> +	test_must_fail git merge order-file-side1 &&
> +	cat >expect <<-\EOF &&
> +		Merging:
> +		b
> +		a
> +	EOF
> +	git mergetool --no-prompt --tool myecho | grep -A 2 Merging: >actual &&

Is grep -A universally available?

> +	test_cmp expect actual &&
> +	git reset --hard >/dev/null
> +'
> +'

Two single-quotes?

> +
>  test_done
>

Otherwise the patch looks good.

-- Hannes

