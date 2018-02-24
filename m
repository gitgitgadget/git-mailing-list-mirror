Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A181F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeBXAtK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:49:10 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41725 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeBXAsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:16 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8so5843214pli.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WPjkRR1cWz4p4jQhVTQgv5atOhcp1ASzQIP7I+rJzdA=;
        b=On3vMROUDB0SVDGHhv42/U9u0oggrdWK9hfiSpqViRBc7yvtCT5hSRuQBTITK+Ce3C
         XyyK4x6DZxyYmQ8fKh46xNlM3WaT2DeI//4eRi6Z/UKmqt9kxuMKbSfdA/HiV7f5+QiE
         m6O99VhYMJbDKvQzhIQ9W/2/M5vxzMdj1lkbskLSz92597i/3ZHEcbA+I8h7SK1+09zw
         RvWtK+XLeDwLkMJ1I1diaPyLpOPp79kwp0oU2SrxnH/Y4IzCdCk5Favdh15mSJB779Tb
         QolKA6HOKHOT2VscgyFGjvEHFTyPQdrdcD2GgJTn0Mo+721OfMnJ3OJen2VvmzimNSlK
         0zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WPjkRR1cWz4p4jQhVTQgv5atOhcp1ASzQIP7I+rJzdA=;
        b=Frtd5oqaATTxqt0vqvUKWhMDp5piPQPZZD5v5WD+a+5TwDAUqWbC5jKStbXo9wfZSS
         V9dWSzM1yIlZfedVlp9FcHWvI52tWRh/3+UZFxuGeZvC/daWLzqu1WNmdjdQgzhajOaQ
         w1KXADdJrl9pYy+/5ywCe9+mKu6hcu530WsWUqCZnpNXk1xDTJjNvReMJU20C4BDMdS1
         0BIozDP6c/oMJ0yfnMcI0/5smAKiUOuJj428uDZCD2dNwv7WwsF8gRYD26/H1aadyVm0
         NZCf7TNQS0iXlOkptT0IIpjtL0IBlkwi/NcuBhhO7emvklVDQM+g+84M1N4I+XoHEDaE
         K5gw==
X-Gm-Message-State: APf1xPCdUfTi67Vfx69OJzntL3JbH6KugFrkpkUUkuLAxnURuU9CFPHk
        ZCeuJid6+PTuqIuCVUz9WCkDPw2mkfQ=
X-Google-Smtp-Source: AH8x227JORq3Ra5nVaeuejHsq/m2XL3D7HOoXgkjvOAVjbC35ZTSRpcHY4j95EMCkp/E0pAcsP9bgw==
X-Received: by 2002:a17:902:6c41:: with SMTP id h1-v6mr3291176pln.25.1519433295501;
        Fri, 23 Feb 2018 16:48:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r70sm6045504pfk.177.2018.02.23.16.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 12/27] sha1_file: add repository argument to link_alt_odb_entries
Date:   Fri, 23 Feb 2018 16:47:39 -0800
Message-Id: <20180224004754.129721-13-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f93d3b95b54..8fb56ca0362 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -465,8 +465,12 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int sep,
-				 const char *relative_base, int depth)
+#define link_alt_odb_entries(r, a, s, rb, d) \
+	link_alt_odb_entries_##r(a, s, rb, d)
+static void link_alt_odb_entries_the_repository(const char *alt,
+						int sep,
+						const char *relative_base,
+						int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -509,7 +513,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -563,7 +567,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -576,7 +581,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -679,7 +685,8 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository, alt,
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
 }
-- 
2.16.1.291.g4437f3f132-goog

