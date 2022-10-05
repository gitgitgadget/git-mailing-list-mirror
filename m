Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A592C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 22:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJEWTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 18:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJEWTn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 18:19:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5015598
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 15:19:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so185436ybj.6
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=913s0jmDq9uljYYFBV+yP+LA3c8M8SVL66r9H8pPa6w=;
        b=YGeJ5mbKClBywH8s4l5dxvvdB4GsIEggjczt/lbDOHqv3qPH6gnxKWnk7wVTuDvvGx
         NPmE+mwUd7mq8m/Nb6puodbVBIIffTXuw/rrxCBwmECxmPsEHlqBlICl+HNNGZnpiuUw
         344CqV6DGI66U7+v6DypDvrQBApwsJOFlqOpFkp0QuRz/D6kQLku1R/trtljwe1vl3aB
         Gh0Y56Zfds/nZgFELEavCB2PhGbyqPS+KofSL7lmGW5naIGuz7lHPAS6LovkPMna+Ul6
         4sKTQ+GhP08qgCe5W0HFmYE6NIZ/OMR8VsrPhV0dUvvufO/he715dxc1CjZ/uu1AU4Sq
         cVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=913s0jmDq9uljYYFBV+yP+LA3c8M8SVL66r9H8pPa6w=;
        b=fUDpz7UhfWh0GVnqtFiWp6ePBk8rzCMGzbswFJ9Z6MfnPspi7bK8Ob9RqRyFNUgkA5
         ydYMI29eSG9vq4KzGjF+T9QicIxDLy5KcMOw5KizdIFpu5BOYYyHlmvx4Vkvtmr1D3GB
         QxtY6q4dlCfFXDS7g7AIqeGz+tONEgaJh2cBetIqr7lrWOMmwdDt83Y7tWniOjhTsxoA
         06n234VLYogmdrq9e4oghjCENt94FKVppJsP/sKP+J4GKW/CZAAlyb/xi+xN5rbdt4Yh
         eUCZ7cBmGelZhSFVW1xnqZH8HuTZg2yRmiPueL46efB4wuCK7Y5fCAU4zLV4lGEIjh0T
         JwfQ==
X-Gm-Message-State: ACrzQf3oPpMclDNAczBg5Y3TUwyqTbqkNaYWFuh+wDvSjAounXdrgBIP
        /vR+hoKzau8VWKWpcu9MEr8d2tCUoyJIg4MSuWqjbNoVugozJRE0FG6CaVrDxzHIlUYHUirQ/Jq
        uB7QtReey6r1xI/RVFvalJBlJidwYj8K2BGSjc2PV45640I3OZn8bf3j31ZaY
X-Google-Smtp-Source: AMsMyM6u6LhyP8hIgMSg1R01lmXfG2htF7fe2jGtlesoIpexjXLyvam5qtx+kFUMYXN5k+p46EsJtGShcc9V
X-Received: from nayru.cam.corp.google.com ([2620:15c:93:a:530e:7923:ce28:a4d1])
 (user=asedeno job=sendgmr) by 2002:a05:6902:212:b0:6b3:b370:44c9 with SMTP id
 j18-20020a056902021200b006b3b37044c9mr2027298ybs.440.1665008381679; Wed, 05
 Oct 2022 15:19:41 -0700 (PDT)
Date:   Wed,  5 Oct 2022 18:19:28 -0400
In-Reply-To: <xmqqilkynd91.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqilkynd91.fsf@gitster.g>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221005221928.703750-1-asedeno@google.com>
Subject: [PATCH] git-compat-util.h: GCC deprecated message arg only in GCC 4.5+
From:   "=?UTF-8?q?Aleajndro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?=" <asedeno@mit.edu>,
        "=?UTF-8?q?Alejandro=20R=20Sede=C3=B1o?=" <asedeno@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>

From: https://gcc.gnu.org/gcc-4.5/changes.html

> The deprecated attribute now takes an optional string argument, for
> example, __attribute__((deprecated("text string"))), that will be
> printed together with the deprecation warning.

While GCC 4.5 is already 12 years old, git checks for even older
versions in places. Let's not needlessly break older compilers when
a small and simple fix is readily available.

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

