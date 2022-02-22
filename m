Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B9C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiBVVzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiBVVzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 16:55:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F2A1BC0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x15so1630184wrg.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0rgFhFumRJ8xLgY7FBzMqanBoGWuWtgz33otHKqQ+8=;
        b=Vl9NY9au//Cm/cyvA9HqXdmMGfSqvB0cvG9RMI2eIzWTXc8u4i63qerX683XmfB/Ya
         1dwEGF7DDJ3Tjr5UGoF62M73ofWrr+rsiuZg4j3JU8JIq+Fqi2vHKEhVa6z16YHDBL+x
         tJpwMCtnNugoZGrX3GqXascQ2hWCCaDttzAAmOUfifqZ2cLrfy537jRL/YXBKHmP8HAT
         /umOBJywra6+C2yPUurcb99+HZytnMQeXcCUVZE+J3yuAbiViRlG2xIAonU2wJPM16dS
         NlvW6mO41YY1Lfw33yEZMYnszivSDiMo9Mrr8wTnh5rtX/BoaDw01HnnrDb7SCBf3NcY
         nJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0rgFhFumRJ8xLgY7FBzMqanBoGWuWtgz33otHKqQ+8=;
        b=jeYP8iU3TpYHjIHWTlbB6KVpOXz3UqbO5ZvR9x2LQ3zxI7cBkiaQx28ZyJ9p/Cf5CZ
         1tW6DknvpZfY2T8EO0AhewCZ9Jo5yIxQ6A5GK6TE+GfWTwe0AhtPMeHPCPKHOpW+TFZ3
         aDSVSiflOVdyRTPEFbzbNyU1R38AfMw9JMJI3PqjIbW29WTcffnYmUiJTmkLa/apunO4
         b/WVNtulg/cd8AfzTczZsqoymP8ZspSByxYwxhhaeh+wh5WQRnGNxG/KjTk+rq1JsDQr
         chac3Lcxb4+mse1vTLw5loBX3DLAKmEP6+k5L/PGm1/DosSMdqNJAdh+iR7zMKt5w5z8
         3k8w==
X-Gm-Message-State: AOAM532ur1oYDa90h+GyTzTMKKj4sO7LW3JgXGxfuKfH1dbpftnNlUcU
        lCCNnRrcTEtQfNqKxt0Ue80=
X-Google-Smtp-Source: ABdhPJz/gL0OsemEMyaqt8RlXxBtwpU+YgRr6xF3QQ/IavAs9RKnxwo5j4GuVhu641yThA1LnYd13Q==
X-Received: by 2002:a05:6000:10d2:b0:1e3:e061:1172 with SMTP id b18-20020a05600010d200b001e3e0611172mr20603764wrx.195.1645566914895;
        Tue, 22 Feb 2022 13:55:14 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id u12sm39471997wrw.32.2022.02.22.13.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:55:14 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, cogoni.guillaume@gmail.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr
Subject: [PATCH v3 1/3] t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
Date:   Tue, 22 Feb 2022 22:54:28 +0100
Message-Id: <20220222215430.605254-2-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222215430.605254-1-cogoni.guillaume@gmail.com>
References: <xmqqbkz4105s.fsf@gitster.g>
 <20220222215430.605254-1-cogoni.guillaume@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_path_is_* to replace test [-d|-f] because that give more
explicit debugging information. And it doesn't change the semantics.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
---
 t/t3903-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af44..11a0856873 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -487,7 +487,7 @@ test_expect_failure 'stash directory to file' '
 	rm -fr dir &&
 	echo bar >dir &&
 	git stash save "directory to file" &&
-	test -d dir &&
+	test_path_is_dir dir &&
 	test foo = "$(cat dir/file)" &&
 	test_must_fail git stash apply &&
 	test bar = "$(cat dir)" &&
@@ -500,10 +500,10 @@ test_expect_failure 'stash file to directory' '
 	mkdir file &&
 	echo foo >file/file &&
 	git stash save "file to directory" &&
-	test -f file &&
+	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	test -f file/file &&
+	test_path_is_file file/file &&
 	test foo = "$(cat file/file)"
 '
 
-- 
2.25.1

