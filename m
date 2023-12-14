Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6766AB7
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v6bw8MfU"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ba2dd905f9so38502b6e.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592683; x=1703197483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKqbkIfE9C+xd6Y3exjFR6YVRIjozkCh/v7fzBRb+QM=;
        b=v6bw8MfUnCCxni5Njkusy8j8esrw6XJWZ2a76mRgwo2DuFL1myw9V3tir2ngKzZlIA
         g5/LpiF6/SgpB/H8a6CQpOlKqK8MBhliOlcPnfJCM1/apUrxfnoO6fbSFoqtZwl1ocg2
         AWAjkq9pKOlOKJIU774PrIs+VBIw3dtCwZBQebXslPoNR80F1YMclSiubMOhv7YJwDE5
         yOwWq0DbVh2Air5/eUTL41I+hHPz3E188NsCphwfXV6NqG2NEjMyEEgiQzb9j88vFe5/
         PicwediXOTIJYMV2zRFXMbMDvgsZrLPHZGsi+Rn9oW6Adlke0SgK0dRPqNukUvSD2o8b
         iPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592683; x=1703197483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKqbkIfE9C+xd6Y3exjFR6YVRIjozkCh/v7fzBRb+QM=;
        b=PAzApScnXjK1LHcxaRjAH4x31iMflX41w3Z37DEAXNfTD8R1xDeQt9B9qIlYUcDiBc
         zVcMUODGvFq/v5WB6zBjSDDvw/gzSQ22TA9EtCDoeoI4YTynjR8ibiDmTqkf46Ph8lu1
         hjFpuwEf1Hok1FKlWzsILU/nr7RNZ0V9Uwj7Vi2WE1RTEuNbx/CqLMK15UYKh/T325oM
         Otywc8sopVLgjBD99yAvsR47JC8pU3FAglKGtt5scxyZTU6OlxH9f3rtWQtLJ7WdNKPQ
         XWDimOV8cra91sIqXkFFrh0ESHziBYmYNfHpuqjhp/ijtFREIEm8ZBw9SbDFhXPOJaxI
         JNHQ==
X-Gm-Message-State: AOJu0YxTSB0puVh94QPhoLAzSQ4BFpCz930e8AmcterpMjzQtm0JR1uq
	1Qpbzjno98VkKuPt1d/E9iN4/aJwnnNfthK4yNLMeA==
X-Google-Smtp-Source: AGHT+IF5zwimxicbhsjfhOX5r8oHLv8UjOhb3vdkojeKnGJCcVjESudUR69aKY9IbbbHg2UwZp+RTw==
X-Received: by 2002:a05:6808:22a4:b0:3ae:1298:257a with SMTP id bo36-20020a05680822a400b003ae1298257amr11246154oib.1.1702592682915;
        Thu, 14 Dec 2023 14:24:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bp6-20020a056808238600b003b2e4511f22sm634092oib.17.2023.12.14.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:42 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 24/26] pack-objects: allow setting `pack.allowPackReuse`
 to "single"
Message-ID: <d06b0961b53c67b1e95f189f5eca888626cb9048.1702592604.git.me@ttaylorr.com>
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

In e704fc7978 (pack-objects: introduce pack.allowPackReuse, 2019-12-18),
the `pack.allowPackReuse` configuration option was introduced, allowing
users to disable the pack reuse mechanism.

To prepare for debugging multi-pack reuse, allow setting configuration
to "single" in addition to the usual bool-or-int values.

"single" implies the same behavior as "true", "1", "yes", and so on. But
it will complement a new "multi" value (to be introduced in a future
commit). When set to "single", we will only perform pack reuse on a
single pack, regardless of whether or not there are multiple MIDX'd
packs.

This requires no code changes (yet), since we only support single pack
reuse.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt |  2 +-
 builtin/pack-objects.c        | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index f50df9dbce..fe100d0fb7 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -28,7 +28,7 @@ all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
 pack.allowPackReuse::
-	When true, and when reachability bitmaps are enabled,
+	When true or "single", and when reachability bitmaps are enabled,
 	pack-objects will try to send parts of the bitmapped packfile
 	verbatim. This can reduce memory and CPU usage to serve fetches,
 	but might result in sending a slightly larger pack. Defaults to
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7aae9f104b..684698f679 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -229,7 +229,10 @@ static struct bitmap *reuse_packfile_bitmap;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
-static int allow_pack_reuse = 1;
+static enum {
+	NO_PACK_REUSE = 0,
+	SINGLE_PACK_REUSE,
+} allow_pack_reuse = SINGLE_PACK_REUSE;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
 	WRITE_BITMAP_QUIET,
@@ -3244,7 +3247,17 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.allowpackreuse")) {
-		allow_pack_reuse = git_config_bool(k, v);
+		int res = git_parse_maybe_bool_text(v);
+		if (res < 0) {
+			if (!strcasecmp(v, "single"))
+				allow_pack_reuse = SINGLE_PACK_REUSE;
+			else
+				die(_("invalid pack.allowPackReuse value: '%s'"), v);
+		} else if (res) {
+			allow_pack_reuse = SINGLE_PACK_REUSE;
+		} else {
+			allow_pack_reuse = NO_PACK_REUSE;
+		}
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -3999,7 +4012,7 @@ static void loosen_unused_packed_objects(void)
  */
 static int pack_options_allow_reuse(void)
 {
-	return allow_pack_reuse &&
+	return allow_pack_reuse != NO_PACK_REUSE &&
 	       pack_to_stdout &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
-- 
2.43.0.102.ga31d690331.dirty

