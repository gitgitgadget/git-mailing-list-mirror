Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4DAC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKUN2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiKUN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 08:27:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10828B1FA
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:27:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so16184747edc.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:user-agent:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Y+rWvAoZZgwlroUSBlWb2j7F1pLRifwrXml3is+raM=;
        b=Jrn3loDFuLwBwdFW1Z8FTdM2GhuJCzlsYPZmEydc9+tTRtgfrIjpIh0nSKF5EpUYaI
         ME/ncs4NFVzTecuIdujAwZ0Sf9hpMQSoWurldleORfqWernSPkr3oUNcJUuTPNE71zgb
         mlU7fPt8X0v0qdlkC7+p6Hrk89iA7hLQ4n696HezFoWLcfi3z6UPRv5ZRHuR146DqGBj
         W7wrZwvV/MYdqGbpzMCgt5/uqmbQwavefdMXVguZNvL0uwVknnAMWuTcxMuOUBtFlWPX
         NUTMWktESQNCdDnY+I0FhMlDe1qkTxg7lHvtE20Gj8lJIHyvHFfuKVPA3WakPij4PDta
         Plng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:user-agent:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y+rWvAoZZgwlroUSBlWb2j7F1pLRifwrXml3is+raM=;
        b=QTZGEZh0M10gUBElW5DXCCCycRgExRVtZuMF/Nq95wawc//GGCjTwsvzK0B5TVo/FZ
         mdQ9cl58oEIsoFhP+qOpOSbwx/RdgvZmzjDDEkIZokzBWvVacEbg6RP/dfNqWN6C/UBk
         Dk/S5AK1/lnX7YTtwHRxSdNYaVT9PtClozzLGpZ6JF2Cjkptp1otAu8iOpBYPRTjAUel
         jXXy7N7x5UbTL9LohPCVKkAFR9BZ94tsDNMZ9bWApWzOUCAuQqhPOqk/4TfU2zh38iwA
         QOyBbupXr8y4ttsAHAODqSI8U7/pLeDUY1nVOiJWw2qycpudz92IWjHdKFtoiExUW1lK
         PPYg==
X-Gm-Message-State: ANoB5plnd4yHVV7zPtx5mBpLqs0J6PkIO2Hlzg8DZke8Xs7QN+rrRtWB
        aHUj90IYzBuDLNeqbRkCqWl6/DUsIGA=
X-Google-Smtp-Source: AA0mqf7uqi8nX2Cj3NtWLZ6JM1aSMRNNRNWyWEzO0Q4lxpoF5HbaCzs1+N9hHmroNm8oKpzrO+2Qpw==
X-Received: by 2002:a05:6402:3203:b0:467:b8c9:a7fa with SMTP id g3-20020a056402320300b00467b8c9a7famr452406eda.25.1669037254254;
        Mon, 21 Nov 2022 05:27:34 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v24-20020a170906859800b00781e7d364ebsm5067875ejx.144.2022.11.21.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:27:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox6ph-0008qk-0w;
        Mon, 21 Nov 2022 14:27:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: fsmonitor: t7527 racy on OSX?
Date:   Mon, 21 Nov 2022 14:07:13 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
Message-ID: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have access to a Mac OS X M1 box (gcc104 at [1]) where t7527 reliably
fails due to what seems to be a race us doing something, and assuming
that fsmonitor picked up on it.

This makes the tests pass:
	
	diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
	index 56c0dfffea..ce2555d558 100755
	--- a/t/t7527-builtin-fsmonitor.sh
	+++ b/t/t7527-builtin-fsmonitor.sh
	@@ -428,6 +428,7 @@ test_expect_success 'edit some files' '
	 	start_daemon --tf "$PWD/.git/trace" &&
	 
	 	edit_files &&
	+	sleep 1 &&
	 
	 	test-tool fsmonitor-client query --token 0 &&
	 
	@@ -443,6 +444,7 @@ test_expect_success 'create some files' '
	 	start_daemon --tf "$PWD/.git/trace" &&
	 
	 	create_files &&
	+	sleep 1 &&
	 
	 	test-tool fsmonitor-client query --token 0 &&
	 
	@@ -471,6 +473,7 @@ test_expect_success 'rename some files' '
	 	start_daemon --tf "$PWD/.git/trace" &&
	 
	 	rename_files &&
	+	sleep 1 &&
	 
	 	test-tool fsmonitor-client query --token 0 &&
	 
	@@ -978,6 +981,7 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
	 	mkdir test_unicode/nfd/d_${utf8_nfd} &&
	 
	 	git -C test_unicode fsmonitor--daemon stop &&
	+	sleep 1 &&
	 
	 	if test_have_prereq UNICODE_NFC_PRESERVED
	 	then

The failure is when we grep out the events we expect, which aren't
there, but if you manually inspect them they're there. I.e. they're just
not "in" yet.

I thought this might be a lack of flushing or syncing in our own trace
code, but adding an fsync() to trace_write() didn't do the trick.

1. https://cfarm.tetaneutral.net/news/41#
