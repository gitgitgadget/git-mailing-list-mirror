Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA340C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiAHBAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiAHBAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:00:04 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3649C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 17:00:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b133so60882pga.3
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 17:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cockroachlabs.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ir9Jr4da7rZenPBMrBIkCfqMN+rjO0QZdv/JCvYFu2s=;
        b=Mg16QHvC68qdi80eeljpbgVLG75h5xlgPPTvwD7z0uhvPVtDywXNVzqPqWtZtbRapa
         2DdMnr8mDjAMlQOVXdYDTiRQmPD+Cmp1XFsbnhCA+t5LdfsoSUCq6YRTMqnmGurupD2P
         hDhtqQxloUCYSUfF4kHFEMY8/9oKhNJp1FE91W3wJdkn4Pm6ArGxtbqeRrptnJdKt2Qm
         xUU+V1HiTbCzgMAJtApGofHBHW3097gsWXwCRYfY5lAeUTetfANtfgzYLzZA6GrdYJzR
         /WlAt6p2QDLMI8ebMhEQVIm6Ef0QsTraB+S0c7MPYRE0KnMV2QWQDTxRqgLMP3rDg36N
         IhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ir9Jr4da7rZenPBMrBIkCfqMN+rjO0QZdv/JCvYFu2s=;
        b=I/Qt4h7j/T7MgSt3RxUSSiG5O67Bsc/7G3sMzAkY9rlpSCbCHYq45YLE+ZmBUnf+cf
         fiYA0JCqYtzrbkCkR/+iS40pZ4MPXnuZSs0YBhGPTPvHo6VY7WvxmlhVKpyHnvuoG5Bn
         ahNBNttG2qaJ5lO6do+ThlE1wNpewKecE4yAAD9CxMe+FZNd77N7mEof/opBb+jOMH9C
         rs821omOEsDRwnidMocXYMpqPotfU2wi2rUvq6O1PpE3HUgHhFqA5mw8kYKq9YHrSM1j
         a23G8y0X5VjS+d34cmY9Azim3VonVBkTmcKbWLObccy/0ZV+krm/kB1oWaiOd4mx3/uY
         ZAvA==
X-Gm-Message-State: AOAM531Z0O2a00SHqUcDXjjNeh40hX2R0VsMOGczsaEP+S47xHJzDrXk
        XA7eV22iBGivuihslxpYV6cEsg==
X-Google-Smtp-Source: ABdhPJyU5yOettH5HdjXqzq023r/c2EUh+oMcrwKmsM+uUtu/u1qVOP8B7GjKnhppWsAR1W61tULrA==
X-Received: by 2002:a05:6a00:a8e:b0:4bd:265:def4 with SMTP id b14-20020a056a000a8e00b004bd0265def4mr5213874pfl.24.1641603604173;
        Fri, 07 Jan 2022 17:00:04 -0800 (PST)
Received: from localhost.localdomain ([50.35.110.60])
        by smtp.gmail.com with ESMTPSA id f10sm120401pfj.145.2022.01.07.17.00.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jan 2022 17:00:03 -0800 (PST)
From:   Sean Barag <barag@cockroachlabs.com>
To:     gitgitgadget@gmail.com
Cc:     barag@cockroachlabs.com, git@vger.kernel.org, sean@barag.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC PATCH] submodule--helper: check clone.defaultRemoteName in print-default-remote
Date:   Fri,  7 Jan 2022 17:00:02 -0800
Message-Id: <20220108010002.43869-1-barag@cockroachlabs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pull.1112.git.1641603153667.gitgitgadget@gmail.com>
References: <pull.1112.git.1641603153667.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops, my CC list got mangled.  Fixed.
