Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232CC2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64422078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYagHF4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgDGO23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44769 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgDGO20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id x16so2739597qts.11
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=an4v6n1HzMOUK6tSWzdiCun/05pQI8hO9zSr23BZ90E=;
        b=nYagHF4kyoCv7WvLybvW2GbZBqwf6p8FhARDo6QPa8STLqjyPraU54/PhGPIumPnSs
         lYE0d+O9ut8vzKOHuatCrr/S1ch/Cyd5LOi86ul4DG+FNoGax66jMJmkFgy+VB/KK1C2
         tWwNGiRObmql7GG36zxwfmtkwjszBplKIGfhr3iMQHPuTikLrMMZuTLHtYAizVGvL0wE
         c7IPHRBHMXQ943DAWmZyvTUQThW31RpP5IgvTXBh5pM6vEN3KZERfUWcdU7R5y2sZVIs
         maoBc/gMYleMttfQkHlwsyy1sC6kdMaZ31ST0wcBYMKXSFoxH3WGggXga2EmhVJH/1IC
         J/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=an4v6n1HzMOUK6tSWzdiCun/05pQI8hO9zSr23BZ90E=;
        b=OwW56AS1E5Nquw+pfy0/ligz8mZZzbVi5/FXpA1w0dsBpIxcRX/qMsdnMsegX3zwYl
         tUy77EqRS5IBSjKah6xHT4bdDQ5NbmcifCPG0xD5gM/HpSwExc5xNlRGUsK2nGMVnfAS
         Q+Z/BWjcZYdf+qRARCKMqoRJOsCxkOHZiuu4wRVlvq6LdzSI0OLlxp60q4g/wwkTgaUf
         a4gHCnRiQkyNgGSm+WqVxRTe97Ee36/fDen/3yrdUJ3+c2LH+nHvR0NC/X6TBh5pZinI
         Hmwa3gANRa/AkirWFawcDAbw4p26SntXxJKZ1Scx/dhHyp4ISihuAXqzeHYXVRFo9Rx3
         rTOA==
X-Gm-Message-State: AGi0PubRmPGuavUxkjHnALw9wbFNLjce9+LxT52j0Oqcna11L+Ma9u0L
        vrqsk5e+gvltvmmPWDMSwXK5bITv
X-Google-Smtp-Source: APiQypI84r3lacbIaEuSeOGuAy/OeKNVY7B8HpeFZiQjh1eL6MOTLBgrwXD8XzZfCHwuBapRBwi9aQ==
X-Received: by 2002:ac8:3f78:: with SMTP id w53mr2558363qtk.26.1586269705695;
        Tue, 07 Apr 2020 07:28:25 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:25 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 06/22] sequencer: configurably warn on non-existent files
Date:   Tue,  7 Apr 2020 10:27:53 -0400
Message-Id: <8c504427e376470fb0d939b9c9da315e7fabf36f.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on externing read_oneliner(). Future users of
read_oneliner() will want the ability to output warnings in the event
that the `path` doesn't exist. Introduce the
`READ_ONELINER_WARN_MISSING` flag which, if active, would issue a
warning when a file doesn't exist by always executing warning_errno()
in the case where strbuf_read_file() fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 6c4e8743ef..32cc289da3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -420,6 +420,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 }
 
 #define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+#define READ_ONELINER_WARN_MISSING (1 << 1)
 
 /*
  * Reads a file that was presumably written by a shell script, i.e. with an
@@ -436,7 +437,8 @@ static int read_oneliner(struct strbuf *buf,
 	int orig_len = buf->len;
 
 	if (strbuf_read_file(buf, path, 0) < 0) {
-		if (errno != ENOENT && errno != ENOTDIR)
+		if ((flags & READ_ONELINER_WARN_MISSING) ||
+		    (errno != ENOENT && errno != ENOTDIR))
 			warning_errno(_("could not read '%s'"), path);
 		return 0;
 	}
-- 
2.26.0.159.g23e2136ad0

