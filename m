Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996EC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 00:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbiBXAMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiBXAMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 19:12:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5955BC0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:11:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j3-20020a170902da8300b0014fdd4e979cso76204plx.17
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=N36Lvokr1G/GFFtkroWp3Pkcgj81VfZXvib4BvViXnM=;
        b=RnixN9C877duYdNU/f10iomxG0KPfSgOdyXao2VvifNADYcL5tUCIRnWXBRoJR7RiJ
         o2WyamwvJV3Erd2sWUh68jt4D4OBcA1qU+m/Hkkm7pweu6nPh6Ub20PFJUAUOvXdlL5B
         UkIM5TQozHpKpnr/8QY+wxyaOUvjWLVK5UZ1+pZQgKhgPPjY8Z1ZrUT/1gKVqKi6geUa
         JhM6EPEXUDGIPJAdWvkV3P5XPQD7q2TNvu+9mY35zd2/6UYMRzJ36ztvN6lfjbyUdN/+
         lmHm0MzK50vpl4CK2Zke5xzLFB8S3nhh+7UDBRQQgbAq9B2AfCEb4H0OcdSOK2DJ/h4B
         QDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=N36Lvokr1G/GFFtkroWp3Pkcgj81VfZXvib4BvViXnM=;
        b=5fpiE/OKKf9vxW3AgBN1M3fDr1JxuhpSA9XB9RUWnx6tUVocz/xuKQBcF1swkZ4bku
         NithTBRcMa2Iqz9CJpAX5AB60ZgNUgGo448jgxA/BKqK50SSRb9LPhNgJtpooXwjt87/
         2rdpLcoYgxpmtQiTZuV0hq/XJjgEA9s2E+g50WSYhh45gHH5Lr7NaXQFSwrgDv/PXkCG
         vOf38/B+Dfg1oKCFpvyDePZI8l6SEOeTGFOPAPCMyW5I6pJ5OiyDK6tCWtAy0I/kr5TD
         E9IxEoKl5ZXl4vyK+38Xpn1h/4i6oSJB69Yr+35FyBilakMJ6yT5mWkfpX8ZfkL3kmKq
         CNUQ==
X-Gm-Message-State: AOAM530hTS531cYviH6nIj38UDZLlxa4jS/uTBH/CFuRQJLt+D1/Mo79
        SKopaY1OnpD1sihFlwyo+a0ZP9tIhbMVYIlm2PCs
X-Google-Smtp-Source: ABdhPJzJ2FWhBsZTUrpDHT4/0fS6Eqioi1UGRObQdXPFpQllAo9gIF+RTlBJ7P8ideQjkmaPWTHU8J0iTQEsXnSosA0S
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with
 SMTP id pj3-20020a17090b4f4300b001bc7e5ce024mr268241pjb.0.1645661506907; Wed,
 23 Feb 2022 16:11:46 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:11:42 -0800
In-Reply-To: <220221.86ley4aw88.gmgdl@evledraar.gmail.com>
Message-Id: <20220224001143.2150137-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> On Mon, Feb 21 2022, Junio C Hamano wrote:
> > I think what this is trying to make sure is that it (1) enabled the
> > combination and (2) uses the object store of the submodule when
> > disambiguating names of the objects from the submodule, because the
> > author suspects that the reason why these two options were made
> > incompatible in the first place was because long time ago there
> > wasn't a way to ask "here is an object name---please uniquify in the
> > context of _that_ repository".  So it is understandable to prepare
> > an object X in a submodule and another object Y in the superproject,
> > such that the abbreviated name of X in the context of the submodule
> > is different from the abbreviated name of X in the context of the
> > superproject (i.e. if X were in the superproject's object store,
> > because the object names of X and Y share the prefix, it may require
> > longer prefix to disambiguate from Y), and make sure that the uniquify
> > is indeed happening in the context of the submodule.
> >
> > So, you are only concentrating on (1) but forgetting why the author
> > wants (2).
>=20
> Indeed. That makes sense, but it would really help to e.g. have the test
> description make that goal explicit.

That indeed was why I did that (thanks, Junio). It looks like it doesn't
work with other hash algorithms, and maybe it's too much paranoia on my
part. I'll send an updated version following =C3=86var's suggestion.
