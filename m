Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03731F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbdLMPOK (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38466 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdLMPOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:14:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id 64so5774310wme.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dnTG/8pyfJOHzAUqGe0Yjbk17iECO+8RgNpAWXoMeY=;
        b=Wl178t1QCOkxzhtqNYcwK96yLZfNozbRWGqjXcwXcBFshx2/q6jC5MUcuDiVmIKU5F
         A51yFhHaciXyL9tfImzZFUkPHHVB1sU+8JZ7PfXMP2xMHHLLm9Ya70iEbR7cFL6EhbkJ
         skQ3hihKNk2bTH5nGRwIYI+QhMrzB1onSgolI8X/U91ZIdQRvrhi7yJhBWXBtBqazZkW
         qf879RlOF3s3aOcovNY/B7aB/PyuVN181Xe+R1k6SvT6q5NaSQF1NdvNB4hD0OGFoaAa
         yGryVwv3Mg+6EPeVFUW/9uNyq8ZfzJ5fhvOMN9aKXODhAmumBAzj0WXspRxkWeS28+lM
         ThpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dnTG/8pyfJOHzAUqGe0Yjbk17iECO+8RgNpAWXoMeY=;
        b=ugqU8lUnDGvli/h6d0zgVas6N7ZFL3rf/g6gGot0TjKempXOoEKc4f4dUbFJxF0paa
         ckpRh5r21nCqhE6tyxumYOxWdVHpcULJs7CP3BsKASHIdQJQlBKhq20LiKKGybDrbmeW
         gwRZ64UsgCoSRFp5eNznTZe4BnWAPwqdv0h1XzSH4i1fABrmy5qtg5eNIIKu/Ev4pHIW
         skKY6m5iELpZJWkGknyhBQ6zSTGWqaoYiFTcAAUwI8eTeOOxJVAiPz71HC8bG1sTPSSd
         +hT1B9UyDXhDOrXHMcMU8yKPlGMMtdrwSmK7zRJDoj/vZK7kZqJ0/R32tubhewZPOSLl
         0G1g==
X-Gm-Message-State: AKGB3mJQwk/D+h1wxdnEFyVcL68MRoz0XhG2i7mad+W88tWquiJGzYYJ
        qnR60lMQ9ZsEWNbokYQ1iQBHRk5S
X-Google-Smtp-Source: ACJfBovb+LsGUhWG6w2R8BUqQpk/yOGwXZdQPVZiZ9vX7lwKk4taO9X0qJps4KIkWUOjDtCTTW7FGQ==
X-Received: by 10.80.129.135 with SMTP id 7mr8241332ede.101.1513178041499;
        Wed, 13 Dec 2017 07:14:01 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:14:00 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/8] perf/run: learn to send output to codespeed server
Date:   Wed, 13 Dec 2017 16:13:43 +0100
Message-Id: <20171213151344.2138-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index 4454a2713d..7b7011f19b 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -148,10 +148,20 @@ run_subsection () {
 	test "$GIT_PERF_CODESPEED_OUTPUT" = "true" && codespeed_opt="--codespeed"
 
 	run_dirs "$@"
-	./aggregate.perl $codespeed_opt "$@"
+
+	if test -z "$GIT_PERF_SEND_TO_CODESPEED"
+	then
+		./aggregate.perl $codespeed_opt "$@"
+	else
+		json_res_file="test-results/$GIT_PERF_SUBSECTION/aggregate.json"
+		./aggregate.perl --codespeed "$@" | tee "$json_res_file"
+		send_data_url="$GIT_PERF_SEND_TO_CODESPEED/result/add/json/"
+		curl -v --request POST --data-urlencode "json=$(cat "$json_res_file")" "$send_data_url"
+	fi
 }
 
 get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf" "codespeedOutput" "" --bool
+get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf" "sendToCodespeed"
 
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
-- 
2.15.1.361.g8b07d831d0

