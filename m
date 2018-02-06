Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B2B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeBFAVW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:21:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35444 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeBFAVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:21:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so172844pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4T82Q6yxC6UKVsMBzDaKLvD1XTcSqa0VKfsAPxyZD0k=;
        b=I3aR5rihdlLVrL4iedBjAT4H+y4oKwCqyN7g+OQqhuMbQexdbmfQtBmyvdtUBDH6f7
         VxuMs4ASJg0PNF6UXPGf0/PKvDBHr3CSgNLoKS5nAF4XMOyRjL8dt+DDqaA83mA1H56N
         7W8u/UwF1friVf6b9SbktPXxXly3DgpcguAAv8K8/Wwr0fFFTKrtstksIUMrchEcXLm4
         D90h3vk5ctOkKMEUlMTTr/E6GYz4h4ExQ2VGU4vQMduCJqZ/Uuavr0bswyzsY2B0yohA
         S/x283V1vuIW0DvIdIxOP/JMy2eNv7cIckx65M4Ajyz1yqNSr/DIl6UPKc7/RaMfDlki
         eruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4T82Q6yxC6UKVsMBzDaKLvD1XTcSqa0VKfsAPxyZD0k=;
        b=PRXSJ3wQxmttiR5lNxtTyeTq5uEhvgWOLDg4mbmFRicywGW23+IZIjwokZbUQOLaQ6
         6e5VgGik4g28Bylu2OxfkG2ISIWU9wHZtoLZsvka6TuE8uQMBXqeev9WFf6FVBhPUZor
         F05JCN3EhHDzW6oCHf369ZycwaSCs2mJsw997skEM3o8ddoAjoYCQMkpZCFk+XUfIU6R
         X1itk5UhCpP6esHnHLPPna4revP8MLjQ9ZfVVGfCpJ9gJnybLql1nZuCQoKLB+s1+dws
         5IwmT4jGmkZBjGaBV3hX+m88zRRqFFwn/lx2WhoTJScD6AFRt8O2+zpP0DZBHs7MLEkD
         jSNA==
X-Gm-Message-State: APf1xPCqjk9TLVuvLBAq8ctdINZt6RDscNPdEUZfRe7dMG17gjDgUZnl
        6Tj5Tr6ZdebppGlO/tvXathqUrkaSBY=
X-Google-Smtp-Source: AH8x226ues2ab80B4w7wPg5p+mhdDDrlUlKcs/T84eN/F88U8Gblir+A62b/LsYBf+wvo6JcWWi+Jw==
X-Received: by 10.99.174.15 with SMTP id q15mr419572pgf.265.1517876480152;
        Mon, 05 Feb 2018 16:21:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n82sm20893352pfa.45.2018.02.05.16.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:21:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 120/194] streaming: allow istream_source to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:35 -0800
Message-Id: <20180206001749.218943-22-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index 5d2c24798e..cb7f8b2042 100644
--- a/streaming.c
+++ b/streaming.c
@@ -111,8 +111,8 @@ ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 	return st->vtbl->read(st, buf, sz);
 }
 
-#define istream_source(r, s, t, o) istream_source_##r(s, t, o)
-static enum input_source istream_source_the_repository(const unsigned char *sha1,
+static enum input_source istream_source(struct repository *r,
+					const unsigned char *sha1,
 					enum object_type *type,
 					struct object_info *oi)
 {
@@ -121,7 +121,7 @@ static enum input_source istream_source_the_repository(const unsigned char *sha1
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = sha1_object_info_extended(the_repository, sha1, oi, 0);
+	status = sha1_object_info_extended(r, sha1, oi, 0);
 	if (status < 0)
 		return stream_error;
 
-- 
2.15.1.433.g936d1b9894.dirty

