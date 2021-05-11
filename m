Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB1DC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051716191A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEKFNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 01:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhEKFNv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 01:13:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796CBC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 22:12:44 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so16506493otp.11
        for <git@vger.kernel.org>; Mon, 10 May 2021 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=26HHYVlndVqnBIfL2RCCT06EmxDrfRx5+U5R5zEkUho=;
        b=XX0Bu2tPObolY6NncXpT4RhEc/hRFfaAcu+PGzRaZJfnLIXnKTFVQk9s//cwfwGuuI
         bVokcaG48a9DXnsxUEtAN910Vx5GWKI+InC6Q7Iz5b/MUTDAr8kp3jWXJ4PO8UnStHX6
         TPyIie9HCC4pWgW4dB6rvFOpxpfVo4IBZX3xyNKFnkP9/vd9/z9OGds7aq9R25MwcM/8
         i01ssaTgdSl4Nx8eIB0g/vrjyX8H4O5TlTbq/fqTsz9TtqYUG6u6fsSNd40EBR2FP8C1
         DPUh4bgzJUSOVdVqtvoAU0oRJkE70TVZpCYZhmJZjN5vOiMfpeIRaLbYQxvwQXV9Fd1D
         J7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=26HHYVlndVqnBIfL2RCCT06EmxDrfRx5+U5R5zEkUho=;
        b=Bf3SZvYjBGvixEfQn/6fUZXyfOV7yfhlk6PL1+UYOuAR4E0HacWTsqyBXHRFZ3+xFU
         2y2VinNC7EK8FDcxJIp/9wmR8PUdFzlVkr/k3U46lX+H+31+Jdf3VMsJes2TBwKz6CJY
         zg+zNIMQmurZe5nU1fCtsOdhZDrSV1wW7FkJsRf+RmoxrcEVw2pSTIAhtzt1F0PFoAVv
         FhpB7UwmuGXKQ43Quz9z1OzVFGM3z+777CNX6vD8Ey7Pnp7RaXf/AdjIltdv0Z0A9y1m
         fYoliM7ERdlLSNGVng5cxKd6Hu15URJzUS8mEF3aKHTvuRUdslQe62W1xgCQ7RfyNvVN
         Z2Rg==
X-Gm-Message-State: AOAM533GK7FGCzqdSFMYEnJvPiqUKaEVMpVQ2g8qMD5NlQeAmrODUgjo
        yNBDOsx6NOHHRr4MO3rSimY=
X-Google-Smtp-Source: ABdhPJzY69PCjofvPsd+pt+pQlQfh9/etYz/yfKf0nNvhtvkJVZStkUfhm4mKofCjeF7CKZz9DTenw==
X-Received: by 2002:a9d:7490:: with SMTP id t16mr25733583otk.363.1620709963963;
        Mon, 10 May 2021 22:12:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id e7sm1688197oos.15.2021.05.10.22.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 22:12:43 -0700 (PDT)
Date:   Tue, 11 May 2021 00:12:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
Message-ID: <609a124a3cdd6_5b0e12081c@natae.notmuch>
In-Reply-To: <87tunaf54u.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <60949be8613c1_8c2220882@natae.notmuch>
 <YJUAmUJiHmJRQBMj@generichostname>
 <87tunaf54u.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> > It seems like everyone has written some sort of tooling on top of
> > format-patch at this point. Taking a cursory look at your tool, perhaps
> > a feature like `--previous-cover-letter <file>` might provide most of
> > the functionality that most tooling that I've seen gives.
> 
> This is a good idea. We can default <file> to the target cover letter
> (e.g., if -v2 is passed, v2-0000-cover-letter.patch or if
> --numbered-files is passed, 0) if present, or the previous series' cover
> letter.

That's a good idea.

Actually I don't see any reason why by default it isn't
0000-v2-cover-letter.patch.

If it was it would diminish the need to warn people before overwriting
0000-cover-letter.patch.

-- 
Felipe Contreras
