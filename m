Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB3FC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9395160EB2
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhITMVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbhITMU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 08:20:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8CC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:19:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so12516236pjb.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDXLYqubkknOrDtQWfxmbkMVMfsHJE2jmyfJNgdfXOc=;
        b=qkZZfxDp3Z7Ik8ahL6Dt7u3brvRKUwgehhs9SKhxpT096ZUfRDd8agIQEZYgG1H/Vj
         6wLhFOJlfsr/2xwj/bXwA+pAvPItsMDCuoIBz+SP8C9YfyYzpqOf6474RGYMBTvZ0xC0
         /AUwWZbhbifOMDbSjhcz8yxDMHLh268o/8MH1sIFYGYlXmCqnE90XOCbdx/3CdRERavL
         D0Mu8JSwxhv8fZUtb4qWYMWxpCgSAZ/NpATkS0PyCFkugBZe/+uwyqVK8yofYV2TtM3m
         Cgff7+eih8qXb82UcYS3vtHtf1+V9Loi4xbVRx87Vwgy5IiL9qbtYUuBE9HNcsdkEKID
         VzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDXLYqubkknOrDtQWfxmbkMVMfsHJE2jmyfJNgdfXOc=;
        b=i8gLSgM6ht2nVJml41oAzWNRAGJSg6NJS+XBfAP+kf1OhbfeQa/9upS4Q6mDySpyj9
         IvwWv2W75hZeZHb2jHDyY5FPN3F5OD1X41Vmvrca40dbNo9h8j5/oYoI7NkzgAGHsTgF
         MNkL7WGf9tvrtAFwiHRZWYZd1JMgbvc1vHgVyN2jlJHcv3GMnxvKfbGS94J/NEyaiaBr
         J624wb1u21hKzFfCH9HB3DwQtOVMZvh4HR0z4p1CNSNUZjk7ExNqTOjCI38Bof8bK85n
         D3TJzC2DQZ7GPGcD0O2ygavPkdV9WR3IEibPDUsOxfkBKDKm5TyJZUELNcTB4lWD49XJ
         /iLA==
X-Gm-Message-State: AOAM5304lvrENb12aA/dW77sY3eR3cvc6rA7lq9EKYgn3EI/T0livKiZ
        2oQFqhUjVU9pVvPalVAXsx9Y3KdKkIACsw==
X-Google-Smtp-Source: ABdhPJwbOKJqcWQZO/wGcnfSj5h1hDgmnaoq20KG9vFDQ6x9GUc6aBYknKJFarhNkVpVbikMJbtCog==
X-Received: by 2002:a17:902:d114:b0:13a:4dec:d590 with SMTP id w20-20020a170902d11400b0013a4decd590mr22588287plw.76.1632140371946;
        Mon, 20 Sep 2021 05:19:31 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id x24sm5036455pge.85.2021.09.20.05.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:19:31 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH RESEND] difftool: word spacing fix
Date:   Mon, 20 Sep 2021 19:16:28 +0700
Message-Id: <20210920121627.905359-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two grammar fixes related to word spacing:

  - delete space in `non - zero`
  - add space between diff formats/mode and option parentheses

Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: David Aguilar <davvid@gmail.com>
Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/difftool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6a9242a803..ad9187761e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -410,9 +410,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		const char *src_path, *dst_path;
 
 		if (starts_with(info.buf, "::"))
-			die(N_("combined diff formats('-c' and '--cc') are "
+			die(N_("combined diff formats ('-c' and '--cc') are "
 			       "not supported in\n"
-			       "directory diff mode('-d' and '--dir-diff')."));
+			       "directory diff mode ('-d' and '--dir-diff')."));
 
 		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
 				     &status))
@@ -713,7 +713,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			    "`--tool`")),
 		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
-			    "tool returns a non - zero exit code")),
+			    "tool returns a non-zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),

base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
-- 
2.25.1

