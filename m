Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C59C4727E
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D86208D5
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwtR8dtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgI2DhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgI2DhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:37:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D1C0613D0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k10so3658774wru.6
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=if/tLdO5VC7d820oFC6cy+yeCQhnDLeKBPiaXw+xkE4=;
        b=SwtR8dtxWFiFlo+/XAF4umRJ+xgDlpjCs7znH2aXBeecnjiOARQp03Bkw1/y1bpAk3
         3QQiHapJEGLVtF6sRXWyvs/YGPjV4YU436MNlefKV0t0tOHnSs2hSutIQaIiufaEGsbm
         be1VdsRKazNVVAH18AvMiCS5Lfo0RpKIeBOzf3CjYlbxne2Lth+3u+DHr0fDnp6nQfdd
         3pfxZ9CU1nQJ+wi0ZWVy5m5CpSmpRdZ2tEVNTJCQGqfaPD1MZVYMzmIrwqPHZOsL1SYg
         aFdPr4lNqAk1Mp+T+zrUkPYsZtmxDIYnw8Sxc3jt6xEVQWL/63qvehltvG36DYL2x2Uw
         MM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=if/tLdO5VC7d820oFC6cy+yeCQhnDLeKBPiaXw+xkE4=;
        b=PDvFxiJnwFBHFdMT6LLruiasfjJM/snFZbM7JUAN1QYotWaPOJd+UDuEKoQFKGnhV/
         XxT8o7wZX0ix/mlxqeAabiOLK2mBAdvVCBpCGgS3hhOdSXKfiQ5b60SUOhbuQO+8bnEX
         2jHC1pd+BsShOZhss7YR2t4kP2l68x2MoMVHSC7rLOqdbhTlO/o6j74xnWtI4/u/uY4d
         eZrahavSTigqM809Zs9JtM6+3FKjACtW6C0NKLeWpH0/eoB0Q5YOzKLTVJDGTzpUh6DX
         VLKhjgpFzkJU4yCQ+PG7T8jnEXAqeubh/piisbZcJI9TtgqCqyPfnCljMOIxORYu3bYG
         dj2Q==
X-Gm-Message-State: AOAM531JDDCcRS8bLARrV4cG4sNGx9NE+DawKEFPDMdu3imbYMYWptSV
        KtOlFWyg64MW8TPlXdD2aZ3YOH/VTIA=
X-Google-Smtp-Source: ABdhPJwoYzEC8sIK5yPHxAiZgVB+Hr1C+ucnKgq5GIOtWjoIkpkkWLMGR0W3PEUp2HPOJlBuF6JAjw==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr1559196wrq.282.1601350619808;
        Mon, 28 Sep 2020 20:36:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26sm3412207wmh.44.2020.09.28.20.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:36:59 -0700 (PDT)
Message-Id: <42dc18601ab09d1f9b45f0a37e7eda726d14599d.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:52 +0000
Subject: [PATCH v2 4/7] refs: consolidate remote name validation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

In preparation for a future patch, extract from remote.c a function that
validates possible remote names so that its rules can be used
consistently in other places.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Sean Barag <sean@barag.org>
---
 builtin/remote.c |  7 ++-----
 refspec.c        | 10 ++++++++++
 refspec.h        |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 64b4b551eb..63f2b46c3d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -194,8 +194,7 @@ static int add(int argc, const char **argv)
 	if (remote_is_configured(remote, 1))
 		die(_("remote %s already exists."), name);
 
-	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
-	if (!valid_fetch_refspec(buf2.buf))
+	if (!valid_remote_name(name))
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
@@ -696,11 +695,9 @@ static int mv(int argc, const char **argv)
 	if (remote_is_configured(newremote, 1))
 		die(_("remote %s already exists."), rename.new_name);
 
-	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new_name);
-	if (!valid_fetch_refspec(buf.buf))
+	if (!valid_remote_name(rename.new_name))
 		die(_("'%s' is not a valid remote name"), rename.new_name);
 
-	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s", rename.old_name);
 	strbuf_addf(&buf2, "remote.%s", rename.new_name);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
diff --git a/refspec.c b/refspec.c
index 8d0affc34a..3056ffdfb8 100644
--- a/refspec.c
+++ b/refspec.c
@@ -215,6 +215,16 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	return ret;
 }
 
+int valid_remote_name(const char *name)
+{
+	int result;
+	struct strbuf refspec = STRBUF_INIT;
+	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
+	result = valid_fetch_refspec(refspec.buf);
+	strbuf_release(&refspec);
+	return result;
+}
+
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes)
 {
diff --git a/refspec.h b/refspec.h
index 7569248d11..bbb25968a8 100644
--- a/refspec.h
+++ b/refspec.h
@@ -62,6 +62,7 @@ void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 void refspec_clear(struct refspec *rs);
 
 int valid_fetch_refspec(const char *refspec);
+int valid_remote_name(const char *name);
 
 struct strvec;
 /*
-- 
gitgitgadget

