Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B167207
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PDYjqyUd"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20307e91258so46180fac.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592661; x=1703197461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fxM0jOl38/bE95GkRDzvnW1PJiCClC1Gv4ljevaEUQ=;
        b=PDYjqyUdXWQmn/D2pNs3n374r3CAJvWr62saMstXcJhlVAOwgowOWYD1AKFonaLDTH
         rMwRVZgovJSrlWHOnk7t0LkX1Dysil9OX/hOcRFPK+XGJdSI8YJeq0MOjItiAWcCXC8H
         NnWD9fw3UPNEJuXc8uF/1SeU92031YSJYuFPyoj79czJ3TrLvJM1RH4clgctxs/lWvy7
         g8rS2uDM9Ip01BTeWPXCAnr7YVh00HASfBWq1nXglwu4ls4CcWYI8Mrg/X5Y5EaIZX8V
         0+ktDU5GXewMfSMwJpM8U5+uGE1YaHQ00soAlnOYZsRkLT+fhtH28dU6rMhY4wCN/C3V
         gmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592661; x=1703197461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fxM0jOl38/bE95GkRDzvnW1PJiCClC1Gv4ljevaEUQ=;
        b=fEP1Vb92EvToCjhIdTK7oP+O9LJR5vVXb8mn9nH31iBoVmyXqChKCnmC59irj2H1aU
         6WehGvfVexuyrnh2qWIkuPk8J2NP9lE1c9shL4YEl5rFzPJXYaaRqRTj1NmYr4b0f35k
         fAN2FnCACPlfZK5135wYhQYCucINdE8yEohcem0rEBcU/m5YluSHxmqQPfrhdciMNa26
         0/gdk1HaWTIalXVaEivjIvMDFnLnjEPLK04RdpYYEe5LrhoQCMn2irT0mv9fj5kucwuD
         /IYQ3zglQUfGwZvJEKH6botSyDRxvd10z+0sWOZoxIqH0QifWu61FzP5y/rPCdRcEnbN
         fr2w==
X-Gm-Message-State: AOJu0YyxS98WbF8TyvL12DVmaeFD19582gKknQax6ryCGnE7QJCxZEqn
	NwX1UEAawEfirv+hYWTFP93MzerXZA+XcTTbcWN6Tw==
X-Google-Smtp-Source: AGHT+IEtXHaQFSvV7+0nogLJ9X25WxCL+2oJXgXU00bi6OAgZXqUBZhg0HiddFREz/Uy1m4DOa691g==
X-Received: by 2002:a05:6871:288f:b0:203:270:96b3 with SMTP id bq15-20020a056871288f00b00203027096b3mr5167740oac.118.1702592661252;
        Thu, 14 Dec 2023 14:24:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ot8-20020a056870cc8800b001fb2c8d6d05sm4767069oab.5.2023.12.14.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:21 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/26] pack-objects: include number of packs reused in
 output
Message-ID: <55696bc1c9fc4d8d99fc870b9f9f5c97dbb181e9.1702592604.git.me@ttaylorr.com>
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

In addition to including the number of objects reused verbatim from a
reuse-pack, include the number of packs from which objects were reused.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 31053128fc..7eb035eb7d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -223,6 +223,7 @@ static struct progress *progress_state;
 
 static struct bitmapped_pack *reuse_packfiles;
 static size_t reuse_packfiles_nr;
+static size_t reuse_packfiles_used_nr;
 static uint32_t reuse_packfile_objects;
 static struct bitmap *reuse_packfile_bitmap;
 
@@ -1265,6 +1266,8 @@ static void write_pack_file(void)
 			for (j = 0; j < reuse_packfiles_nr; j++) {
 				reused_chunks_nr = 0;
 				write_reused_pack(&reuse_packfiles[j], f);
+				if (reused_chunks_nr)
+					reuse_packfiles_used_nr++;
 			}
 			offset = hashfile_total(f);
 		}
@@ -4587,9 +4590,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
 			     " reused %"PRIu32" (delta %"PRIu32"),"
-			     " pack-reused %"PRIu32),
+			     " pack-reused %"PRIu32" (from %"PRIuMAX")"),
 			   written, written_delta, reused, reused_delta,
-			   reuse_packfile_objects);
+			   reuse_packfile_objects,
+			   (uintmax_t)reuse_packfiles_used_nr);
 
 cleanup:
 	clear_packing_data(&to_pack);
-- 
2.43.0.102.ga31d690331.dirty

