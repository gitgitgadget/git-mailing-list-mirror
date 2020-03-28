Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477AFC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 02:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7C206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 02:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq/Nqz/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1Cuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:50:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41234 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgC1Cun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 22:50:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so10373851qtv.8
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1d1u9c4+BYo8HfK9aZyi3Rk/1MNM+V5fyh4yYIRoTec=;
        b=nq/Nqz/iwhgYkLHtVtGX1wQV2CoKfw0fRu4MOhUUUKDcfa/YQAfhoz7Aa1Q+OAAAPT
         X4h9t5G4hy88tB9m52F98hJHO/T+EwXnhZHr5eC//qBBUin9HxSV1R50hTSccpMbCy4V
         hncC2G2UVzNBG/QIIaCDUIXg3qY8Xmfs0DNVEA+82JbtaXdBbMW+wf+V6m/ttpb9dgi0
         KivHKr/IfrFu2Z8lvTgcWMgAWcy5I09VJOMEJiIlhU4PwbdMlxC5OMGo//5Q1j//2kqy
         UidEoDNdLfMIcYiOTAFIZq9Ny1eGCI0ZXun33Myqn42ydv/63UkxoMumI07AmWawEdoG
         fR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1d1u9c4+BYo8HfK9aZyi3Rk/1MNM+V5fyh4yYIRoTec=;
        b=frNL/GvtR5KaLhi3J3e2ZD+QgeciE8b7qpYWl1cjpPYuM3flSeyH6AVB5xNuKar9ui
         RZIU3M44jCvBt4HOes6tzv19sb+7GNOpXp97d5BQpT/k7+bOThO1oUXRDLDckggAvOiv
         JOcbX1IBtghJaau0Bt3ERkXZqNQrQx5OXelW2fn5eNtVt3Q4vfFaOWLpg4EihceNzeqL
         cndqCPS7yPKxUHWNHCjM/LGvJ+Z2o77qgIY2UM3t+dBPFeVQBA+y/S0kNnovDeqi7eKx
         JEP5KwN+Aql4Cre4IUmvOBA0pXiTOLgQvUHH7X0VP90HIA012CpEUhT8sgEzitfEgXa4
         VnbQ==
X-Gm-Message-State: ANhLgQ1kkuue+czrOXb30qtsQTWHmC07EWreP43EZU0PNjCY8H6G3T2O
        htCXuQYPmDmsbTloPj/Sp86FuYNv
X-Google-Smtp-Source: ADFU+vtmsSsmivDrw3jfObYzmElIoP2KPZul7xrqo49FIUDdhzUaNakbsUa3zsXT4OZ8TtS0jC05gA==
X-Received: by 2002:ac8:4e44:: with SMTP id e4mr2280842qtw.313.1585363841722;
        Fri, 27 Mar 2020 19:50:41 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id d72sm5236361qkc.88.2020.03.27.19.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 19:50:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH] http-backend: write error packet if backend command fails
Date:   Fri, 27 Mar 2020 22:50:32 -0400
Message-Id: <b5f8b81498e1d152014acab92fa1b6e9701b3a0e.1585363771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If one tries to fetch packs with an incorrectly formatted parameter
while using the smart HTTP protocol v2, the client will block forever.
This is seen with the following command which does not terminate:

	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...

Meanwhile, if one uses v1, the command will terminate as expected:

	$ git -c protocol.version=1 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...
	fatal: the remote end hung up unexpectedly

This happens because when upload-pack detects invalid parameters, it
will die(). When http-backend calls finish_command() and detects a
non-zero exit code, it will simply call exit(1). Since there is no way
in a CGI script to force a connection to terminate, the client keeps
blocking on the read(), expecting more output.

Write an error packet if the backend command fails to start or finishes
with an error so that the client can terminate the connection.

Note that if the included test case is run without the remainder of the
patch, it will run forever and fail to terminate.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    So this is the first time I've touched the networking code of Git. There
    are a few problems with this patch that I'd appreciate some help
    addressing.
    
    First of all, is this even the right approach? I tried to find some
    other way to force a CGI script to terminate a connection but I don't
    think that it's possible so I had to get the client to do it instead.
    
    Next, with this patch applied it seems like t5539-fetch-http-shallow
    fails on 'no shallow lines after receiving ACK ready'. I've been trying
    to dig into why this happens but I can't quite figure it out.
    
    Finally, I'd like the test case I added in t5702 to be guarded by some
    timeout in case we regress instead of blocking the test suite forever
    but I'm not sure if that's even available functionality. It seems like
    we don't use the `timeout` program yet so I'm not sure if it's a good
    idea to introduce it here.
    
    Thanks,
    
    Denton

 http-backend.c         | 10 +++++++---
 t/t5702-protocol-v2.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ec3144b444..7ea3a688fd 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -488,10 +488,11 @@ static void run_service(const char **argv, int buffer_input)
 	cld.git_cmd = 1;
 	cld.clean_on_exit = 1;
 	cld.wait_after_clean = 1;
-	if (start_command(&cld))
+	if (start_command(&cld)) {
+		packet_write_fmt(1, "ERR %s failed to start\n", argv[0]);
 		exit(1);
+	}
 
-	close(1);
 	if (gzipped_request)
 		inflate_request(argv[0], cld.in, buffer_input, req_len);
 	else if (buffer_input)
@@ -501,8 +502,11 @@ static void run_service(const char **argv, int buffer_input)
 	else
 		close(0);
 
-	if (finish_command(&cld))
+	if (finish_command(&cld)) {
+		packet_write_fmt(1, "ERR %s failed\n", argv[0]);
 		exit(1);
+	}
+	close(1);
 }
 
 static int show_text_ref(const char *name, const struct object_id *oid,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..69a920a34b 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -586,6 +586,23 @@ test_expect_success 'clone with http:// using protocol v2' '
 	! grep "Send header: Transfer-Encoding: chunked" log
 '
 
+test_expect_success 'clone with http:// using protocol v2 and invalid parameters' '
+	test_when_finished "rm -f log" &&
+
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" \
+		git -c protocol.version=2 \
+		clone --shallow-since=20151012 "$HTTPD_URL/smart/http_parent" http_child_invalid &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log &&
+	# Verify that we sucessfully errored out
+	grep -F "ERR upload-pack failed" log &&
+	# Verify that the chunked encoding sending codepath is NOT exercised
+	! grep "Send header: Transfer-Encoding: chunked" log
+'
+
 test_expect_success 'clone big repository with http:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.26.0.159.g23e2136ad0

