Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6852220899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbdHWMhh (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37430 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id r62so1344977pfj.4
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgclZfwnfzQ+pPdF3IxrlAbzqNwt+g1EEvxZLqvXu78=;
        b=oTc0Kon7kz9vFsNj25X4HOaD1aIDM8tIP5F3LpveiTCfiQDI1SiBcRrcpiiN79rx9U
         e3Js4/038PqslDiD3DV3R0moeGkEXnFj8XIs9snX8PJXUACsNed4UhpbogFbCywzWy93
         XJ9o2AZGd+x7/Ged7wKhSCvKzw+43HiHTj7CCt0xC1hiY5hNuRf9qtJ08jOt1XoJgp20
         HXJZZUKUExG4hNWRaeiz6VwaGeUnkfSH9B4AR7KeeT97d3yQ6gzYJ1843ESnBOXYne2K
         aSm+prpDVHYkZKsWi8kozEOl386CFNueMezhRt6XOaECCLMxepoCILUUJOxuGrXJIFWx
         TOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgclZfwnfzQ+pPdF3IxrlAbzqNwt+g1EEvxZLqvXu78=;
        b=uTF37hXzReCwVKAJlZ/e70rJPaQoYBjwRq0l9gtuhWziffEKksew2KKM12eE6aVE8a
         r/0NjYsbOjbjQZ8W9gNzOSyEFAVji0daYd+kZriL7qGTkcvDUG6LxXIJz0u25104Gi0y
         7mmfwl1+nsy7NvWQogqo1pON+rB800w712VGchB6M4KqJp20nLmoovQs3s4cVROE3B7G
         4gnuxVRHz8EpeUv6I73w0kBzCnOz/bL9grY8y+wZt1hOpjlx1LL3Moo9+PB6ZGYK71ja
         VYjQQPQntCu3reLKakA7Nf1Vxyq1ZlME51ejcNirhUquZiY9poJkJZrVHJHHdvt2rDXZ
         6Hnw==
X-Gm-Message-State: AHYfb5jKHH6oyqzmqF6w7jCjrF14Aa8vrwqXDPd4EsBl6Wpo8UhKmJBW
        MDNcz5YyJhcGmEjI
X-Received: by 10.84.224.142 with SMTP id s14mr2835055plj.189.1503491855126;
        Wed, 23 Aug 2017 05:37:35 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id x124sm3082977pfx.65.2017.08.23.05.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 02/16] refs.c: use is_dir_sep() in resolve_gitlink_ref()
Date:   Wed, 23 Aug 2017 19:36:50 +0700
Message-Id: <20170823123704.16518-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "submodule" argument in this function is a path, which can have
either '/' or '\\' as a separator. Use is_dir_sep() to support both.

Noticed-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3d549a8970..dec899a57a 100644
--- a/refs.c
+++ b/refs.c
@@ -1507,7 +1507,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	struct ref_store *refs;
 	int flags;
 
-	while (len && submodule[len - 1] == '/')
+	while (len && is_dir_sep(submodule[len - 1]))
 		len--;
 
 	if (!len)
-- 
2.11.0.157.gd943d85

