Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7EC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiF0Sj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiF0Sjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:39:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A59C8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:39:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so2662135pjs.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bujdv2Bbps6cQCcQQMNaNkHDaBL9Sstt5t0q5JysfdY=;
        b=QDd/6RVtGkwQ+8twQH73++gBkjaHIImLg0z2Iw/5OffrW3/YnKcHC4aS8kOw4N0I4W
         ADQWdMF96YQlXtKD1eqsZ224A3Kf4xWoR6ZUqPm90hRzjWgshd9Em94+DBPcelUgFcZE
         ZnPzxrD48sDrl2rh8po3m6vDKS4vDuiUo7N84tjGNFOKvht7OtsmDXeItuMPSfRjhbcL
         ADK3x1Mys8RJQdZqSagyCqLMsnwC+VZ948NCESl2LZ+h9/iJuNQIbA/1QS+9BVHAR0qv
         nP+oyQ+kO+G83ikP/0DNPamxh6xTud71bUTjNyvHog8iMvdwDIxU+yAse61kOeFbqo+V
         Cxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bujdv2Bbps6cQCcQQMNaNkHDaBL9Sstt5t0q5JysfdY=;
        b=s24PtzsPki+m6nNFdpnUpSHryXNXx6RlQ/u8xMPVW8PeD8oOYjV3lh/yclBXE+I2dJ
         Ws46J86Y0tvpHDc6mD7Db/nd7rlo02VFFDzAEVJ0/BB568JH9UPimBv4e00ld0thuorc
         9UDzRq8vRWNOto50SB0S3mrrnV0JrmsT4Hd+QpS25jxjrqteUAewCqnZAYbzvlUSMjMB
         FapnTejSHqYfMRO22jlhqs9j1ioTqYdcCzGF6jEjzd5dzjvjl0olYmgCMUEZHHJ3A3EW
         wZZt43sd07UApNt79aUPHdsx5gGJpBceovo2LyQfBxRDQARTpA4/RrXR8QbHfcTiL5re
         dR8Q==
X-Gm-Message-State: AJIora+Cubtn/4RL7CD0nEYpf9vHSXduezCvceklmtoIxlTFKWavcFk3
        dOtdPcePSGk3pstJBo5nRCE=
X-Google-Smtp-Source: AGRyM1tViFbXREHnAuYTG9lkSuMynHr8Y5ua9aj/HnJyexFsxnldoVEZ5dWl8dmpaCDG0mHCWpLq5A==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr15759716ple.157.1656355186112;
        Mon, 27 Jun 2022 11:39:46 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id h27-20020aa79f5b000000b0051c79bd5047sm7704770pfr.139.2022.06.27.11.39.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 11:39:45 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
Date:   Tue, 28 Jun 2022 00:09:23 +0530
Message-Id: <20220627183924.16369-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrntSpG5asIPNdZz@nand.local>
References: <YrntSpG5asIPNdZz@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> Probably both of them should take into account their separate
> configuration values, but cleaning up the hashcache one can be done
> separately outside of this series.

Actually, it does respect the `pack.writebitmaplookuptable` config.
As pack.writebitmaplookuptable is by default true (for this patch
Series), this line enables it by default. If `pack.writebitmaplookuptable`
Set to false, the proposed change in the `git_multi_pack_index_write_config`
function disables this flag.

> This region may make more sense to include in the previous commit,
> though I don't have a strong feeling about it.

Ok. Will move it to the previous patch.

Thanks :)
