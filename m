Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C4D1F464
	for <e@80x24.org>; Wed, 18 Sep 2019 01:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfIRB4v (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 21:56:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42538 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfIRB4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 21:56:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so6932024qto.9
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 18:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gl2RcPJvaGIwAn5hVCLZ0x+U2hc4Ggb6qS55Xh04DZY=;
        b=oRoDImZJKBHkSer0DBEhvm+DosdfNmad25FoqMA7H/LifePCldaLl1bHtsKqSKgGqO
         Ct1yXJLr+7KNJvjgNxu8sWVwfoaMHZB5nbmPJyF9LM5hBXvcdf7SGPNy0Etc0cM0eINm
         J1DNtP4y0qitP91SJ72Y4jf9WqDsCh2YAu+gOKXxy/UAWxt0fzkB0S72vLD1g7MKJySL
         ruYfu3P90jDRbOApkhd0c/W1BVirULx0Px/WbxOeLBSgco2WjoqE/bC1y7F5WxKP1eJb
         iJqT8Zni93qqaLqDyKSojx7RdNItwB5VkDZETHVXmt7cZXEerB3KNjLxN3xpx9BZepKh
         bZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gl2RcPJvaGIwAn5hVCLZ0x+U2hc4Ggb6qS55Xh04DZY=;
        b=TcAYuYRHXLszPOIwEl1wWMXzK4FzUeSvhFtntOLGltl1gS+tTwIF6iGvdHOIRc9F0/
         uAl8VwxJgpnPLxMLidFcosRVEDJop6YH9WudImtWE8AUhChwZGCSZ+hE+c/UgSZ1ci+G
         Y+YS+pixHGR2s9359Dw7beCOcIzbiPvjBUvlamkmk4zQgpCzEa6N160cuxiOun8WKw+B
         oZn8oYF/bkZdWflcWgHIMczgP0iGWSpRR+0Q7TVqSefdV5Ki9H0yB1ZxrrCamd/Fq7l9
         z0LldFbNQzUSCJWol8YeAWY1uKSvW63VFzXDuLQJGKUvbvYeo4YM0Lg2MQ6qpK1ttZgC
         +XbQ==
X-Gm-Message-State: APjAAAUPOY2xWXVuKdwjEqqU9rUi4rUi+IURK6TnEqbF1Q412Tyyebs0
        FxbUb1h0Kkp1y2wqXedVM/zWID22RDQ=
X-Google-Smtp-Source: APXvYqxBqNL2ZHKQY/DY9S2to8izj6BJdyN0TmtwHlfa7T2VbNSvC+FzEOwfRjh/eiNVkICIgRCnKQ==
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr401905qvr.159.1568771809448;
        Tue, 17 Sep 2019 18:56:49 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j17sm2156371qki.99.2019.09.17.18.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 18:56:49 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Subject: [RFC PATCH 1/3] diff: use the given repo at diff_populate_filespec()
Date:   Tue, 17 Sep 2019 22:56:03 -0300
Message-Id: <cac0c5a8979d45225436f310660f6fcf4d0bd7e7.1568771073.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568771073.git.matheus.bernardino@usp.br>
References: <cover.1568771073.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff_populate_filespec() accepts an struct repository "r" as parameter
but implicitly uses the_repository when calling read_object_file(). To
be more consistent, replace this call with
repo_read_object_file(r, ...).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 663b5d01f8..c743e4ce50 100644
--- a/diff.c
+++ b/diff.c
@@ -4044,7 +4044,7 @@ int diff_populate_filespec(struct repository *r,
 				return 0;
 			}
 		}
-		s->data = read_object_file(&s->oid, &type, &s->size);
+		s->data = repo_read_object_file(r, &s->oid, &type, &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
 		s->should_free = 1;
-- 
2.23.0

