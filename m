Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3D2EB14
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="y2oFkT9z"
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3CED73
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 14:56:32 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ba962d534eso2047688241.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699311391; x=1699916191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmbAJOPvOxlonyTOSHSXWfRz8/PAZTQqB3RHCadHKOs=;
        b=y2oFkT9zUeB18YsJtBIpyN7Ce7gxiRvipLPWpYY6pymE3ArH1Gi4I+Nb2fTvUJMaTx
         2IYoEBFBQmhs3EmbfSPgeVCCL7vUELX6GUlWXUwTvrYfhUXro1Im5dT5HV+ewTj88AgE
         vgl+5oLLtCl+e2s1Dzl+LQPzX4b8AFWL/wY77U2FWb8VRJk/ftx/Vf5nmHTtKwGN/IQW
         NfX7ST/DQd0M/IaIiWgxwHxvC9kUrz8gh2Pkcr7rt9htYP4EUnDXvkxVOSzhsWhI6Vht
         kveAEqf8Rgea9pDs/092X0lFZ2f9cOBoD7o4XttRdhexHq1G2MiXpxB7nAtNvLWEtuqy
         +Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311391; x=1699916191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmbAJOPvOxlonyTOSHSXWfRz8/PAZTQqB3RHCadHKOs=;
        b=cqAIC+aF492eDqI4jE6JTYUfVxW1NtZ4naZHZjsbpxut23qgoQf558LJ9Pd42aqm3r
         6PmmIjM6OAMUGcltl7phuOrt4OOd56I+ijPxZt26Aa20frGYJsk887FNMe20GbdSGLYb
         JE5MgcAkUCWwMk/6n6mprNSnjb43Od1oM7AzjDLHl5/5hYxDiJA2QgvxhQKn5CP5M/u+
         38agK7yn1xqrZV0pBqXzd/rUkgvUXdZvC7HzmMjO/ZfmkEHHbL58fZeHXI/H8VKAZW/I
         A5TtHLPHSuIyL3vyt+8knMykUzLQ1hZwgeM2VTIqqoDimFllAyd59/Ue11HZSC6vsuiF
         27+A==
X-Gm-Message-State: AOJu0YxAljjDX831oszneeKP6o6BuRaA9GUEDJsNoqeEmw53ZgpaHo3W
	22srpibyTaVOug7FJ8T0NT1T2cI+aCIx/QNDsOxHhw==
X-Google-Smtp-Source: AGHT+IHvgRpHln9tXufuMWruxGhKS6YoHcAI9Iut21ONo2pLtIOy2jeIML/9jZa0Q6G52WYoIE6+tw==
X-Received: by 2002:a05:6102:c93:b0:45f:3b30:9ca9 with SMTP id f19-20020a0561020c9300b0045f3b309ca9mr4408178vst.15.1699311391562;
        Mon, 06 Nov 2023 14:56:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gb7-20020a05622a598700b00418189b689csm3861374qtb.10.2023.11.06.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:56:31 -0800 (PST)
Date: Mon, 6 Nov 2023 17:56:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] list-objects: drop --unpacked non-commit objects from
 results
Message-ID: <d3992c98aaa54c3635c249a15d919aa1177324d8.1699311386.git.me@ttaylorr.com>
References: <cover.1699311386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699311386.git.me@ttaylorr.com>

In git-rev-list(1), we describe the `--unpacked` option as:

    Only useful with `--objects`; print the object IDs that are not in
    packs.

This is true of commits, which we discard via get_commit_action(), but
not of the objects they reach. So if we ask for an --objects traversal
with --unpacked, we may get arbitrarily many objects which are indeed
packed.

I am nearly certain this behavior dates back to the introduction of
`--unpacked` via 12d2a18780 ("git rev-list --unpacked" shows only
unpacked commits, 2005-07-03), but I couldn't get that revision of Git
to compile for me. At least as early as v2.0.0 this has been subtly
broken:

    $ git.compile --version
    git version 2.0.0

    $ git.compile rev-list --objects --all --unpacked
    72791fe96c93f9ec5c311b8bc966ab349b3b5bbe
    05713d991c18bbeef7e154f99660005311b5004d v1.0
    153ed8b7719c6f5a68ce7ffc43133e95a6ac0fdb
    8e4020bb5a8d8c873b25de15933e75cc0fc275df one
    9200b628cf9dc883a85a7abc8d6e6730baee589c two
    3e6b46e1b7e3b91acce99f6a823104c28aae0b58 unpacked.t

There, only the first, third, and sixth entries are loose, with the
remaining set of objects belonging to at least one pack.

The implications for this are relatively benign: bare 'git repack'
invocations which invoke pack-objects with --unpacked are impacted, and
at worst we'll store a few extra objects that should have been excluded.

Arguably changing this behavior is a backwards-incompatible change,
since it alters the set of objects emitted from rev-list queries with
`--objects` and `--unpacked`. But I argue that this change is still
sensible, since the existing implementation deviates from
clearly-written documentation.

The fix here is straightforward: avoid showing any non-commit objects
which are contained in packs by discarding them within list-objects.c,
before they are shown to the user. Note that similar treatment for
`list-objects.c::show_commit()` is not needed, since that case is
already handled by `revision.c::get_commit_action()`.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects.c           |  3 +++
 t/t6000-rev-list-misc.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/list-objects.c b/list-objects.c
index c25c72b32c..c8a5fb998e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -39,6 +39,9 @@ static void show_object(struct traversal_context *ctx,
 {
 	if (!ctx->show_object)
 		return;
+	if (ctx->revs->unpacked && has_object_pack(&object->oid))
+		return;
+
 	ctx->show_object(object, name, ctx->show_data);
 }
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 12def7bcbf..6289a2e8b0 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -169,4 +169,17 @@ test_expect_success 'rev-list --count --objects' '
 	test_line_count = $count actual
 '
 
+test_expect_success 'rev-list --unpacked' '
+	git repack -ad &&
+	test_commit unpacked &&
+
+	git rev-list --objects --no-object-names unpacked^.. >expect.raw &&
+	sort expect.raw >expect &&
+
+	git rev-list --all --objects --unpacked --no-object-names >actual.raw &&
+	sort actual.raw >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0.rc0.2.gef6b2154a3

