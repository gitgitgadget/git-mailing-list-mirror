Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB9C7EE43
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 22:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbjFLWM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjFLWM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 18:12:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF770E7C
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:12:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25bd72d7093so1141073a91.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607944; x=1689199944;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWBwJBQ+o6ZFGDLrJAUCBdj12xl4JxoSML8JtHizr6g=;
        b=hHxbevQKDPBoZ5rS5mgJymatkaDdfQInDGvq+ix3FJ7IaixZqgBZp5DCifHGcEn9Ks
         DtRGZyb+1j6anQimsd4T+2455rvCEXRt6fg+s1xKFLVz8fZtyujVPtb0BnzKQ2K2QOe/
         9cDruo2z0EzdJw98lMcLkjDWuLAlLwyO6wldYqR7qiwTtII7e8G+A8H0MevPVDOZX+Xx
         C2XXsqHap7uoAfobTw0FuFDcuUAsfgBhHf+O5Paqr3UKtaH76GtxPHLbFWdzFYXw5hfX
         HDWlN2yqfskrvRpN4qA45hpjMDtbTNgP+DvOPVrV/+Npr/1F1lvqwEROrnhlzijBnxvW
         IQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607944; x=1689199944;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uWBwJBQ+o6ZFGDLrJAUCBdj12xl4JxoSML8JtHizr6g=;
        b=KvSSHm6gt3flxgZ9D/H5LpE/mImqliWKbbt3EoMbBA6Z9lQzbYp5lCIV7fPENuWWa+
         rnSfGEi0T49RZW8KMxcSfM+fDpXeTFdpvT/mqIJTa/sQzHWypqj/ELuWmKGoT9TvRWVT
         O62aMW2ZCpsS8+y8KlfQ0Zve223Sy+tFl/3UjUN/DYsV9V3Fp26SZ/Hi+jmKHBB/HWNJ
         tdcwve2TCxCYQ7ur24GaJjO8qxJKvzprRXVmoCpdPpl/VPa1IBDo3xq8z1WXo3IGL986
         GJYzHoMfbXDKzl8Uj3Iw1kw3cXdTconNzxTufB2JNw0yhml0OGt33NxMH6R0W9V7ZuRx
         0ejA==
X-Gm-Message-State: AC+VfDzCe08/xZKGEW9hsM+p6hYSxLy/KDmpyR2bHo5CK0YMj6xnLhrx
        6XmqRscMOa0eNvj/tH+bMdzJqsO7s00=
X-Google-Smtp-Source: ACHHUZ7NfCyfBFVqzEXVu6ylaq33FI0Dx3CsY2PzRdRbVJs37+KHvZ69oIyUAm4pX1XoYpR3BB1Jzw==
X-Received: by 2002:a17:90a:6342:b0:249:748b:a232 with SMTP id v2-20020a17090a634200b00249748ba232mr9133419pjs.25.1686607944191;
        Mon, 12 Jun 2023 15:12:24 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090a630800b00256b67208b1sm9589082pjj.56.2023.06.12.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:12:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Remembering which http remotes require authentication
References: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
Date:   Mon, 12 Jun 2023 15:12:23 -0700
In-Reply-To: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
        (M. Hickford's message of "Mon, 12 Jun 2023 07:47:19 +0100")
Message-ID: <xmqqh6rc72k8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

> Could Git remember which remotes require authentication for which
> operations?

Interesting idea.

Credential helpers may know which URL needed authentication before,
but that is not per operation.  I wonder if it is sufficient as the
zeroth approximation to always try authenticated access if helpers
have any auth material to the URL regardless of the operation?

There needs a way to force unautheticated access if we were to do
anything of that sort, of course.



