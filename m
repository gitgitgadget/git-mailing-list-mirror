Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B837DC4332F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9719261100
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbhIXQx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344084AbhIXQx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:53:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF13C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so29404450wrg.5
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhQePB5TT8C0PstkXR2LYBE/KgU3p9wAhukUAsr7B8o=;
        b=Io4P+SU0jFTMjpYc8xfabbh1vjLPjAwIGVy3kaF55h/CAuvo/g0QZtYGBotA6j9FZm
         KMuvWx0RUdfsvpmNfkWSIUWOOBr76rdBW98UbYMkxwathG1usdPpcbzYkFxp9SW5mT7u
         eOw0LRhau07D+E5RKrowB0R7rQSXcz13X1UxBmruWS7DIWW0sXVFgdE68o9ctCGP0taf
         C6aeIE/ZnNdBBRQ5KGkF3T4Vh0brXm/P4/9Uj731m1r3+Z5nkUIiwI4IKUpRebTQgTsT
         KILzMxeIgjO52gozUlgfALrV8rWCEJqaG2PGfVTlKl4E0I8A87VTIW4XuP9w4sbDw82t
         dM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhQePB5TT8C0PstkXR2LYBE/KgU3p9wAhukUAsr7B8o=;
        b=sv4J3M4Zn+DtgSJyq4+dDhXal0GW5dlXyQgIm/WpNYsi54bfD0yG9WiqwawHQ50YOT
         lL5HTHiqA5QgCMSGK3eQuXewQ7wYB7dEsCpSk/iQUSkSMkk9kkIN3kxUzLa0ivPapFLu
         8zt81l6XEyqRevrxtnAbshi19DA2uAevPogLwHTua7AOPYtaKcLjbLPtMfQA4dY3Oc2u
         Fo6B23FgaiEb3MmBnTv/AcfrOF3M7EafasCCjU8b6CEfA9BSw2nVxj+uURpmrpW4ft1H
         lUIV/WNQeov6Hb2DmaBxVDhjrBP3nKlS7QMAc/7uuxf+i2TIAJGxWzbFM/mhhwTA+w+e
         bgqw==
X-Gm-Message-State: AOAM533PWraOq+An87+0ckPL05Rznk3ZiqSNTTfteoH6Sw9geNdBsAK9
        G1xRU84HfZdVPMOIY3TxbPjS3o/xaUPurg==
X-Google-Smtp-Source: ABdhPJzZ3T3xOOcUbAZ2iFNvQ4oQdNFjKj48zdHugTdEDSbDYLi5445Gngv5zQmkMd1PTecEpHcGlQ==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr3069609wma.129.1632502311102;
        Fri, 24 Sep 2021 09:51:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm8929623wrc.66.2021.09.24.09.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 09:51:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] ls-remote: remove documentation for custom -h option
Date:   Fri, 24 Sep 2021 18:51:45 +0200
Message-Id: <patch-2.3-32b8dbecfe0-20210924T164820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1285.g7aff81f6560
In-Reply-To: <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net> <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The custom handling of the "-h" option was broken in
ba5f28bf79e (ls-remote: use parse-options api, 2016-01-19), first
released with Git v2.8.0. We've been promising that it's a synonym of
--head, but it's not.

We could make this work again by supplying the
PARSE_OPT_NO_INTERNAL_HELP flag to parse_options(), but if we were
writing this command today we wouldn't make this an exception. Since
it's been such a long time let's just remove this rather than
restoring the exception to "-h" handling.

Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-ls-remote.txt | 1 -
 builtin/ls-remote.c             | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 492e573856f..6e241640bd9 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -21,7 +21,6 @@ commit IDs.
 
 OPTIONS
 -------
--h::
 --heads::
 -t::
 --tags::
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f4fd823af83..c5e68918b78 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -64,7 +64,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-- 
2.33.0.1285.g7aff81f6560

