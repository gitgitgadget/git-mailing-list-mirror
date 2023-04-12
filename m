Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D77C77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLX4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 19:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLX4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 19:56:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1344CE44
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 16:56:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k65-20020a17090a3ec700b00247131783f7so606565pjc.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681343790; x=1683935790;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKtxXoaEBalsKLjGTQUZZPHf7TA0p7pCq/1nDCCCgx4=;
        b=kTzA9AM9JA1nLODeuC4v2zPQZTyL+ISKU639g+UiThVUdjsfoXPJhfZ6ZgdzABxPbs
         e6JvABC5SfNuMMk08wWjfTXVtBALGUfEJv4FUN2DjjkdGFqCYm5UAPIeqQp5rghIDOnO
         sf40UgRXS7nmLZnvhZxt3BKpWTi1yHpDhikk4ZYQJuKRSxmrhwM6yrJh0HoJ4fy5bK/0
         QZd3TzFq4NJ7qk3Ke6qT1R57sYonnpyXecBA/pnRqRGmmCXWQEUw58eGMJpIKU7g5p20
         Vc2LuXUNXtL7GyCFgBDeUcN7E7AoiES7MkGzVfNPOjJ3RI3oM/WuPB9nxK9j9vZ1G3cD
         hXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681343790; x=1683935790;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKtxXoaEBalsKLjGTQUZZPHf7TA0p7pCq/1nDCCCgx4=;
        b=KuEm69D0cVmEGIyQ8qm9miS2LDv7nHGoxsMYCrl76xCpYPAPJBOjjy4SORH4Sy2Cib
         Xt83h80U/6FKkt7uMBrOnxf70f6ebqsOijGJt/igzexhzK6q1TNbnu0i2Bcf7zcOlUUt
         xlDh3/2dDWKQrRPEXkCuDayMgt69ZBJLtMSnN6l1pHh2ZYHNJACWaeo+B4Gr7roWtmJK
         apjo4b9fXzKGyNQ1F/x/piWyMt89jf+CoORETWSBeuOGJDkwZyNys9gbVpzf5dmBBgIC
         VV2zsY0HlfnHdmsCiMAe8Rr/1onlOWbzMXI07tFl7hQRfKS9ytaPLSmbmsQ6U6uQZdKD
         SyAg==
X-Gm-Message-State: AAQBX9cF7sBheut0hKK5GbfVpQKgKsLIuqE9PpQ00Q8/DjP3vv9ydCkP
        zL9uArnz3G0KalY1jA4wlco=
X-Google-Smtp-Source: AKy350Y0knU7NmHVCJF019T3MdooCdlHTyVNT1Vst1TfAScTSGKPc4dzcBQ2+mWDVjC56FR6LQjqsw==
X-Received: by 2002:a17:903:2285:b0:19e:5cc3:828f with SMTP id b5-20020a170903228500b0019e5cc3828fmr96633plh.27.1681343790534;
        Wed, 12 Apr 2023 16:56:30 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001a51402dea1sm154350pln.20.2023.04.12.16.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 16:56:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v2 7/8] repack: honor `-l` when calculating pack geometry
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
        <cover.1681294715.git.ps@pks.im>
        <608dde4ad52c28ef42845b6bfdcb168e252bd29b.1681294715.git.ps@pks.im>
Date:   Wed, 12 Apr 2023 16:56:29 -0700
In-Reply-To: <608dde4ad52c28ef42845b6bfdcb168e252bd29b.1681294715.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 12 Apr 2023 12:22:56 +0200")
Message-ID: <xmqqr0sozmc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +	# Note that we are using stat(1) to verify idempotence to also verify
> +	# that the mtime did not change. This is done in order to detect the
> +	# case where we do repack objects, but the resulting packfile is the
> +	# same.
> +	stat member/.git/objects/pack/* >expected-member-packs &&
> +	git -C member repack --geometric=2 -l -d &&
> +	stat member/.git/objects/pack/* >actual-member-packs &&

These tests that use stat(1) are very likely to be non-portable.

Worse yet, even when stat(1) is available, when running

    $ cd t && sh t7703-repack-geometric.sh --root=/dev/shm/testpen -i -v

in my environment (based on Debian), the lists fail to match at
subseconds.

--- expected-member-packs       2023-04-12 23:48:52.817035290 +0000
+++ actual-member-packs 2023-04-12 23:48:52.833036370 +0000
@@ -2,7 +2,7 @@
   Size: 1156           Blocks: 8          IO Block: 4096   regular file
 Device: 0,25   Inode: 2330515     Links: 1
 Access: (0400/-r--------)  Uid: (1001/   gitster)   Gid: (1001/gitster)
-Access: 2023-04-12 23:48:52.801034210 +0000
+Access: 2023-04-12 23:48:52.829036100 +0000
 Modify: 2023-04-12 23:48:52.773032320 +0000
 Change: 2023-04-12 23:48:52.773032320 +0000
  Birth: 2023-04-12 23:48:52.773032320 +0000
@@ -10,7 +10,7 @@
   Size: 276            Blocks: 8          IO Block: 4096   regular file
 Device: 0,25   Inode: 2330514     Links: 1
 Access: (0400/-r--------)  Uid: (1001/   gitster)   Gid: (1001/gitster)
-Access: 2023-04-12 23:48:52.781032860 +0000
+Access: 2023-04-12 23:48:52.829036100 +0000
 Modify: 2023-04-12 23:48:52.773032320 +0000
 Change: 2023-04-12 23:48:52.773032320 +0000
  Birth: 2023-04-12 23:48:52.769032050 +0000

