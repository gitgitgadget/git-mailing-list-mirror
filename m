Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23968C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF8661175
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 07:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhGTGoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhGTGn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 02:43:58 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A9C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 00:24:37 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s11-20020a4ae48b0000b02902667598672bso1162579oov.12
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/efE6va2A1i8HNdfdE9vVwFqPKGud9OqWBR8S/5L7Xc=;
        b=a8g80hk+/jY3Zri+K+cggJzTrkf2h+wKsIf0jSz21zHiOLiMUKxoPQySfLrGDDDB5h
         uw+cyv+W9jG4F1VC3ANq9eADnyrfyLabBrQ3xTtHacc2/SjgboPGMCIB72ZzU6B/z11W
         AJr00qjijiGZhs2fuRA8IA0iuYVeQN5quIVv4z3duCvNr02AghlV5AQfF7dh73OKzLmX
         kQ1iVSSlaF2/SweNzVE7Udj+t51TXjHwu2bAK8aDkI7578+b8rQvI0okZc/Jw7dz6OzR
         tdjeMfj0iPdItL1XBqTyexIkX410RHGG+d7rokEGag44USAe9rHi3yWBK450MDDn0/ZA
         s3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/efE6va2A1i8HNdfdE9vVwFqPKGud9OqWBR8S/5L7Xc=;
        b=tvjTmzDAgUHUl/6zRZF7tKXcRHkpT9VE4Ibmp2IM1jg68iz2N+qsG/3qgDvmjmMLvy
         vhMg0GLPGNFrKD0fatR3auKsubl2IQwO4pngrurBk6hZIUG+f7BHGxmUdIr6Y/um6D5T
         SYINeWK02Wjz7njaxcmaEPagXujASseDu8QhtKMZi73UJ+rSqE/8BpBwu+3ZI7mPdeuL
         8/8AMu3KBjiTYZhjI/BE8c7Otd/Mi2h643wA3KgVtIwtLQEvvBWOHIkqY5InmnpnrmXL
         fgaBIYyriaFYv0KVza9vmtKlw+/5wCqoytLhLv8gPD/NpfiuyaWK5+hQ+yXt7sx9ih/m
         s3Zw==
X-Gm-Message-State: AOAM531mAMfLqqGWsTDtgmn0ojLEWYoWBWPIURSpRYSoBFkbRcTxhLcU
        SNxFyXo3D9YCYYrYUW2dFHE=
X-Google-Smtp-Source: ABdhPJw74TjSq/BKHl/ZZ9CkLuQlLO/yhMV/NQwBwUlOZWkdEw/dVdZBk8Qehr0T5U/Wuw0lf5uO5A==
X-Received: by 2002:a4a:892a:: with SMTP id f39mr19881668ooi.19.1626765876858;
        Tue, 20 Jul 2021 00:24:36 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 81sm4057078otv.10.2021.07.20.00.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:24:36 -0700 (PDT)
Date:   Tue, 20 Jul 2021 02:24:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60f67a334777f_14a799208b9@natae.notmuch>
In-Reply-To: <44006e7b0bdda50dc51153cc2efb6ae954d4eecb.1626762728.git.ps@pks.im>
References: <60f5d923848d3_145c71208cc@natae.notmuch>
 <44006e7b0bdda50dc51153cc2efb6ae954d4eecb.1626762728.git.ps@pks.im>
Subject: RE: [PATCH] t0000: fix test if run with TEST_OUTPUT_DIRECTORY
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> Testcases in t0000 are quite special given that they many of them run
> nested testcases to verify that testing functionality itself works as
> expected. These nested testcases are realized by writing a new ad-hoc
> test script which again sources test-lib.sh, where the new script is
> created in a nested subdirectory located beneath the current trash
> directory. We then execute the new test script with the nested
> subdirectory as current working directory and explicitly re-export
> TEST_OUTPUT_DIRECTORY to point to that directory.
> 
> While this works as expected in the general case, it falls apart when
> the developer has TEST_OUTPUT_DIRECTORY explicitly defined either via
> the environment or via config.mak. In that case, test-lib.sh will
> clobber the value that we've just carefully set up to instead contain
> what the developer has defined. As a result, the TEST_OUTPUT_DIRECTORY
> continues to point at the root output directory, not at the nested one.
> 
> This issue causes breakage in the 'test_atexit is run' test case: the
> nested test case writes files into "../../", which is assumed to be the
> parent's trash directory. But because TEST_OUTPUT_DIRECTORY already
> points to to the root output directory, we instead end up writing those
> files outside of the output directory. The parent test case will then
> try to check whether those files still exist in its own trash directory,
> which thus must fail now.
> 
> Fix the issue by adding a new TEST_OUTPUT_DIRECTORY_OVERRIDE variable.
> If set, then we'll always override the TEST_OUTPUT_DIRECTORY with its
> value after sourcing GIT-BUILD-OPTIONS.

This is a very *very* narrowly-specific hack, but I guess it's better
than the test suite failing.

-- 
Felipe Contreras
