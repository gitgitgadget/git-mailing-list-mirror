Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07184C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiCUXKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiCUXIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB0E4BFC7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n35so7791794wms.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6JK1ko3GgXmzBEKlacZFTwKT+j13QTKVT7Pq1rPnC8=;
        b=KEMcYVDFyQPaj5ceGGBFgUOstwYYJ5oC5ibeo9AxSyo4NJSkV0I3ViOMVx8bkCl4Ar
         Lv7CKiEf+fWuhtKH4MwsnjuDUEuNMbVMP46McCISoav0M6mzBny9gE/vt8rBE3Pwdrkb
         44mgGmBTClMcGXMlZJiVAUpwK2B7ANNWr959cYhwFLM7vtrVQ193lb6H9gWVJrtpdFf/
         aUanobeWHtPEP/rSbJ78aUsvANi3jqfCfNBtel7hdPsyA1dTq3CfWavq8S7G9t7tSIXJ
         BLt9MP60XTf9cvgQpoPJg0GW4xGDRFcm1KG1DkXyjpa9Af6q2yBxvD8l9UArjQkoRVUs
         owLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6JK1ko3GgXmzBEKlacZFTwKT+j13QTKVT7Pq1rPnC8=;
        b=hPEOWZZ0RT5gEygp5CydqlS27Mh2vv8m/nTtNHNpdujS5AVRaTzGa8NNk/WLfADesC
         njP3VpoePrao8jYM3a51k8DYl+4K871oKVFlV7dfwKYeW4Pb37RtEQeH0awucsEXppYo
         TLnLUu4HZJDm1vKQPvCSn2BHZahPpnrhwvmk9IIi1FaKFrHfS4ZiZki5MxQSlT11HjaJ
         vISEcWlkBHL6641dfHSDfLADQqyg4aDwUIqNxDPu0MuA/m+XjlCnC+XxjBEct70ZjU+l
         WkgJxk6UhLnPLAZtPOzcBDxrV4Iki1wGrQcU7DAiwq8HhdSsJedDeLFtvgVURC68zlqq
         Sbdg==
X-Gm-Message-State: AOAM530HJ/SNLGz+pn98zEe4KtmymmfVJMxE/g/9F3hK5LVPkRCiLbPS
        StxrD6qUMRAZjoiK2fjjv2fsBWs1h5s=
X-Google-Smtp-Source: ABdhPJwfgzGpMZHNiTS2QXeY07IZp/KJ9I/W2l4oLlUSe3IM594TbBFGPuOd8k0sCwmTTjnjbjBceg==
X-Received: by 2002:a05:600c:3516:b0:389:f9aa:f821 with SMTP id h22-20020a05600c351600b00389f9aaf821mr1113232wmq.73.1647903365431;
        Mon, 21 Mar 2022 15:56:05 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:04 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 26/41] daemon.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:08 +0000
Message-Id: <20220321225523.724509-27-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 94a5b8a364..cd07ae1643 100644
--- a/daemon.c
+++ b/daemon.c
@@ -134,7 +134,7 @@ static void loginfo(const char *err, ...)
 static void NORETURN daemon_die(const char *err, va_list params)
 {
 	logreport(LOG_ERR, err, params);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 struct expand_path_context {
-- 
2.35.1

