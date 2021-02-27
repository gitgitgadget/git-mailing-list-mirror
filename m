Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5112AC433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1299E64EC0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 07:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhB0H0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 02:26:42 -0500
Received: from [93.83.142.38] ([93.83.142.38]:38160 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229967AbhB0H0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 02:26:41 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id CB7092E46C;
        Sat, 27 Feb 2021 08:26:18 +0100 (CET)
Subject: Re: [PATCH v3 34/35] userdiff tests: add basic test for ada
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-35-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a756d24e-53b9-0245-de68-be96946ba5f9@kdbg.org>
Date:   Sat, 27 Feb 2021 08:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224195129.4004-35-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 20:51 schrieb Ævar Arnfjörð Bjarmason:
> Add test for the ada userdiff pattern added in e90d065e64 (Add
> userdiff patterns for Ada, 2012-09-16).
> 
> I don't know the ada language itself, I just stole a couple of
> examples of code that used tokens we're matching[1][2]. Both test
> examples stress our negative and positive matching rules.
> 
> 1. https://rosettacode.org/wiki/99_bottles_of_beer#Ada
> 2. https://en.wikibooks.org/wiki/Ada_Programming/Tasking

Missing Signed-off-by.

> ---
>  t/t4018-diff-funcname.sh |  1 -
>  t/t4018/ada.sh           | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100755 t/t4018/ada.sh
> 
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index ba10d1f5313..b0c2782d067 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -18,7 +18,6 @@ test_expect_success 'setup' '
>  	# Do not add anything to this list. New built-in drivers should have
>  	# tests
>  	cat >drivers-no-tests <<-\EOF &&
> -	ada
>  	bibtex
>  	csharp
>  	html
> diff --git a/t/t4018/ada.sh b/t/t4018/ada.sh
> new file mode 100755
> index 00000000000..45fc2c7a3b2
> --- /dev/null
> +++ b/t/t4018/ada.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +#
> +# See ../t4018-diff-funcname.sh's test_diff_funcname()
> +#
> +
> +test_diff_funcname 'ada: "procedure" over "with"' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +procedure Bottles is
> +EOF_HUNK
> +with Ada.Text_Io; use Ada.Text_Io;
> + procedure Bottles is
> + begin
> +    for X in reverse 1..99 loop
> +       Put_Line(Integer'Image(X) & " bottles of beer on the wall");
> +       Put_Line(Integer'Image(X) & " bottles of beer"); -- ChangeMe
> +       Put_Line("Take one down, pass it around");
> +       Put_Line(Integer'Image(X - 1) & " bottles of beer on the wall");
> +       New_Line;
> +    end loop;
> + end Bottles;
> +EOF_TEST
> +
> +test_diff_funcname 'ada: "task" over "procedure"' \
> +	8<<\EOF_HUNK 9<<\EOF_TEST
> +task body Check_CPU is
> +EOF_HUNK
> +procedure Housekeeping is
> +  task Check_CPU;
> +  task Backup_Disk;
> +
> +  task body Check_CPU is
> +    -- Comment for spacing with
> +    -- the above "task" for -U1

Aren't we using -U0 by now?

> +    ChangeMe
> +  end Check_CPU;
> +end Housekeeping;
> +EOF_TEST
> 

I don't see anything special in these tests. Couldn't you just use the
simplified version of tests, which are much easier to read than this
shell script with EOF markers?

-- Hannes
