Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF4C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952DD214D8
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdlfY42W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDSMcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSMcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:32:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC1C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id f8so5561698lfe.12
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1GthsNFcUQAh9GinZ0S+m53EiMiD0AXcDg2WTyM0gs=;
        b=TdlfY42WnUPyhG4PnpgdDwFYbxwS19LAjDVHKxBZOBZ3H+BsjM1kRMaf5ERoQ11cc5
         O7rrxQbGvH4SsJsX8MX92X2u/RcFdVygw2Mo5y7FEldy9tNYvFv8tRlniuAAHGQWpD1/
         0VLgjZSpR7n+bdKdlGNeag5GsbT9NuIeyXhEmjTiTjQVQkuOoe+3xnWntZ5vuA2Clzcx
         aPUxaPIyJVmqns9HqP6wUTiG8CsfPuLBsmI9YpfsxEftxxTHVeiWKSlQfaoKejxPY9z+
         DmD+voMR0vUjDTIX0avJRU2O9q7Zkw5b4ipCBbYCNLOw+JOZyedpNEkBusJ1D1PQPTpR
         w4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1GthsNFcUQAh9GinZ0S+m53EiMiD0AXcDg2WTyM0gs=;
        b=tiaJVPVuTuOGFeD/W4oEm9xxSCRfzkiPqNcQCzHdP3ickWEcw7f8P3EMZaT6J/fkol
         RPP6FGsFRNHy64NJCTY/PbepCBBtOPYWCYBd6gzIwNwbGM5ovEblTFWw7FwVZs8p29wd
         RcYmr6YSaPm3Q1H4MV0LH6ddTygwIsI2c74JvpThNpp3uTG+G8fc13wdRRDuB4D8kWIO
         4WeoAIuJP3qj1VZK/7xiMNdHUs79lmORWIj1Ref5WCeEldYmmDyxDXwhfXxTQuls6dk1
         cus4kyklEpVTxn3bA549Pl/V/hHwoGP0B6hO893b+oE2psQJQaSt/MS+s8rjNwY5dqMn
         MkPQ==
X-Gm-Message-State: AGi0PuZrdJ8G91eRBzMz+FNMgNHhOAuTybnFyvJVxKPNrTunrms6XBEz
        eP1g7yIJ8gxURXSLhhVhrhau4REd
X-Google-Smtp-Source: APiQypIzryxxtS8MIKJo5G84ASuw0mlZgDISlDi3B0YLDDgZENa8FMgrz23SO+7qGRiCZxvXC+jhBg==
X-Received: by 2002:ac2:51c9:: with SMTP id u9mr7766086lfm.184.1587299569917;
        Sun, 19 Apr 2020 05:32:49 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm1843547ljj.72.2020.04.19.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:32:49 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/4] strbuf: fix doc for `strbuf_attach()`
Date:   Sun, 19 Apr 2020 14:32:27 +0200
Message-Id: <54e10bb06a39d23591ea4d02665083d705682468.1587297254.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587297254.git.martin.agren@gmail.com>
References: <cover.1587240635.git.martin.agren@gmail.com> <cover.1587297254.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 917c9a7133 ("New strbuf APIs: splice and attach.", 2007-09-15)
added `strbuf_attach()`. In the commit message, it is explicitly
discussed how using `mem == len` is ok, although possibly costly. When
this function was documented in dd613e6b87 ("Strbuf documentation:
document most functions", 2008-06-04), this distinction was missed and
the documentation simply forbids this case.

The function handles reallocation and truncation, yet the docs say that
the "amount [of allocated memory] must be larger than the string length,
because the string you pass is supposed to be a NUL-terminated string".

Several callers pass in `mem == len` meaning they are compatible with
the implementation and the original commit message, but not with the
documented behavior. In fact, compared to the documentation, they look
outright dangerous.

Later commits will convert most of those call sites to use new, simpler
interfaces, but in at least one instance we really do want to use this
possibility of passing the same value twice: In rerere.c, it is not safe
to pass in "len, len + 1". Doing so makes `strbuf_attach()` write a
trailing NUL at `result.ptr[len]` and running our test suite with
AddressSanitizer will spot an out-of-bounds write due to this.

That is, rerere.c really has use for the flexibility that `mem == len`
gives us. Let's update the documentation to clarify that this is ok.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 strbuf.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index ce8e49c0b2..2a462f70cc 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -112,10 +112,12 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz);
 /**
  * Attach a string to a buffer. You should specify the string to attach,
  * the current length of the string and the amount of allocated memory.
- * The amount must be larger than the string length, because the string you
- * pass is supposed to be a NUL-terminated string.  This string _must_ be
- * malloc()ed, and after attaching, the pointer cannot be relied upon
- * anymore, and neither be free()d directly.
+ * The amount must be at least as large as the string length. If the two
+ * lengths are equal, reallocation will be handled as appropriate and in
+ * any case, the string will be NUL-truncated as implied by `len`.
+ *
+ * This string _must_ be malloc()ed, and after attaching, the pointer
+ * cannot be relied upon anymore, and neither be free()d directly.
  */
 void strbuf_attach(struct strbuf *sb, void *str, size_t len, size_t mem);
 
-- 
2.26.1

