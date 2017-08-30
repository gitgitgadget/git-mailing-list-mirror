Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8D6208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdH3G5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:57:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33982 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdH3G5V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:57:21 -0400
Received: by mail-pg0-f65.google.com with SMTP id 63so4470406pgc.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFT1J/TnbfAMYVsITKbtFpLr6giGUWZZZ4Zjqke3wPM=;
        b=L9ua8pGyAniF7UBGcGPeQN4lL7sD3NrzczqHFRB9qIL9bkUUXRKmSj2mMoRgLVMD+m
         Yhl3fyUdIBvk9lxFQKncr/QU3olEyI7dic+khhhIAUnBnt0L/Ry5i6WSJIU9zcku3lWh
         u/BtA7zkgF/75/j+pikCin1s6XUjqQr1nNfdyfthBFrGpa7lT3t5lk7MyOmiUr2FRhV4
         rYrJpeDlDBZMt8fPcIaPFe5cRetgc4DEjfN7Kb0XEZfzMaWi+kHBD/KhF/G0H/7oK4uZ
         9GeLk8PIl3jMN+6i4t94jClsTT7TIeTz+SXMmU5W05ATkzoJWdV1T12OEHaOCMAHhct2
         YssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFT1J/TnbfAMYVsITKbtFpLr6giGUWZZZ4Zjqke3wPM=;
        b=pVpocx45iOGhyZZZ4Wla4Vow0/OtjFi9T2EksZfzOCXIWELO06KWaYQcFRYrTmLW/e
         N29ZnYdJh/s945H5fXKji7Kd6TDBs9MtmDa0UPa/cd20L8sA1Xi3Uyf4buWDOfk3tE16
         6pPvSnLxu7iYodDOEzgWpTeMldi02kYWTJhMKFYpaKFSEA9Y9gCenwwusjeAuKxaSqDy
         xHco9iaMvrBDAIQlx5pW3do8Zi6yswd9qSK9zuagSI33GYnzutPF2NZhjGIMyy5yrqTG
         VoaoVrHvnHNumaUIXhfx/SoQPXh6JYhajQCIaSZIaWdww+urTavnyZoY8cRaMzucW6/c
         Xo1A==
X-Gm-Message-State: AHYfb5hiuMdqCDRjvEuHYNWcpDYl8U8kmZY4stWNrQMl4Fa0HuOM6uDG
        UdxjFH+g1/JRZmXXLu4=
X-Received: by 10.84.210.143 with SMTP id a15mr778170pli.20.1504076240261;
        Tue, 29 Aug 2017 23:57:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id u21sm9045205pfg.121.2017.08.29.23.57.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:57:19 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:57:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 08/39] sha1_file: add repository argument to
 link_alt_odb_entry
Message-ID: <20170830065717.GI153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the link_alt_odb_entry caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commit, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1c757b44a3..c63b52f6fa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -324,8 +324,9 @@ static int alt_odb_usable_the_repository(struct strbuf *path,
  * terminating NUL.
  */
 static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
+static int link_alt_odb_entry_the_repository(const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -419,7 +420,8 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(the_repository, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
-- 
2.14.1.581.gf28d330327

