Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B52C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 06:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiEQGUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQGUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 02:20:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E93443E1
        for <git@vger.kernel.org>; Mon, 16 May 2022 23:20:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t29-20020a056a00139d00b005107ebaefeaso7220848pfg.20
        for <git@vger.kernel.org>; Mon, 16 May 2022 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=jfUqrR35jMj3uwJxW8peqfqH4wbr5vXob7BEbwuvtoA=;
        b=pYM8oUuAi/tSAD/sBQopre93vXXap/jU1TfSUQ4UFDvcGENkbHSRMWlejHZC/M78Y6
         AGD7bMvE6ACf6nyiNfUnOeHUe/gRidJ2LtE3Zmizm6Zhg7FwDePfyifD/0DGCeH0A0YI
         9O6YqvNbXigGgRXhL5mS6Bw2pkEKkAm2M6F1dR2SP9OgTzL053OpVEkrJOIz4KW+nsso
         WTwLUTUTiVKpt9OGUpS0RYgKmFy6nkLZT+lb1mAxJW+oxNfomrYj3Uf6Bq71D4vu2Nh/
         mBUjmzTFpZLZXZvi+6R/eDadZU3WZsdNZELE05VCAz9W/19yZmCofHLt9NzVes+mzUmQ
         T78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=jfUqrR35jMj3uwJxW8peqfqH4wbr5vXob7BEbwuvtoA=;
        b=V3sjvkY81GtH/2etaTO/S+XOIfgo/NMBBmVPsYpcO5WrAIOX23eD03LjCMaOkxUOZ3
         KbQG7YL9Qe4omuovLt0d4YAHsjSrQ3vH87KJvauvbDeyTmGpYwQ5/2jgvj7Dlrvuef0n
         c17Wi4wYynDrOi5ttco4d7H6nzKpHXJbbMtPa09h5rRwc95EAEyiReP05Bs1ZxpwRz7G
         eMKUyt/5iQdh6wjvM/AQiP8YYaf+3im4jCmrEEDNdSsF/bjxoaoooVmb2WrrqC/qTDnK
         HxMuEYGPnrdW3Nh34Ys2L9773VrAKyrQ+b6ouK5H1FGTHxEjRuWrRKheTUoFBlDClImx
         vOJQ==
X-Gm-Message-State: AOAM530/5iAZNVYyTyPRKneYTWJ0pzskS+VbAWQ78BP6X2ovh6RwS+p3
        DOj+FsmTQJ6Q2QG3T5uw1N58S+kHVjhtW9SUtrYN
X-Google-Smtp-Source: ABdhPJw+kEeGQt+G9jHAY0fYtyQKL5z8Bn1eNtD+3lDy/SSZ1m9bvs3ptFcXyXZLYFB+zkiM5obGRBByKhvqCzzpfMzl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8d83:b0:1dd:258c:7c55 with
 SMTP id d3-20020a17090a8d8300b001dd258c7c55mr92682pjo.1.1652768438096; Mon,
 16 May 2022 23:20:38 -0700 (PDT)
Date:   Mon, 16 May 2022 23:20:34 -0700
In-Reply-To: <xmqqr14t4fwf.fsf@gitster.g>
Message-Id: <20220517062035.3648639-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: Re: [PATCH] fetch-pack: make unexpected peek result non-fatal
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> We used to die unless READ_NORMAL was returned, so the code after
> packet_reader_peek() can rely on reader->line to be populated.  Now
> that code must handle cases where an earlier _peek() gave something
> other than READ_NORMAL and in such an error case reader->line points
> at NULL.  So any code that assumed reader->line was populated needs
> to be updated.
> 
> Makes sense.

Thanks for taking a look. Yes, that's correct.
