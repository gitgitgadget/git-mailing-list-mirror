Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52825C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244CA20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 14:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieIvhcp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGOSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:18:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGOSH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 09:18:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so2878335wru.7
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 06:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hU3BPCz6397o2/NoM+6xmekWEMv077kSqPtQSBdGOIU=;
        b=ieIvhcp7DXzORBGcfV2jsaqOspn+YbO0QvMgA0aAVfdOxBNQToOOgQBTF55wY3nuDL
         Nwx3nT7G50zaUnaMp61wFSRq5FoC1bL0ueDMqwkfYBjQ38bgeFBIjqkRJMbyBXH2c7X7
         1I/0XIxfYstaktKa5IUKF40qBCB8ikJtA6IBCG0+UlNNGnlsqmqcQ4CQku/laiEhvI8m
         Ou11VD9hX2YKzDJ7Yu7smqVfOD40JgdJwU2ylh0gVzmTbO0mTdoSBuod97CLkoBUjrWc
         P835tGmVnHnwyfuwGpXQjJ/5ZbrEK/6Ze9xmw7ogdL5HxzSI5Jj0y0EMM3NVU6Dx6zer
         SKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hU3BPCz6397o2/NoM+6xmekWEMv077kSqPtQSBdGOIU=;
        b=ckdL/2n5Azz23yuNF26kMEghS1YCQ75fZAR/gcFnAkPmmy0v20EruZqmlJ89A/U2p+
         deVCwcN/F6FA6lGMyH71XZokOL4oagxA54ZUPbRz6IP2GXofgwIhYntqys4wmj39rm3a
         Iv85d4x/fSLJNDRyqxT52FB93nPMRg892QwsRhpeyAufztqb12OuQSwZSNWtOskdk46t
         3TiKUEQrWpSdwVPtmQ0R3LDdYBHFOH8ryoOopQ/LmgaXK1UB00jRpWBXejxEZWz7Fp0e
         ZzQnytqfHei/CrvUJ7YKp2osBv7tXiR/BQ6W7cxcuswppLuHfiZYzPSNLqca2RsS0BJ5
         Jztg==
X-Gm-Message-State: APjAAAXBKD59QemGmwPgb9SSMr6NKNmZcwmv3evIxSScOzk3E0jjowho
        3/Sl7/ElSXnJ8q+FBt+BlO4JDSbr
X-Google-Smtp-Source: APXvYqzC+Ya+l7bxtTvWLrNAKUnhUB+Xy3hwjySw36liL+c9mx6oA7v2PVLd7zpLCYqze4OP/2I8xA==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr4899463wrw.318.1581085085628;
        Fri, 07 Feb 2020 06:18:05 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id y8sm3479435wma.10.2020.02.07.06.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 06:18:04 -0800 (PST)
Date:   Fri, 7 Feb 2020 15:18:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200207141802.GE2868@szeder.dev>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206004108.261317-4-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 04:40:56PM -0800, Emily Shaffer wrote:
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> new file mode 100755
> index 0000000000..451badff0c
> --- /dev/null
> +++ b/t/t0091-bugreport.sh
> @@ -0,0 +1,49 @@
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
> +check_all_headers_populated() {
> +	while read -r line; do
> +		if test "$(grep "$HEADER_PATTERN" "$line")"; then
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
> +	git bugreport &&
> +	REPORT="$(ls git-bugreport-*)" &&

What if the globbing were to match more than one file?

> +	check_all_headers_populated <$REPORT &&
> +	rm $REPORT

Please register a cleanup commands like this with 'test_when_finished'.

> +'
> +
> +test_expect_success 'dies if file with same name as report already exists' '
> +	touch git-bugreport-duplicate.txt &&
> +	test_must_fail git bugreport --suffix duplicate &&
> +	rm git-bugreport-duplicate.txt
> +'
> +
> +test_expect_success '--output-directory puts the report in the provided dir' '
> +	mkdir foo/ &&

Is it really necessary to create the directory in advance?  Or to put
it in another way: shouldn't 'git bugreport' create any missing
leading directories of the path given for its '-o' option?  FWIW, 'git
format-patch -o dir ...' does create all necessary directories.

> +	git bugreport -o foo/ &&
> +	test_path_is_file foo/git-bugreport-* &&

What if the globbing were to match more than one file? :)

> +	rm -fr foo/
> +'
> +
> +test_expect_success 'incorrect arguments abort with usage' '
> +	test_must_fail git bugreport --false 2>output &&
> +	grep usage output &&

This breaks the GETTEXT_POISON CI job, because "usage" is translated,
so the test should not look for it with plain 'grep'.  Please use
'test_i18ngrep' instead.

> +	test_path_is_missing git-bugreport-*
> +'
> +
> +test_done
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
