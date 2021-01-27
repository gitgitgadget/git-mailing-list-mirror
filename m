Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE0C433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B732264D7F
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhA0XZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhA0W4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:20 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1EEC0617A7
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 14:46:39 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l11so1950521qvt.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 14:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hFKPeHR/K6OTfCtyrAPkmcMC/vgh1gmhyyiWOTkuwxE=;
        b=YyG9LP0TGcJpNwctIW9rXu09s7DrCzDuJErNapnK5v0yzJPlvQSmiEbmGeD8N5mHWA
         iLzWmVJeqwjY9N8eyo4Oj5nEpQmeG94PylXXGs9jCBqmuDS7GlN0ZaOa5ODsDJAmuB4X
         khWj99+97zgWlpwPdE0whIJ9MJg6vQ+G7O1JYWHubOTYxBs80N79PDQ7YkvE5yu1UPZM
         e8ErJrBFv3y1q1ZF2cRWaAByeRdG/O67TkhvQ/65HKryZcFWYrWVwRyOcgodehNW1Whn
         BSbkmbDMNvK/SH7m0c5iAWVjtvvCgb/r2Z897mti3EjHBeJ+lWTMYWOY1ykxTM148QZD
         gOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFKPeHR/K6OTfCtyrAPkmcMC/vgh1gmhyyiWOTkuwxE=;
        b=LHwyxcOgmYDGxI0oND3/HaLPe9W3YWsZtjXR/Z/XWwqHkkPtVe0HqzJVT11lc/6fjS
         BltczIjVohLYdkh3P4ZaNFK+DqDUzHZ/9aQ5nGk8cWQF46ekT8YzzyMmqWLDlMdwrbL2
         mnFWIFxY3COjluB5wFT/UcdmJ8h7LHA40bB5ae91uSsdeEEhthmnnBJOIxrgv3NGOG2D
         puAvcBDdiSFbuVGZzpmfnsJuoF/QC40f0tgdvaJk6bgTA9C3a1YVTyROMeS+FbP8Unbn
         upxeODvYgA0jmYgRm6ccEVeo/nIHMmohDBPnsRlxATOC8G7bzmy2I6w8PmgoPTMf5lRq
         roxA==
X-Gm-Message-State: AOAM532iXAY0FYBzSiEncmmf3+t1HiVTz5LCITGDvtmt3uSgU0WfocfE
        DvhM3z1WdISTIVkOtscmmvPXPVThlBvykg==
X-Google-Smtp-Source: ABdhPJwD3Q878D5ahBm7pnsMkEPXSpKLd8tDQrImzrbgq4vQI+HhBJ1Mh3xn/QEFsGyk2/ykpPqJzg==
X-Received: by 2002:ad4:55e6:: with SMTP id bu6mr4138751qvb.49.1611787598615;
        Wed, 27 Jan 2021 14:46:38 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8b08:17f3:5149:2ab0])
        by smtp.gmail.com with ESMTPSA id z30sm2181435qtd.21.2021.01.27.14.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 14:46:38 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:46:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/2] rev-list --disk-usage
Message-ID: <YBHtS4bJQxHFU3DM@nand.local>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 05:11:36PM -0500, Jeff King wrote:
> The first patch is just a test-script enhancement to let test_commit
> avoid creating tags. During some recent refactoring, we actually broke
> the --disk-usage feature but the test script didn't catch it because the
> tags were being picked up by "--all". Since this is at least the third
> time I've run into that in our test suite, I thought I'd make it a
> little more convenient to avoid. :)

I appreciate the non-incriminating "we", but the person who caused the
regression was most certainly me ;-).

This happened while cherry-picking Junio's recent merge of
tb/revindex-api, which obviously did not cause a merge conflict with
this new caller. The remaining details are boring, but they definitely
weren't Peff's fault :-).

Thanks,
Taylor
