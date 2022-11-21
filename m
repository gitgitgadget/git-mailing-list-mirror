Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55C6C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiKUNjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKUNjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 08:39:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D77ECB9
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:38:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so10643462pli.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmaVBc4TsELhMx5LQC8hkmL5l06u0eWMpaz9bEWWCSs=;
        b=Mf/7U3dojxG3RaAOVmM0Ytvzdv0B+EKYpKPrDIY/Men4OVMbd8tkXqYAcfpjGWYlzI
         +vanHOEgc4tIZf8t+BQwAOYSTl1VQrnBJwSMHSp5jAUJA51xvn30TPZcnanq+qP1HV6X
         3yLgup+BAovgFuh7wKGmt/5yO8JlyYGmoZt98XAXCLcygFna0honVeHFSszV2ymDkWzm
         dRfieG6SOlcHEmJR5JR4yXoIbp1WLplZ9CQSve0UaJrZ2vy2mQY/nN11b0k8Uk8PbYl7
         Jz4kNG6+UWN806SDG+R9iEH7lHy5DoQvyajZnbx+MhIHzTZ9Igv8ndhaBPV8QxY1LahM
         CG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmaVBc4TsELhMx5LQC8hkmL5l06u0eWMpaz9bEWWCSs=;
        b=BwNKz/7gJJ2KVlSMngtDd9/Flf6XKOkxQVOV21y3RjaE5z7zTx5ylTctDGGwTgYLQk
         ksVmx4NUIdZTgsD3fpFJtpleADbgPG3fiesEzEwou8KaD3XVhzwAsDQqzODlnkZsvSmx
         BvvxMjQkKHosbkM1RplsXp8SeSRYClVCKpTf8/r30lWiURU6sJSXfCilhcZrcZhGOzvH
         JBAqrafzjKnDzuApIJGKjeKqU+4QzYUf+/nXvB5qw/mVoM2d3TunFyEsztERphRdeER9
         0LlyR7XTDSju4hBpH0G55xNUPpxbQH9x7iSMKpmjCqvcn6cPp62Yezi2iJj2OKZ4rnLJ
         31SQ==
X-Gm-Message-State: ANoB5pl3wLsGzsFggdfufW4r0VvZuHvdO4QFac1Gu/nuokFZDPYGKrWJ
        RfCHD5xwoCptG0INlPEYMI2ocJUhSn0=
X-Google-Smtp-Source: AA0mqf486ooRL9640T48Q22jMrEa2ODrdwCxVr/XGPq2iabLJCd7WX9HoixFWuF/cPXRMn/pMU9L3A==
X-Received: by 2002:a17:90a:8a03:b0:218:9f92:d1a0 with SMTP id w3-20020a17090a8a0300b002189f92d1a0mr9299847pjn.53.1669037924404;
        Mon, 21 Nov 2022 05:38:44 -0800 (PST)
Received: from localhost ([2001:ee0:4f8b:a070:2a99:1bbd:b117:5037])
        by smtp.gmail.com with ESMTPSA id y129-20020a62ce87000000b0056bd737fdf3sm8700968pfg.123.2022.11.21.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:38:43 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:38:41 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        Eric DeCosta <edecosta@mathworks.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: fsmonitor: t7527 racy on OSX?
Message-ID: <Y3t/YbZUIuIJkSil@danh.dev>
References: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-21 14:07:13+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> I have access to a Mac OS X M1 box (gcc104 at [1]) where t7527 reliably
> fails due to what seems to be a race us doing something, and assuming
> that fsmonitor picked up on it.

See also https://lore.kernel.org/git/YvZbGAf+82WtNXcJ@danh.dev/

I raised 3 months ago and it seems like Jeff Hostetler is too busy.

> 
> This makes the tests pass:
> 	
> 	diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> 	index 56c0dfffea..ce2555d558 100755
> 	--- a/t/t7527-builtin-fsmonitor.sh
> 	+++ b/t/t7527-builtin-fsmonitor.sh
> 	@@ -428,6 +428,7 @@ test_expect_success 'edit some files' '
> 	 	start_daemon --tf "$PWD/.git/trace" &&
> 	 
> 	 	edit_files &&
> 	+	sleep 1 &&
> 	 
> 	 	test-tool fsmonitor-client query --token 0 &&
> 	 
> 	@@ -443,6 +444,7 @@ test_expect_success 'create some files' '
> 	 	start_daemon --tf "$PWD/.git/trace" &&
> 	 
> 	 	create_files &&
> 	+	sleep 1 &&
> 	 
> 	 	test-tool fsmonitor-client query --token 0 &&
> 	 
> 	@@ -471,6 +473,7 @@ test_expect_success 'rename some files' '
> 	 	start_daemon --tf "$PWD/.git/trace" &&
> 	 
> 	 	rename_files &&
> 	+	sleep 1 &&
> 	 
> 	 	test-tool fsmonitor-client query --token 0 &&
> 	 
> 	@@ -978,6 +981,7 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
> 	 	mkdir test_unicode/nfd/d_${utf8_nfd} &&
> 	 
> 	 	git -C test_unicode fsmonitor--daemon stop &&
> 	+	sleep 1 &&
> 	 
> 	 	if test_have_prereq UNICODE_NFC_PRESERVED
> 	 	then
> 
> The failure is when we grep out the events we expect, which aren't
> there, but if you manually inspect them they're there. I.e. they're just
> not "in" yet.
> 
> I thought this might be a lack of flushing or syncing in our own trace
> code, but adding an fsync() to trace_write() didn't do the trick.
> 
> 1. https://cfarm.tetaneutral.net/news/41#

-- 
Danh
