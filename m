Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D73EC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EBB23B08
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 13:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgLSNf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 08:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLSNf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 08:35:57 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C3C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 05:35:17 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id q25so4668202otn.10
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ibzjgZYAYskqwgGaqyIYwcQ8GhjrTmi/G3yfS/W2AXQ=;
        b=HTRvtbTEx+WIARAKLpLed0nVdoMXT17uhU4NdDno7njLibahtmT7lEilew3pTiC78X
         fWcC0KLM2a3iBcmolIc02Mx91lhJZ/TRpltYkrKuOG9OjLhWbXa9fOZ4IwYcc+c5K77q
         l5ljVnwbTJSNTnGR/Py4785g5wMScgOlmRtxGbffVCeeUR3W6I0n3HuWcZ/InncFcNHY
         qgmDKquIawn47dY+RFyfVv4kUS55rmGkV1D22XxDappPwKoW26H8yqGxp7nFpVgNCtrx
         YTt99M/LXJ/CIMWzjdg/VtZwrkcbTePPk+Ibtc+nYNE19BNRtq9N3ALBC2lQHZpXPyp4
         Ri0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ibzjgZYAYskqwgGaqyIYwcQ8GhjrTmi/G3yfS/W2AXQ=;
        b=ZKhnwVR0YYczeYlaGgFvXpr9Li87TcymFPFn05djzsbRxWFSfMzPIJxA6xHyScf/Xd
         OOg4OIWimctJL/kt0NvMkzoa6W40ETupwppRvXnH0/hswamNl8PysICgxim7xriFzs6H
         +BdsJGjGXIVycMWHoHPpDPBMzdPR9PEpdH1jTfTCiFRYGa00r5n4mMiK0U+fkBkn1Ykt
         dbuGXmEYtkBx5kofKJn1m92nqWpCCCAyQd3TCIvWpxy/kz+L9m3uhs8nOUvYu1C/RvUO
         TbVhbNRN4C1EEGl+xzS3lXj0OW10DgERQxT5mrSXn2X1/6DhyNsI8S9fCaPoHExqm3sS
         94iw==
X-Gm-Message-State: AOAM531wYjsJ8G7jpnN5M/i7zmwO3U+h1hAXXBcqjnWyR1RjUS/dkAEH
        H1A6sgkchGEeI5vrIfGxkyXw0N+W/7PPGg==
X-Google-Smtp-Source: ABdhPJzG2kzTLPOG7xP3JvtAsUA1ZAAuPjZCxrAwiM3tr1JwfUOiyvivR1UuUFArbU7WFK/iNwAgCQ==
X-Received: by 2002:a05:6830:1de8:: with SMTP id b8mr6059033otj.204.1608384916433;
        Sat, 19 Dec 2020 05:35:16 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z14sm2560701otk.70.2020.12.19.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 05:35:15 -0800 (PST)
Date:   Sat, 19 Dec 2020 07:35:14 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <5fde01924f744_1de0de208ea@natae.notmuch>
In-Reply-To: <87o8iqm1wq.fsf@osv.gnss.ru>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-27-sorganov@gmail.com>
 <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
 <87wnxfb2gt.fsf@osv.gnss.ru>
 <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
 <87o8iqm1wq.fsf@osv.gnss.ru>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff without
 -p
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> The problem is that original name I've used lies to the reader, or, more
> precisely, tells half-truth. True meaning of the variable is "do run
> diff for any commit, no matter if it's merge or not". So "need_diff" is
> already better than "regulars_need_diff".
> 
> Maybe "diff_all_commits" will do?

all_need_diff

-- 
Felipe Contreras
