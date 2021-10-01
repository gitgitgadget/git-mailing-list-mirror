Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D05BC433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4162161A7D
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbhJAKju (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353609AbhJAKjl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:39:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252ABC06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:37:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so14713612wrv.9
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBJtEXUEuzanEVwKp3F98QIkLhR8h7jZMiOPfRcXjT8=;
        b=NYU4ri4Kkcb0gIQ7SAA0sSV6rQT8EInURQ5TEqMCJAualM/HrcCN+XcogsLOkF4tUW
         JEFIGYhl+tiBdzsApcKO4IDn6xAXNRe0gwOVp+jJEiSypT8OiBNXlX5OC+JjcgudjZCL
         +MOLhzkR3CWC0dCXCfxrJN5SQ2bGCC2l38575MMF2Md2ModyyfziGqS+Lqaa/Ap494s5
         Rl2HBfgDl9KVlJJjrjvrZiaDj7rHdXo9WqM3KPJq9McfSUU7jsxio+5+LCvtWoVcVAkd
         uDoh3Fo6ZLgHlIZqHh1xbxMRuZL1JYzD4Y8I5dcxcIepEda6FFNym8ZwFJErxHphwIBA
         chXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBJtEXUEuzanEVwKp3F98QIkLhR8h7jZMiOPfRcXjT8=;
        b=ALTbjrf8qzc1jX/d6eWhNzsHJ0fXeG2+5NrS/qY34a00Hzs7EV6KCFhTVMGxxnljcO
         PTts5eNa//nl0FiT23pdZGWF2R+mR9/7oaWOsEMdgGkFpA6lWcZx1aFvLX5lNptomGtC
         MoIHchE/mqIBdkJdVjzl8NffQMkZUrGlMBum5ktFeyRYuUV/ynM4XbOezCRdfWDJGZov
         sIp6MhZKBEOFS6hhQbtcSHs9SwVTbE3hlrXnu1+JrV682EU3CwDhfNa8egeBFkA0OMp9
         /W7vm1kxS2W9H7WD7B2nO3wXlCU9NFbYfmPnZ6yoTmeV7edvv2E41EajQuNaZvBIK3VW
         Gr4Q==
X-Gm-Message-State: AOAM5306fjqwbIkHmbb7K1WQTOdi6Qz2/zpt56709VptMdy9q8xuaKi9
        I2n/V73sFKot3761Y5UftE3iPff1ZTnclw==
X-Google-Smtp-Source: ABdhPJxyAWnoWK3c7B5vz5eFC1SmgoN/f6QlS2vyuryPXId1yRLpXp3XuUssevDRg0Dcww69ofq31Q==
X-Received: by 2002:adf:bb09:: with SMTP id r9mr4822303wrg.238.1633084675421;
        Fri, 01 Oct 2021 03:37:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm7235586wmr.32.2021.10.01.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:37:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] grep.h: remove unused grep_threads_ok() declaration
Date:   Fri,  1 Oct 2021 12:37:41 +0200
Message-Id: <patch-2.4-1aa29533277-20210928T125228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was removed in 0579f91dd74 (grep: enable threading with
-p and -W using lazy attribute lookup, 2011-12-12), but not its
corresponding *.h declaration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 128007db655..a68dce5dfa5 100644
--- a/grep.h
+++ b/grep.h
@@ -223,7 +223,6 @@ void grep_source_load_driver(struct grep_source *gs,
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
 
 struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
-int grep_threads_ok(const struct grep_opt *opt);
 
 /*
  * Mutex used around access to the attributes machinery if
-- 
2.33.0.1340.ge9f77250f2b

