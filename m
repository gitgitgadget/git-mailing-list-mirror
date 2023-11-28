Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xXUmDOHp"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB819A7
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:55 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77d708e4916so306775885a.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198534; x=1701803334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+HnTrDUlLfFrEvRBf2+sp7Svlm3XV3W17W8ck0s8Vg=;
        b=xXUmDOHpWucW17oWjqCOG5I07/K3izTR1WgC/NVEgc3jRTvvBi1TXUinH/QSVZtj4d
         EtDYO60Tu2g6O/+PFti46prfj6Vm4rZ+qk4somsGT5hYUzJ0F3uYwJrXsw3k22UlqxXs
         vUeyO/+H57ite9TSw3JFpDPen7cIMn0pobsdQImidFCq/gHeImPJJXFOK2jaX8w3Hyot
         frdAyZs/ycWbvwmOB70SHExTCPcqzlrQPKissK5NqKunJNslZt5IjBJgJoZc9ChH63v2
         ciu7fR+fEiREIohBcnRlimS4AOVjQtvEMQNjRrNV/LtjmO9qWLr5OZCYhpZhz61n0L4V
         Irwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198534; x=1701803334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+HnTrDUlLfFrEvRBf2+sp7Svlm3XV3W17W8ck0s8Vg=;
        b=q6f48r/L4BSwcpJ6Vg6UH04viGlb+NMZicGUcuJf4PuDLGIot176JWlih6JLX7K2Hu
         1Be7f29Hqw86HnhRLeByDSiCirSULC2dSXlVq9weiGBnQyq9EhUrAyTFCRUNnInF5P38
         sXJ1KAhgTIGYiYFV/kQTy0xn5so/uFFVUg950k437RUpSCRzhXinTbM5v++PwrEgY348
         2N6rtq3bLeYvgoyUMxK4FZpKEDuC+LYLGGr6D9FltXlCsOpBCv7c3/ONzbGoBHs1rtt4
         H9sDBNEKtI9gf5ekok971ehh9ORd5bXwtcSpA0CesMFheGbywWn28G+aMXZ3NuWOZ4EQ
         3kXg==
X-Gm-Message-State: AOJu0YzNS3ySsdrOg37NfdV8KqxEXkhA9qw2iap9dJzWsO4tzUPZ0xDq
	glEjj0hxUEj+rIxYsItk/cd/BRN7fnCUpHy/3C0=
X-Google-Smtp-Source: AGHT+IGxaE8ImNoF7U7VZoKd8C5gGQMeIABvjNTGv1s3cE7DFAsy8tYyuYyS0//76fFALcU2jWdIbw==
X-Received: by 2002:a05:620a:1402:b0:77b:c536:3722 with SMTP id d2-20020a05620a140200b0077bc5363722mr16353079qkj.25.1701198534518;
        Tue, 28 Nov 2023 11:08:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b0076efaec147csm4704615qkk.45.2023.11.28.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:53 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 22/24] pack-objects: allow setting `pack.allowPackReuse` to
 "single"
Message-ID: <3140a1703a7a0dbf2787b953c7cdb0c0e1803a6f.1701198172.git.me@ttaylorr.com>
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

In e704fc7978 (pack-objects: introduce pack.allowPackReuse, 2019-12-18),
the `pack.allowPackReuse` configuration option was introduced, allowing
users to disable the pack reuse mechanism.

To prepare for debugging multi-pack reuse, allow setting configuration
to "single" in addition to the usual bool-or-int values.

"single" implies the same behavior as "true", "1", "yes", and so on. But
it will complement a new "multi" value (to be introduced in a future
commit). When set to "single", we will only perform pack reuse on a
single pack, regardless of whether or not there are multiple disjoint
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
index fa71fe1ccf..4853e91251 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -230,7 +230,10 @@ static struct bitmap *reuse_packfile_bitmap;
 
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
@@ -3246,7 +3249,17 @@ static int git_pack_config(const char *k, const char *v,
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
@@ -4002,7 +4015,7 @@ static void loosen_unused_packed_objects(void)
  */
 static int pack_options_allow_reuse(void)
 {
-	return allow_pack_reuse &&
+	return allow_pack_reuse != NO_PACK_REUSE &&
 	       pack_to_stdout &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
-- 
2.43.0.24.g980b318f98

