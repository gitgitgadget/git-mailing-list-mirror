Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD4C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 15:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7180D20735
	for <git@archiver.kernel.org>; Sun, 10 May 2020 15:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUU9G6+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgEJPwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgEJPwb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 11:52:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90169C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 08:52:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j5so7809900wrq.2
        for <git@vger.kernel.org>; Sun, 10 May 2020 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ztFCUeGfFSawqq0UfBgOPHOUim82kIhSwXT/9BJk7h4=;
        b=uUU9G6+rOFQmqAbISIVoprIatWbX4fNniGkpXQ7CFD/USEr/VZXGlUtKfUrY4Ax5Mv
         eBA9ls/bhO3VfIHkSNhSuy1XJk78ANAA/6RfvWrw71jyqZKphGspJ52vYlfN+pvKy+cp
         rzzyibH2oQX3voJYp0oyWG24c+R42OVEx5tliEDUMckTbGS/IsdEtjqHKcuWOcTgS8Er
         YUuORm4vrYMcrqXiOsbhi+pReKfimLxShrPfIQo59SPaNho7txmXjdBtjYzwe3RuNzKk
         dxFTz07IQPbPWgvw5DFaYyXCcCRERt0JUxDc3JZ4GmN3254tEbICoVfvl2olUsmyPSIV
         TjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztFCUeGfFSawqq0UfBgOPHOUim82kIhSwXT/9BJk7h4=;
        b=q3HHSIj74QYunJJwR85Vg07qvKIqxai6kogPORzCqfkzbfBqOnIwwgLyKxoTDT4UUW
         dAbFn8VBjSKc0Hkn1bXJoQ2wFi6sInwNtntS+RXZgZcoaBsMozTCiLk0HQt+oLvyCiiD
         aIy+iEfTeEZm2fBH6Fd2smXPoV4YmPqF/f6IiUPDrQGhZjGZ+VaioA5Ar5g7s73jex27
         BWzYEGDuH5m1kKgcFx6NbcWIG7WuRLY8Q5/nbS1L0zSTYXVcOu009AWioPAVrFYVP2QK
         K3LTgNpWXB37WXlUg/OaH3WVQ9Q7eIwymx2i5BRXceNkXMdKEa3ruO04i6o1ON85ss1D
         sx3A==
X-Gm-Message-State: AGi0PubgJsYQDtsbT7I1QDFtmvZWgKaMIxtU8tAIeb+Pt+/7enDDmqyZ
        QpGApnRQzIc8fzCmm6StldI=
X-Google-Smtp-Source: APiQypK+dYYJtuR/ZtwB1ZnEyTbC3ckbUniruJT8mb0IdIsvP+WUcpxbLC25wo5OXBhINTUBVX717Q==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr12792189wrs.128.1589125950347;
        Sun, 10 May 2020 08:52:30 -0700 (PDT)
Received: from C02YX140LVDN ([2a02:a210:ca2:9c00:24fa:5ec6:f137:aace])
        by smtp.gmail.com with ESMTPSA id q2sm11577914wrx.60.2020.05.10.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:52:29 -0700 (PDT)
Date:   Sun, 10 May 2020 17:52:28 +0200
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/3] multi-pack-index: respect
 repack.packKeptObjects=false
Message-ID: <20200510155228.GB27407@C02YX140LVDN>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
 <988697dd5121430cd3ddfa60b1ebcf26027566ef.1589034270.git.gitgitgadget@gmail.com>
 <20200509161159.GA15146@danh.dev>
 <xmqqlfm1ui6t.fsf@gitster.c.googlers.com>
 <20200510063844.GA14311@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510063844.GA14311@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks Danh and Junio for the testing improvement suggestions.
I think these are the points I will adopt into next version:

- Remove the 3rd patch and keep the removal of dollar sign locally
  inside `repack respects repack.packKeptObjects=false`.

- Change `head -n -3 | tail -n -1` to `sed -n 3p`

- Apply test_line_count on keep-list for failing fast (before touch)

Cheers,
Son Luong.
