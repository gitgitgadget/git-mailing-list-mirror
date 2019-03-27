Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BF0202BB
	for <e@80x24.org>; Wed, 27 Mar 2019 10:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfC0KLA (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:11:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0KLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:11:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so17780980wra.12
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dFTCtR2/1Sl5vNYxuu454fia8JbIwiusq4Hk6bRGZFs=;
        b=f/1wMkYQgAXPGvqnDwjb1HUKTOmo0bUlEkakaXJCL/HDOEPNogFEymalgEx+Sc+Ris
         2+BUc52H0bYnz1pG5V0T29u27tI7ksjN6tlg8IjX7t21ZMGUn+4bVpPG/GbYy4JUmlQY
         fRoS1xVu4scvpKoEFIVNYVDw13LosC5diD4S1NfVvZCFHsFaWPUyVyJ23i6AporlGHTc
         5HItU2KavVLcMwq380wDptH7gVgIkjTQoP7cZvlM5sAyb6d2MtKvFJEzZhraVNsmLDTs
         9GP2XnQcUEeOeiNi4o2AYYbKCjYdeRgwusawyPXU45gslT7GzlnKNyilaoi6wlE8Tziw
         wOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dFTCtR2/1Sl5vNYxuu454fia8JbIwiusq4Hk6bRGZFs=;
        b=Lp+AJooGxX/pjPNlBQCD+o+U0Z4KC9OFYQnXC1zOC5pbt5XGVcbxra79TVdZoRmaj3
         PhI+u09NwYIoK8YqrlvNVwsQrPFG2Y0ypXXqtmri2eRkeF9VoGe0XwmIn0GsQvbtAN8g
         Bw9vdznjy1axsCPdhOhyrsUBQ6oWiobL1KXN9/faT/1sFHPAoNI8lEBtieLUv4Dj1NIu
         g075YenCy0iCjmZX6xHsfu4OXPafZeJ8bP0pnK9J41/O46ovFzDL3JA3otrb3DqaAe7h
         Jh2c3M1MdjoBULSArmWI2mFM8+CVfZd/vqcU/iNQEeIAcqNCcoEbzvgNHF4+PPBb0RwK
         q7YA==
X-Gm-Message-State: APjAAAVnr4lAWaJiNGmulnvNclh7S1WAlzFEdN3kzrHnyPJBhGl6vOmS
        2jp94stM+g6R+BJczFh149fiHKzoL38=
X-Google-Smtp-Source: APXvYqysxxzV9WSmEcnEGOKGC19JMczoyEwettDn5y16TuYVsM9nlogFi3HyWbixcn2DHfsyWNr1bQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr23792450wrp.72.1553681458506;
        Wed, 27 Mar 2019 03:10:58 -0700 (PDT)
Received: from szeder.dev (x4d0c7b09.dyn.telefonica.de. [77.12.123.9])
        by smtp.gmail.com with ESMTPSA id k9sm25583501wru.55.2019.03.27.03.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 03:10:57 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:10:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: batch fetching of missing blobs
Message-ID: <20190327101055.GB32732@szeder.dev>
References: <20190326220906.111879-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326220906.111879-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 03:09:06PM -0700, Jonathan Tan wrote:
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> new file mode 100755
> index 0000000000..38f03be114
> --- /dev/null
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +
> +test_description='behavior of diff when reading objects in a partial clone'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git show batches blobs' '
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff batches blobs' '
> +	rm -rf server client trace &&

Please use 'test_when_finished' in the previous test to clean up after
itself.

> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo c >server/c &&
> +	echo d >server/d &&
> +	git -C server add c d &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count = 1 done_lines
> +'
> +
> +test_expect_success 'diff skips same-OID blobs' '
> +	rm -rf server client trace &&

Likewise.

> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo another-a >server/a &&
> +	git -C server add a &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	echo a | git hash-object --stdin >hash-old-a &&
> +	echo another-a | git hash-object --stdin >hash-new-a &&
> +	echo b | git hash-object --stdin >hash-b &&
> +
> +	# Ensure that only a and another-a are fetched.
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "want $(cat hash-old-a)" trace &&
> +	grep "want $(cat hash-new-a)" trace &&
> +	! grep "want $(cat hash-b)" trace
> +'
> +
> +test_done
> -- 
> 2.21.0.155.ge902e9bcae.dirty
> 
