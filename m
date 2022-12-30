Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C14C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiL3CTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiL3CS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F0178BE
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l29so21832633edj.7
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihL02fWLnPVa1G+vouJKVEijt+XqGqjvL0PoGlNa2RY=;
        b=mtTQXLgfXSFRekrhLcDghcsT5u3KOqa0oW9KTjeVXj5+XgGBSvooHFwlJiOOU17qpd
         uNG7UdE2a8+Zl4P3/lPHAgBDAzk7EM0A/tJTSwRy0fy+Yj9jvft9x75AT4Aho3TVUbB3
         OCKkYxbHcw0Ng1R22ZerIcLBpcWewZTtwxNk7dwUvuIu3V12qyKdWX+9scxcC8/qKn8O
         1riXiyPfKFKapT0Fn0Ym0RadJ2HR7S2/Bbn+Uz8Ati6NH4jmImsvw4itPPu+tSpQoeI4
         rKAc4A6Y0U/Sxaduda9Q7F8PsH4wmziUxM1EtSDyyiqNp1bAFPfcAo86PinsS+sRM270
         sNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihL02fWLnPVa1G+vouJKVEijt+XqGqjvL0PoGlNa2RY=;
        b=ZQZhQ1vF2ymBJRHODCLQNbRvY+hU78huVB8QiVK2+0elksdGPi2FgY8l039Ulco8L/
         uSHCKFJvQlkTU2Op1o+5UsMsKzZAi/tLd3auZ/kZkNVahVhQUxWbzqc2vytfbmtmozQG
         BjSxdX9MOCVMxZ9YkSU4g/EwJYfTzEprt7rNtpoErC9ZLA88ihdLkLP6bKuMEfHlJZsR
         YCw0fU1RemcIS+ROrK9MYRpE5oQSaC8O+2sXnUN5/7jZ2HmU18OYPG+Wl6z4YO3oxWw/
         Jq4QsfMVLRjEwx4Vo8I5JZuzZKem8reAifcBz/7HK3iuTN90jHOdkYciJwXUOwke6AI0
         iwAA==
X-Gm-Message-State: AFqh2koXUpk2ywDYcWzdxSNyrZeqQmFsvyJK6/rYKEw7t50NCRNBU3V9
        174vvOan1su1LFtOk9qZQBfcQFq3IGtnNg==
X-Google-Smtp-Source: AMrXdXtnAs2ci5aT+bxEVXMoP0ihYPMw6WHegSGz1Bq0JbmtkjdGmOxngz+4sYs1rRCfAdHSQfEL0Q==
X-Received: by 2002:a05:6402:174c:b0:467:8dd2:b42 with SMTP id v12-20020a056402174c00b004678dd20b42mr24089728edx.10.1672366732150;
        Thu, 29 Dec 2022 18:18:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/20] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Fri, 30 Dec 2022 03:18:29 +0100
Message-Id: <patch-v2-14.20-bdd2bc9a956-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 91dd5435c59..2b13124c497 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
-- 
2.39.0.1153.g589e4efe9dc

