Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884AC63798
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536CF21534
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klu1faWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgKZB3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZB3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCA6C061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a65so561285wme.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+Oer4GSRchoXVNYtlL5I1oxz4Ket+on6CG5jj0l5gg=;
        b=klu1faWJaj60BWzwksk5Yl1SCnoRQYUwdWSennGDWBGUfiu5q7HuH8cOs44JHUlw73
         ipxzOZ5mtF+9Uex9x1nqM/tNwZ9oTVUMuJ89ZP3ycmU6ZAuP1ZWDxfJ00Ad13f0RpbZ3
         vPSyDwbeDVz5oRxfW+IHKNFaKgeR/jlrOIQYn6/aw5y8R0f39CMhE6mNJghDDubRDRsd
         yhK5xULDJx2gMw/vnQm6f3Du0qe+qy5Z6WkW/0pQXgIxVXEtHP6+QlVnG9j6iHBZt5Rg
         xOROJw1xINpU8AqJ+PCVzu3tlphUb33VEOCF9bz6UROfDyBMq+UlqJCLjJfqNR9CdEnB
         GvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+Oer4GSRchoXVNYtlL5I1oxz4Ket+on6CG5jj0l5gg=;
        b=jxKia+jYPdUma/T+kDQWvDYeB3c7HXgad4BP8nCmQshwRbItkjZMsNquFHDBCfV008
         GYP5OVay8j6yGXD9Q9M1uhXMKNAAne5sptbbULJH4in14ZIuPq93PPsKeGq2p+gApXkL
         yQZJxb0UAQqQy1H8U/hxBj2pisXNFAucss4oqC38q5q3oiot0qml70/tLgp0YdDv94ic
         xrWA7SzEPtvYlZDhN8pUcK3Gba9GP7BlhXbWlZQmcIA7FA8LZaDsfmpVpvxfM/10QQLA
         W8mUXRRNvxo73bznsJxuPBrpptu6K3e+T8GR9z7CCDTJm46OCQJxovJDa6gOnM61wiYb
         h9iA==
X-Gm-Message-State: AOAM532FNwG0l8Bg7R74JBnJpUMYKVlCPkmcWybmzFA23XVNCidtp8HQ
        5xEf0aiKRZXMy3LEgrao0OPfqQlxa27jTA==
X-Google-Smtp-Source: ABdhPJz6Y0k4QPd9wNehiquukZkZbC4m+0Hr4joy6zsUFsvDcRQ4WMqK9lb8CeVXoDpsRVvLQ5SlMg==
X-Received: by 2002:a1c:ded4:: with SMTP id v203mr443162wmg.93.1606354141907;
        Wed, 25 Nov 2020 17:29:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 02/12] mktag: reword write_object_file() error
Date:   Thu, 26 Nov 2020 02:28:44 +0100
Message-Id: <20201126012854.399-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error message emitted when write_object_file() fails to
make more sense. At this point we're not writing a "tag file" (which
as an aside we never do, we just write to stdout). We are writing an
annotated tag object, let's say that instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index ff7ac8e0e5..603b55aca0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -171,7 +171,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 		die("invalid tag signature file");
 
 	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
-		die("unable to write tag file");
+		die("unable to write annotated tag object");
 
 	strbuf_release(&buf);
 	printf("%s\n", oid_to_hex(&result));
-- 
2.29.2.222.g5d2a92d10f8

