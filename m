Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7311F576
	for <e@80x24.org>; Wed, 21 Feb 2018 11:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeBUL2g (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 06:28:36 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:31633 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeBUL2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 06:28:35 -0500
Received: from [192.168.2.240] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id oSZdeEdxQYeIpoSZeecnxO; Wed, 21 Feb 2018 11:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519212514;
        bh=e6HqnDRFrLTih4pOHDIYKEXRICKiouURpR1PijrCMkU=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=nF1AO3JTyPnqMHiQ0/352pf07wtimsz8H+V1mvdHcQhQ/zT/XUzHPA97dk4627I0b
         RmTF/zrWad5sPm4flIL0xPgnTMiiKIB1mY//vvS+rBFKCCG9h+cdnc/TtTY9aVLaCe
         zeEYDtzG+cOiSuFVIgGEvKif7FePvDISnZWpvhtY=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=WZB8UwpX c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=WvESTxkSeTEF8LECkvQA:9 a=_dbRjs0I79sj8RWB:21 a=7IZBSK-OCb8ssTkv:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 5/9] t3701: add failing test for pathological context
 lines
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
 <20180219112910.24471-6-phillip.wood@talktalk.net>
Message-ID: <69548d34-3982-6eb7-2620-6e223ab80aaf@talktalk.net>
Date:   Wed, 21 Feb 2018 11:28:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219112910.24471-6-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNo91cR4tfCZCFa/lxLdNjefrAX81jjlobSTLr0RQ/t0LrjGY0v9FJVpNYDvdDfNxhuTVqsKxSlR6OSfuj1eo7JzZPFYS6b4porZ4huqGpknczob4DWe
 mVd7vTanAXKa5bkALmqAEzOr0Ubu0bfSDgl3ZcCaoWOFNOTiDsEHaZYWpUIZ4O8ZLwSeNToiNRb88eWySsSBHjHLzshnc5iYJtyYYOwM50yle+uoYcmQw8Zw
 Xn4IakAqRfdWglObpk/jgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/02/18 11:29, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When a hunk is skipped by add -i the offsets of subsequent hunks are
> not adjusted to account for any missing insertions due to the skipped
> hunk. Most of the time this does not matter as apply uses the context
> lines to apply the subsequent hunks in the correct place, however in
> pathological cases the context lines will match at the now incorrect
> offset and the hunk will be applied in the wrong place. The offsets of
> hunks following an edited hunk that has had the number of insertions
> or deletions changed also need to be updated in the same way. Add
> failing tests to demonstrate this.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> 
> Notes:
>      changes since v1:
>       - changed edit test to use the existing fake editor and to strip
>         the hunk header and some context lines as well as deleting an
>         insertion
>       - style fixes
> 
>   t/t3701-add-interactive.sh | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 70748393f28c93f4bc5d43b07bd96bd208aba3e9..06c4747f506a1b05ccad0f9387e1fbd69cfd7784 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -511,4 +511,35 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
>   	! grep dirty-otherwise output
>   '
>   
> +test_expect_success 'set up pathological context' '
> +	git reset --hard &&
> +	test_write_lines a a a a a a a a a a a >a &&
> +	git add a &&
> +	git commit -m a &&
> +	test_write_lines c b a a a a a a a b a a a a >a &&
> +	test_write_lines     a a a a a a a b a a a a >expected-1 &&
> +	test_write_lines   b a a a a a a a b a a a a >expected-2 &&
> +	# check editing can cope with missing header and deleted context lines
> +	# as well as changes to other lines
> +	test_write_lines +b " a" >patch
> +'
> +
> +test_expect_failure 'add -p works with pathological context lines' '
> +	git reset &&
> +	printf "%s\n" n y |
> +	git add -p &&
> +	git cat-file blob :a >actual &&
> +	test_cmp expected-1 actual
> +'
> +
> +test_expect_failure 'add -p patch editing works with pathological context lines' '
> +	git reset &&
> +	test_set_editor "$FAKE_EDITOR" &&
In light of the discussion of patch 2, I think this line should be deleted


> +	# n q q below is in case edit fails
> +	printf "%s\n" e y    n q q |
> +	git add -p &&
> +	git cat-file blob :a >actual &&
> +	test_cmp expected-2 actual
> +'
> +
>   test_done
> 

