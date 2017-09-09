Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA9620286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757373AbdIIG5u (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:57:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35661 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757364AbdIIG5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 02:57:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so3023881wmi.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2017 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWuaAHMjMeSuftEwyxNvFW1ZqHxztMwwt1l8yOSqHLM=;
        b=qgp+/DCk87urB6JT53d0ZxrCKpXXf8HbIsrG9bKEHkYG6hdWoPm1aM8WnLr4xKfEPH
         qcaaoefqnRpb8uWviykIt7Hge3516eAA5DPHBihQ8fgBISynNHYgAR9JoUMLss4mit8Q
         XF104oG5msaYt2RFa0O2icDXBo30ZvjFFYrmDG0ndiQy0OuEbeA4+nWgH63kxpNXdG/m
         JpKwIYaQWIcVpTPa1TDjGQuwRUGIMIBAuy0E7ySZ/ye8H09Q/OVtczThRnCtCj483Cbc
         /oIjJhMdg25dg4qsYmRgo8XdmgSpeOmzeYENB8cMWrOWEZwymgHM7ctT0r7my7na3OXw
         ys+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWuaAHMjMeSuftEwyxNvFW1ZqHxztMwwt1l8yOSqHLM=;
        b=A0z8UHkAfo8Ko5AjxckW7Hoz9ctea7ET1YyiTaK48yRu7eRGA2xh2JxKNx9vsNUM0X
         2/gDhGBFnL6I6n9ZyuEyP3RB0shBBEKnSXnZho1yiJM5dvdxnDBkVrtKGJwbzaeNOBxa
         Gc+FMFb3VjqZRX+r64v2h5VMAVUY0BgfjL4gcQKBCH3jxO9XDKToIPS+vUqcKG5m04dQ
         WkfP4S8vLsv4MwlsyK37M/mwE5lg1cgwrBM6qzoZCWOgvF29BWgIHl4NZSzQVzIwEnHH
         1oYq7nTcX0qKxBvyRR389W8Bob/++BYwSMEJDd4mozWAOp9SEjrwj5lOAjcY83BwMBz3
         2Xig==
X-Gm-Message-State: AHPjjUiVZqVGL4mOrTd+IxrIB52KTxfDxyr6Zm4sqZGB7mfWhRJjy8r8
        d7M5iBhx7yrpIHij
X-Google-Smtp-Source: AOwi7QA/Rj8+w+qYfyn1s68qhC3/gHA8w8CLxCp1IsFGxcHBJl4e0ia3UW5+cv10g104JkVZ/9B6+Q==
X-Received: by 10.28.221.7 with SMTP id u7mr3136166wmg.50.1504940268424;
        Fri, 08 Sep 2017 23:57:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id v82sm4269403wmd.44.2017.09.08.23.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Sep 2017 23:57:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 3/4] refs/files-backend: correct return value in lock_ref_for_update
Date:   Sat,  9 Sep 2017 08:57:17 +0200
Message-Id: <3b2adfcb53d1564f7e794ec5cfbbb93c37c9f3a5.1504939825.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.460.g848a19d64
In-Reply-To: <cover.1504939825.git.martin.agren@gmail.com>
References: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com> <cover.1504939825.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one code path we return a literal -1 and not a symbolic constant. The
value -1 would be interpreted as TRANSACTION_NAME_CONFLICT, which is
wrong. Use TRANSACTION_GENERIC_ERROR instead (that is the only other
return value we have to choose from).

Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3d6363966..03df00275 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2801,7 +2801,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
 						    original_update_refname(update));
-					ret = -1;
+					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
 			} else if (check_old_oid(update, &lock->old_oid, err)) {
-- 
2.14.1.460.g848a19d64

