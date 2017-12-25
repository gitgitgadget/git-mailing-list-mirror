Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439DB1F404
	for <e@80x24.org>; Mon, 25 Dec 2017 09:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbdLYJ0b (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 04:26:31 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:18300 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdLYJ0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 04:26:31 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3z4tz85HwDz5tl9;
        Mon, 25 Dec 2017 10:26:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0E5CC41E2;
        Mon, 25 Dec 2017 10:26:28 +0100 (CET)
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in
 addition to in-memory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>
References: <20171225002835.29005-1-avarab@gmail.com>
 <20171225002835.29005-8-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e9a248f9-2caa-693d-3300-b86247fbf76a@kdbg.org>
Date:   Mon, 25 Dec 2017 10:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171225002835.29005-8-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.12.2017 um 01:28 schrieb Ævar Arnfjörð Bjarmason:
> +create_test_file() {
> +	file=$1
> +
> +	case $file in
> +	# `touch .` will succeed but obviously not do what we intend
> +	# here.
> +	".")
> +		return 1
> +		;;
> +	# We cannot create a file with an empty filename.
> +	"")
> +		return 1
> +		;;
> +	# The tests that are testing that e.g. foo//bar is matched by
> +	# foo/*/bar can't be tested on filesystems since there's no
> +	# way we're getting a double slash.
> +	*//*)
> +		return 1
> +		;;
> +	# When testing the difference between foo/bar and foo/bar/ we
> +	# can't test the latter.
> +	*/)
> +		return 1
> +		;;
> +	esac

Nice!

> +
> +	# Turn foo/bar/baz into foo/bar to create foo/bar as a
> +	# directory structure.
> +	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')

	dirs=${file%/*}

should do the same without forking processes, no?

-- Hannes
