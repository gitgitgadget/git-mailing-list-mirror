Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A86FC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24BF61250
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbhIXQx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhIXQxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:53:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC878C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r23so4010726wra.6
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QoOR07aVizwggee0Ov8YtUl1o/rRUmBtl3kd3iu8P0g=;
        b=TcHU48WgHxnZJjRuH/Wf/Hq+JlD6YPctzDmSJu4XVEt1H/H/edKHm00ahmu95rOn58
         SJe5wy5owmQi7bwqIbnzX2MQWqd1v8I/rLlwc0jU2Gj6P5XIZorY40+PsWWkdDkZ11P+
         5FLQCtCkAqfMJIRAU/va6PBYQz6VhcKHuXwwWmiZZI/kj8/VV9KsPNOk7AvXlqbh6xiK
         jEvGYX7yPY0jHpleQsbtdDipa0f5HlIol3tz/mwo5mhZnT3OT6J4yJ06ShHY2JQJXJ2Z
         0ekybZewhnYWI7SclSy3A69tgVvU+c9f77ZADAQPLceiTYgxvVSlhTtt4ZGTOQGvMaS4
         Ocrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QoOR07aVizwggee0Ov8YtUl1o/rRUmBtl3kd3iu8P0g=;
        b=jtxgnwy2Um5w3FCNPgUvZ1bhYjmC1zAkTD5m5CDA5qazGGbnqaYmik/0FJa5k9DdDA
         kHDc/NKoyinpwlr97SR8pytmp9HJn74UDdVr8C0+3uGYaUJ2Jonw00U4DKYyjZbKTlin
         drcevoyZ/mcy6DvkL9xJVWwZaLSzkE5Whr9Uuxyp0N7TkMWmGpl+kShUB9aovqluj3DS
         MVjPoK9lLFrcIE3jR3cVu138TFE90Z/MChMleDEiKQBEe7sW26xDTflmtXdBe7tdsQMb
         nbkoVQnk+iTGj27n93T/t9jbgmtJ0epfiojom6TsYpwqXv0GtghRoRbRdDpVh/ts4jNN
         QCUg==
X-Gm-Message-State: AOAM530/pw08tKrzCH78Uyj5i67eALRmMIYRxTQ1YheyviyLnl8rXre1
        /bCA7XRo6CmZgB+1F2RBjhSHp14rx/sD7A==
X-Google-Smtp-Source: ABdhPJwJFFF+AMoQKNR6SifqQz5Bt3LnCIaU8NZoUr4wGj4wuEzsM2uZJyifFzNZ082vChIxMRdsFg==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr3217526wma.67.1632502309998;
        Fri, 24 Sep 2021 09:51:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm8929623wrc.66.2021.09.24.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 09:51:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] show-ref: remove unused custom handling of -h
Date:   Fri, 24 Sep 2021 18:51:44 +0200
Message-Id: <patch-1.3-c79a3907a27-20210924T164820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1285.g7aff81f6560
In-Reply-To: <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net> <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since b92891f9783 (parseopt: add PARSE_OPT_NO_INTERNAL_HELP,
2009-03-08) parse_options() has handled "-h" unless told not to, so
when show-ref was migrated to parse_options() in
69932bc6117 (show-ref: migrate to parse-options, 2009-06-20) the
custom "-h" handling that was retained did nothing.

The option was then hidden in e62b3935056 (Show usage string for 'git
show-ref -h', 2009-11-09), but that OPT_BOOLEAN didn't do
anything. Let's just remove this dead code.

Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-ref.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7f8a5332f83..8cefb663282 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -163,8 +163,6 @@ static const struct option show_ref_options[] = {
 	OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined with tags)")),
 	OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 		    "requires exact ref path")),
-	OPT_HIDDEN_BOOL('h', NULL, &show_head,
-			N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOL(0, "head", &show_head,
 	  N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOL('d', "dereference", &deref_tags,
-- 
2.33.0.1285.g7aff81f6560

