Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB321F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 01:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfH0B0D (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 21:26:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38244 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0B0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 21:26:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id f187so7327801ywa.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 18:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nvccj90ZcjDQGPBL8nqdscdxi8VlrUFDlisDNo3ygyA=;
        b=i6b4ypvw9K8GqcImi4CWMtDnh3v48h+ziniTKBZE2dwhjAt7wVELozVhty17KwiI5A
         0Fcio1q98EUO/t4Xp5ZdVHWM3mSAprKGa5MZFlf+SObrI3+JVta/SibMOXw942pL+56G
         ociaa47Ojl5SpCQ30jmZxz5x3XxRaAG5WohFAVGcob85gKncO2s/WnNNR60wZHHyNkgZ
         QGVBtIj99aetKMrD+8F7T6OEaTb0EEr+VJc6pFETYryRM3zhqKwFnUabz4a+orSr4H1l
         KQCTzo3oruCZlH0luOShu5wWwbolsDtkzLpEWrXfgPouuG12veIrJdFrLZuNdgyPPXuQ
         VyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nvccj90ZcjDQGPBL8nqdscdxi8VlrUFDlisDNo3ygyA=;
        b=Pukrf6nwgOnfj5D6O/amvcyr6uDQJduIYKqDaTxk8etpobPTGvuSop1gYw/HMUvL6y
         B0hVzT0bwWMDS5SNcWEIlqMydHSBnoBtwDZ/+JYhOoDmDPL2xsY953tE9obq1LsI+dsg
         5gMipn6JLDTKbtGh3q7tUdXiZl5Bqk+KeeShmg90YNCKyU8AAyEtgnGItgA6g2n95mJA
         pMtL95DrzaRT9V+brfPO4bZB3siJgNaUzKCJQ+KJP739/0k3+yiuNnS3+UyoUrSDWDWL
         pqf6QWFhd+8W8rGfrmA9JxAQZRAUCFcgpDfr+iRxZ+omFb7P+N2ayP/mBG3nvPpzOwIx
         aMCw==
X-Gm-Message-State: APjAAAW1yon57thd6CuWGHPod6tUnem6PH6ZKqkwyziAYM6h0+0lVgrJ
        hUxEnZVj2hm9gJlkzFiCFPM=
X-Google-Smtp-Source: APXvYqyzJD7PuJtC9vjxfNK2+8oly5KmSh8ewtT/C2mq60aXSQjAmRrtUJAlyntBg5g9mVd7mIE1fA==
X-Received: by 2002:a0d:eb4f:: with SMTP id u76mr15005963ywe.285.1566869161555;
        Mon, 26 Aug 2019 18:26:01 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id c7sm2770016ywb.48.2019.08.26.18.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 18:26:00 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] t3427: accelerate this test by using fast-export
 and fast-import
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
 <20190826235226.15386-3-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad7446ac-34cc-b566-302b-053bf5dafc63@gmail.com>
Date:   Mon, 26 Aug 2019 21:25:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826235226.15386-3-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2019 7:52 PM, Elijah Newren wrote:
> fast-export and fast-import can easily handle the simple rewrite that
> was being done by filter-branch, and should be significantly faster on
> systems with a slow fork.  Timings from before and after on two laptops
> that I have access to (measured via `time ./t3427-rebase-subtree.sh`,
> i.e. including everything in this test -- not just the filter-branch or
> fast-export/fast-import pair):
> 
>    Linux:  4.305s -> 3.684s (~17% speedup)
>    Mac:   10.128s -> 7.038s (~30% speedup)

Again, impressive speedup!

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t3427-rebase-subtree.sh | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> index d8640522a0..d05fcce5dc 100755
> --- a/t/t3427-rebase-subtree.sh
> +++ b/t/t3427-rebase-subtree.sh
> @@ -42,7 +42,9 @@ test_expect_failure REBASE_P \
>  	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
>  	reset_rebase &&
>  	git checkout -b rebase-preserve-merges-4 master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&

There's a lot of repetition in these changes. Is this a good time
to introduce a helper method? This trio of commands happens to be
difficult to parse, so I'd rather do it just once.

>  	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
>  	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
> @@ -53,7 +55,9 @@ test_expect_failure REBASE_P \
>  	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
>  	reset_rebase &&
>  	git checkout -b rebase-preserve-merges-5 master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
>  	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
> @@ -64,7 +68,9 @@ test_expect_failure REBASE_P \
>  	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
>  	reset_rebase &&
>  	git checkout -b rebase-keep-empty-4 master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
>  	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
> @@ -75,7 +81,9 @@ test_expect_failure REBASE_P \
>  	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
>  	reset_rebase &&
>  	git checkout -b rebase-keep-empty-5 master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
>  	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
> @@ -86,7 +94,9 @@ test_expect_failure REBASE_P \
>  	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
>  	reset_rebase &&
>  	git checkout -b rebase-keep-empty-empty master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
>  	verbose test "$(commit_message HEAD)" = "Empty commit"
> @@ -96,7 +106,9 @@ test_expect_failure REBASE_P \
>  test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
>  	reset_rebase &&
>  	git checkout -b rebase-onto-4 master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --onto files-master master &&
>  	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
> @@ -106,7 +118,9 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
>  test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
>  	reset_rebase &&
>  	git checkout -b rebase-onto-5 master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --onto files-master master &&
>  	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
> @@ -115,7 +129,9 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
>  test_expect_failure 'Rebase -Xsubtree --onto empty commit' '
>  	reset_rebase &&
>  	git checkout -b rebase-onto-empty master &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +	git fast-export --no-data HEAD -- files_subtree/ \
> +		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
> +		| git fast-import --force --quiet &&
>  	git commit -m "Empty commit" --allow-empty &&
>  	git rebase -Xsubtree=files_subtree --onto files-master master &&
>  	verbose test "$(commit_message HEAD)" = "Empty commit"
> 

