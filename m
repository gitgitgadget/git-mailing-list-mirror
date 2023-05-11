Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B3BC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 16:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbjEKQV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbjEKQVy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 12:21:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2EFB
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:21:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba6939e78a0so7093690276.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683822112; x=1686414112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xq+UHsCAdwmVy3RvUvwg+kyJnbwtra6MuDLyJGVZwbg=;
        b=Sn0OyqI+pv/6WSSy+X4Zu94a9FyqYKKGXsKQsdAfWMUArdnsyHOrlM5AhnvOLV4Fbp
         ALIilO3dOsgAJGjxH5ddeKYvDmtLhtBKurMwCTrlIuSgVxCzA/flTGKXPnX5Wd6qkrUU
         8SPqC2KuDx50frVwZfMTyoAeHiFjj8JDRbAUvuRJSo/WpCjkdPqWySTa9r1/lVKrWMP7
         in/uhQp6INIiirrtiArkF5V3yLAnOeCKzBbGyNVyprO74RHyl8QUYZElH8fRbz3/ZOWA
         h9bFnyYk94suyYL+o0Os3+jDtMc9Ys4kagFrriXzXfjRW2An6QYwXMsTyWsZHOlOBMaX
         EBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822112; x=1686414112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xq+UHsCAdwmVy3RvUvwg+kyJnbwtra6MuDLyJGVZwbg=;
        b=ZtdVsogpoN51sGSOsbt873W47ZK/iK31b/WryXm8zL29uhMqEPAyl2h0Gocnur9a0d
         MMwF1Hqq0BBy+wLTdH6YF8siB5LHY6b5lhNqzwhGwcNDNHiLlRgGRht+CoKYAE+1v0O6
         cxZz7VonHwp3bex6hqMIfRza771TYCEmyezK/D7YHv+QRACceAIKRZCsg/2F+ZSy7vQH
         KEWiiOS5L6QMmgJCaq+bVwgFIFShqJ4N79ULrHPXMWfY39Ofx8/DokV4gz/1Up4qgVX7
         SCFMfLTqtwzJpZ5gI0SlfBlsuUvg9lhxlXPbwOSMlY0wtdIzt9imwuBLAEeKN4CJYbDU
         O4VQ==
X-Gm-Message-State: AC+VfDy+DkCOo7uTKChOCG4xzUDNpFQ7YGnC684aclHMvrz8GeNFLafH
        azcZJiEeWiT37I50NJbRRsLPbEpWp4HJSD6V9rRb
X-Google-Smtp-Source: ACHHUZ6rIyTPQqazceexuWuzAOQs7A+r+4Ceb4f0cO0PtQH9xGp78HAzUXjsmdQl5uFTaooHmQkyHi1PVrVfxk1Ct70W
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:11e:14f7:fd:99a6])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a888:0:b0:55d:e173:8a73 with
 SMTP id f130-20020a81a888000000b0055de1738a73mr10581720ywh.2.1683822112329;
 Thu, 11 May 2023 09:21:52 -0700 (PDT)
Date:   Thu, 11 May 2023 09:21:49 -0700
In-Reply-To: <kl6ly1lxyvgr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511162149.897554-1-jonathantanmy@google.com>
Subject: Re: [PATCH 10/14] (RFC-only) config: finish config_fn_t refactor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> I've covered most your response to =C3=86var upthread, so I'll omit that.

Thanks. Indeed, I missed the situation in which a caller used kvi not
by accessing its fields directly but by passing kvi to a function in
config.c.

> In an off-list discussion, we described some plausible ways to organize
> the refactor that would make it easier for a reviewer to confirm safety.
>=20
> I haven't tried that yet because it sounds like you'd prefer the
> sidestepping approach. Do you prefer that primarily for safety reasons,
> or is it largely motivated by other concerns too (e.g. reducing churn or
> sidestepping produces a better API)? If the primary concern is just
> safety, I'm somewhat confident that we can find some way to organize
> this that makes it easier to review and I should just do it.

My preference for the sidestepping approach was to reduce churn, but as
you have pointed out, it doesn't actually reduce churn. So now I think
that the patches should be reordered (but am open to being convinced
otherwise, of course).

As for safety and better API, I think both approaches (bulk modification
of all functions to take the new config_fn_t and two sets of functions
each taking a different function type) are equally safe, and it is
bulk modification that results in a better API (as you've demonstrated,
having kvi information is needed for good error messages, and I expect
that to be more and more needed).
