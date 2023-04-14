Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CBC77B7A
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjDNMT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjDNMTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:22 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D9B47F
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:13 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id ec6so5163430oib.8
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474752; x=1684066752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec1J/m5HWnjTuS8Ur8RdtE/9QOvbxJc45gQAchmgOws=;
        b=bM5fPHAnvrAdJoeakPN3A7bLYJl6Aad8g8U8nxhT4EjtbP/cTrRyrhXfI1+SmlzNQT
         pGI2eZX3z598Oa373OzuzBDx7hKpaa+KZDmq15+CH1zvHLzckt/CZfOwztkSDNX1xfqt
         zhkIPOmOWUMZTyMYIxofVExNCyaDcJmQSq+yEuUJ+LEjYJ33+0QZ+BEfuMWsg+6DqlCc
         3oEc6ZVaHJJejKf49DQ/gdq9wvXgzl+PB7lZKcC+bnnRb/TBGBa3qE9nAhLt88ldbvR3
         qa1A/8v1p7lChl3gP3udsySI46X+C5dJ/XYpwP9/g+CZE8mUfVqT4JR89kGg1E1oIjX3
         LlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474752; x=1684066752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec1J/m5HWnjTuS8Ur8RdtE/9QOvbxJc45gQAchmgOws=;
        b=evpsyLPHeQltZSXHs8zJGIPuY8xXn10+9kij6kx9ckiMG0s7Rel6HYzUWVPyOiN+eB
         9bhp360NfBkeUqw1MXpWPuNZ9NRgJwQJDFGV5YYrfk6ieEAVnU7mCxttinIUdx+Vqk9k
         7KR7KQbSMigccLTh4mQT+tAyNU9rGXkIOEbwhBWKQaqBI1HZGWE0enZzEA7SANOXKWi0
         VxUiFDHzHApVDXXXxZ0WseuOGCqGAccGQbECCMjDN7TxtDGhAldvwrkUqDp2GIPu0xEs
         gkaIdSJay9bnMX0U8t22yr5H1DUpWMrwv+kHbDEYpSfFlrdxjsqRSv1Ca5LBXg1Nex4d
         p67w==
X-Gm-Message-State: AAQBX9c66iD98ze/fceyFK3TNdnRFoFthK2dPWKH7E5ZylIAjaLlwv6v
        Vcgh2VMcqSyRp0k1RdhSLrP6sSGv8QU=
X-Google-Smtp-Source: AKy350Zul7emKiF0AHQxvvILV7QNybW+NprWnNYuwq1gEdwerUKEwjcwymCtC8hfNh0JLAKPpdN41g==
X-Received: by 2002:a05:6808:a92:b0:383:f8a3:2529 with SMTP id q18-20020a0568080a9200b00383f8a32529mr2389273oij.6.1681474752093;
        Fri, 14 Apr 2023 05:19:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z8-20020aca3308000000b0038c34e67d47sm834938oiz.55.2023.04.14.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/18] version-gen: generate proper interim versions
Date:   Fri, 14 Apr 2023 06:18:41 -0600
Message-Id: <20230414121841.373980-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The change from dashes to dots was done in 2006 to satisfy some RPM
 requirements: 5c7d3c9507 (Allow building of RPM from interim snapshot.,
2006-01-16).

This probably was done because `2.40.0-100-g000` would be interpreted as
version `2.40.0` release `100`.

It isn't clear because the commit message doesn't explain.

But using a dot makes it worse because `2.40.0.n` will always be newer
than `2.40.0-n`.

What we want is an ordering such as:

 * 2.40.0         # git release
 * 2.40.0+100-g00 # interim version
 * 2.40.0-1       # Fedora release
 * 2.40.0.1       # hypothetical git release

So we should use a single `+` sign for interim versions, and for the
record that's what Mercurial does `6.3.3+hg591.dd42156b6441`.

[1] https://rpm-software-management.github.io/rpm/manual/dependencies.html

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 161fcdf1ab..99584bf86d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,7 +2,7 @@
 
 get_version () {
 	test -f version && cat version && return
-	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/+/' -e 's/^v//'
 }
 
 NEW="GIT_VERSION = $(get_version)"
-- 
2.40.0+fc1

