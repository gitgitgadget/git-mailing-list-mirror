Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8016C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLQNaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLQNaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:30:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D130E0DD
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id q6so7476633lfm.10
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A9gLdcm9F5SLxSqVmmhUP7MFrcHV+7hifQXKb2rOUs=;
        b=ZUsviuP0NX9v/n95hgmMZ2QawcfMTz2e6vnMQJrTB2DvmM13r+/ecp4CAeE0pVuO+f
         LyJfWK4dz7VYpG9IVrq1rmky66E0Fl3OzAnU0K9k3NsRQ0Mbxmj5aaqrdpmco9fd5P7g
         Gnsk7gU68bf1yPYloZvNz1izzFVq8bLRrBI+Hopwci0MB/UHiVXIhXJgr7w9t+VoRZLA
         Ju66UHVYzNOywGwWrNbrOopRypE5HhP0r7MWypYAycYmu8CRQBNGWESTzxDwZeb9oqx/
         n8PBVfhXzTAmtBg5jHQk3bFYRloPND6WiuKzYG8OfrMbBWq9u5qjPv9M115d7W8V3keV
         ++aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A9gLdcm9F5SLxSqVmmhUP7MFrcHV+7hifQXKb2rOUs=;
        b=OrMeHlxiAazPGtmg/sAf4rK7cGHIVcuC4auSJSBZBgenOclVo/1CZTnH9v3Cbzv5LF
         gbCmSGxZejnbJ2xmwAZUDuqwp7IXtv4rhpdpDDCBULnYN1lw4SFxw8ilVsDxVfeZ2yZU
         pwpor1kFJO+X3uaeOiG5RR/seOU1u6z9fYEkZU7G1ZlykpkEfpJIFI0srcE4R1fIZ0KK
         4gbyAu8A1hfuM5r3vdOJd+e1wxTfFx05jMB7hADUIJiN2zxB9H0I4h/tz+eHmn+MB3Km
         S8oFBubXONUXqEn0TMRLnH0mfDKymnD0vfVuUCLU/lTUPDkyOFTB6JwaxSLq5KTb0HLl
         qRKQ==
X-Gm-Message-State: ANoB5pkLINunH/vL5sJ9o+vaBtEI5SRrPVbYdtauxdfU9TSZPUUbi8F/
        LBKmHE9HeJ6Ho/rHPQ9vYsA=
X-Google-Smtp-Source: AA0mqf504w9NWmedwLo3K7IN9JPskpbcjSeuimlP0k7FxkVoEUEl2WpQqlz6UxdNk3otL9csmwbcTA==
X-Received: by 2002:a19:5e5e:0:b0:4b5:6042:d136 with SMTP id z30-20020a195e5e000000b004b56042d136mr8212141lfi.22.1671283813619;
        Sat, 17 Dec 2022 05:30:13 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004a100c21eaesm512420lfr.97.2022.12.17.05.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 05:30:13 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 4/5] diff-merges: issue warning on lone '-m' option
Date:   Sat, 17 Dec 2022 16:29:54 +0300
Message-Id: <20221217132955.108542-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217132955.108542-1-sorganov@gmail.com>
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20221217132955.108542-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lone '-m' is in use by scripts/aliases that aim at enabling diff
output for merge commits, but only if '-p' is then specified as well.

As '-m' may now be configured to imply '-p', using
'log.diffMerges-m-imply-p', issue warning and suggest to instead use

  --diff-merges=on,hide

that does not depend on user configuration.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/diff-merges.c b/diff-merges.c
index bb2797ff8cc5..1f4e43e16940 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -10,6 +10,7 @@ static diff_merges_setup_func_t set_to_default = set_separate;
 static int suppress_m_parsing;
 static int hide = 0;
 static int m_imply_p = 0;
+static int got_m = 0;
 
 static void suppress(struct rev_info *revs)
 {
@@ -179,6 +180,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		set_to_default(revs);
 		set_hide(revs);
 		revs->merges_imply_patch = m_imply_p;
+		got_m = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
@@ -239,5 +241,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 	if (revs->merges_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-	}
+	} else if (got_m)
+		warning(_("legacy use of lone '-m' detected: please use '--diff-merges=on,hide' instead, as '-m' may imply '-p'"));
+
 }
-- 
2.25.1

