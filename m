Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6CC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjDNMTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjDNMTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:20 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A77B741
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:08 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-187a742a963so2794335fac.10
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474747; x=1684066747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIGvxajfvtryih2lmcsbBElF96yKV22yxCa6ixUKZpo=;
        b=K/o5KfyoCyzWrC/QcTBrKnSXWYBr69RPxmQXNsTEPG4W+GSnWcQZfB9ykJzMc7hQx4
         XQzRuw31T0c1R0DIvEhQtM+7WmRRna/CtF6clKj/Ub8eFOfZ6Pkb3gWYiMn3BTvrPwa2
         F0+DmQuX8RcTgTzdQE8o1GkLRrOwEzxUJurfl/eMfN9DzTQ5k7v/zQkjsHwSJD1ZnI8l
         bbgnTrawp5E3fVSklOKnrHFH9n5ICErsYgs2+ucwyCM4OP/KNXBCFasdedaEn3GQwdfT
         94U7lGvCbETVqgt0mEztjihUXR5ksBc0N2tGz43YEKzPtysgKMqc66sJvkSIlmGil0Qg
         AozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474747; x=1684066747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIGvxajfvtryih2lmcsbBElF96yKV22yxCa6ixUKZpo=;
        b=VhZt7bWYPlI1WS/krb171nEThdSICprScUskL7diWWGr3umWNM8KxS3kCoqciTZ+qU
         o8V1fc8xeOf8AbANvywWW8qxXUkj8+ccx/zUMts99f0HtjgCkaGdn0nAyEoSZ5Gc4n7r
         IADNyjDZHKegBO/5s+6hMeoKjCeDKNhU4AGuhIc0xVM5s/69rNkPNSi48GQVKDnLRNV/
         zYeDV7OBAVTbrsowKsl2tM52Tm79TRCIOa/IouZ8Am+8NMUdDkGDzEn9USKDvDp/ozz8
         9o5BxvTY88fACV6HqkoCsLamhcyaNrmYU/XDuSaFy3s5a7ZKi/nvM0vlaNY89/9twPw7
         le0A==
X-Gm-Message-State: AAQBX9dBR8+AeGfOZnyrBFM3EiW9cW88vLEHy1SzdtShqmki4TroOwHz
        O9tm17SKAW2QMe44JK/Ws9YHK5ZVOn0=
X-Google-Smtp-Source: AKy350YzlCYCKcwCHFyFSRf5i5tcCM5LZCCQhi4R2xnJ7qdjmxENsOz8Emktr8QUp8q89CriOmIwOQ==
X-Received: by 2002:a05:6870:611e:b0:187:afc1:ccc7 with SMTP id s30-20020a056870611e00b00187afc1ccc7mr984776oae.3.1681474747516;
        Fri, 14 Apr 2023 05:19:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870e1c300b0017e7052ed84sm1693325oab.41.2023.04.14.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/18] version-gen: remove default version
Date:   Fri, 14 Apr 2023 06:18:38 -0600
Message-Id: <20230414121841.373980-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's two use-cases:

 1) We are in a git repository

 2) We are in a dir extracted from a tarball

Is there any other case?

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 53b3d64131..2b0973f4b5 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=2.40.GIT
 
 get_version () {
 	test -f version && cat version && return
@@ -10,7 +9,5 @@ get_version () {
 
 VN=$(get_version)
 
-: "${VN:=$DEF_VER}"
-
 test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
 echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

