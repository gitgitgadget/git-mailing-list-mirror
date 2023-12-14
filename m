Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2E6721B
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="d8f00qCO"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b9fd7b14cdso512083b6e.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592678; x=1703197478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRsYYhPgPUf8u728XV2u8BkxysmiQ6wX1U/0wFiUVNg=;
        b=d8f00qCONe8woQ74m2UmtJGn/9xNyY2YnVreIp6GBYN/LecUAwQbfy36hRIKjUsEX5
         gakwds4SuXXdWUMewjsKImlcLbQRgLOK1CEGOT00+cUr+xDOssTaMOngMlHIbWdVGCcP
         YAWP2h4jfEbfwTcmT70vIMHzxyALaemC0E7f7xH2TcrpVNy6/ovxyZxrBy/RFPNfTBK/
         4BtdCHBQqjnjei7RKWhsVEvIjXQwWAdohSS/gXOMQwDXK5r0ZVCFNbbxTbEHpC5XijRY
         RY8ssCfCFgBSttJgxkkxIZO+m80eVUIr2B11HLgnoFRoQyc0DfkB6fZzJs79+/V8HorL
         Eb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592678; x=1703197478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRsYYhPgPUf8u728XV2u8BkxysmiQ6wX1U/0wFiUVNg=;
        b=Je01bn2ZJ/uo/kUCbf+HCnKq0g4EstyTQl/aR3EYktrn/C/xCT+WE31WREShQf2pA3
         WQcG84IGMu3mO/mYwEJrhZwAf8/qYnwCQnWpQPYtnLVyd9ZtXqYxb5Ds4a6aS5bnrURt
         23XJ7YJtAgb0cxJXfYSL3yieRSqBoXP9YpbZ7Foaz0QGXd2Qa4GmhV7r6SzO7DJmzypb
         xYbTwdjXXV9lIOE4cp1Su02qiKvrdmnxpPZytSEFkGCNulhaTqUoBHcLVQd0AOw+Qwjg
         hlagaIa0ds3R5Z9oUkCu5fiar75O1/cgjoY2tl1hPcKAYVWi0m1dAj1gwYUe4YRvXVjn
         UDKQ==
X-Gm-Message-State: AOJu0Yze9bOLfj7WALUR/I63M8ZlUyigt64s6CtODtVn+EUbTKtL9Lvl
	zIhcp7zn0ssCyF9HKsT+vZ9xoAovHddup/3s77pwlQ==
X-Google-Smtp-Source: AGHT+IGyWcWdwzmsOM2GGOSv770RPtctdMgvWxPyLF2HUaFEAGDL4hqMGEfTF93Hkb6NRUT9CXzfog==
X-Received: by 2002:a05:6808:3989:b0:3b8:b06b:97f8 with SMTP id gq9-20020a056808398900b003b8b06b97f8mr5656374oib.40.1702592677613;
        Thu, 14 Dec 2023 14:24:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y9-20020a4a2d09000000b00584017f57a9sm3675566ooy.30.2023.12.14.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:37 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 22/26] pack-objects: add tracing for various packfile
 metrics
Message-ID: <1723cd0384b56bbf5ae77ed249327c16cb937634.1702592604.git.me@ttaylorr.com>
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

As part of the multi-pack reuse effort, we will want to add some tests
that assert that we reused a certain number of objects from a certain
number of packs.

We could do this by grepping through the stderr output of
`pack-objects`, but doing so would be brittle in case the output format
changed.

Instead, let's use the trace2 mechanism to log various pieces of
information about the generated packfile, which we can then use to
compare against desired values.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7eb035eb7d..7aae9f104b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4595,6 +4595,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			   reuse_packfile_objects,
 			   (uintmax_t)reuse_packfiles_used_nr);
 
+	trace2_data_intmax("pack-objects", the_repository, "written", written);
+	trace2_data_intmax("pack-objects", the_repository, "written/delta", written_delta);
+	trace2_data_intmax("pack-objects", the_repository, "reused", reused);
+	trace2_data_intmax("pack-objects", the_repository, "reused/delta", reused_delta);
+	trace2_data_intmax("pack-objects", the_repository, "pack-reused", reuse_packfile_objects);
+	trace2_data_intmax("pack-objects", the_repository, "packs-reused", reuse_packfiles_used_nr);
+
 cleanup:
 	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
-- 
2.43.0.102.ga31d690331.dirty

