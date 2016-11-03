Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECA72021E
	for <e@80x24.org>; Thu,  3 Nov 2016 20:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757801AbcKCUkF (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 16:40:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:6720 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754558AbcKCUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 16:40:04 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8xfp0Twjz5tlR;
        Thu,  3 Nov 2016 21:40:01 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 958E1149;
        Thu,  3 Nov 2016 21:40:01 +0100 (CET)
Subject: Re: [PATCH 2/4] t0021: put $TEST_ROOT in $PATH
To:     Jeff King <peff@peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
 <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org>
Date:   Thu, 3 Nov 2016 21:40:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.11.2016 um 19:18 schrieb Jeff King:
> We create a rot13.sh script in the trash directory, but need
> to call it by its full path when we have moved our cwd to
> another directory. Let's just put $TEST_ROOT in our $PATH so
> that the script is always found.
> 
> This is a minor convenience for rot13.sh, but will be a
> major one when we switch rot13-filter.pl to a script in the
> same directory, as it means we will not have to deal with
> shell quoting inside the filter-process config.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0021-conversion.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index dfde22549..c1ad20c61 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -5,6 +5,7 @@ test_description='blob conversion via gitattributes'
>  . ./test-lib.sh
>  
>  TEST_ROOT="$(pwd)"
> +PATH=$TEST_ROOT:$PATH

This causes problems on Windows. We need the following squashed in.

---- 8< ----
[PATCH] squash! t0021: put $TEST_ROOT in $PATH

We have to use $PWD instead of $(pwd) because on Windows the
latter would add a C: style path to bash's Unix-style $PATH
variable, which becomes confused by the colon after the
drive letter. ($PWD is a Unix-style path.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0021-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4e4b9a6be3..cff2b7259d 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,7 +4,7 @@ test_description='blob conversion via gitattributes'
 
 . ./test-lib.sh
 
-TEST_ROOT="$(pwd)"
+TEST_ROOT="$PWD"
 PATH=$TEST_ROOT:$PATH
 
 write_script <<\EOF "$TEST_ROOT/rot13.sh"
-- 
2.11.0.rc0.55.gd967357

