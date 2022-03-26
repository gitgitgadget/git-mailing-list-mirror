Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5037C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiCZRQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiCZRQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE635864
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r7so6042370wmq.2
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDxh8upBo/U6/bc0tZXVn53L22i7wxd0KvIxVuk+5xs=;
        b=CJ/81h80C/p/WrQIrOqaqhBQm61QT/Nq3maBOr7fBt7SA7/Tdc8vDEbZt053FMRa8k
         rlG/vxJdCbh4eaeYEqU+oD1yFUKo1NYwPbHI8akqlTxe723aDuBcMAkEfVV/wFXMqouj
         Hg3C9uPDzdhvx15w6l28Gwnv1ESaEQgU4NOcRO/wNRIOBsWUG+wRXIvQT93I4brP6ttL
         jknOLGn4LcCnHdFnexctf0ARXzPVRtmkZXJZIAaSgqNx3YIF/d4B/sdB5CLbqkKPqAhr
         mC98+6zx+iydDxglOYdxGSvy5kNaOt68NFcxW0GISVRk8A/3j6r2i5N8fh9+1xx7ReNO
         h+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDxh8upBo/U6/bc0tZXVn53L22i7wxd0KvIxVuk+5xs=;
        b=s58anjdSjH6FGgrnwWjbpxc2WhVzKWw8FSPuv0jdYBjrjaJJpTp3CsB6FAtrW6Dtis
         rjdBZTLLJmEIJ974vIvit4EdVZYUGgo0JCO5NXAmB6Wn+l3cIgP2lfUvlt9A+bFbmHyJ
         bXnU3vnVUe8LruXAzc+Rluton4LA2GstvxwrBxlcm/vriWwMVFt8YAekMK14M8jZ1v+V
         IFCtCt5cnfWf1iS3ue5JbkiIYUZyLVDlh78S59AYwOJi8uToixHJeJDApn3vTPW/4Vox
         0OAqj9ognZ3GgDq60uTedOt9+C7WdFCUajKaOzRQ72tVTb789G+5pHRyczgnMvUfXV0U
         30GA==
X-Gm-Message-State: AOAM530fN4kXZWj9z0l71kbrwYzEaGV1qvXv84mCjeOJRgJE/h+1sZRK
        8c/dV8OkR4yHRilLV76MIWSzVhDlKmiqzg==
X-Google-Smtp-Source: ABdhPJzcCO9KCiU+DB6w8CJJWaEwKHAUQA1FbkEz9w9e51rAkVNNRuEZFcrZVNxpv9YJ/dIrsx+wIA==
X-Received: by 2002:a05:600c:19cf:b0:38c:b1fd:1fc9 with SMTP id u15-20020a05600c19cf00b0038cb1fd1fc9mr16013726wmq.103.1648314872771;
        Sat, 26 Mar 2022 10:14:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/7] xdiff/xmacros.h: remove unused XDL_PTRFREE
Date:   Sat, 26 Mar 2022 18:14:15 +0100
Message-Id: <patch-v3-3.7-05adde5b9e4-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro was added in 3443546f6ef (Use a *real* built-in diff
generator, 2006-03-24), but none of the xdiff code uses it, it uses
xdl_free() directly.

If we need its functionality again we'll use the FREE_AND_NULL() macro
added in 481df65f4f7 (git-compat-util: add a FREE_AND_NULL() wrapper
around free(ptr); ptr = NULL, 2017-06-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xmacros.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 2809a28ca96..ae4636c2477 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -34,7 +34,6 @@
 #define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
 #define XDL_MASKBITS(b)		((1UL << (b)) - 1)
 #define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MASKBITS(b))
-#define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
 #define XDL_LE32_PUT(p, v) \
 do { \
 	unsigned char *__p = (unsigned char *) (p); \
-- 
2.35.1.1535.gf8d72b9da1e

