Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5841353A8A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054794; cv=none; b=k/7nravEuclNxxCppkjTEJgIt+uH/c8nujFJGGKoI/KZ+89p1/jL+UE5Q2op+Z6ZhzQP9geZyCCtoZGq4qI8jo7YbkKfdZdpRHxFdNI3VXwRZfMLHSTHueuOKMI3/9s1zqGpx7ZaXk0ia8u9mNViZw+yUNxSC0z86c19a7iICbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054794; c=relaxed/simple;
	bh=qT70r6hsf7WuPc3xZ1T635jDGrOtbUvRT4zycRB9pQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQByrr4+739RpyVzVQK80GTQTfPYwrsrBZbbgIfeJnykSWQleihSSGLJCReCVpW+PyjEJktuSNt2WJavZZWbsFZr8MlNskVVTWK9jYWaS2ExIYjYAlqe8b3BiG1R0ygw2/msMxmqEYq3WUMkjPxiooIuf8J7f1fsUMb+hetio7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=KFvs1ZiQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="KFvs1ZiQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf49dc28ccso3319595ad.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 01:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785054792; x=1785659592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qhXGBzAMioG3PkeJ3hZnc/fVeepcNS4CYSG4hY+PVxc=;
        b=KFvs1ZiQx/zEaqAn5YgbALXSVMB/MM+cw9S5tHlN0PwvQyTp8MbJ+SPj8Ws/5dFNn9
         eMWp1Ipv4UPmhjUTvbRTw/HlPExpOvK9jawXYtnzYhMz0fsJBIQKSKfWkIp8zexo0oT9
         3yGChvB+DfgrbwudmrE9sb0JGlmVF/UEfSlEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785054792; x=1785659592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhXGBzAMioG3PkeJ3hZnc/fVeepcNS4CYSG4hY+PVxc=;
        b=K6Q6PA68NMBg00+lS72FhFPTZY/iy5+miUTdkDyRUfAOofUbHFyxjL5D1seuoaGmKX
         2vvwupua9t55/QcqwBtGN9Fxr2WKYFlx5JfHHVv1XMZDUW1QcPVUIDhBJg7UdVo/xJzZ
         3KoyU0tcxmlJLlLUmn3g0Flr6buqiG0BjumzabuFTQOZV9YhYKthkOndV6OknjLeeYYY
         X6z7FOX5JVYKzoD029Ndco5+Z+WAwJMuTwi4hn1bJlgsBcRlYFNJXyV1o9VDvtWmUFhv
         AIHpV6nI4ZhLAmaQtcC2OvAsjxhp+SlFtw10y7HYlfqV/fYI9RBd4RKEnvZBOgfGOXKI
         laVw==
X-Gm-Message-State: AOJu0YzlMUo66QYCW/KL4UKpRA3qZmwlXpA3OikT3JGAr4QvMgjMNPu+
	UAxfqGAL9/c40qrDgsZXZn1j4zmObsPuX6H82vcsj678L2U0EhryoCB2m00ZkuxgC8+5Pgxu+sp
	S3iwTtoQ=
X-Gm-Gg: AR+sD12VHfKGb0ejnHQMCKC9/Z4/QFkvN9VPkPRtRwbGBF1wHCo1vkBvjx72yHLa/7b
	CLa7/yDkiSuA/0iXV0TKUQDVBmVqKBW5VfpC1sQJfkaTBGCo5I5yPDzIfoYnnm8ck4YMZtGnguV
	rD7qXuTwZmT8aZDAEsENeWbAhxpE6E57VcUJhDBadMwBSBHOI7lYKsRcVrw43v6iY2uyFWq2noH
	l6Y7UqjYJ5APcw5QbuGPnTya9I3OP7alROqGNOREYpNr+hhnQnS9HBRa5UT2JvT2lk404EZtzz3
	7I4a88Eq99GLrrEPzknTPK5ku4s08yeir0eUAyDWZgyZQVv1bUEUTOBgxgCXTO97MJK6d86X0ID
	2GJ+vLy02r27FMDvjlarsQikavnI9aWCGqrl/rSM5Um3ny8Pu1MLYbhE2aVejBaLIoJ6MxEYXz3
	18vrQaYC/YI6W6OL2xPFvJ8xdPGQt+244Rfdnxoes87r0VUjk7ROhlRqhh44pDdBetx5SN6Bjum
	SD4dnPdUMjJ8g==
X-Received: by 2002:a17:90b:5870:b0:38e:7069:7117 with SMTP id 98e67ed59e1d1-38f2925ec3fmr3199399a91.0.1785054791926;
        Sun, 26 Jul 2026 01:33:11 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:50d4:8855:c7f5:b68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc413766sm19240063eec.8.2026.07.26.01.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 01:33:11 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com
Subject: [PATCH] fetch-pack: trace packfile URI downloads
Date: Sun, 26 Jul 2026 01:33:11 -0700
Message-ID: <20260726083310.16180-2-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.378.g9a0c4701dc.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a protocol v2 fetch includes packfile URIs, the client downloads
each advertised pack in a separate http-fetch process. Existing Trace2
regions cover negotiation, but not the time spent downloading these
packs or the number of advertised URIs.

Add a Trace2 region around the packfile URI download loop and record the
number of URIs. This makes the cost of downloading external packs
visible without emitting an event for each pack.

Extend the existing packfile URI test to verify the region and count.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 fetch-pack.c           | 12 ++++++++++++
 t/t5702-protocol-v2.sh |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 29c41132ee..701a23f808 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1886,6 +1886,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	if (packfile_uris.nr) {
+		trace2_region_enter("fetch-pack", "packfile-uris",
+				    the_repository);
+		trace2_data_intmax("fetch-pack", the_repository,
+				   "packfile-uris/count", packfile_uris.nr);
+	}
+
 	for (i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1936,6 +1943,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 repo_get_object_directory(the_repository),
 						 packname));
 	}
+
+	if (packfile_uris.nr)
+		trace2_region_leave("fetch-pack", "packfile-uris",
+				    the_repository);
+
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 74a2b7730b..537deff7b3 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1223,7 +1223,7 @@ configure_exclusion () {
 
 test_expect_success 'part of packfile response provided as URI' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	rm -rf "$P" http_child log trace2 &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1238,10 +1238,15 @@ test_expect_success 'part of packfile response provided as URI' '
 	configure_exclusion "$P" other-blob >h2 &&
 
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	GIT_TRACE2_EVENT="$(pwd)/trace2" \
 	git -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
+	test_grep \"event\":\"region_enter\".*\"label\":\"packfile-uris\" trace2 &&
+	test_grep \"key\":\"packfile-uris/count\",\"value\":\"2\" trace2 &&
+	test_grep \"event\":\"region_leave\".*\"label\":\"packfile-uris\" trace2 &&
+
 	# Ensure that my-blob and other-blob are in separate packfiles.
 	for idx in http_child/.git/objects/pack/*.idx
 	do
