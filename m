Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F38C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 13:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjERNdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjERNdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 09:33:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E450F1A7
        for <git@vger.kernel.org>; Thu, 18 May 2023 06:32:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30626f4d74aso1377246f8f.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684416773; x=1687008773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A1RvlDKpdYd7ejFdrIfD//YkZ7B6AONKy7vK/wOEs4s=;
        b=GHgOOgzZ8rFYM9NF1PDACbyDlS8Q4lrLMRl84jCHSvy3PuDdggKGBgQPHaoANi8TkR
         IPiJ7HaDMIOvGhnTsyGxzWYeRoXZgDJUER2MuzJnWfDtty6uai78lxmKttyCqjpQO/bX
         Mbr/p1jEYXp+i6wZwh0DU/vdK9KLZ2wgX59W7Nm6Ii2+qZJeWMntAMS16AgyZL6mpW82
         HxPHgSLWy4c84lLR4pc/uwod2le+RYzIvUOn/3cdAWPXrXfrF3tp3hU5hwzs2a+UANp2
         VguBYO1nzfEkiZ4i5d3utAzdHP2G+l4Wi8HjNggrCp7F3n2Rs5ODFHSq0RDaoOM8DY21
         7y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684416773; x=1687008773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1RvlDKpdYd7ejFdrIfD//YkZ7B6AONKy7vK/wOEs4s=;
        b=SyYEVEmaWSGMkcRLwFZfDAb5gFJ67o90PY2Jqc4LsEIgGZYUVIc9ThEilDfEGnJD/2
         tdHMteEuXxuZef0KXFMYSdYAwk7hWkkGkRupxCGMf/4xix7zNdN5pvvclaY4QhukwzMP
         yXPvExpBtHcgUk4oGDYGsstaFSEX+YoABmLq/cB3t42IFx+c1BdxARb2WAr9q1kNhdln
         zJvtYClr75GxJGdamTnY96vQ/BLDuo6TNRTvmIiQApT8DMnXiq4Ad7j/GGbNegKoQ6cr
         fVT16dgCoWTvknUwZrbBbtqIB/+OHQFN/PUqI+/J4bLuuMDR+IzBBLYoR95ds2SNtSzW
         FGkQ==
X-Gm-Message-State: AC+VfDxSDS9QOJxk2UyJ/e/hnwxiFPOT3xqjAeLgitoChXtncsnWBsdJ
        lVIW3SH+TRCUSAg8bmr9zvMGrvnquu4=
X-Google-Smtp-Source: ACHHUZ4mt9FVrQ3J3FdKxvsFsjc4mmFHaR34YkMZoghWUONZzQdjPjmQePDAGtTegq4nAmoYYqD6nA==
X-Received: by 2002:adf:f20b:0:b0:306:36e7:db27 with SMTP id p11-20020adff20b000000b0030636e7db27mr1689611wro.16.1684416773167;
        Thu, 18 May 2023 06:32:53 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id z2-20020a1cf402000000b003f4f9274d10sm2098430wma.16.2023.05.18.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 06:32:52 -0700 (PDT)
Message-ID: <e26789b2-21fd-668d-ee00-2640d5b8d5c2@gmail.com>
Date:   Thu, 18 May 2023 14:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 4/4] unit test: add basic example and build rules
Content-Language: en-US
To:     steadmon@google.com, git@vger.kernel.org
Cc:     calvinwan@gmail.com, szeder.dev@gmail.com, chooglen@google.com,
        avarab@gmail.com, gitster@pobox.com, sandals@crustytoothpaste.net,
        Calvin Wan <calvinwan@google.com>
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-4-21b5b60f4b32@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230517-unit-tests-v2-v2-4-21b5b60f4b32@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/2023 00:56, steadmon@google.com wrote:
> Integrate a simple strbuf unit test with Git's Makefiles.
> 
> You can build and run the unit tests with `make unit-tests` (or just
> build them with `make build-unit-tests`). By default we use the basic
> test runner from the C-TAP project, but users who prefer prove as a test
> runner can set `DEFAULT_UNIT_TEST_TARGET=prove-unit-tests` instead.
> 
> We modify the `#include`s in the C TAP libraries so that we can build
> them without having to include the t/ directory in our include search
> path.

Thanks for adding some example tests, it is really helpful to see how 
the library will be used.

I tried building the units test with SANITIZE=address set and I get lots 
of link errors complaining about undefined references to __asan_*

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> Change-Id: Ie61eafd2bd8f8dc5b30449af1e436889f91da3b7

> diff --git a/t/strbuf-test.c b/t/strbuf-test.c
> new file mode 100644
> index 0000000000..8f8d4e11db
> --- /dev/null
> +++ b/t/strbuf-test.c
> @@ -0,0 +1,54 @@
> +#include "tap/basic.h"
> +
> +#include "../git-compat-util.h"
> +#include "../strbuf.h"
> +
> +int strbuf_init_test()
> +{
> +	struct strbuf *buf = malloc(sizeof(void*));

Is there a reason to use dynamic allocation here. Also I think you need 
sizeof(*buf) to allocate the correct size.

> +	strbuf_init(buf, 0);
> +
> +	if (buf->buf[0] != '\0')
> +		return 0;
> +	if (buf->alloc != 0)
> +		return 0;
> +	if (buf->len != 0)
> +		return 0;
> +	return 1;
> +}

This test nicely illustrates why I'd prefer a different approach. The 
test author has to maintain the pass/fail state and there are no 
diagnostics if it fails to tell you which check failed. To be clear I 
view the lack of diagnostics as the fault of the test framework, not the 
test author. I'd prefer something like

	void strbuf_init_test(void)
	{
		struct strbuf buf;

		strbuf_init(&buf, 0);
		check_char(buf.buf[0] == '\0');
		check_uint(buf.alloc, ==, 0);
		check_uint(buf.len, ==, 0);
	}

which would be run as

	TEST(strbuf_init_test(), "strbuf_init initializes properly");

in main() and provide diagnostics like

     # check "buf.alloc == 0" failed at my-test.c:102
     #    left: 2
     #   right: 0

when a check fails.

> +int strbuf_init_test2() {
> +	struct strbuf *buf = malloc(sizeof(void*));
> +	strbuf_init(buf, 100);
> +
> +	if (buf->buf[0] != '\0')
> +		return 0;
> +	if (buf->alloc != 101)

Strictly speaking I think the API guarantees that at least 100 bytes 
will be allocated, not the exact amount as does alloc_grow() below.

> +		return 0;
> +	if (buf->len != 0)
> +		return 0;
> +	return 1;
> +}
> +
> +
> +int strbuf_grow_test() {
> +	struct strbuf *buf = malloc(sizeof(void*));
> +	strbuf_grow(buf, 100);
> +
> +	if (buf->buf[0] != '\0')
> +		return 0;
> +	if (buf->alloc != 101)
> +		return 0;
> +	if (buf->len != 0)
> +		return 0;
> +	return 1;
> +}

Best Wishes

Phillip

