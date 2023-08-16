Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7ECC001DF
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjHPRSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbjHPRRw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 13:17:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4319A1
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 10:17:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so17131cf.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692206270; x=1692811070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1dtOWuU9C9eadWAyWDBo4aYFzHSuuWvoysv6mGCyG0=;
        b=uBF6kPCYQp4wxTUFbiL5u14DWO6lPQSZ0TCxRodkl9T4ATkVj4I1bNO+LdfAvFr+d+
         pUJv6aWCqOLhw2I7IOacyGuaK24o1PjW7qWOfZUjiwJO4pvff5jtYpeSwPtsyn4sRzty
         p3cO92DP7vZMYe/DrKa9uqmTUQa/QNj/nff7a3xUwgT3XNLRm6negLbhL1EP+/veuL8A
         Rd1+irN8cO8JdhKMJzqQQE5ZXiONLB9gN3ZIsGQPZqAmyYqtls6x79jJwINsC27lJDzc
         3Fpy8paofHbFUF3HY7Ko7sArvNYq5pHIyPO9zZJ7P8EP1arcptbRwvBluS2Y+fn8pGcw
         ZTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692206270; x=1692811070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1dtOWuU9C9eadWAyWDBo4aYFzHSuuWvoysv6mGCyG0=;
        b=ZvYl4A2iQllpLg3FMdpkAfkxuWB3ISm7ohM+KueiSdWbpp/+ikB7DAD8Cwy9RKsI4I
         D58/aHOOJ8bhiuLTXdvxqr5/bW7GbRcPvtU0yOdWTipNHUHdmX7jg5aJFXgw/bncLJ1b
         NzvOjEhL5yQrUWGUw17j2oFFz6egAx5Zig9NAIKlI5MY0dlnIbRsz64Kl3fnwgXX5BTg
         GWrSkIGQ3Q1PmqqZbXKa26IMC6yBO6IGBWKP2lahwzRFxvBAOqbeqfpYKFwI4BEGl7zi
         y9HS/64R0PHKmUMdoUClCGenm934aJwFSymP0Bcsni0azJcbWnfAOFt5UOoRkGuPckzv
         xD8g==
X-Gm-Message-State: AOJu0Ywnk/9y7YgDfKEUfaGvbEOmQotl3CYGePEbb5pPGsxwkT6K8nI3
        6759tmveQ7SCuJwN0bWgpZFDYJ9SfrHUkK8ZRcSLAQ==
X-Google-Smtp-Source: AGHT+IHBk8Q4+BWxbZR3NXHmUtJJyC7sE7Nk8GP+yR8KV6W7GaAYD6608HAokLm4kyQLtULD9O8HtQq5AppoqF5+4XQ=
X-Received: by 2002:ac8:5fc1:0:b0:3fd:ad1b:4e8a with SMTP id
 k1-20020ac85fc1000000b003fdad1b4e8amr12261qta.22.1692206270465; Wed, 16 Aug
 2023 10:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230810163346.274132-1-calvinwan@google.com> <kl6lmsyy8sfj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <56d0838d-12a5-8a8a-3c3e-7d473f2977e8@gmail.com>
In-Reply-To: <56d0838d-12a5-8a8a-3c3e-7d473f2977e8@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 16 Aug 2023 10:17:39 -0700
Message-ID: <CAFySSZBN+-HVPekCjkshepKZLB5uP-m9A=1bWm5Z_OBUVtgQYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Introduce Git Standard Library
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for resolving the conflicts on master. I should've rebased
before sending out this v2 since it's built off of 2.41 with some of
my other patch cleanup series.
