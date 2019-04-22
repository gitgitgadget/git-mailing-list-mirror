Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F62A1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 03:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfDVDYE (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 23:24:04 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38030 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfDVDYE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 23:24:04 -0400
Received: by mail-wr1-f42.google.com with SMTP id f14so13774388wrj.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 20:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuBe6rNhJoqxrkAlfVHKw6eIcXvQP/MQX0ByT/7psks=;
        b=eD/BZSqSV0F28XeKrzYlHzxMKzcRn+uAstQlT7bhpbrLHuC4F8ChcehbrkapbwWUKF
         1XOrRKLgsuxSbFgRAegJEtxob8BxyO94dpEu+U3wS1nlda0PJB5fpOoEGbdRiPusR5pj
         EqPn72d/I3oOq1NjlBZa+eKwyqF7OMAbjmfAd3+/83dXn6AE6Wxi5VJsaMlEn9/TYUiM
         mP/D0B96YaHEZlWUZiGivDP1MDhm1ZIWm2rJNqr7W0ATHJlIzjFYjWIH4/HdHJDKmMZB
         RrmqeH/zF8F6AD96E4eOrF+IAS4swENWcpdlTKTME88pBud66m8heNLdYSjj+8Z9Z+7V
         NqmQ==
X-Gm-Message-State: APjAAAUZGz6DVrlvH5xPq/JczIj3T6FjU+CuJ/zS6ep1CSNOBhvVLnjF
        dNxOYhswCRLu5+szi9ma1LCgJIeGkPlKa+leHFE=
X-Google-Smtp-Source: APXvYqy5SEU6U/2Ty07zKF6qCRn3axUWg5EaDSXlDiQRNC+VYRx/LrCTy+Ov92izgyosazHl4xpmfoGU9MXn7BKlrVU=
X-Received: by 2002:a5d:5282:: with SMTP id c2mr862512wrv.88.1555903442408;
 Sun, 21 Apr 2019 20:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Apr 2019 23:23:54 -0400
Message-ID: <CAPig+cR5yMtdBA0HgLZ6k-j3NeMS+4UeEKgRiEpZ0YGrW_L0cg@mail.gmail.com>
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 21, 2019 at 9:19 AM Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/Makefile b/Makefile
> @@ -822,12 +822,12 @@ VCSSVN_LIB = vcs-svn/lib.a
> -LIB_H := $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
> +LIB_H := $(shell (git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
>         $(FIND) . \
>         -name .git -prune -o \
>         -name t -prune -o \
>         -name Documentation -prune -o \
> -       -name '*.h' -print)
> +       -name '*.h' -print) | sort -u)

GNU make's "sort" function also de-dups, so an alternative is:

    LIB_H := $(sort $(shell ...))
