Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3111FC433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355986AbiAYCAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1845353AbiAXXSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 18:18:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9CEC07E28F
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:44:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id o12so24412135eju.13
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=L/Xm0pshxiAUEz5nN7HGKCAFlW9uCriFbVEhvIBH2EA=;
        b=OIG39dvDteGVgiJoDyOn2s5mdXHyumy5tGjFIRl4lCWs67Q7YeWZlxrmU+zRAKUhkT
         x+hKQ5T/dswhxQHeIibvXO6lQc4EvnLNrIfL1+3Vaao8bSeIbvRtUvYnD9efdyr5XKAp
         vh+hAe7Wk2HtstL5yrhKhE1HClSf15fLfy4NBOoYO9UF+nO3QsqzJivK3z4CPxnssaMh
         ltWM8aglrdk1wqBhMKoqhZc7M4ezu/tsVOX1ABN+2uFKc5qO/B8HvXPVDE9nyP+ebH1F
         A1cstS4xJC22xJ0aVrJmpisNu2Jt7bXsYSkwAhb52SJThOimeZ/GrNGkpKA6/UwUOj48
         TWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=L/Xm0pshxiAUEz5nN7HGKCAFlW9uCriFbVEhvIBH2EA=;
        b=ejnc/Y3N8W8a389+6IeLIwrer/rV/t7hyk74we0UajS1yXp56Rw5p5oj16nTcYCAyk
         Nmct8HsW39YMTK/BzoQJso4EnaKaEY3mcNip3ijY+vIq9uNu7aSxQP8B8cxbcMOJZqsO
         fVz4IEob7Jyd4e401QPQ4v/JQCRJn6eI4aHX8QCKt/T6jzY8BIBvVeEdE+Vid+t5TFad
         nZxr7DBykZi/sSgsbe4eUmpdG0HJ687VNfxwlZvbnvvFvA7rSPKCwTrtmc+7Hv6NiMsQ
         t9C7dgI/bgsMPq4oPHrjG0p+HJ4hAbC2r43tFpVK26bzvG/EkGbdP4Pj5Q1es68t7V2r
         F5GQ==
X-Gm-Message-State: AOAM531qhSszuDwL1wnzEW2jprfh3GxSOl4PPlzYc64AwmRtmwWsea3R
        PT8SI+tuQivfCnrma16u8B92J66bSAQ=
X-Google-Smtp-Source: ABdhPJxBQ42V+CMAxqxv3V1Ej5Nk7ttVJSPpeQ1y6akgPpVztfeDW3m25iPW02SIetf3BrGqSBk63w==
X-Received: by 2002:a17:907:7da0:: with SMTP id oz32mr11566370ejc.462.1643053480972;
        Mon, 24 Jan 2022 11:44:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fn3sm5266664ejc.58.2022.01.24.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:44:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nC5GZ-002a39-SE;
        Mon, 24 Jan 2022 20:44:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v7 14/16] reftable: make reftable_record a tagged union
Date:   Mon, 24 Jan 2022 20:39:20 +0100
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
 <047bbb75fcbb67c41d307bf5fa44587a76cc0777.1643051624.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <047bbb75fcbb67c41d307bf5fa44587a76cc0777.1643051624.git.gitgitgadget@gmail.com>
Message-ID: <220124.86ilu8hqag.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> [...]
> @@ -129,17 +130,25 @@ void reftable_iterator_destroy(struct reftable_iterator *it)
>  int reftable_iterator_next_ref(struct reftable_iterator *it,
>  			       struct reftable_ref_record *ref)
>  {
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_ref(&rec, ref);
> -	return iterator_next(it, &rec);
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_REF,
> +		.u.ref = *ref,
> +	};
> +	int err = iterator_next(it, &rec);
> +	*ref = rec.u.ref;
> +	return err;
>  }

I didn't test the v6 on xlc on AIX 7.1, but found that it refuses to
compile this code (but the one on AIX 7.2 is OK with it):
    
    "reftable/generic.c", line 135.26: 1506-196 (S) Initialization between types "char*" and "struct reftable_ref_record" is not allowed.
    "reftable/generic.c", line 147.26: 1506-196 (S) Initialization between types "char*" and "struct reftable_log_record" is not allowed.
    "reftable/writer.c", line 261.26: 1506-196 (S) Initialization between types "char*" and "struct reftable_ref_record" is not allowed.
    "reftable/writer.c", line 312.26: 1506-196 (S) Initialization between types "char*" and "struct reftable_log_record" is not allowed.
    "reftable/writer.c", line 406.45: 1506-196 (S) Initialization between types "unsigned long long" and "struct reftable_index_record" is not allowed.

I.e. you're dereferencing a struct type here to get at its first member,
I'm surprised that gcc and clang don't complain about it.

I think that the below fix-up for this series as a whole (didn't check
if it was just this patch) should fix it:

diff --git a/reftable/generic.c b/reftable/generic.c
index b176c1cde0a..fe8f060a689 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -132,7 +132,7 @@ int reftable_iterator_next_ref(struct reftable_iterator *it,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.u.ref = *ref,
+		.u.ref = { ref->refname },
 	};
 	int err = iterator_next(it, &rec);
 	*ref = rec.u.ref;
@@ -144,7 +144,7 @@ int reftable_iterator_next_log(struct reftable_iterator *it,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.u.log = *log,
+		.u.log = { log->refname },
 	};
 	int err = iterator_next(it, &rec);
 	*log = rec.u.log;
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 847abfa2b04..be99de5194b 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -337,7 +337,7 @@ static void test_reftable_obj_record_roundtrip(void)
 		};
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_OBJ,
-			.u.obj = recs[i],
+			.u.obj = { recs[i].hash_prefix },
 		};
 		struct strbuf key = STRBUF_INIT;
 		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
diff --git a/reftable/writer.c b/reftable/writer.c
index 5b768438625..6cc2ef9acaf 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -258,7 +258,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.u.ref = *ref,
+		.u.ref = { ref->refname },
 	};
 	int err = 0;
 
@@ -309,7 +309,7 @@ static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
 {
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_LOG,
-		.u.log = *log,
+		.u.log = { log->refname },
 	};
 	if (w->block_writer &&
 	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
@@ -403,7 +403,7 @@ static int writer_finish_section(struct reftable_writer *w)
 		for (i = 0; i < idx_len; i++) {
 			struct reftable_record rec = {
 				.type = BLOCK_TYPE_INDEX,
-				.u.idx = idx[i],
+				.u.idx = { idx[i].offset },
 			};
 			if (block_writer_add(w->block_writer, &rec) == 0) {
 				continue;
