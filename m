Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D8C47420
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDC821D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkSIpulA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgJADqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgJADqX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB05C0613D1
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x14so3949796wrl.12
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=if/tLdO5VC7d820oFC6cy+yeCQhnDLeKBPiaXw+xkE4=;
        b=CkSIpulAxYpNvODpCtBFRy+JKFPJetRN6h8+2i0ZBQoyP2FLysoRl4Ji9H//NNPRlS
         kl01fxZ96A54B8hKiFEO5LTlsfQUmV9ddv1V5NmKvLGcdcqk6V/nwkLMaAEKTPt2VFcU
         GfLr4ZeRFm3aKKKdYYx/ncKURCdgkD4dvlAPIFjem4e87N4jQJZBxUGm4XAGG7GUiak3
         3C3cYNtL9Bg63ll8d99J2HafRwDkc+Q5czylva85mtVgzHa59tXpu+E30zJzOL/fGoCT
         gzLJ3l/C7BZwhSeTcmPNe9VhjHOa7sc8Qd0QwZaH/i2opjniTU53IO4JegqkBjD/QZvx
         k0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=if/tLdO5VC7d820oFC6cy+yeCQhnDLeKBPiaXw+xkE4=;
        b=K6Ms92gK2xbDY/h6VlLanzGDOWqkv7rGkuGcFKMkJxh8K6lwAWg8NS9uGDA3svaFSY
         mmHIoEPqejz0x+ZsoynHqj3EGrqRTj5s/Mr32RQvo66syOVqBGC24GaTNgApRD0beDzV
         X0cdBg1Mrod+70fa58gn5viJptrZE2dmYGNan/UBSQQPXHv1EQgo73ZE2EHgIolQ5k89
         j3kn9lWYsSGGbNtcXDxUg1VzM5zmMCwQR7Qguh8SLNxpguYDkK8YllESeEHplsP59YjM
         f1OX38yppvbSBWIPtgA4T2EgbR/UnIBIEywzfyeyrdOm2Cqc8Tq/Jkkk0cZ8543lYUmv
         Z5VA==
X-Gm-Message-State: AOAM533HW+W3NAObSR5uPPnU/TuvJY6RfaNsWLSiWpO4i9BTgRIGaIHN
        zU/ieUTYngsBDDgjsXxioi0W2WjaEoE=
X-Google-Smtp-Source: ABdhPJyjU3JD7OtC0OUTi5WbztOKHGMfyMWHNpKzu36hCrQ/cblVQ1ISBPMZ1JGNPmKtu5bcE9J0mQ==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr6506044wru.10.1601523981758;
        Wed, 30 Sep 2020 20:46:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20sm6076473wmj.5.2020.09.30.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:21 -0700 (PDT)
Message-Id: <cb686b4129902335ef98c83c8cfbcac1c88da856.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:13 +0000
Subject: [PATCH v3 4/7] refs: consolidate remote name validation
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

