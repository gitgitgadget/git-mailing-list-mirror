Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A17C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDJWxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:28 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2E1BF7
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54bfa5e698eso279789707b3.13
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167207; x=1683759207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYYglhFGC6dAPiBth3kdOOoXPhN+QeLt6UuSgkb6z+A=;
        b=rgNCw+gLdTpHnf+uPfqGwxpZUr6N2V9RYWXW6i41kbRQ/dWNs8uBlPPttSJsfj4XXn
         uXXywTRlpf3eN9UNxuJtrS7BbmXLQrQ5NXOOGzrz8Um7cgwJcGTViB5TsZqyShweU/Xl
         X5aQJJ6PggLoRX6bfgFTc/VLWcLzmSX0da9hSFS0Cc9do/UMNKYQwRod8slEchtXdHsA
         pw7hwFAYQWjv0eQ+jFAm1H2s2I76id5V8KQtUnXk5I6oG7XVe2anKpFbEC5i+/nUWX4r
         8VXi2k0I2014NmTrLQAQkzRO0VyrTvnt2oIKLKWBD38Di0eamFgazOHTVmvs/+ueqEtu
         /mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167207; x=1683759207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYYglhFGC6dAPiBth3kdOOoXPhN+QeLt6UuSgkb6z+A=;
        b=vQE5IuEo+C++LbOReOzd/GeY13x4lytdudXKwR2Z9idmM/EURgvoND9u+gTBQcBi83
         0XYDFIAPRy0uuUo9SpUd/Kcf5dny8ts5e04Gzv4Cap3zTTYg5kXrxWonmLXyP5iVTpPC
         /kcrXnrP0NZyZNaC15dJwFmK/fg1WC9IiJyzXKEeIMON/eeM8D3LNq3hDOd6c4HClheo
         04LYdWPfBa6aOrNSj6ljGTbm9oCw+Ena305Fj0hAY17Bf1yxi0bnEDRmnrrTySu1/KQl
         Pp/hJH2MnD4zcNoWYe5F/fhQPw5CQeYqkDWcEXpJ0DU5/q0IRT6CUJj05BtPpMq+L3RE
         XYZw==
X-Gm-Message-State: AAQBX9e+Wc2aQsZuxS6LBizd4jbHcL0YuXdYmtQ0d24V/GHeFdYnBaXf
        UnT8BM5O9zSpkv/XufcMHWvSvF1KYbEcmYSvUCZkDg==
X-Google-Smtp-Source: AKy350YCGkEg3d75yJQU/luKLjMYItFFL/YlDwEVCn65HQHV7vBXgax8/Q8E2ehxnjB/wP34Crz5Qw==
X-Received: by 2002:a81:84d5:0:b0:541:6b00:f68d with SMTP id u204-20020a8184d5000000b005416b00f68dmr10046356ywf.16.1681167207142;
        Mon, 10 Apr 2023 15:53:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z18-20020a81ac52000000b00545a0818474sm3125767ywj.4.2023.04.10.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:26 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <18be29c3988295cd58521f8cc4a729897df074c8.1681166596.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `stage_tmp_packfiles()` generates a filename to use for
staging the contents of what will become the pack's ".rev" file.

The name is generated in `write_rev_file_order()` (via its caller
`write_rev_file()`) in a string buffer, and the result is returned back
to `stage_tmp_packfiles()` which uses it to rename the temporary file
into place via `rename_tmp_packfiles()`.

That name is not visible outside of `stage_tmp_packfiles()`, so it can
(and should) be `free()`'d at the end of that function. We can't free it
in `rename_tmp_packfile()` since not all of its `source` arguments are
unreachable after calling it.

Instead, simply free() `rev_tmp_name` at the end of
`stage_tmp_packfiles()`.

(Note that the same leak exists for `mtimes_tmp_name`, but we do not
address it in this commit).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index f171405495..f27c1f7f28 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -568,6 +568,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
 	if (mtimes_tmp_name)
 		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
+
+	free((char *)rev_tmp_name);
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
-- 
2.40.0.323.g9c80379958

