Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130141F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeDFXWB (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40261 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeDFXVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:55 -0400
Received: by mail-pl0-f68.google.com with SMTP id x4-v6so1524625pln.7
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9TLeusPxioiUp1b5S8dL0ndR5klO8A2iNvUDGjD/Rk=;
        b=kG5VR2yluDh2jBp2gBZXWayQtujMuDKnyq4syfNFmw9Y40YmYmooblIL0Ke4M3AGfk
         8cD5c2czMhk5+z4Oaz/Nd/jst12bFgguHYo1Afpz2+wUYdMezhS1TOVFwKZ87xXjcOx7
         1XCaZr/sTi8cdxeRlIMcKF25AlIn+8uZ7K95OQTZOcEBEPZ2/BF3PtgtGtVeSS98Q8oL
         UQYxOr+OMjDzDSxbrLeFyeQd6C27Ca/glnYr+IrUOZXilnusjKw6pL7ldo9r2+oLlN11
         ezQcDkkptvFJvsC6AnZMj226QU/Q2oRNo2V62ldVzYQtGe91s/46AL0ovXDJ7kPBUQ0/
         P4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9TLeusPxioiUp1b5S8dL0ndR5klO8A2iNvUDGjD/Rk=;
        b=a3BLIGF6zrECu54Xy/4ByR5EbnbPKyOi7KLlFZ1uTNWuj9xGg++zIfsSZScXW/ukOe
         ywe1EKvaLDv7YDj/7HsFVEnN/QVPphXlRVfA8puOCZ0OD91AiqtztiV/L9oBW+ktn5d4
         J9HFirHXVrcTdpJHQl0r030CtcNRvFz8iWOj/JKpS05aKx/9fwrMP/DmclFKe/a5u6J7
         SmWLISUxhQl5zQdlaEecNzz9zOYhes3t+/kSjbbnlmGWxEuI7N7RO4l2ICC4u+E+2BOm
         38gvJb3jl1aRoEhNJAiWk8F9SAPjEiBH2fvcwOEyOx34tMl88Aoj149cfkt0Kg7AGnUb
         0J7Q==
X-Gm-Message-State: AElRT7FGplYNCPlrTzlpT7XOdHCQyGC17kTg+mlyOjQV1soEpDO3exVj
        8G9TqOhXoXtgENhqj2N51Tsopw==
X-Google-Smtp-Source: AIpwx495h+TJeqZ2MApxqf0RNQttkMCrWIjVto4Mbzy1anSegh7SzlegKwdwv3Sdu2eyjkymYhllww==
X-Received: by 2002:a17:902:968a:: with SMTP id n10-v6mr28651709plp.362.1523056915162;
        Fri, 06 Apr 2018 16:21:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f64sm21222252pfa.154.2018.04.06.16.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/19] replace-object: move replace objects prepared flag to object store
Date:   Fri,  6 Apr 2018 16:21:21 -0700
Message-Id: <20180406232136.253950-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another global variable on the way.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h   | 2 ++
 replace-object.c | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index da639b3184..be90c02db6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -105,6 +105,8 @@ struct raw_object_store {
 		struct replace_object **items;
 
 		int alloc, nr;
+
+		unsigned prepared : 1;
 	} replacements;
 
 	/*
diff --git a/replace-object.c b/replace-object.c
index a7eb31026e..603d11e931 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -73,13 +73,11 @@ static int register_replace_ref(const char *refname,
 
 static void prepare_replace_object(void)
 {
-	static int replace_object_prepared;
-
-	if (replace_object_prepared)
+	if (the_repository->objects->replacements.prepared)
 		return;
 
 	for_each_replace_ref(register_replace_ref, NULL);
-	replace_object_prepared = 1;
+	the_repository->objects->replacements.prepared = 1;
 	if (!the_repository->objects->replacements.nr)
 		check_replace_refs = 0;
 }
-- 
2.17.0.484.g0c8726318c-goog

