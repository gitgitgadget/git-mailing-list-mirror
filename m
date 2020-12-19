Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC9C0018C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3358123A23
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgLSOHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLSOHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:07:11 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5264CC061257
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:31 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s2so6249614oij.2
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHCeU0sLDu3EzAmS761szeotYetdErsVQCIBuHJfbpk=;
        b=huP4ZqOVUSFbmuhMOW50cFN3XPzhu9rBVlhTM9a/kNiC4zdQyatPuoGDSJG9LWSu66
         2ZFfQHEfXNTaZTs5SIQ1fFoGG+wmUTXTVQmVvpUn+GS2JVURMoFV+4iNajNGoY9QT03n
         PlSUjKSrW4u6TKihN6Nl+/2rBdAJ78z9hjFY8knvlHVVHmS4tOwCgaFo3Ioh4aZDOHN4
         Adlz1QTFZgK6hexionwkuMhF+HV13GHpWVHujrhtzZM+c4NBglZUNf/35TBJmd+j2/K6
         QlPEHOE8g8wDL47QIT2Lb4+/y1lsTMSMpHu5lFdd+UfkEojnNp7y2Q57I3RDV3noV62l
         fG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHCeU0sLDu3EzAmS761szeotYetdErsVQCIBuHJfbpk=;
        b=EVj0ge951bM1OdgFBd7WKDoVFafpUTxqwgGjgPlh5CeJ3xfkYsyDOTkYsVXA0EhgHG
         urby/0J9sXkA7+noP+8E2QcNo+OOPacq6VzaJUEpG3vCXg1yvzGxz0p6335Nme5wyjeS
         8c4pYRW5+wfddmXO8BKVqs/7lDhFqV+bqT0QFgVnJdsDlpVQQIVcIOf8M/x9AnkZcPKx
         X9Q13l/4oyk8wCXgMxNxH/z/8a3ZTnQruWd/2dLG1XUmmBOyBpCfyFUNlARV9IJRjlgU
         XijDE4WKICd8INT8AYyjzkiIQ7tlOph3dbOxtwC0tCtpm25/hRCAdn/ceYQx+1SCLFxc
         Dtiw==
X-Gm-Message-State: AOAM530drcoA/1q8KpO42veFqvh4DOMFjIg6BASfNb5e7AF9fZ+viqmB
        jXD10oma/bM2a68RqaSDcsuOjCEbD2jQbA==
X-Google-Smtp-Source: ABdhPJzCqv7BYcdlGRA/jQhCCKgUthF0Cz2lyociZOfoNG7gAUU6okMCAU+LuTvHMrp/lHbxssmLQg==
X-Received: by 2002:aca:5d09:: with SMTP id r9mr5838517oib.25.1608386790403;
        Sat, 19 Dec 2020 06:06:30 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s204sm1545791oib.42.2020.12.19.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:06:29 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 4/4] completion: bash: fix for multiple dash commands
Date:   Sat, 19 Dec 2020 08:06:21 -0600
Message-Id: <20201219140621.1961760-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201219140621.1961760-1-felipe.contreras@gmail.com>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise commands like 'for-each-ref' are not completed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5b2dff150d..7e893abf43 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -412,7 +412,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.30.0.rc0

