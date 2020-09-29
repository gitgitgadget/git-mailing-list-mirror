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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D24C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8225208D5
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy4snppJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgI2DhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgI2DhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:37:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A50C0613D1
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so3146234wme.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SEpnHZvLycK4QZFA8t9RNM7Hm1dYHbneTQ8+7VkoepA=;
        b=Xy4snppJLMOTrqkevoZcqb03HN8OlJo2IqylRfJkAYaD2Cc0UeoCJU7CR4gT3cZKAm
         YYXN2iJaxtusMxxNjjAa0DhRr+wEmZtjMoHqgTI6VfsjqD2Kbnf3yXvMj6+RxzlLAb1I
         HzEKNTtU7cJxLLiBchKut0rBeCRu1r72D3AXyRogoM7SNWT0+KJgEYpUxqHU7mbuHY/9
         6v95tZBhCXex/j8Gzy33NEDarKytOZkncO9IYKXdnHesrHi25B5TBLZMsFNfEF3ikHVR
         P1xaPDxn+o+OrJGgYN0JgOArfcJcKWGE5l0YHcF9ct5SR2Uu5AzO9L7i03xuiKYWcZf+
         iLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SEpnHZvLycK4QZFA8t9RNM7Hm1dYHbneTQ8+7VkoepA=;
        b=NS28LrFdk68HXunUUEwYtuYOZsgnp1JoG97ajgo6yOMN2Zv2BRGbP4yMOtC26AzcbC
         DaTZRUADIVIH+PCEQIczS4WBcIo/By8ORtxIEjLXdXkqJfkRoK6cmNyGDiPOL6IH7sdh
         Prtfl4J0wkfu9N87h0kLDxyBB5RAohTbaH6F98YEz35fgdKrGuS7iUQjNxVQTFKqziYg
         Rxfoha8Dn+gg5DcZVVdXESfcLeWBZCz6NLD2kG4vrvjBwbUEqVGF9eYaQmCxsz+7aU9T
         myMruemdBxqdK8EER/jDAPRQOoTTVdjRHZGGg26Vn1bIFuYcoi/muGumrc4IV8+CJdja
         5XDg==
X-Gm-Message-State: AOAM533F2TcVgkLDtNQetD651qKp5086HXTiyBI5Y/t3+gLLEcIS7ILK
        teNA9onJbtkEQXcSthBlOKk6wGLxZ4M=
X-Google-Smtp-Source: ABdhPJwWLAnzDtHdt2DMu8ltrIoNRbScM6cw2KnQD6V2xWMae+sqc6ptsn/o1krvDqow86S2nTcOZA==
X-Received: by 2002:a7b:cd8b:: with SMTP id y11mr2160188wmj.172.1601350620730;
        Mon, 28 Sep 2020 20:37:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm4198902wrd.29.2020.09.28.20.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:37:00 -0700 (PDT)
Message-Id: <fdc9d3b36979c1c4733e9326cc455006e3329d64.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:53 +0000
Subject: [PATCH v2 5/7] clone: validate --origin option before use
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

Providing a bad origin name to `git clone` currently reports an
'invalid refspec' error instead of a more explicit message explaining
that the `--origin` option was malformed.  This behavior dates back to
since 8434c2f1 (Build in clone, 2008-04-27).  Reintroduce
validation for the provided `--origin` option, but notably _don't_
include a multi-level check (e.g. "foo/bar") that was present in the
original `git-clone.sh`.  `git remote` allows multi-level remote names
since at least 46220ca100 (remote.c: Fix overtight refspec validation,
2008-03-20), so that appears to be the desired behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Sean Barag <sean@barag.org>
---
 builtin/clone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 93ccd05b5d..673f7b68c3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1011,6 +1011,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_origin)
 		option_origin = "origin";
 
+	if (!valid_remote_name(remote_name))
+		die(_("'%s' is not a valid remote name"), remote_name);
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-- 
gitgitgadget

