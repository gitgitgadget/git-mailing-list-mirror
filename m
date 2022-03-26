Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27732C433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiCZRQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCZRQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6535844
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so14641560wrh.11
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EadTkMciLhjGR6QcebbyJkkFyqLNtd7O1LT9DEwGC0k=;
        b=f8Uz5I1n6FTZ8d+5EdXLfDJdP7goCQpe0SynYjVLMn928LGVueVryNxmXkMJlHmG4s
         yLALiSD0KviPISqLC/0cozmDA6qGN178The4ekWRIY664Cw9BCc17gGqT0YZWpq3MHFL
         4u0ucyfyIb7lrgVxS3OnV4r42UWrYNyK6CMEDoF0c2EwPviqkTkL0+2mzgmF52uVy0kE
         7+B8d6DY2bJNWj9p9JlIddFceQBd8prLhbG6t0Dhl2gUJNAVCu/NPIwbq77ln+/jlfnS
         kRpe92OTw+HQtvPNLjp3ri5Ce3lgqEUd+awzEZcCeX1Gi1RVtsvSFiExWngfbakxn8Bv
         Y5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EadTkMciLhjGR6QcebbyJkkFyqLNtd7O1LT9DEwGC0k=;
        b=o8EIh51nMAjFQe5Jxwv87ZM3+6G9osJuLoFewBMgv+Mp5c/JnMjNRSps9jIYdmdnsO
         40K8RE3yZfDDYA90WA9h6M2m23wteF6WoHOni+gNd7mksiajsR6OsW8+MOeb0dQUKFrc
         oE5ivsjIc3zEsSykbjPszptAorXdQbrroFG92eUecruiRqzLW4/JtzjdIiTUrB5VW3g5
         y8LJpeTb42GzAIuE/qZn+21hpBAlXO9nwBU80YoHJZMmS9zDNiETDsamxM+yFoBx6n4m
         XxLQxSfwj2z2da+e+pSCHH39nEyqd/MOxsndhJ9DrYVRgY241WMXi0uxGkUwBf4OXpL4
         7+JQ==
X-Gm-Message-State: AOAM5301S1DPQHx+YIDIYHFepuYmXxg8v17c643Vlu3RAuFyKZRev6Kr
        Iap4o0X8WyqJV/IavRyKFzky9MfQMv2qxQ==
X-Google-Smtp-Source: ABdhPJzx2XVHIDH+ihplumGj7GHZTAcEJ5xae5bqQpP5Rr9iwvHhjshlisxWIcC5HqxHdpKK0wPoCw==
X-Received: by 2002:a05:6000:1688:b0:205:a693:134c with SMTP id y8-20020a056000168800b00205a693134cmr7697318wrd.558.1648314870788;
        Sat, 26 Mar 2022 10:14:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/7] run-command.h: remove always unused "clean_on_exit_handler_cbdata"
Date:   Sat, 26 Mar 2022 18:14:13 +0100
Message-Id: <patch-v3-1.7-bac78566135-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a "struct child_process" member added in
ac2fbaa674c (run-command: add clean_on_exit_handler, 2016-10-16), but
which was never used.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/run-command.h b/run-command.h
index 07bed6c31b4..5bd0c933e80 100644
--- a/run-command.h
+++ b/run-command.h
@@ -142,7 +142,6 @@ struct child_process {
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
 	void (*clean_on_exit_handler)(struct child_process *process);
-	void *clean_on_exit_handler_cbdata;
 };
 
 #define CHILD_PROCESS_INIT { \
-- 
2.35.1.1535.gf8d72b9da1e

