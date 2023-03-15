Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC96C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 19:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCOTeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCOTeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 15:34:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6112BE4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:34:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y19so11450128pgk.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678908851;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94Qhkv4iZZFNX4HCNhYVhnnMtfXnDOYya63Gx5+vNyI=;
        b=iaQoz/+CA2mch1pWc4kHFfouSuvF/yotVUawTWBLrtMniOjhQZdm3J2y/+iJYEs0Xo
         4biHP62d1P9mIUxsuuwsD6Bc3rk4dfDzHMOM8/BkYjr+E9bgxK4n8l6nJcjtNJ7AAtU+
         ajV5Zf8rBVAbtUo2iFCTeGdv11mJxgXqxrXKYjcZO7YYOii7nneoNMi7FRSLb5knLlhD
         b3V1fOVs0xT2rBdnJ7BIJA30xOD1KZ/qzCRab1P2Sxg27+2DAk56knldsVsOmbfmsOEA
         Vooi+FhsQsj97h6D0dcfTasFSL2wneHIZ6mP7Ur3k3X2LHwyTa62AYIf+g6q3TobbAgt
         smjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908851;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94Qhkv4iZZFNX4HCNhYVhnnMtfXnDOYya63Gx5+vNyI=;
        b=5XRlLva2De1IZC+U1WkjVfaRWr7W1G/Eit/bD/PAJQCQDk+E6HQM7hW6yt3ZJC/uyH
         jn3WAahvh8sg749T7Ik+dxl9kzSoh5jrhqouyh0+54YcFc+oEXWv833V3VzT7Kc6cJ+p
         PvvZ4SeePuA/TSpwAdNXbrANjudvHywd+Zp3/X1F/x5lujzR96lZmrAbpN0RogUZdwHF
         Uogi/+TFgnEpVB28SF5j5zRqKO+JinF6+mFsfjQTeR8WPOb0wOZ2Dor1ePLLYKanAmbh
         HFzp8HAPivoD7UsoAYjMxnEpY+hBRKLs8j47j2iRcKTpIA/1fRrEXUkRrsqQ6oLe9MrR
         RTcQ==
X-Gm-Message-State: AO0yUKV8xx8P6IBA7ljk25I4Xw39a87L3ChTvsHIR9sYQ7yaGNhK1MQK
        mBDvthbx9Jv8aYPxd9LeyOc=
X-Google-Smtp-Source: AK7set8gF/6ahQgqLuFtvT5a66d02fEwdj9+93xyaBGnriFJB+jaIylPKsN2HG4h1GM2gLvvjVEP0Q==
X-Received: by 2002:aa7:8f09:0:b0:625:55e6:e5d6 with SMTP id x9-20020aa78f09000000b0062555e6e5d6mr594412pfr.9.1678908851178;
        Wed, 15 Mar 2023 12:34:11 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7848e000000b0061a829d2679sm281161pfn.37.2023.03.15.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:34:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster
 --merged option
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <xmqqedpw5se6.fsf@gitster.g>
        <74656b93-8c67-ffe3-4aea-4c184345384d@github.com>
        <ZBIA7+85Lld+lpUS@coredump.intra.peff.net>
Date:   Wed, 15 Mar 2023 12:34:10 -0700
In-Reply-To: <ZBIA7+85Lld+lpUS@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Mar 2023 13:31:27 -0400")
Message-ID: <xmqqilf1oll9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> E.g., imagine resolving "main" to 1234abcd in step one, then somebody
> updates it to 5678cdef, then you run "for-each-ref" to compute
> ahead/behind, and now you show an inconsistent result: you say that
> "main" points to 1234abcd, but show the wrong ahead/behind information.
>
> Showing 1234abcd at all is out-of-date, of course, but the real problem
> is the lack of atomicity. Most porcelain scripts deal with this by
> resolving the refs immediately, assuming object ids are immutable (which
> they are modulo games like refs/replace), and then working with them.

A really paranoid caller can use %(ahead-behind-detail:refs/heads/main)
and get a report on refs/heads/topic, something that conveys

    refs/heads/topic (at 67f9f40d) is ahead by 2 commits and behind
    by 4 commits relative to refs/heads/main (at d7c3a768).

in a machine readable form.  And when the "ahead by 2 commits"
disappears, we know 67f9f40d is merged to main sometime before
d7c3a768.  Then it can say "update-ref -d refs/heads/topic 67f9f40d"
to avoid racing with simultanous updaters.

