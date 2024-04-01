Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A506111A5
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971042; cv=none; b=gDHq4wO3snxlBJ8Xg4f3RaFJp/5hSQjgB90yDgc/P6j0Uq5AQ5TBVfhoHn9Eu8ljuLPmf9g4jplir0+9iR2j061gV81FpM6Uaah3rhG46B8rkyvaOnyzOrUg77xr+NLBNi3+oZqqMtygrS1/UOBLga9YKiDm4zDzvosvS01ETPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971042; c=relaxed/simple;
	bh=7GO5fTJp3QXPiOl9HCtkY7Ks+E2pvvXczWjx0JHzAso=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PqkC13qKai1kavO/pzV2oyFsKitOTwzFGZ1u+58L0NtFK9fqtM2Ij/g/FgZynkv4ZpypNtfljqjR2DyF5SP79Pc3jPdvAEjNEp32jKHNV4aQjAsPQuV971HdRdusg35+C+stlByWrCGC4G5YgPoPvSgt0NFP8DQ2SKxxzouCZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343496f8b80so795753f8f.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711971038; x=1712575838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UPV32U878PtpetZ+i1HJfk82ZoUv8u+Rybc6Kch06I=;
        b=YbksgT795xkcnqhoaYUJ2+DebWbtbn6cE8BMFCWhormzdzP+i4HldEDBZD2VCnSdFo
         7h9jlXZ49XML9z2wo+rmMYZEjs9gvg5b7low0hDQk48uemnmq2sLXyfkKJmy+RWEUUjJ
         LSia3wB0ivjXSvhtw64j0jWZWOcbsysHaEmaunZjJHZ+2Yb8zDbCrGb4tsvFT2WRRG6l
         EDxxdGhFJ6ilzpTy5KALIQVcZ1i55XTzciNB7q4gcA4Xc7h8ZeTV71tOorQeNmbgJRaS
         dmAqDacUMBcQIV/gsU3GrRTHBzjlTz35+NJDHGXRYLW7i2Osit3pki0nTKTZ+moycT+t
         JibA==
X-Gm-Message-State: AOJu0YweBgS7JrKu+yxNDLRYnLBOfRSyirQBeume4GsrQRlOlo2Yg+WJ
	IGfhGklB0dGuV5gR+0qAgmM90rjCv9h3y95QXDZy8HGi65K6avaC3NarHJyg4xQ=
X-Google-Smtp-Source: AGHT+IG9Ig0MzA3SmfFNQhy9PXICtEsEWUy9VWFMaLRIv/Js7VQHkrfqdcssZhWGcEHPulmmVnI95g==
X-Received: by 2002:a05:6000:508:b0:341:8412:a6e7 with SMTP id a8-20020a056000050800b003418412a6e7mr5886749wrf.18.1711971037665;
        Mon, 01 Apr 2024 04:30:37 -0700 (PDT)
Received: from t570.home ([128.65.235.35])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm11364833wrh.67.2024.04.01.04.30.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 04:30:37 -0700 (PDT)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: git@vger.kernel.org
Subject: [PATCH] completion: fix prompt with unset SHOWCONFLICTSTATE in nounset mode
Date: Mon,  1 Apr 2024 11:30:33 +0000
Message-Id: <20240401113033.28709-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`GIT_PS1_SHOWCONFLICTSTATE` is a user variable that might not be set,
causing errors when the shell is in `nounset` mode.

Take into account on access by falling back to an empty string.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 71f179cba3..3826f52dec 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -528,7 +528,7 @@ __git_ps1 ()
 	fi
 
 	local conflict="" # state indicator for unresolved conflicts
-	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
+	if [[ "${GIT_PS1_SHOWCONFLICTSTATE-}" == "yes" ]] &&
 	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
 		conflict="|CONFLICT"
 	fi
-- 
2.40.1

