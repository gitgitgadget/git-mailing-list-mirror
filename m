Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C69FC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 03:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiJRDer (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiJRDeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 23:34:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2359C7EA
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 20:25:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i6so12572598pli.12
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zdr/8wDeyTj5meIow12JadWoxMB4WK/OxxqLRasTbI=;
        b=eD35KqkHtoIMu3jufFcBSSv7h0bzh6Gm99GSmuPUUx3uEfHH9p8n/QHYzOS1JAzU96
         NEPSttv7AcThyAyqW2u24yogt1FjAGnxCkb/lkj2CFTJT+6ejt3wskVlM5RtdB47EpSY
         ve2EY9sEUqfFqg9++fu1iMjRFWAKEO8sht2uscyAOtodCkx/n8lViYW2sc1GvuDN1Rje
         RbDELUdekZOrh/ztqrUunpXAxAopwfQ8GYIX3N890D6HBp9CvXXhbxamtHS024eTqu69
         NefIsQShu1oI7VMSD9GL93PIvYJ1JO4Kzp9aSyQl5SZZl2vCKhZTYSUZFqvfCGQKpr19
         CQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zdr/8wDeyTj5meIow12JadWoxMB4WK/OxxqLRasTbI=;
        b=rXGqtN944lYS0Xy8zt9ItmfmKArTYeyH+dHLuM/r1+fZ4Sk1KngdzJEFXu2Q9fnZtq
         NcgCPIKH8DBh3GBUDq8gDEg/ZN1kznbkqMae8PM5sJVCdR7IBNxPAJFDss9WT7fcS1/m
         MK4GfrSyMV3anNGVhJqXETkToA7fmoSchCPFs0uq276zffeJJJSWJJWydQGh8VfjoZFt
         dfsfUuTL1nwQqvFJ6M7V8R8PXJFsClr22ol+Z0cBaV4nk+EwsmPw40FC/a6C1IJq1QLR
         gnVEJOkFqFpgygVKmrYev74md77C7PaNmcoXLjHmzfhjeS+6UHkM1lLuUzGrL/S1pxX6
         B3nA==
X-Gm-Message-State: ACrzQf3WjPmVIvBEHsQjue5OKx2mHiOoNP2UvkbK6lvLU+WZ+MF/sBH0
        cMWzm28CdkQbxf1XsRJewoo=
X-Google-Smtp-Source: AMsMyM7PnConjOh4NhVqXTyWwtlWe/SiqN2yJKtPOP84kbrx7uT/J3Ww70ktCdrf8Q61FOAlVJc9yQ==
X-Received: by 2002:a17:902:aa42:b0:17e:b779:dadb with SMTP id c2-20020a170902aa4200b0017eb779dadbmr908545plr.11.1666063530002;
        Mon, 17 Oct 2022 20:25:30 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.59])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902bd4400b0016d72804664sm7313307plx.205.2022.10.17.20.25.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:25:29 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     phillip.wood123@gmail.com
Cc:     --cc=avarab@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note are both empty
Date:   Tue, 18 Oct 2022 11:25:23 +0800
Message-Id: <20221018032523.74253-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc0.2.gfaa0bb20b59.dirty
In-Reply-To: <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
References: <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I don't think its written to if we take the 'else if' branch added by
> this patch so we need to initialize it for the free() at the end.

Actually, I didn't get it totally (maybe because my English, sorry for that),
but indeed the 'else if' expose this problem out, so I think to initialize it
is needed.

Thanks.


> We only seem to be using cp.buf.len so we can test check if the original
> note was empty so I think it would be better just to add
>
> 	int note_was_empty;
>
> `	...
>
> 	note_was_empty = !d.buf.len
>
> instead.

Yes, it actually does as you describe above, your suggestion makes it look
better.

Thank you very much for your detailed review.
