Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC4C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 21:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJCVai (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJCV35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 17:29:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F251A1A
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 14:23:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34d188806a8so121902537b3.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date;
        bh=6yXXrYAcclUFBEJHnY5yuNVwySKR4OwgykuY/s8uTK0=;
        b=qwj4qfzNS8Jz5xqfafccJ4tboEdHmvMU/BNolCQ4sb0rSyS+dtayID0F1dZsENv3Jm
         YLMwCqGhJ+uaZDzpH6jbrymhkNmaQOMSpFbJaQcc+rQeDEkuh9vvjso2T1MEnd4ba4Cc
         yVBLDEI1iE+uG3Dt+0jrRqXKNfDOsBxM5aoJ5B9a9bQ8MIG5+Pq2AhDAHUZ2WNTo904M
         OeEsx7ZN5UrWBb/EpHxms1KOSghf8dcS6ZUYYpNrvZwP9HjK1hn6i6uI1W79Tcf8LaNN
         EolZ8bSwWdmcjaZWbbtkZ1JQErGTzQU2b5O68xnSigipTxEalCWhobgmGQWlyAeUdJPu
         IpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6yXXrYAcclUFBEJHnY5yuNVwySKR4OwgykuY/s8uTK0=;
        b=uSYLz8CxJs8j36yWuFAQYm6bpAFOqugyonyhnXtcflZIujjiPAdavUfOTEoYcJUdt3
         vICWeych+vZMekHMFlzY7k1SEIx2YmIVpjj92yoplqRE82JEtxG3WOClFht7VdHr/0Jy
         7fkvQm8/8wmi7A7u2hHQLN2IJ5/RmjJMZbvUw4go5y9AIl2TeXCK+Effy6/baYQjTwBN
         Ru/+NwrLcfNtjjV6214N3zchPwjqK3q2Qp+shL8ObwWpFY6rnN6QOxBl2O2KKpU+2HyU
         Bq5wiyWOrG/r9twEv5mQkGy7oYS8rDqLmN3WGXOhOJ40qmSp1qKUIEkmBdJKLMQcEpzP
         GSLw==
X-Gm-Message-State: ACrzQf1BE96mof5wrdHOgxq4AhNVdtvuT0ue6K7rMwVD7hB1BAK0zrdO
        2okqkJxxe1+QDWPU9A3RfeLLxKXXzi6ZW3blAXkH3A+6I0muS8jNFnS5Jws1l+JVG/di8WUDd0R
        hjJH0I/mfk5Mp26FBaqY0cxtckLAd+3qvyHZbvcoBq4uP+ypLdR10va53IYdN
X-Google-Smtp-Source: AMsMyM4SrwqxRnwJ8raajh4j/fFSK22jMfY5JCPSGCuebYPyh9buHHkN5qBOVLQ4xYKCWSqrnX7rJcMgnkGq
X-Received: from nayru.cam.corp.google.com ([2620:15c:93:a:530e:7923:ce28:a4d1])
 (user=asedeno job=sendgmr) by 2002:a25:af52:0:b0:6b3:de78:452a with SMTP id
 c18-20020a25af52000000b006b3de78452amr22061923ybj.157.1664832228664; Mon, 03
 Oct 2022 14:23:48 -0700 (PDT)
Date:   Mon,  3 Oct 2022 17:23:18 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003212318.3092010-1-asedeno@google.com>
Subject: [PATCH] git-compat-util.h: GCC deprecated only takes a message in GCC 4.5+
From:   "=?UTF-8?q?Aleajndro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?=" <asedeno@mit.edu>,
        "=?UTF-8?q?Alejandro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>

Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
---
 git-compat-util.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b90b64718e..045b47f83a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -189,9 +189,12 @@ struct strbuf;
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
=20
-#if defined(__GNUC__)
+#if GIT_GNUC_PREREQ(4, 5)
 #define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
+#elif defined(__GNUC__)
+#define UNUSED __attribute__((unused)) \
+	__attribute__((deprecated))
 #else
 #define UNUSED
 #endif
--=20
2.38.0.rc1.362.ged0d419d3c-goog

