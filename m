Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF1FC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 05:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKBFiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKBFh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 01:37:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC120BE1
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 22:37:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z26so2324491pff.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpgiqhZRF91O/hV4iG5breGo8jkn74bQBoh+adBWV3E=;
        b=iPinxhzeyn2y95llhqj9swnoJ7DKIi7nDqfZL8CLGJnLbkakNlre0idyj4uUiM9bSz
         ItsIwsfXkPtip0AgtUhtijmJ56m4/JWIAzD3G+K4qleBlyOTr4Y02PQMyIWAnD8ZdTjQ
         DIjE0cSjDVl/QFVASh53BVKOF4AqMHvZnz5whJAm2S/hpKBJTahS7NtWMaGaVbMcCcpd
         MaU7PsdhoeXiQG3aJpg4W9BvNt8t/6r90GaHMI5LjKxSN3WOsPJEaJCbudXZKfuwHDyz
         ggDIO2vMaln8EqpEobQOodRrXltdMZv/vuKP5jFXz7kGtoeVx8EpnTihN3Fz0qN5DRE9
         JfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpgiqhZRF91O/hV4iG5breGo8jkn74bQBoh+adBWV3E=;
        b=ienUbCpiMGaRnm6twvecmyVYx2cssGYfWbCCGg5FiYFqbMWKLrfwTCCsudo+q4W0Ku
         le6QJS4jOr78RBbs6bT55eL26AsHTq7Ktq+AXNkJ9NG4bSrwM0EBk3mibxG8SI64ImuO
         NZpg5XFQPrcA3fvp4NsPJIqB4tWZGlJmNPjmcMjV070s3VAjBdW7MAQ/yeJgo3/X2hpP
         bj1vxjdnCjINB1YUuMzCJl7YMT9Ayc29YE5Nr1VCa8arNGqPLX0Q3oURe1MP775KlFft
         h8N9itIBpBHib91Ud+qSrhrbR6Gf1/Yh0VSytnSapyI1KdZnLeXS3IA9d8F/KyjXwkqb
         HJtQ==
X-Gm-Message-State: ACrzQf2aqt8hryn8HwPL7aSA13JOkted+RQl7s18f0lbklhbWcTA3Edd
        wNiTPNLxwwC/D59AzwSJIGE=
X-Google-Smtp-Source: AMsMyM5uI8dEI+8lEyVDdZDoP1EBJFolAij66ojh11O+r0Amb5F+LIfwVcjfIPNfIeVMDC/kms/flQ==
X-Received: by 2002:a05:6a00:a05:b0:563:5d36:ccd4 with SMTP id p5-20020a056a000a0500b005635d36ccd4mr23148468pfh.25.1667367475936;
        Tue, 01 Nov 2022 22:37:55 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b00176ea6ce0efsm7303072plb.109.2022.11.01.22.37.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2022 22:37:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Wed,  2 Nov 2022 13:37:48 +0800
Message-Id: <20221102053748.7366-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <Y1rt+uOKwlP5PIrT@coredump.intra.peff.net>
References: <Y1rt+uOKwlP5PIrT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes：

> Now this might not be as bad as it seems:
>
>   - in the long run, we might open those idx files anyway, if we have to
>     access those packs. So it's really just overriding the lazy-open
>     behavior.

Sorry, can you explain it a bit more. When we might open idxes anyway? Do you
mean if the pack idx files will be opened sooner or later if a repo serves
git-upload-pack many times in the long run. So, the system-wide table or the
mmap space will not be wasted so much in practice.

>   - in the worst case, the one bitmap file is at the end of the list, so
>     you hit all N anyway. And this is actually pretty common, since we
>     sort in reverse-chronological order, and the bitmap is usually on
>     the oldest and biggest pack.

Yes, in "sort_pack()" I think.

> So it may not be worth worrying about. It does seem like it would be
> easy to reorder open_pack_bitmap_1() to look for a bitmap file first and
> only open the idx if it finds something.

I think it may be worthy if we have lots of packs and the bitmap is refer to
an older one, but I didn't make the test. At least, the scenario is common, I
agree with that, so maybe we could shuffle the sort order in "open_pack_bitmap()".

Thanks.
