Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B650C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjARMrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjARMqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1625C67A
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v10so48119058edi.8
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/TBun5atiNc/oQ2kl9/mKAezutuVYs7tQgzxFAmUZ4=;
        b=DfYpdWUn0N56xNfs+8iGrIUXwN6sR24GJiTkeQxuyu+uEurKFToy2+Mv0RbZ8Ug7Cu
         acIcun1SRQeyyE3YR+Ca26AK6n84trkXVNnDHZtPuvomxXaZXDRFmHKFmkvyK6+hWiqy
         IU+nE2mFGILh/CIxAi6fX28fzsycwxkpE/DsXbuQPo57Cy+6AUBGlab4QICJeE+AQgRj
         nJzbh5VJ6zI6b7PRabqSzp5ugKMqDoZ27W8poQVgLyCF8MusKaSBKFgW9u8g6uGJ5WOf
         20ypSH2BGWi00Xv8TsnKvJQa9z+A/bB5E7s0RsgvXoOfw3SQVBX8t1XUp41TXmtRv8qX
         LSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/TBun5atiNc/oQ2kl9/mKAezutuVYs7tQgzxFAmUZ4=;
        b=qIDQVOia3gdWujXVbg3n8osjIYdLII7sOJvrY82Di3bcbIC3eFGLew9EtyBLoKNsqU
         UDUyyONxWibb05aa30jdh46viXYsUnUrq3y1qBMSc8yFzf3xYdnBBjesqGduAqtDg/Nu
         An4Eef0GJYsE+lUiBrO8jdwdVci3Q4Qe5dkmZ/2hNGpCKAVMq+LKCHMjaKbhDd2PMoRC
         R9o65V8tkvUXbqR3YpdUs5kYkIX+R9Xh4Kthuvqay6Tw9+z6aNtW1kG+4xoYBZJISy88
         WdFZVxCmXQur2Ycba52ThI88IZ1EKQEUUBJV4V83+Z/AWgKbkl+FebJfJe+rLHoJnjwY
         y2gw==
X-Gm-Message-State: AFqh2kpTs2eamrz5BjN2+dKDBYc+6KmVFja8e/ol5Qbk7RDSXnOvf9KM
        4bbdPP2YJdzBAQ0gmr1qIgu3EhyaSs7aUw==
X-Google-Smtp-Source: AMrXdXs14dsBqvFGlYpUgSd+18f7NSkvXIlMm/kCzx4upzUz4VeeMxfcO2wpz/BhOQFpgs3D0lhUzQ==
X-Received: by 2002:a05:6402:1f87:b0:49d:221b:4b3f with SMTP id c7-20020a0564021f8700b0049d221b4b3fmr7023221edc.21.1674043723357;
        Wed, 18 Jan 2023 04:08:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/19] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Wed, 18 Jan 2023 13:08:23 +0100
Message-Id: <patch-v5-10.19-928dea2d4ee-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since
2f4038ab337 (Git-aware CGI to provide dumb HTTP transport,
2009-10-30). In this case we're not calling regerror() after a failed
regexec(), and don't otherwise use "re" afterwards.

We can therefore simplify this code by calling regfree() right after
the regexec(). An alternative fix would be to add a regfree() to both
the "return" and "break" path in this for-loop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 67819d931ce..8ab58e55f85 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
 		struct service_cmd *c = &services[i];
 		regex_t re;
 		regmatch_t out[1];
+		int ret;
 
 		if (regcomp(&re, c->pattern, REG_EXTENDED))
 			die("Bogus regex in service table: %s", c->pattern);
-		if (!regexec(&re, dir, 1, out, 0)) {
+		ret = regexec(&re, dir, 1, out, 0);
+		regfree(&re);
+
+		if (!ret) {
 			size_t n;
 
 			if (strcmp(method, c->method))
@@ -774,7 +778,6 @@ int cmd_main(int argc, const char **argv)
 			dir[out[0].rm_so] = 0;
 			break;
 		}
-		regfree(&re);
 	}
 
 	if (!cmd)
-- 
2.39.0.1225.g30a3d88132d

