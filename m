Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE171C10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1A02072A
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUNpK1/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCINHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:07:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35324 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCINHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 09:07:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id c1so10048325oiy.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wG7tR4Gr2GGLUndjQwsSlZbbq1BGxVy9+4srWO2EH4A=;
        b=aUNpK1/el9xZ5yxcggpw3XnWZUPGoY3vaFy+IHCVw9KS9U90skUtdfaUWup3uM0uQ9
         kQX8BWbDNVtg20f4s/6Ost+iAVp0BGkIi2Y3KTUURzXO+2WhQRsezN070ZrONd1fKPzc
         jWB+fntXGVcbVCPSCjoWGbNMsZKtwUxzKKsXAqKVJv/B2SX/qAuYsuCJIlO40YumIl9N
         yfkAa9Tn2nV7/Pxh7KQNy/3QAxrKbDz9jaRURf4YrD+NiowqxLWD0JpCWcLn33RlWpKW
         8KrSVEQ118oKiiv0ALlPezCupuhHNOE48sHd8/Chb/zcSTkKkgO69U7sWdniKPVHnYI5
         FxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wG7tR4Gr2GGLUndjQwsSlZbbq1BGxVy9+4srWO2EH4A=;
        b=il8uyc7riopI3ujXCwuWsY7B9TANYOEUD0FCLOipx3/EN0h+p42Ni57WqaZFxyWPTn
         HWcde1d0ZTaJPwvmHSpCsYxRYirB/OQL9ltFzHk0vGHutYrZvyrZHunlnUPGYjkHPVNk
         2dqDZLPWx3xsFvLMkuwKtisldiIH8aGc3JFn3u9gwjXdEl8ohHaZZNXLTecMNTmtfDZg
         muCJeoLCghvFoaaYdXItdKMhVeaqmMJiMOfG00xjgJfPg/vjWw6O6khD3h31D2M/g4H0
         +UfocE4t+Z2P7flMYC7wLFG30oYl5TtK5a5qsZa/c3d1kckxQZd3xQ93NA5GA6D0u2/R
         0iWQ==
X-Gm-Message-State: ANhLgQ35Kg8M7o+JLgxhbimqJEpt8CrlODEbQTFa+x+I97Qs/Cre0CQE
        wK8J8Vmt7hCR0WHARsZEXgdIJ5J1UTg=
X-Google-Smtp-Source: ADFU+vt7aTsdPe575BA9SgFQfsv/sIJhFyWmxrRXqYzXA7xGjvzbJRBiRGRulnWH4WKoSx+b6nAw3g==
X-Received: by 2002:aca:4c12:: with SMTP id z18mr518335oia.43.1583759230735;
        Mon, 09 Mar 2020 06:07:10 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z28sm1811228otj.52.2020.03.09.06.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 06:07:09 -0700 (PDT)
Subject: Re: [PATCH] t1091: don't grep for `strerror()` string
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <018001d5f305$0c709af0$2551d0d0$@nexbridge.com>
 <20200308084627.26677-1-martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30680fbc-203d-ef31-9863-794ff8f55382@gmail.com>
Date:   Mon, 9 Mar 2020 09:07:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200308084627.26677-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2020 4:46 AM, Martin Ågren wrote:
> We grep for "File exists" in stderr of the failing `git sparse-checkout`
> to make sure that it failed for the right reason. We expect the string
> to show up there since we call `strerror(errno)` in
> `unable_to_lock_message()` in lockfile.c.
> 
> On the NonStop platform, this fails because the error string is "File
> already exists", which doesn't match our grepping.
> 
> See 9042140097 ("test-dir-iterator: do not assume errno values",
> 2019-07-30) for a somewhat similar fix. There, we patched a test helper,
> which meant we had access to `errno` and could investigate it better in
> the test helper instead of just outputting the numerical value and
> evaluating it in the test script. The current situation is different,
> since (short of modifying the lockfile machinery, e.g., to be more
> verbose) we don't have more than the output from `strerror()` available.

This is the better design, and I should have used it in the first
place. The test is really trying to reveal that we are using a .lock
file, and the new error message check makes this even more clear.

> Except we do: We prefix `strerror(errno)` with `_("Unable to create
> '%s.lock': ")`. Let's grep for that part instead. It verifies that we
> were indeed unable to create the lock file. (If that fails for some
> other reason than the file existing, we really really should expect
> other tests to fail as well.)
> 
> An alternative fix would be to loosen the expression a bit and grep for
> "File.* exists" instead. There would be no guarantee that some other
> implementation couldn't come up with another error string, That is, that
> could be the first move in an endless game of whack-a-mole. Of course,
> it could also take us from "99" to "100" percent of the platforms and
> we'd never have this problem again. But since we have another way of
> addressing this, let's not even try the "loosen it up a bit" strategy.

Your alternate substring is better than loosening the pattern in
several ways.

> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Hi Randall,
> 
>  Thanks for the report.

I'll second the thanks on the report, and extra thanks to Martin for
the fix!

>  > test to fail. The error message generated is "File already exists" not "File
>  > exists" as is required in the test. We should not be testing for specific
>  > text content originating from strerror - I thought we had this decision in a
>  > different thread.
>  > https://public-inbox.org/git/xmqq36intlpj.fsf@gitster-ct.c.googlers.com/
> 
>  > error: 'grep File exists err' didn't find a match in:
>  > fatal: Unable to create '/home/ituglib/randall/git/t/trash
>  > directory.t1091-sparse-checkout-builtin/repo/.git/info/sparse-checkout.lock'
>  > : File already exists.   <----- this is the test issue
> 
>  Does this patch solve it?
> 
>  t/t1091-sparse-checkout-builtin.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index b4c9c32a03..44a91205d6 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -305,7 +305,7 @@ test_expect_success 'fail when lock is taken' '
>  	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
>  	touch repo/.git/info/sparse-checkout.lock &&
>  	test_must_fail git -C repo sparse-checkout set deep 2>err &&
> -	test_i18ngrep "File exists" err
> +	test_i18ngrep "Unable to create .*\.lock" err
>  '
>  
>  test_expect_success '.gitignore should not warn about cone mode' '

This change looks good to me. The commit message is superb.

Thanks,
-Stolee


