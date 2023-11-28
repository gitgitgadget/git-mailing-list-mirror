Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nvVTDDYK"
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74C92
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:44 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d817ccaa6dso2067134a34.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198523; x=1701803323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XYPYw4QcsT+ncSJlBUK7JQLmFa9VjpCKiOD0dkIe5E=;
        b=nvVTDDYKLWokrI+7ZpDK/djx2AkY60cG+oRpiJk5QBL1gjv3T/QbSKVEkCG7wEsapk
         KbnY/dPb3czGoC6COMxqqiXDLTlvd1tovtIf+tmjSWu9SiIEEsrd8Auz40MfvX5s7oGK
         nvFQAZCnppgCxPVxMZomkNR2NW2wMfiP55SpMSLZOGtbL6vMSGjWaBJ6CNyNH2OLvS5R
         KqDrC3UspK+OXkv7PYjBp7u1//nXetm4fIsMjcMjOF/Wjk0d8l43D2ITkyoKRiGg2Tq2
         qLqYhg0D7nQ3OpO47fXfQEEDPsZWahqm4S8G1jdcYrL2MO6T3IwgfVdoCXsfmh1HyB/x
         yZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198523; x=1701803323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XYPYw4QcsT+ncSJlBUK7JQLmFa9VjpCKiOD0dkIe5E=;
        b=uptQas0y6hUs5bpughkMBZrNx3OfPluJSHJvftE0bNxwfJZQN9bN4kq/qzWtmIBDp5
         eOakbC0fzez9wcpwlhsYD6N134I7A8tNgA+WIuZH0+lP4PrPHe2ZnOgXVSPGYB5kbgaC
         ZgwnWqz+bAyaQfJE+QB0Lfmy6g9dqlafO8dnxu1Gf+IBO3hq+xfxcRGxApnzAAImRV7U
         PplcnKBJvdsw5+BIkljy+0UzF45/pkg7R7HqaGOltafo5tQLlFt+5LY+5fYiv1gZsCmx
         QqRKTgiXpBvlr9HYJOI7sU/FKoJRfW7MGx9slvij0oyhBPSH/V/et4/YkMKPBC9uya9x
         +HlA==
X-Gm-Message-State: AOJu0Yx8niMX80Fn9Tv0xhpyjFsRmAy/mpelbbPTLtPz0NYRGcjeakUA
	NqpzwXvgXOWGBeGx0X+ijYuyR7l4OwVS/H5ZGrerwA==
X-Google-Smtp-Source: AGHT+IFMTfbOGU/R2LDK7fQF+9EIK1fL/ZBJ18szCO7R2j9yATrQ+lLLzwbVG/PLfs511GAVdJ8e/g==
X-Received: by 2002:a9d:7382:0:b0:6d7:f8c7:1a73 with SMTP id j2-20020a9d7382000000b006d7f8c71a73mr17675235otk.24.1701198523508;
        Tue, 28 Nov 2023 11:08:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gv9-20020a056214262900b0067a2354f8besm3808396qvb.91.2023.11.28.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:43 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/24] pack-objects: include number of packs reused in output
Message-ID: <4cd9f99bfdda0fa7db2372ca194572df1000304f.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

In addition to including the number of objects reused verbatim from a
reuse-pack, include the number of packs from which objects were reused.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e37509568b..902e70abc5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -224,6 +224,7 @@ static struct progress *progress_state;
 
 static struct bitmapped_pack *reuse_packfiles;
 static size_t reuse_packfiles_nr;
+static size_t reuse_packfiles_used_nr;
 static uint32_t reuse_packfile_objects;
 static struct bitmap *reuse_packfile_bitmap;
 
@@ -1266,6 +1267,8 @@ static void write_pack_file(void)
 			for (j = 0; j < reuse_packfiles_nr; j++) {
 				reused_chunks_nr = 0;
 				write_reused_pack(&reuse_packfiles[j], f);
+				if (reused_chunks_nr)
+					reuse_packfiles_used_nr++;
 			}
 			offset = hashfile_total(f);
 		}
@@ -4612,9 +4615,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
 	free_packing_data(&to_pack);
-- 
2.43.0.24.g980b318f98

