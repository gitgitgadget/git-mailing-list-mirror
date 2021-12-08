Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94749C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhLHVxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbhLHVx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA459C061A72
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so6397459wru.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJ3GDWKJ0GCH/2sQjyhi9Wp9eandivSrWcGSEkqQkNE=;
        b=WMo+TbC2YIt0dpXyaNnSilQxJoYv8xFd+nk66k+0NiFEs37koFhhsWAGnoP7B5+O7f
         RA2fo/d4pnjyuuVu5OsbR6tqszr0Mww4nhya9UCfllMCNdjB0lS10sXlTSX6Zjy/rIi0
         0GjX3k6EHRx0hZe+Ja82Vuh9fAhBXsvHgwx/FBHJiJ0tlUbYaSEgJ2Rmj/ByIvKYF/dH
         Q9zl3Pl+m4Tt9ZkHo/FRQdiP5nhRbtk75964PfvZdkDv06AWJHlq6n8fKMe/XnHwrPJF
         nzGlC7sncbnGQrhapTF6qdSEd43IXbbcaRWDM/Z71/bXLaAmKIbD3INd+EcG/CA4OIWN
         QgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJ3GDWKJ0GCH/2sQjyhi9Wp9eandivSrWcGSEkqQkNE=;
        b=Q8hg+8qKt46d4mlo8yh/AS0iiRL+oHWwW5+icCk6rjdcN8YlaKVGcu6grP/NUyMrN/
         zHqukGHyrPI27dNt4O+7NFsb/y8vKFlvnx+IahBNnlVcYDby7nT5Hb9W7NE8XHV32Gm6
         JmOztMTn+i71I35K2pafvucqTSWcsL1yz+zpe9SSALe5ViaVn+gxlQ+tSWGXySDTdOfe
         kqUbmYSoxmP0zCdMBLgTcitUlqhRT8KHAzbExbY+obu/PfU66siPBRMkymqU69S1qKwh
         E18g9/c68dr7fR5xetXbjim91yzM3+uCBG9TnP9vxw0Tq91ouS2BUG88ZW0bO1kDq3Vk
         jDeg==
X-Gm-Message-State: AOAM532elQohZe6g30qvQxd6jZZWhAp9zRy2hfk5dHECjOXGJs4p80Zp
        BC5n7MXpdkEpu1wSMWusM4fEiMr3J0A=
X-Google-Smtp-Source: ABdhPJyqvomfav/XeUCDDsHcqeCyp13zivoQHp0Ce7K+F946MVnaSNEOln7llvLTEUUeeTxdNlin7w==
X-Received: by 2002:adf:dbd1:: with SMTP id e17mr1509617wrj.480.1639000193241;
        Wed, 08 Dec 2021 13:49:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm3636414wrz.22.2021.12.08.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:52 -0800 (PST)
Message-Id: <700387ac5d386aec5c1525223bd5952b037b15cf.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:42 +0000
Subject: [PATCH v2 07/11] reftable: fix NULL derefs in error paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 3 ++-
 reftable/stack.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..8d308d858f8 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -796,6 +796,7 @@ int reftable_reader_print_file(const char *tablename)
 	reftable_table_from_reader(&tab, r);
 	err = reftable_table_print(&tab);
 done:
-	reftable_reader_free(r);
+	if (r)
+		reftable_reader_free(r);
 	return err;
 }
diff --git a/reftable/stack.c b/reftable/stack.c
index 10dfd370e8e..eb03b6c74f6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -707,7 +707,8 @@ done:
 	strbuf_release(&temp_tab_file_name);
 	strbuf_release(&tab_file_name);
 	strbuf_release(&next_name);
-	reftable_writer_free(wr);
+	if (wr)
+		reftable_writer_free(wr);
 	return err;
 }
 
-- 
gitgitgadget

