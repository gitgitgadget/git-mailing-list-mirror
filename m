Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05696720F
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wsD1LPD3"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-20308664c13so30969fac.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592680; x=1703197480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VF17IDQorzmO9WV0u1VPJ82QQN6gFJDb0Wcyvjc5H9M=;
        b=wsD1LPD35GyS9ekCCveVZ65Vd/vheTxKuKH/CBxAmUOD+WKsj9NOgD95XX2lP8xRWG
         tvzWVjmwadcrfrX1z+tcAqP9v1zpjds8n/8Co360Odn8LSpNbEkEBZGEz0G4WX8kPyFu
         /IMqjeZlwbD0LX8eORuvIohztGZEbNzpy1U2upv3UYyy3eXr6GEyQg+urhEVoz9wHFGL
         SwqRoujSW3xdeom7WaYMteFCLPnlZNQqd0bM4vq2CKlMhGRJu/mMXZ0ihnsyEczIkOIo
         h30Jgoy865HutE4B7HGxbnLEHpaDDGEayO2ifvfLhE6btdmGphtv2ox8dH/5QOPNlW6n
         Ukfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592680; x=1703197480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF17IDQorzmO9WV0u1VPJ82QQN6gFJDb0Wcyvjc5H9M=;
        b=Y8KWltNPUiAVZzNmspJfMSEQ+W8n+EBGrPWtc9mhu43q1RlXt2u774vfV9dHIwFBA9
         voIixrqiItiFYFA0UAWZ3KKj7xfZ6y67DuyrbqKyrObMYUvnykD1U0ELyzKzVzFvKNu4
         4e4mY8C4PSUqIQZyVc81obTuBLZWg1cs7Z3Pfgt8p5vw7yqfpUER7omuIqujkt09iYAi
         4fwTAw7SOxFZyF3x8Mg126ou7lFQsB8ukXp+OFD0MEwYui59F1iAda0qnYuW8Sq8dJUb
         PfHtejjBSMRascDRCNSnQGJWC4O8YFPHQiRR0szsHHtagXoeholksCDs5TX8crP0LHBm
         HNuw==
X-Gm-Message-State: AOJu0Yzx9P2BYxus5X2mMTnV/dIc2UGtUPsbhZCLNa0MBgPMeYFXXWj3
	36aBHWPjDkPVRGO/37e8vEyp0Y1COzeLqBOXZl7AIA==
X-Google-Smtp-Source: AGHT+IH+D7rfA056aLM7owiH0V4zVP1TvL9lTDwDWmrz1Gph04GD54CytFvD6M4xY36hbjajr9Ff2w==
X-Received: by 2002:a05:6870:e388:b0:203:268:7773 with SMTP id x8-20020a056870e38800b0020302687773mr5649813oad.33.1702592680268;
        Thu, 14 Dec 2023 14:24:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hp10-20020a0568709a8a00b0020312c31095sm865880oab.28.2023.12.14.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:40 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 23/26] t/test-lib-functions.sh: implement
 `test_trace2_data` helper
Message-ID: <79c830e37ae7acec826bc41b8473309b38ed006f.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

Introduce a helper function which looks for a specific (category, key,
value) tuple in the output of a trace2 event stream.

We will use this function in a future patch to ensure that the expected
number of objects are reused from an expected number of packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib-functions.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b26..93fe819b0a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1874,6 +1874,20 @@ test_region () {
 	return 0
 }
 
+# Check that the given data fragment was included as part of the
+# trace2-format trace on stdin.
+#
+#	test_trace2_data <category> <key> <value>
+#
+# For example, to look for trace2_data_intmax("pack-objects", repo,
+# "reused", N) in an invocation of "git pack-objects", run:
+#
+#	GIT_TRACE2_EVENT="$(pwd)/trace.txt" git pack-objects ... &&
+#	test_trace2_data pack-objects reused N <trace2.txt
+test_trace2_data () {
+	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
+}
+
 # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
 # sent to git-remote-https child processes.
 test_remote_https_urls() {
-- 
2.43.0.102.ga31d690331.dirty

