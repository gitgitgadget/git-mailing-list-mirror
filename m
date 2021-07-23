Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D4C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CACA60E99
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhGWTBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhGWTBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:01:17 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF2C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:41:50 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id s21-20020a4ae5550000b02902667598672bso629214oot.12
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bxVZWl9ys2ENk5+cJ6Yb0aFo4HAU4k6es/PcRmAhFVg=;
        b=Mv6M1awCavsjCtJe4VO7QJRV4T8V/P+MiwnlkKYgiap4WIidZ+PbncEBQXaRab2Va5
         LXIZKVjqePpD8orooe0OHySHAZnlkyWuRa0GcpE6jZFJUapeWuFQ6VnG50tzoKi//yYv
         KLwBTZitFCKk+HDPt4JBPEclMkziusRCsTMOwnOxhBBPD8+SrZ9yM9DMddbWUfmT+6MJ
         rpQSEMeGQndC4RI6IZoe9IVg1/E+WWOI4sFFDWUWDyn6V4P3C7qOpgeaX+cH+EALbDqo
         B7/t0oKCVhpNuNYmnaQX8hxpxQHU6Bp4x/B2xb4/rixMlMewxUeogElEYw6rZiGobqCE
         MZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bxVZWl9ys2ENk5+cJ6Yb0aFo4HAU4k6es/PcRmAhFVg=;
        b=LXHH6Josdjgxk4FsRh3GBHYCN2ys4kKWcIX1qhrsqgsnV/Li844MfyEPr+PRHZtohs
         DImeVvzU5yteDnlVJTuqu+7RlWZuiI0LrhcXlEY5zm1TgJYBQQiDExzOIHkbZXmE6ngi
         z1vDasCKZG5bgVlDZA+Pe3NxcvoIi1K72uEoHoxOGf5YB+JdVLNWya9nKJmwDbLRvROy
         amC4H/9B1meqBKqw45AEk7GDXGe+5mU7vlHXIwhNTF0ZUwq9zdMvG+6fZ18Jt/tbHEuq
         6Vna0pnmSf8lmZi3HVW+PETDw2mtVklq0ZLX4Mb2CYMGu7+4p4fyEPDVZmj8zjjSrt8l
         I8fA==
X-Gm-Message-State: AOAM5305upifrZqsQON/KHupSW0TpN5vJTZshTMyT5zFu5FbW78oAHwy
        GL95JPH0nxA9qE+bG1ML1Co=
X-Google-Smtp-Source: ABdhPJww0lwd7gyNOMTSYw2iEcSLBzWUp/l2K3iXTuE9KvYgZ2sKFu5XIvOQbI4jVXsLhDio/arcqg==
X-Received: by 2002:a4a:df02:: with SMTP id i2mr3737860oou.14.1627069310352;
        Fri, 23 Jul 2021 12:41:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r15sm2357428oth.7.2021.07.23.12.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:41:49 -0700 (PDT)
Date:   Fri, 23 Jul 2021 14:41:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60fb1b7caaf7d_1073e20833@natae.notmuch>
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
Subject: RE: [PATCH v3 0/5] Makefile: "make tags" fixes & cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> The big win here is that none of the tags targets depend on "FORCE"
> anymore, so we'll only re-generate them if our sources change.

Very nice.

I think most of the nitpicking in the comments is not really worth the
trouble (either for or against), there is one comment from Jeff King
regarding multiple runs of the xargs command that I think is valid, but
too hypothetical for me to care about (ARG_MAX is 2097152 on my system),
so it would be nice to fix, but not necessary.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- =

Felipe Contreras=
