Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A1C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99F120658
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgHQTw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:52:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39513 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHQTwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:52:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id c10so13339496edk.6
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrekugLo3vJkHJzIgjhbMNTls/LD8uSMMJBOFD/oKeA=;
        b=UD+mewhBG7JO70JvN/aNVSbx9oaYfA7VGXNXQHZNr95FLSM+gMyjcbcjhjGYtuvK9R
         e2US8vt+hVqNFiVKq4Odcswi6haQrujcnWtoZ8JVgkGY9fam/NtU1was4Zt/CTkSv+VC
         aJKS5zv8FgmpX1URUqJMVAPSOpdOKs1HNl90YUOvps3KnAfxuTpImC4KS96o6Cxfi3De
         7yZ5qOxBBxsupId5Va5ieJ1kBVPrJsd0l09EmL1AHAu9t5sf05jn4g4g7IGE8MQ8Kd5F
         GnsOP8y8MeEm5ipHVk8srhhT7eEOTx/7EVIKViBN+AYKhwsHuP8fbEfQARkhStpEOotw
         C1lg==
X-Gm-Message-State: AOAM531QLOyeFxP/AK6jgtYyRIZ6gAYYux9cM5ZRVwhMCt54HwsvAC6w
        u84zuIw2GB5vV+Ohm72y3EPsqS+Vn5lZnSDGc18=
X-Google-Smtp-Source: ABdhPJwowYZn25Z9moJnkAqL9SIWnrJoybHCKjV44DavvUEhwP/gpPKVaXPVUggiYm7JBLFuY59DrusMEEMeNjzoeoM=
X-Received: by 2002:aa7:d516:: with SMTP id y22mr16404264edq.221.1597693973759;
 Mon, 17 Aug 2020 12:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200814193234.3072139-1-jonathantanmy@google.com>
 <cover.1597693540.git.jonathantanmy@google.com> <53270b3033967bec664a264a1770e47cb4c12348.1597693540.git.jonathantanmy@google.com>
In-Reply-To: <53270b3033967bec664a264a1770e47cb4c12348.1597693540.git.jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Aug 2020 15:52:42 -0400
Message-ID: <CAPig+cTv4JiLt+hCSy_RqmwUwu5btTjac6+cFH=ztWeHQgHEyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fetch-pack: make packfile URIs work with transfer.fsckobjects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 3:49 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> +test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
> +       P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +       rm -rf "$P" http_child log &&
> +
> +       git init "$P" &&
> +       git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +       cat >bogus-commit <<EOF &&
> +tree $EMPTY_TREE
> +author Bugs Bunny 1234567890 +0000
> +committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
> +
> +This commit object intentionally broken
> +EOF

The v2 cover letter says that this now uses <<-EOF so the here-doc
body can be indented, but that doesn't seem to be the case.
