Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A435812A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC6wCF1u"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so5367433f8f.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705008451; x=1705613251; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VBk4EyMiw/YCDW//yDr2gqsDT9ZWXwNQbfn0sjXWRJw=;
        b=OC6wCF1u525xK8kbPLNL90myDip5GkuxrqYVPfCunW59YOK5AahW+/6vhz6MNheudJ
         aKq6eO9KEVQrqYZoJt+g6RAwABcn2iDfcTdhfYUQ8v5XVWZeq8RLCq0osWVYiwyxDXLh
         YmdM4XAD0p4ZDuyfzys8RlYN9TO50PaLodhs9sN5eJ7FfOkhB1nPl45Ehcbhye4pxz0F
         cxOnTJ4oPZ+6BP+N2ayHFliVGecogvt9vDHFd3H0IjKms7vm6nLN6g+GANi+fUQF1oR8
         NVASEYFThvEE2fwPibxkEzl20bW1SklEHxZp9xUel7fqZ4owiIpqNN5pb4eXEnBJm/9I
         ebPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705008451; x=1705613251;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBk4EyMiw/YCDW//yDr2gqsDT9ZWXwNQbfn0sjXWRJw=;
        b=B8o1NE5q0SW2qFq8zH1XNScPqkcXA9WOE+S2fVk13D/C4dNEbCP/R4/b6Gzl0pIVhr
         rg6m3bNkyGTeCfVo+mT6PqhYnBw6c/JdEMKyucLwgDJnl9vb0YhMNIppAByTNWhna/0o
         wFPte0rtNt5ioanLKoFqoYJXMPzehdTIZLj9PGWzB2lm4AhDJhkeo5g8HI9vaUtlozFM
         jXWvUKmR1rw1P+HVr1CWXFjK3BHLqod69619PqqAK1vc8F3u9lToJolq0dgxuwwp/DvF
         RIfn0+vw8SiXr2I7aKcoSH8hevBVMTkXCqfSyTpRg+637UfERnGbGJyt8b6MpVOD6cBh
         DX6w==
X-Gm-Message-State: AOJu0Yx3HE9UkupdiQxffG1y70nvRpfd8yEAKT5EHSqMz/cLeexKeYaN
	YNOD6CD69I+Yc5dqHA3iFuxt/72QRIc=
X-Google-Smtp-Source: AGHT+IESNu8sDxlQW7O5DaU+e8iRqbegVK+MsMsi56kHHCAQZZz1w0+pidCKIBLZ8VZOtngjJCkRdQ==
X-Received: by 2002:a7b:c8c3:0:b0:40e:4ca5:7c99 with SMTP id f3-20020a7bc8c3000000b0040e4ca57c99mr132662wml.124.1705008450640;
        Thu, 11 Jan 2024 13:27:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0040e527602c8sm7279469wmo.9.2024.01.11.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 13:27:30 -0800 (PST)
Message-ID: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
From: "Benji Kay via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jan 2024 21:27:29 +0000
Subject: [PATCH] push: improve consistency of output when "up to date"
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
Cc: Benji Kay <okaybenji@gmail.com>,
    okaybenji <okaybenji@gmail.com>

From: okaybenji <okaybenji@gmail.com>

When one issues the pull command, one may see "Already up to date."
When issuing the push command, one may have seen "Everything up-to-date".
To improve consistency, "Everything up to date." is printed instead.
(The hyphens have been removed, and a period has been added.)

Signed-off-by: okaybenji <okaybenji@gmail.com>
---
    push: improve consistency of output when "up to date"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1638%2Fokaybenji%2Fup-to-date-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1638/okaybenji/up-to-date-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1638

 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index bd7899e9bf5..c42cb4e58b4 100644
--- a/transport.c
+++ b/transport.c
@@ -1467,7 +1467,7 @@ int transport_push(struct repository *r,
 	if (porcelain && !push_ret)
 		puts("Done");
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
-		fprintf(stderr, "Everything up-to-date\n");
+		fprintf(stderr, "Everything up to date.\n");
 
 done:
 	free_refs(local_refs);

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
-- 
gitgitgadget
