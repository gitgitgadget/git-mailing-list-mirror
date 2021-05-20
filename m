Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A4C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8D260C41
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhETM1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhETM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E1C0AF7BE
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so24605453ejo.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXLTONZHnk/yMVPW/t0IVE7KOVDiMC9YyS7bMLZRtcM=;
        b=dn3ypN1I+JjmZ8qkrpiYUmpgBV10uYZFlNYK6cWH7OWFLQBOd/vPOwY0GSEFiFgO54
         U7evNfTncxJ8Nk2cGKha97XkGnpODYvB46gp6V8MHtqJoFpnbG1YrgfEDc3Fms2LRyh+
         rpTVbpS26SkXEq/49OMklCTBLXswLdCEou2ruDgcDLUbvyC6IY7HFItmtI4hS7HsEEXG
         jYvljwV63g7pfiS6TnQqcXbIq9Tmp+qLB3yq27TdDSOupPXyOhR9sBcDfXj5jHr4WfH9
         tqUbpXCviJzrLqRDTKLoTwR3xLOO4AePYdfC6+qfrRrJN80VBjFaojGVNH71IjuDJtRl
         GTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXLTONZHnk/yMVPW/t0IVE7KOVDiMC9YyS7bMLZRtcM=;
        b=jwqw8huxkth+QE/5usxwkUiU+G55UQquipU6CqYGU6oqvZCVUQWzRN9tgzojfL6bJ3
         EvG/OHc2ulC3e455gGHt38kn3YEAXX6VMBBdLvhVnkcOr720pv0ogJ0rsVw8+w/K7Kpi
         seQI1M7pi12+vKJ6Ksd9xTnRfXHsFy0upMC/0o+bPsAbPUHGoynv88Ugcz846XhvvQTi
         W6/Vo+LoAE2wMxADzMMZz+/oWhINXGB08FZxj73N77hRfDAVYIz03DRnRZCJSTvUodzi
         oDIlUGFU9dJbCe5jbOc6mFsXI5dfbEufOG42w9Gi0k3x7ij/7iMB14OF8OHuMohQ3nHf
         X9eQ==
X-Gm-Message-State: AOAM533iuENsWR7+1P6x6ENasP73cZ9GgFwtDF4eM9M5HtGrpPyZ6ngb
        OtH5YNFlzc9iZ/kLcwfcCM8llOEViUt+0g==
X-Google-Smtp-Source: ABdhPJw7NKT0qlqio7g1HlZPLztvA3nnWsl5IwiZ6lUfEIMFYSAK8oiCFXKCmYtH8WwzffRDr0+9UQ==
X-Received: by 2002:a17:907:a06e:: with SMTP id ia14mr4302707ejc.17.1621509805648;
        Thu, 20 May 2021 04:23:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/17] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Thu, 20 May 2021 13:23:07 +0200
Message-Id: <patch-13.17-d22d5b8b85-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return a -1 when git_inflate() fails instead of whatever Z_* status
we'd get from zlib.c. This makes no difference to any error we report,
but makes it more obvious that we don't care about the specific zlib
error codes here.

See d21f8426907 (unpack_sha1_header(): detect malformed object header,
2016-09-25) for the commit that added the "return status" code. As far
as I can tell there was never a real reason (e.g. different reporting)
for carrying down the "status" as opposed to "-1".

At the time that d21f8426907 was written there was a corresponding
"ret < Z_OK" check right after the unpack_sha1_header() call (the
"unpack_sha1_header()" function was later rename to our current
"unpack_loose_header()").

However, that check was removed in c84a1f3ed4d (sha1_file: refactor
read_object, 2017-06-21) without changing the corresponding return
code.

So let's do the minor cleanup of also changing this function to return
a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 7623ada1aa..0de699de98 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1229,7 +1229,7 @@ int unpack_loose_header(git_zstream *stream,
 	status = git_inflate(stream, 0);
 	obj_read_lock();
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
-- 
2.32.0.rc0.406.g73369325f8d

