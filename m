Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FA224CA
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a36/8jM5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336990fb8fbso392976f8f.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 05:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376608; x=1704981408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UXvCO1Kwt7e39DSs9w5Aire4gi7nzDyVeDPWSN/youw=;
        b=a36/8jM5PK9qQzbqARrJ6im6v8tv3c1/COZ1M6JXnxvvw8CbfbEZ+aqA6G4eqol5AZ
         w+5GmMp1DzZD6kCFCcm8BFEc1S5mHijXdTR1jeUqw39xastwTdAXidZ6HUX6IhfvO8qb
         2MNClR79VtFklGb/GcYjzpa4g6AZVBpqmUaCSWBd4kpppuX8RxN8Jmy+bEmpb5DeoSnE
         qTw2757v49pzyxPnke0f3toUZtIkaPPEbrI89cXogVsFU5DkwosQI7Mq6Na5kSU42fso
         NGu0VV5WecA5yzV7oz0WSGj2uDO/2ZtNkGKCdafMQCennLdzeyWMosPzq+1e996mE0kM
         pZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376608; x=1704981408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXvCO1Kwt7e39DSs9w5Aire4gi7nzDyVeDPWSN/youw=;
        b=DL77eSCr6qJFyuK9+mZSQlIMM68aUw8oUvAsIc/YZm4cDO2siV8jdru95vHDHSEf4d
         BLD5ze9+RTDfGCCLYvbymWXqGqrVBnoegKdbJn29a1hFHfk/o1jiNHTUrVfkuTLt51s9
         1RVJ71jQOIRD2RrtS2pQ4TSg5SS/NdwMhX9zQzefpnDq3uQ5Hl1J4jTLARt9XzUdsnrR
         RlLkgHrm7fcAYSM4nTh1u1z7pE2dSQq8RGEpyW7L0DcLbTibBmTHCCFTOfg8HYzWruX+
         qDnX1M8Y3gNx2M1XXAl+/0tJKxHPtRTXUImnFq+UNg3l/35ib36GnG+vZ0+EjQ4+VjRD
         +MtA==
X-Gm-Message-State: AOJu0YwnQZmsYoilDBfpa+oN0MyiQgHrkSVgbjcoTDG9RrRGZ3cStxr3
	KntmsgEJkd+kgmPFPMJJ7RY3odlEhbI=
X-Google-Smtp-Source: AGHT+IG7yQZ+x9+S6Wf5StCCmFfNIJZqZj6buPuf7ijw2ywJgYBqzygEVkF6d33An+0fN2kiOYCavA==
X-Received: by 2002:a5d:4e05:0:b0:336:7eaf:9baf with SMTP id p5-20020a5d4e05000000b003367eaf9bafmr392800wrt.65.1704376607888;
        Thu, 04 Jan 2024 05:56:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020adfe706000000b0033342338a24sm33240971wrm.6.2024.01.04.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:56:47 -0800 (PST)
Message-ID: <pull.1636.git.git.1704376606625.gitgitgadget@gmail.com>
From: "Chen Xuewei via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jan 2024 13:56:46 +0000
Subject: [PATCH] fix: platform accordance while calculating murmur3
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Chen Xuewei <316403398@qq.com>,
    Chen Xuewei <316403398@qq.com>

From: Chen Xuewei <316403398@qq.com>

It is known that whether the highest bit is extended when char cast to
uint32, depends on CPU architecture, which will lead different hash
value. This is a fix to accord all architecture behaviour.

Signed-off-by: Chen Xuewei <316403398@qq.com>
---
    fix: platform accordance while calculating murmur3
    
    
    Short Description
    =================
    
    fix: platform accordance while calculating murmur3
    
    It is known that whether the highest bit is extended when char cast to
    uint32, depends on CPU architecture, which will lead different hash
    value. This is a fix to accord all architecture behaviour.
    
    
    Problem backgroud:
    ==================
    
    when using git log --max-count=1 <commit> -- <path> in an mixed cpu
    cluster environment both arm and x86 in a cluster as a service, where
    the <path> character is chinese or some other character that the highest
    bit of char is 1. all machines share the same repo disk. It happened
    that sometimes you can get the searched file among commit, sometimes you
    cannot.
    
    
    Conditions
    ==========
    
     1. file path include chinese characters or other characters that the
        highest bit is 1.
     2. mixed cpu architecture as a git cluster service
    
    
    Reason
    ======
    
    when you have over 2 machines (both arm and x86 are included at least
    one) as a git server cluster. once you open the commit-graph's
    bloom_filter feature. The bloom filter stores the file path as hash
    values using the murmur3 function. suppose the arm take it this time,
    then the char's highest bit is not extended. for example, on arm,
    char(11100110) to uint32(00000000 00000000 00000000 11100110) on x86,
    char(11100110) to uint32(11111111 11111111 11111111 11100110) then
    according to the murmur3 function that git currently use, the calculated
    hash value will be different. If the value was calculated through the
    same cpu architure machine, then it is ok. however, sometimes the hash
    value is calculated through a different cpu architure machine, then you
    cannot get the searched file. for example, bloom_filter's hash set is
    calculated through arm, and query through x86. So the hash value is
    incorrect, then missed the searched file.
    
    
    Solution
    ========
    
    No matter what the highest 24 bits will be when char cast to uint32, the
    murmur3 function only cares about the char part , which is only the
    lowest 8 bits, so we can use & 0xFF(11111111) to the casted uint32 value
    to choose only the lowest 8 bits.
    
    
    Others
    ======
    
    after fixed the bug, the historical bloom_filter data stored in
    commit-graph need to be updated. because the path's hash value is
    already calculated through a bad way. so we need to update it. this need
    to be done in repository

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1636%2Fcdegree%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1636/cdegree/master-v1
Pull-Request: https://github.com/git/git/pull/1636

 bloom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bloom.c b/bloom.c
index 1474aa19fa5..bc40edac795 100644
--- a/bloom.c
+++ b/bloom.c
@@ -116,11 +116,11 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 
 	uint32_t k;
 	for (i = 0; i < len4; i++) {
-		uint32_t byte1 = (uint32_t)data[4*i];
-		uint32_t byte2 = ((uint32_t)data[4*i + 1]) << 8;
-		uint32_t byte3 = ((uint32_t)data[4*i + 2]) << 16;
-		uint32_t byte4 = ((uint32_t)data[4*i + 3]) << 24;
-		k = byte1 | byte2 | byte3 | byte4;
+		uint32_t byte1 = ((uint32_t)data[4*i]) & 0xFF;
+		uint32_t byte2 = ((uint32_t)data[4*i + 1]) & 0xFF;
+		uint32_t byte3 = ((uint32_t)data[4*i + 2]) & 0xFF;
+		uint32_t byte4 = ((uint32_t)data[4*i + 3]) & 0xFF;
+		k = byte1 | (byte2 << 8) | (byte3 << 16) | (byte4 << 24);
 		k *= c1;
 		k = rotate_left(k, r1);
 		k *= c2;

base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
-- 
gitgitgadget
