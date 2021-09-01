Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7752C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B364560F56
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhIACH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 22:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhIACHY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 22:07:24 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796FC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:06:28 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r6so1728351ilt.13
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OIE3VXFxWnkGYSPaughoSk1zvDBancJLezU+Bont/ks=;
        b=O5GtY+iJOpdJnk8VnHMndAB1u2l+l0zneXbfFDpBmdZ1BT4Ya8AEqByb8XJDIoMzGW
         RoXRkbOwqoyw8ZUYoWfZTogsrAJxUBGBqmSKOOtANkMKqLYQVyWgtlvwlDb+TAeLtt0V
         pf2OL3SppwmzgILfN8JgRQpqtu+PRLVXc62wSJ2YvJV0p+SqS64tkU2vFtHnwugpooqY
         /vKdMEXaC585BNZOqQYhu+mmXtPDTqIUDiWan70/dQMVHn1+ShyRD1GTf2FRGKpdcDnC
         NFyss0yUsXOlu88B0Gkw5Q2qCbbWAoJAHAXceOJxeFFu1n3DVquyak87oYH/4o87Ug8M
         u2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OIE3VXFxWnkGYSPaughoSk1zvDBancJLezU+Bont/ks=;
        b=iPGi6FtedI6j30ft59a+CDpCjry1JiqA6FWxKZM0uMXYP0ZgbuV2r4Nh4mjDI2c77D
         /p+J9FlioGhMz9ps+eTcIXk1QhoCeJ2dvEJpf8YqrVZXQYJDzHIooFd6934qiZ9lqnMm
         /jVcvbqAfgLv5GvNBbicm15cfwsJsSzf0pjmKn7x1XJMxH6W/ySGjxf7xqn/KrqUjx27
         f+e7FluTlYMkcivJTlXeG23Zz80iJFj7MXxFJY1h9zFdB9nwCEs2X53+S5m4m7/SlAlp
         ZQOyK9bJcffkh6Apgwh0AVKr7Z50rY8MfH/IYDAAt+JxRo7b07WIlZEhlHsmFMEdCIYK
         zrnw==
X-Gm-Message-State: AOAM532GhVhAtNfRG22xH+d5kf0ymUbHmMFb+8bQh6zHHi34OHe/gvw9
        Z2WPM3ksBkLaJomMJEz2kEbTM2ES6T7DuUHt
X-Google-Smtp-Source: ABdhPJwLR7BaQqZKlzDwaWbKYVBvdvtqYkaobaHiTf369zEiXnHCsapsAc2SRRmdTA7U2HcfFvAHvA==
X-Received: by 2002:a05:6e02:1a0e:: with SMTP id s14mr22098426ild.48.1630461987516;
        Tue, 31 Aug 2021 19:06:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14sm11048824ili.19.2021.08.31.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:06:27 -0700 (PDT)
Date:   Tue, 31 Aug 2021 22:06:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/2] pack-write.c: rename `.idx` file into place last
Message-ID: <ea3b1a0d8edd7b6179f305349bb316be7ff92e18.1630461918.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We treat the presence of an `.idx` file as the indicator of whether or
not it's safe to use a packfile. But `finish_tmp_packfile()` (which is
responsible for writing the pack and moving the temporary versions of
all of its auxiliary files into place) is inconsistent about the write
order.

But the `.rev` file is moved into place after the `.idx`, so it's
possible for a process to open a pack in between the two (i.e., while
the `.idx` file is in place but the `.rev` file is not) and mistakenly
fall back to generating the pack's reverse index in memory. Though racy,
this amounts to an unnecessary slow-down at worst, and doesn't affect
the correctness of the resulting reverse index.

Close this race by moving the .rev file into place before moving the
.idx file into place.

While we're here, only call strbuf_setlen() if we actually modified the
buffer by bringing it inside of the same if-statement that calls
rename().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
The diff is a little inscrutable here, since it shows the .idx hunk
moving below the .rev hunk (instead of the .rev hunk moving above the
.idx one), but the end-result is the same.

 pack-write.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index f1fc3ecafa..277c60165e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -490,18 +490,18 @@ void finish_tmp_packfile(struct strbuf *name_buffer,

 	strbuf_setlen(name_buffer, basename_len);

-	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
-	if (rename(idx_tmp_name, name_buffer->buf))
-		die_errno("unable to rename temporary index file");
-
-	strbuf_setlen(name_buffer, basename_len);
-
 	if (rev_tmp_name) {
 		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
 		if (rename(rev_tmp_name, name_buffer->buf))
 			die_errno("unable to rename temporary reverse-index file");
+
+		strbuf_setlen(name_buffer, basename_len);
 	}

+	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
+	if (rename(idx_tmp_name, name_buffer->buf))
+		die_errno("unable to rename temporary index file");
+
 	strbuf_setlen(name_buffer, basename_len);

 	free((void *)idx_tmp_name);
--
2.33.0.96.g73915697e6

