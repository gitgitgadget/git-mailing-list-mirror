Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6442056
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998498; cv=none; b=Fc8AJTUNPLEFiuVjuHLFqMHun9HypvXZ9RBPQYcMhXYmzk1/Jsoqvb87/oi+87OC3y2CQi4M5V6gbs9w/4URIoQwBNfqJ/WyK4Ipv7LEeRWMFOe37pK47X2syOSlcQVOJpoW44XqjMmg14HKwPdiJE+UJ7C6kpfOQlk5a/cBXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998498; c=relaxed/simple;
	bh=BYE/7MpfUvq/h2vaXH0auOoW+blk4Qnir+cpwzUHMYM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Lhf/jUB2WuhzEjPxW20YHtn37RF6BCry4qhLPe+LNwryLdJ4c/8T4Or/Kg1Ia1d4q1BJStOL30z4D0WIr04j+9cT9Zq8VXmO3lBgoOqSVuRE4Y8VSBa+wbXTRgRChqLtg5p0q554XD+FOwr2Md4GF9SaexpaL+lpU5DEox0mHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3416a975840so3453589f8f.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 12:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998493; x=1712603293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwy102h+b2q7jIOlA3TuXjC+mEwR5pbPuaYYGhdxfvM=;
        b=cNIE9Un2VVUT6q6t25oSPEva19C4JB9wtTKFDXTJTUd6IT5Ag8QqzXiO74WwpsunlZ
         j3wY1t6c2bwE7h0TVMJetsiWDFl2eQ+rp7B0QLYreJYKO/uP/Oii7emBPtznkSLXPICv
         NkqRNWore3m61hwyRHgecIPBlLQiZ1mNQ0FtZ1xuy2/Y4BIn0pqg8vtm+dgFF6g0Kyd+
         s3f6nFGSRXYP8D9Gereig4RkK/g3THeoITaGhsl/ekPtYxI3njyx0NLKJxrOYMfSFtru
         PNK8cIkkD4cT9AMziCAtSw2DXPhtx15NbhVSSmw2OgMWQX+nRY9kRDRHecOAFxlGPxIy
         JXOw==
X-Gm-Message-State: AOJu0YwBzx4eu/VIaLc/xl4Ql5cRAxfkuol2EtKVlhwMZe5say7hzaCT
	38e1I6XRijaZeKL7IeyIyS6VIK+njTIoGHJcYymyQPMYcGiWWujsv6IhzDgJe50=
X-Google-Smtp-Source: AGHT+IHm9OitatSv9id0G71HMVDMXKW3zIln5OERGClc0xoVlXkIbPtWbqe6gbY58BzFO6btqouDvA==
X-Received: by 2002:a05:6000:4014:b0:343:2e09:58d1 with SMTP id cp20-20020a056000401400b003432e0958d1mr9712907wrb.44.1711998493036;
        Mon, 01 Apr 2024 12:08:13 -0700 (PDT)
Received: from t570.home ([128.65.235.35])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b0033b6e26f0f9sm12222673wrp.42.2024.04.01.12.08.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:08:12 -0700 (PDT)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: git@vger.kernel.org
Subject: [PATCH] completion: protect prompt against unset SHOWUPSTREAM in nounset mode
Date: Mon,  1 Apr 2024 19:07:51 +0000
Message-Id: <20240401190751.8676-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As it stands, the only call site of `__git_ps1_show_upstream` checks
that the `GIT_PS1_SHOWUPSTREAM` variable is set, so this is effectively
a no-op. However, that might change, and chances of noticing the
unprotected use might not be that high when it does.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 3826f52dec..5330e769a7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -141,7 +141,7 @@ __git_ps1_show_upstream ()
 
 	# parse configuration values
 	local option
-	for option in ${GIT_PS1_SHOWUPSTREAM}; do
+	for option in ${GIT_PS1_SHOWUPSTREAM-}; do
 		case "$option" in
 		git|svn) upstream_type="$option" ;;
 		verbose) verbose=1 ;;
-- 
2.40.1

