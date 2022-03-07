Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4287C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiCGL3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbiCGL3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:29:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D05AECD
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:12:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so13844023edc.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=T2beQHTC23FFqnrHiCY2Kccewsrqlfy9U0rJGdKYysM=;
        b=jyIV81fVLgvj7JNZ7KR3p3ylOCFb9+xwaGP0/QA+la8ZVQJOOyJ/T2Mu2uGKR0K3J/
         iyYBBh2TY+S+pi+y+N2ZMNQ6+zv91k1XcZr/u1NAC4H9LUt5Z672WtAfK2PpCSVcjcih
         /7JpAw4X0F5f7wYUxiKJsKONHXtcUOjLsdL8U9Eo+s808GbICxGMTLCa4VICSds6u7Wi
         ZupiP2oYq+HOGHthfc2iPRa+Kc1/IlT45rFonF+yA5UgObfnPHPt2fU+op1SqgivEs6p
         YFpjdIL0Hs8F722n5lZ5LAmeGNae2hPzoskPKvboz+7SvVyd5ehA2aVi/OmDcYoz+aYM
         KsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=T2beQHTC23FFqnrHiCY2Kccewsrqlfy9U0rJGdKYysM=;
        b=qsaws7OlSbgsWm9Lp653TCgWZlHGkQdt6vA+KIa5H7kRL3noTBvtko1W38uEY4J094
         SFmwz1p0CLIOKNel+kKFeP5Wfa7BpSoOVI2HBAXkG9mvTAZUgTyAxXN/vCfguJI+4uCX
         LpaDhEYqNb0vYtM28n/nbC8tdjqJSRT+mYESDRG89UAU4Pz041QfKrGBvkpD+gCYMKPn
         gFzbZfru66IqeEmxDvUnUC/5rnjzpYauBtxWmXWKHXULLdmiJfkPV+s3xWYEvNVklr51
         z5iblYuAs5jJV8Yt4wL7tiOuW7BPDUVCslgDj+gnos+ju/VAby4RbViWRSDI/Iy2D32g
         Prag==
X-Gm-Message-State: AOAM5308d6i1tJUIV+pufQmi7+rPc/UflO/AO3/KTPtTS0haE92MjdNw
        i33zRz+pGyT0FIb+1HUxUL8z2ezIAmM=
X-Google-Smtp-Source: ABdhPJyuoNQTyN84Fp9l4IGNxK0TXGJnTESq3LT2zQqD5eZ5eqiVURMYBCuzaHotcvtl4fMo5/rKaQ==
X-Received: by 2002:a05:6402:1d52:b0:415:bf04:28b4 with SMTP id dz18-20020a0564021d5200b00415bf0428b4mr10609162edb.83.1646651524986;
        Mon, 07 Mar 2022 03:12:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm4633630ejc.24.2022.03.07.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:12:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRBHX-001RAR-L9;
        Mon, 07 Mar 2022 12:12:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 24/30] t/perf/p7519: speed up test on Windows
Date:   Mon, 07 Mar 2022 12:09:36 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <a70748b4640e673de32e24a77080c27da580a1df.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <a70748b4640e673de32e24a77080c27da580a1df.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220307.86zgm210fw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
> to touch thousands of files.  This takes minutes off of test runs
> on Windows because of process creation overhead.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index c8be58f3c76..aed7b1146b0 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -72,7 +72,7 @@ then
>  	fi
>  fi
>  
> -trace_start() {
> +trace_start () {
>  	if test -n "$GIT_PERF_7519_TRACE"
>  	then
>  		name="$1"
> @@ -91,13 +91,20 @@ trace_start() {
>  	fi
>  }
>  
> -trace_stop() {
> +trace_stop () {
>  	if test -n "$GIT_PERF_7519_TRACE"
>  	then
>  		unset GIT_TRACE2_PERF
>  	fi
>  }

These minor unrelated style fixups could be split up / sent seperately?
Especially as the seem not to conflict hunk-wise with the actual changes
here.

> +touch_files () {
> +	n=$1
> +	d="$n"_files
> +
> +	(cd $d ; test_seq 1 $n | xargs touch )

Missing &&-chaining for "cd"

> -setup_for_fsmonitor() {
> +setup_for_fsmonitor () {
>  	# set INTEGRATION_SCRIPT depending on the environment
>  	if test -n "$INTEGRATION_PATH"
>  	then
> @@ -173,7 +181,7 @@ test_perf_w_drop_caches () {
>  	test_perf "$@"
>  }
>  
> -test_fsmonitor_suite() {
> +test_fsmonitor_suite () {

ditto unrelated style changes.

>  	if test -n "$INTEGRATION_SCRIPT"; then
>  		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
>  	else
> @@ -199,15 +207,15 @@ test_fsmonitor_suite() {
>  
>  	# Update the mtimes on upto 100k files to make status think
>  	# that they are dirty.  For simplicity, omit any files with
> -	# LFs (i.e. anything that ls-files thinks it needs to dquote).
> -	# Then fully backslash-quote the paths to capture any
> -	# whitespace so that they pass thru xargs properly.
> +	# LFs (i.e. anything that ls-files thinks it needs to dquote)
> +	# and any files with whitespace so that they pass thru xargs
> +	# properly.
>  	#
>  	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>  		git ls-files | \
>  			head -100000 | \
>  			grep -v \" | \
> -			sed '\''s/\(.\)/\\\1/g'\'' | \
> +			egrep -v " ." | \

Per dcf9a748cab (t7700: replace egrep with grep, 2019-12-04) should we
be adding more egrep?

Also, even if we did want that, why does a the " ." regex need ERE over
BRE here?
