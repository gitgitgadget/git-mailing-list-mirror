Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710FCC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AB7610C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352991AbhJAJTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbhJAJSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999BC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so10711252wmc.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LtpOaAYEhc9+JHygSA2ZAw6tjmkIcZsS5TdyGk2V58=;
        b=fd09JrXtESqwAZujT5B/cSXLyzqldRubZYrXqkVEOwmXJ4QCelUulxNAKlUpvBHI0W
         1OLdMfpFE51lYWbMhinKVtd08oC98Y2nZyS8Wpjry07xt3kPOJ+5Vh9FTPku24FRkljC
         fKmk8nBi76clhLMFWeee/A8p3QNQOp0pVn6DwX/fzMW+V9lc1ItdKIs0GcQs50TQXP5S
         ImaYAqpkj4oQntmEBV6PKYBbMXrVTEkgF+cQ4/cK7HHe2Uu6IUJ6oVKA6A82zTxzA+9M
         ZHyoF5RuXDmPw7KINTOoof0suEILCV/Kd8PwxEjylB1y4Ep/FUp25/XOno73P48ZjNZL
         rliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LtpOaAYEhc9+JHygSA2ZAw6tjmkIcZsS5TdyGk2V58=;
        b=HEV747uelj64bwirB8IsQx3BJjOJyvuwWVmxZgfFCLv3oZlvCxPiOLAD9jqzZtnd8e
         PY3wSW+ShF38c3A54wqJ6gEnd+R0lOEqW02DrTCPMEK+NTaGhnbJDQlb3dXtMzQvHAuQ
         kbzlTrz6oxefNab/Q/Vk1T9RuUXU/YoY3bh7dKWFiNnHcmDwd3x0h7NQ4kyer/ZIVaH8
         wOvx8BRKzC+yU7vNgYhNU5AGrPPetS6fMTB6cwoQ5hcFaQ9JPs9lDgadJrwQPIWO0jvp
         V2F/HPmlIu071cj/W9LVUPcDIZPDcHfVSQYnHAbH64It0uVVUe2WAkVEh4GPM+mKK7lL
         t9uw==
X-Gm-Message-State: AOAM530LyYj3F9Ban0/LhiScpioXIbpM9KLOImC+G3707n7Gj1xMsYcS
        RnfDZDxBarIsSlyD5qrZtfJFsJ2DizH+Bg==
X-Google-Smtp-Source: ABdhPJxFwwE9/ZUxJ1r/D5UJX1KeEGg8zAC8i71LMEfczpQ4eofkfu7z2+psghqjO21WS04CLVNpqw==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr3242396wmq.151.1633079826748;
        Fri, 01 Oct 2021 02:17:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 10/17] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Fri,  1 Oct 2021 11:16:46 +0200
Message-Id: <patch-v10-10.17-51eaa2e8479-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
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
index 766ba88b851..8475b128944 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1284,7 +1284,7 @@ int unpack_loose_header(git_zstream *stream,
 					       buffer, bufsiz);
 
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/* Make sure we have the terminating NUL */
 	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-- 
2.33.0.1375.g5eed55aa1b5

