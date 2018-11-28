Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51F11F609
	for <e@80x24.org>; Wed, 28 Nov 2018 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeK2Izq (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 03:55:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37417 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Izq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 03:55:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so18049621plr.4
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 13:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kIGM+xcWlTqpfSxz3FH2UZVcIjMyrgIvf7HyDD6FwYc=;
        b=HrrkepHPWCtCdadFs9tzJCa2/dGDb9LseRzogxwciygCRijtvqAda9y3nvdI/fqZhb
         dZsm1wQJnHNsu63UUm0n+whhHeh8Nvc1/J+RCGwUwT/wJ9YtMNOSfbes81cc188rutQU
         JllawqOW5jMTZbWJgnSSpY+BJxHuNhn7Gw+XmEBoXb263aJyaoyPsVS4BYF1duUB8QI2
         4m1Ax8MSZnY8r5r/xIIB/DtiZ+olTPBvwZZE+AdSBL3LVxUFZEa47S9khzCwrpsRuIkZ
         SKX88M+zOrNpJ1m4509zwGaXyz8nF0kiAZB1b9vkSPsZ+sIWFqG7RIuWqHckAfqWPrrF
         cAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kIGM+xcWlTqpfSxz3FH2UZVcIjMyrgIvf7HyDD6FwYc=;
        b=UlyAtwm6sP3J8uN2gdEDNIGE2TnkI0vQA7NXesQm4HsTozIAnw6gcRSrLJk6Bh9NVU
         F9pf2yMvCWua1C3GaTn1UG2D34X/hbusPZDvK9Z0G8wPrx9afwAyppwt9yHna+sDoT70
         Qxfj4jE0wwPKqKdK/nh4AIZP1XKhbbh4+22yDDcir7Vym+2tdeRUOXzACaMIhpcuMAtU
         IzAlOccEnP+kY8j/lKw/P30p3BbtFDECy9rLyk+KW9zEZRmMXLaAjrE+P4j2wLNDWQrl
         dwfIv4hjQAGUEb6fB14jOwTUNDfDZpR2qpbAJr1dcD+UAmv++YzIsecIDjjuEWUrK8SM
         J9YA==
X-Gm-Message-State: AA+aEWac9+ifpbWofqCeerlsSKE+hgqMBiY7W2C0ANXxKgvoo5oPt14V
        WcTNIOGdP6THy5TYFKXFT/stg9lt
X-Google-Smtp-Source: AFSGD/VukL1GZMvjYfWxCyDIUsaJ/QD559vW8+IgheJWpuKlLF9CBIQTqYYECKapSLfT0TE2y9feZQ==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr8938806plb.182.1543441962291;
        Wed, 28 Nov 2018 13:52:42 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id q75sm6141674pfa.38.2018.11.28.13.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:52:41 -0800 (PST)
Date:   Wed, 28 Nov 2018 13:52:41 -0800 (PST)
X-Google-Original-Date: Wed, 28 Nov 2018 21:52:34 GMT
Message-Id: <pull.89.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] Add a new "sparse" tree walk algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the biggest remaining pain points for users of very large
repositories is the time it takes to run 'git push'. We inspected some slow
pushes by our developers and found that the "Enumerating Objects" phase of a
push was very slow. This is unsurprising, because this is why reachability
bitmaps exist. However, reachability bitmaps are not available to us because
of the single pack-file requirement. The bitmap approach is intended for
servers anyway, and clients have a much different behavior pattern.

Specifically, clients are normally pushing a very small number of objects
compared to the entire working directory. A typical user changes only a
small cone of the working directory, so let's use that to our benefit.

Create a new "sparse" mode for 'git pack-objects' that uses the paths that
introduce new objects to direct our search into the reachable trees. By
collecting trees at each path, we can then recurse into a path only when
there are uninteresting and interesting trees at that path. This gains a
significant performance boost for small topics while presenting a
possibility of packing extra objects.

The main algorithm change is in patch 4, but is set up a little bit in
patches 1 and 2.

As demonstrated in the included test script, we see that the existing
algorithm can send extra objects due to the way we specify the "frontier".
But we can send even more objects if a user copies objects from one folder
to another. I say "copy" because a rename would (usually) change the
original folder and trigger a walk into that path, discovering the objects.

In order to benefit from this approach, the user can opt-in using the
pack.useSparse config setting. This setting can be overridden using the
'--no-sparse' option.

Derrick Stolee (5):
  revision: add mark_tree_uninteresting_sparse
  list-objects: consume sparse tree walk
  pack-objects: add --sparse option
  revision: implement sparse algorithm
  pack-objects: create pack.useSparse setting

 Documentation/git-pack-objects.txt |   9 +-
 bisect.c                           |   2 +-
 builtin/pack-objects.c             |   9 +-
 builtin/rev-list.c                 |   2 +-
 http-push.c                        |   2 +-
 list-objects.c                     |  51 ++++++++++-
 list-objects.h                     |   4 +-
 revision.c                         | 113 +++++++++++++++++++++++
 revision.h                         |   2 +
 t/t5322-pack-objects-sparse.sh     | 139 +++++++++++++++++++++++++++++
 10 files changed, 323 insertions(+), 10 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-89%2Fderrickstolee%2Fpush%2Fsparse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-89/derrickstolee/push/sparse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/89
-- 
gitgitgadget
