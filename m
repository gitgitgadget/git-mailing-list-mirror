Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617AC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 17:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbjD0RuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjD0RuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 13:50:14 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2DD10D
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 10:50:12 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115ef7234so5250116b3a.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682617812; x=1685209812;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VTbw/t9Nk0IZ6J3RBkWNj1VmaRYe2m7L6r9qe9P6gw=;
        b=7CruVnS3R0rZjZ98CC5BNLHAevjXVQ8rBzOj71BrjRU396/JaW3DTRVVFzFPJuMmHy
         j7kOai6o2Q6nvqIm78Y5nmx80n4/l7Cj0R8rcYlqvd4XgywiCFACqOO90KzpqWnjNfqx
         bONRAgoNH+UOAC/EpwYAqXbjvXw9IhkPtoDesXfmoj61SEqyCUzUFaI1fOLMeuEdX2xb
         qfqgSud/+VCcAPCAbHNO8MZgq3VEAO5x8GdrdCt8qu3YV1e+Ek1Li7BNK54IOo6IdURB
         dvw0tyiRHEoJ5ysNODjmJlo+dXld4Fab4IXjesqlRI1NWWtN2FUkm+ixjTEjxELJ4Gez
         YqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617812; x=1685209812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VTbw/t9Nk0IZ6J3RBkWNj1VmaRYe2m7L6r9qe9P6gw=;
        b=XA5SNQstiVmYDl1zwC5HThhvKbjv158+/xZqkU8w8xUqgnbSfoSJ4d4Ly1rmn+S9pI
         l0vOoLZ7ALp5pBAUeTb+LIlcHzA3II4cayWZJfehVA1IJM3X6ymHPSaibn/WEpnA+5tb
         xlUEeftsNXfD+mXUEdICPYEsb70IG/lPCSnXgh2ozESX/mf/bWZXrUhtbtCyZpFJC5FN
         6YRMLslUi+dfwx/Y0SWnqR/L73ai3ll47SWReAaTlx+Yx5TOvK9LtV2QcU91Lps2Bocu
         cT/MOLQ9hLF0aIpCwXTRIxl5KFkPmT0O/Olk+pdHyG8yGt/wp7yth3ORhoRGJqpXrH5E
         /AzQ==
X-Gm-Message-State: AC+VfDyiPOJpgIyrqEco65l9f5/HSoXInA0ie3amKmFVPypCmM1TL7w4
        tGpsAQSzMDjA94N0CUJ1kStdEHwR54unHCef5b0UP3HGVH5IbcfB0GdndeQvV1jJK5DyRptnNcV
        yxkKwg6PffTrgINhZKXk2SBCYyGQuJm42fi0l8gUZ0JfiepQ7ff3t4dchfQ4+XYCeGQ==
X-Google-Smtp-Source: ACHHUZ6ZwtPegxdaXRmrvK6Tp8jigLrfMsT7G0Pc0/uNdekBuhmSB/DgmCHrbaxJtvGzeiT0KayDBxr2Vahnt+I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:fc4b:0:b0:521:70e7:a8b with SMTP id
 r11-20020a63fc4b000000b0052170e70a8bmr1746076pgk.1.1682617811614; Thu, 27 Apr
 2023 10:50:11 -0700 (PDT)
Date:   Thu, 27 Apr 2023 17:50:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427175007.902278-1-calvinwan@google.com>
Subject: [RFC PATCH 0/2] add an external testing library for unit tests
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Unit tests additionally provide stability to the
codebase and can simplify debugging through isolation. Turning parts of
Git into libraries[1] gives us the ability to run unit tests on the
libraries and to write unit tests in C. Writing unit tests in pure C,
rather than with our current shell/test-tool helper setup, simplifies
test setup, simplifies passing data around (no shell-isms required), and
reduces testing runtime by not spawning a separate process for every
test invocation.

Unit testing in C requires a separate testing harness that we ideally
would like to be TAP-style and to come with a non-restrictive license.
Fortunately, there already exists a C TAP harness library[2] with an MIT
license (at least for the files included in this series). 

This first patch introduces the C TAP harness and includes only the
necessary files. The second patch showcases a basic example of it. As an
RFC, I am wondering what the list thinks about using a second testing
library for unit testing? Are there any problems with this particular
external testing library and does it provide the necessary functionality
we would want for unit testing Git libraries? How should the folders be
structured and how should the new Makefile rules be written? Ultimately,
this will help us determine the setup of our unit tests in future
libification patches.

[1] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://github.com/rra/c-tap-harness/ 

Calvin Wan (2):
  Add C TAP harness
  unit test: add basic example

 Makefile       |   11 +
 t/TESTS        |    1 +
 t/runtests.c   | 1789 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/tap/basic.c  | 1029 ++++++++++++++++++++++++++++
 t/tap/basic.h  |  198 ++++++
 t/tap/macros.h |  109 +++
 t/unit-test.c  |   14 +
 7 files changed, 3151 insertions(+)
 create mode 100644 t/TESTS
 create mode 100644 t/runtests.c
 create mode 100644 t/tap/basic.c
 create mode 100644 t/tap/basic.h
 create mode 100644 t/tap/macros.h
 create mode 100644 t/unit-test.c

-- 
2.40.1.495.gc816e09b53d-goog

