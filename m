Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF69C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3E120737
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ+QUuZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbgDAURs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:17:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37251 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAURs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 16:17:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so1643662wrm.4
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IgYZL+wLE1oriJgTZA8wjgTgVC1o/VU17rOtjyhaJgE=;
        b=XZ+QUuZnyI0dldj2Zea89oM83KyTA3uIfRuYnl2/8t3vzevpd1LVIpHtd6562IbuJ6
         35otpOaXC0GQ2l5BpOcFg1G+7nXyM3sj0vRycwhbG4qmqRuS9DHvUUMr1b+CaVECFR88
         aPfz4t0gPaeziTsN/X4My2HDgMUAjdAvhS5ZZ6bpI1mMjgQ1neIf+OlVb99dQdDo2TuC
         I5sFptK2BBFr3+iyQcK77i7WsH1nOMxMuvgp0TFouI6debePZNg7qE2irME+qB8zLOCC
         fXjPkAEVvLRLMVYYh8yU91+uD3zCcUkxtiROUgbZFRzxrNkvUPRUU01AADO8XmZaglN8
         QX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IgYZL+wLE1oriJgTZA8wjgTgVC1o/VU17rOtjyhaJgE=;
        b=pUtE3XJddlgPWWRQiY0PVilZ3qPnIxOMq0hxzaW4LI5z99Jj7LbF2qrh2+9Riee5NG
         I8mXpnpNjUZWyjbV1DI77CmtaX76VU2NUEu4Z/YPJqgGVhZHHxImIExtLiCuqq/s8QpI
         9NpEFIMfIu7Dsc3ESYGi9XzBYzrbI0w2FNBSj7eXAuvToPuugz3/T4tLhclowgtXqQnq
         V/zwlDThLQl9RWVgXeag8fwLsEYmbuGWHCBW+SMd12emtRh7FJ5N/aPbZxYdq4GQmNeQ
         3E5JRejktUyAtkwJo+X8AyO1yYpEjTN+aGBXSaRgZcBi1FLuG87fHBc5ZS3vjaBjosfE
         m35Q==
X-Gm-Message-State: ANhLgQ04LW0aqGLs4PSK5dqyQ8yWBf57aaHmC5gP4mMIkb965kz93BeL
        gA330dpI14J1lGeyTxTjnmFqoUtx
X-Google-Smtp-Source: ADFU+vs2EMeY3CaIdn0OzGJ+02I2jgwrrqYSI0ohtXj+BXH6YebQrfw5VFpeoeAc5ZE1dkJfnXWbcA==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr9836815wrw.43.1585772267032;
        Wed, 01 Apr 2020 13:17:47 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id j11sm3955043wmi.33.2020.04.01.13.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:17:46 -0700 (PDT)
Date:   Wed, 1 Apr 2020 22:17:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v11 2/5] bugreport: add tool to generate debugging info
Message-ID: <20200401201743.GF2224@szeder.dev>
References: <20200325212500.135046-1-emilyshaffer@google.com>
 <20200325212500.135046-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200325212500.135046-3-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 02:24:57PM -0700, Emily Shaffer wrote:
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> new file mode 100755
> index 0000000000..65f664fdac
> --- /dev/null
> +++ b/t/t0091-bugreport.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description='git bugreport'
> +
> +. ./test-lib.sh
> +
> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> +# information there; we can make sure all our headers were followed by some
> +# information to check if the command was successful.
> +HEADER_PATTERN="^\[.*\]$"
> +
> +check_all_headers_populated () {
> +	while read -r line
> +	do
> +		if test "$(grep "$HEADER_PATTERN" "$line")"
> +		then
> +			echo "$line"
> +			read -r nextline
> +			if test -z "$nextline"; then
> +				return 1;
> +			fi
> +		fi
> +	done
> +}
> +
> +test_expect_success 'creates a report with content in the right places' '
> +	git bugreport -s check-headers &&
> +	check_all_headers_populated <git-bugreport-check-headers.txt &&
> +	test_when_finished rm git-bugreport-check-headers.txt

'test_when_finished' should be at the beginning of the test, otherwise
it will have no effect if a command before it were to fail.

> +'
> +
> +test_expect_success 'dies if file with same name as report already exists' '
> +	>>git-bugreport-duplicate.txt &&
> +	test_must_fail git bugreport --suffix duplicate &&
> +	test_when_finished rm git-bugreport-duplicate.txt
> +'
> +
> +test_expect_success '--output-directory puts the report in the provided dir' '
> +	git bugreport -o foo/ &&
> +	test_path_is_file foo/git-bugreport-* &&
> +	test_when_finished rm -fr foo/
> +'
> +
> +test_expect_success 'incorrect arguments abort with usage' '
> +	test_must_fail git bugreport --false 2>output &&
> +	test_i18ngrep usage output &&
> +	test_path_is_missing git-bugreport-*
> +'
> +
> +test_expect_success 'runs outside of a git dir' '
> +	nongit git bugreport &&
> +	test_when_finished rm non-repo/git-bugreport-*
> +'
> +
> +test_expect_success 'can create leading directories outside of a git dir' '
> +	nongit git bugreport -o foo/bar/baz &&
> +	test_when_finished rm -fr foo/bar/baz
> +'
> +
> +
> +test_done
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
