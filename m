Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5FC433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 05:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiFXF2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFXF2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 01:28:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3029C67E7F
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:28:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so1145693plg.11
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ChF47S2kSfBb6+MelZOzdf0mfG/imwAGHvP5siEpmz0=;
        b=5hoqiE8IhCyxiznMFkIspnphAPQSHuZYMd9bzhAv5HNio/9+dBCvXTq96dZLo8I6lz
         EBMwAdch42n/QYVK/ubSXRXF1/XzH5GcGIadhTos2xR7+ccy4dBBwbnDt9JfcmB6eAjh
         t7BTDhMxfnv1ELtwAR0IsNnrbyzsGm9C9UDlu38vq9s8rOk2iZu8MPeJgQ3dPpHh7x1s
         pzKUlo193EaSIGg5a5yQWZYzt10/5PYMszsMQejNg3rge4mNADsXSUU2O4rdZcQWCBCW
         042hfI/u3ZRhXkZQTEXLI+Li6JX07++KVi7pO0oitmyMy/cbvHkfP20D74WZEpojAton
         RIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChF47S2kSfBb6+MelZOzdf0mfG/imwAGHvP5siEpmz0=;
        b=N4dCW8SwTZWkQW1S8MDxKGp7HLt/n9ecXPJwetNgdJTkXK1T5V9cHLNi8oVSxQVAbP
         qi/uJiUosWOaPI1JlITS4Jb9672FI0c09/+AxfGemYrLJ3W2XmN4coCfQhd+QWeRP6mB
         jHo/DY5ZKP+MvkKFNkwOp/vf4xQ07G3wsm/xD5nne5ij3sFUxJWvY0TvUkv2xElzMyet
         mohS4SPBsEp0DFEOCxEt033fzneL72WTiCzewkXuC4uEsYjmI8cQJs4jkFYKT6UUdMgI
         JQs69EYO64b0z2eWMZN2GblqhEO1lQ+NRYcxLNpD8k41FsFVkTHqog9JBsUA83Pzl2Aq
         F0nw==
X-Gm-Message-State: AJIora8JLLHkjVF2imHuKvmNsG8e8utV4iSKA44/vv+DdbYm6Ai/UP9T
        W0UfUoVYwgw/3/cU/4vaYJlbmA==
X-Google-Smtp-Source: AGRyM1s4UtTWMgxc16Uc3gp2sagXyasxNvEEWFVVko5yZbFOTSU+0kvWMnzz7cKJauuPoaua6NoPjA==
X-Received: by 2002:a17:90b:4c49:b0:1ec:e8a2:b5f0 with SMTP id np9-20020a17090b4c4900b001ece8a2b5f0mr1886008pjb.21.1656048529694;
        Thu, 23 Jun 2022 22:28:49 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s144-20020a632c96000000b003c265b7d4f6sm602960pgs.44.2022.06.23.22.28.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jun 2022 22:28:49 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: [PATCH v2 1/2] test-lib.sh: add limited processes to test-lib
Date:   Fri, 24 Jun 2022 13:27:56 +0800
Message-Id: <442a4c351dea603e226bae89eddc2b3496d93262.1656044659.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656044659.git.hanxin.hx@bytedance.com>
References: <20220618030130.36419-1-hanxin.hx@bytedance.com> <cover.1656044659.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will use the lazy prerequisite ULIMIT_PROCESSES in a follow-up
commit.

With run_with_limited_processses() we can limit forking subprocesses and
fail reliably in some test cases.

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 t/test-lib.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8ba5ca1534..f920e3b0ae 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1816,6 +1816,15 @@ test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
 	run_with_limited_open_files true
 '
 
+run_with_limited_processses () {
+	(ulimit -u 512 && "$@")
+}
+
+test_lazy_prereq ULIMIT_PROCESSES '
+	test_have_prereq !HPPA,!MINGW,!CYGWIN &&
+	run_with_limited_processses true
+'
+
 build_option () {
 	git version --build-options |
 	sed -ne "s/^$1: //p"
-- 
2.36.1

