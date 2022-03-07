Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A6C4332F
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiCGP2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbiCGP2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:28:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A392D04
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:27:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u10so22258163wra.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1hozro8p3OYJHhPJ/DMIJf42E8AfCW8HABwTasbPYo=;
        b=fC7GgNY5lF9JuNb2FU3LjU+4mRBi+/c2WBhD4Dp78dukwTy3MgVxoqD5eSfGqKL6gF
         Hs4oOIf2989J6ohlW+9g7LG6SlYC++hgDRSqUNy6ufpq12CoWpCYjWyRWHFI/ifjLx5F
         cTwgwVEoFHxTTx02j6wbGgWc78iZbWShkBHmeYV60xA8oJ0t00elw8LjMAZFJB74Q3Lz
         DDhzTBUeTeLljF+8TpDjpw22J5ApLXm4CJpF33O0Y5GEYXzecDcF2/l0YjBDveHVzt9F
         efVKmdB7y+0jpzJ25eX2nkqzU3ytbxC48UPWt6cRbsBQBLrO7XjlFGj5ZOqe1VyIH07V
         3xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1hozro8p3OYJHhPJ/DMIJf42E8AfCW8HABwTasbPYo=;
        b=wprHBXl26zcvI8nwikLsv9oLaqdY7nrOhW3MoS8Bx2kHHzR1tDCTKkduY1e1F36EMX
         EdhfrVNibi7eXa2nSiVyGNnpuK4CpExwK10NBgaHWT8Vp6PEqDRa+yf4f2ZHpzVut3LU
         Lj3kd+mZwz2p6Tbt7ZgKc+HosuzqqfQ9gPEhnXRdGio5Qo2aszIyi3NUBm2OBYEUhBat
         dPCiT9o4W//mXf9e77BntP5bjdFB65hayefYjlqVYT4MPL6mO3uSSdZqWCQo0PzQxhEU
         MnTvyzxVciuvmKq3DHm2eaxtqAVvWV+9WGCaupDxkCdm97LoWutBu0fhwRw4JcJQWR/x
         oYaw==
X-Gm-Message-State: AOAM533rk5IIhp/ef1WF5XKdi6fL+Sh4bdu4GhEem/ssCALfyWNXFjGH
        yBw+D5BF32fufioO+8wFL+9g+eugnv+7xw==
X-Google-Smtp-Source: ABdhPJxxnYTPiDTzrzEucC8KQ9Mk1zgvyR8X2YJydPjE3/iQ+a+V7QS/IcL9ckctObS4txSYjcTq0Q==
X-Received: by 2002:adf:ea85:0:b0:1f0:1251:1eb9 with SMTP id s5-20020adfea85000000b001f012511eb9mr8711149wrm.455.1646666831373;
        Mon, 07 Mar 2022 07:27:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm16927214wmq.2.2022.03.07.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:27:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] gettext API users: don't explicitly cast ngettext()'s "n"
Date:   Mon,  7 Mar 2022 16:27:07 +0100
Message-Id: <patch-v2-1.2-83fd21741ad-20220307T152316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220307T152316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a few stray users of the inline gettext.h Q_() function to stop
casting its "n" argument, the vast majority of the users of that
wrapper API use the implicit cast to "unsigned long".

The ngettext() function (which Q_() resolves to) takes an "unsigned
long int", and so does our Q_() wrapper for it, see 0c9ea33b90f (i18n:
add stub Q_() wrapper for ngettext, 2011-03-09). The function isn't
ours, but provided by e.g. GNU libintl.

This amends code added in added in 7171a0b0cf5 (index-pack: correct
"len" type in unpack_data(), 2016-07-13). The cast it added for the
printf format to die() was needed, but not the cast to Q_().

Likewise the casts in strbuf.c added in 8f354a1faed (l10n: localizable
upload progress messages, 2019-07-02) and for
builtin/merge-recursive.c in ccf7813139f (i18n: merge-recursive: mark
error messages for translation, 2016-09-15) weren't needed.

In the latter case the cast was copy/pasted from the argument to
warning() itself, added in b74d779bd90 (MinGW: Fix compiler warning in
merge-recursive, 2009-05-23). The cast for warning() is needed, but
not the one for ngettext()'s "n" argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c      | 2 +-
 builtin/merge-recursive.c | 2 +-
 strbuf.c                  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..89339e83a0d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -579,7 +579,7 @@ static void *unpack_data(struct object_entry *obj,
 		if (!n)
 			die(Q_("premature end of pack file, %"PRIuMAX" byte missing",
 			       "premature end of pack file, %"PRIuMAX" bytes missing",
-			       (unsigned int)len),
+			       len),
 			    (uintmax_t)len);
 		from += n;
 		len -= n;
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index a4bfd8fc51d..b9acbf5d342 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -58,7 +58,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 				   "Ignoring %s.",
 				   "cannot handle more than %d bases. "
 				   "Ignoring %s.",
-				    (int)ARRAY_SIZE(bases)-1),
+				    ARRAY_SIZE(bases)-1),
 				(int)ARRAY_SIZE(bases)-1, argv[i]);
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
diff --git a/strbuf.c b/strbuf.c
index 00abeb55afd..dd9eb85527a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -875,9 +875,9 @@ static void strbuf_humanise(struct strbuf *buf, off_t bytes,
 		strbuf_addf(buf,
 				humanise_rate == 0 ?
 					/* TRANSLATORS: IEC 80000-13:2008 byte */
-					Q_("%u byte", "%u bytes", (unsigned)bytes) :
+					Q_("%u byte", "%u bytes", bytes) :
 					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
-					Q_("%u byte/s", "%u bytes/s", (unsigned)bytes),
+					Q_("%u byte/s", "%u bytes/s", bytes),
 				(unsigned)bytes);
 	}
 }
-- 
2.35.1.1242.gfeba0eae32b

