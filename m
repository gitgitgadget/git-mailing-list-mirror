Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C02376D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7kTk0/b"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF7BC
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:11:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226cc3e324so3007851f8f.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099117; x=1698703917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1lvhVCXRzMw7HgOrEKsA1o0NdzhK9+ehJB0Dc8CB+A=;
        b=D7kTk0/bDqbMYAZIsYF1FEistUpnLweOQMGLNZyafww0IbwXrhHSjEEYjTIj+mclEX
         wh+LOH4mA6BcLq5yV4mFTdICa/OOSTv5Nk6ZjvVx5tsTpTeqHkzsL8tQbhLT1G5bvWqB
         GdODi+H7iEXUlvIcwomimWvt5Mi36qsSWj4alN+dXErndNPqPYZ0JGGYPspJHBlsS0jc
         n9MELWoYAV/ymnyfVQY8MVKtCWEXyXues01GL0Z79jRLbviI/Ah3ynrWkiDWMncI+Hu+
         5+9KsFzr2P0vmlzRRj0QZviqnJhoTEqXSJ0DD6MLkkoa/VI3guq1JSRg0WTwrwNaTByT
         mu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099117; x=1698703917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1lvhVCXRzMw7HgOrEKsA1o0NdzhK9+ehJB0Dc8CB+A=;
        b=jqxJJRhkmqpVjYiyXcvOsH20XHj2SZfoqa01mUfWEaHb3NGKkEffULmeqvcUeD4CrY
         5HSq+aCaoGTXpCiyyvVVz9GdYYFjK5rtcIJGsmlphGzUqGbNXca3S21nMOPS54VLDAfZ
         PDCBh5EAFh+2P9UHZOmk+mF8xdcM+AzXqWUZNEoY7YZ+rxjN8ezNUkCt4DwhFjdA8bCA
         BU5Q1EJGz6y5CWkS2MDBT5lOFSeAQfIdhn/9a5FHW7aegu1ibgc2+jntmio6NuKQJGaM
         6KyXw+DumbzNr6RGCnydeI5x6rGdE5Qi1cxf7Z1TPNjQrvOZgTq6t9s2KgiYNkEX/i1b
         E13A==
X-Gm-Message-State: AOJu0YzVpXZflUHE5JAmQsdtgga9GXe0V9WyTyuM2gzCUXaUlqjW5IpF
	xra5/hvqMdPxsBGZHM+7Md9oP8ZkDGwJhA==
X-Google-Smtp-Source: AGHT+IH4ScxFpMlNRVzmyoHgYuNN6kgLMu8+dBYNGaQb/AL3tQds/yAae1H6xovmG5yXALxH850YfQ==
X-Received: by 2002:adf:fa4f:0:b0:319:67ac:4191 with SMTP id y15-20020adffa4f000000b0031967ac4191mr7938104wrr.37.1698099117176;
        Mon, 23 Oct 2023 15:11:57 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:11:56 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 2/7] log: use designated inits for decoration_colors
Date: Mon, 23 Oct 2023 23:11:38 +0100
Message-ID: <20231023221143.72489-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231023221143.72489-1-andy.koppe@gmail.com>
References: <20231022214432.56325-1-andy.koppe@gmail.com>
 <20231023221143.72489-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use designated initializers instead of comments to denote the slots in
the decoration_colors array for holding color settings, to make it
consistent with the immediately following color_decorate_slots array
and reduce the likelihood of mistakes when extending them.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 504da6b519..8bdf889f02 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -34,13 +34,13 @@ static int decoration_loaded;
 static int decoration_flags;
 
 static char decoration_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RESET,
-	GIT_COLOR_BOLD_GREEN,	/* REF_LOCAL */
-	GIT_COLOR_BOLD_RED,	/* REF_REMOTE */
-	GIT_COLOR_BOLD_YELLOW,	/* REF_TAG */
-	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
-	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
-	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
+	[DECORATION_NONE]	= GIT_COLOR_RESET,
+	[DECORATION_REF_LOCAL]	= GIT_COLOR_BOLD_GREEN,
+	[DECORATION_REF_REMOTE]	= GIT_COLOR_BOLD_RED,
+	[DECORATION_REF_TAG]	= GIT_COLOR_BOLD_YELLOW,
+	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
+	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
+	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
 };
 
 static const char *color_decorate_slots[] = {
-- 
2.42.GIT

