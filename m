Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42EFC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiFFV4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiFFV4J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 17:56:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDABB3C4B8
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 14:56:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p130so9321517iod.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0vJk4MZglsUu1MqPmcKx+XAsi21r4Zv7EK+vRJ7olc=;
        b=cydq2F4Ayfk3e4hNROOAuOZzGMrFmCTZCOcU70GpUnxiGxMxsYj88BOwX6auBzHnXB
         YjxxYxxQ2nTiOsC1c/k+PSTUsuxLAPAVsutVFyf9J0X33dpzGnK5rJ8TiJPBIYLhje9x
         v8FlToVIIL/cJL2U2ObIGtO2PV9Fxo68pYVirPkkK1PGvp5+bUDswMwCp5BrKEJh8rcK
         dfFTXV5KW64nBv8qlhBHecVxWcAdL/B8UcOH1kkZMDdx6V1yTg/uAsDEipXZ8JoPOyau
         PAYEWHInmpEZpblIp9dKGDEdR/Pf9W839W8p2mfxUh/tt9jqWShmEMrt2HgkAPOn5GLk
         qglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0vJk4MZglsUu1MqPmcKx+XAsi21r4Zv7EK+vRJ7olc=;
        b=RQ8I18rm4woyLvWSvwlBU9sPgXtrk7GiMe2Rcrw5WXhH6mOsi4oKuVgO/Keot1IUnt
         2i/0RwWYoUQ1I8JtHvaSZkmeUTkYmLvZZV+RibE+GJQqvGldTUvR5HwBjo0joFnH2NNf
         DsNBKO7v5LuKSS4fJQnHhjEboKI10VXlqpQYGKqghkwBBg+zBvL5ScGFQlw3zL8+YprY
         RvzBXhMoWYfBbt2CgWxqaWbWDdsEPlWDigwiPCmf0jS3pAvXj1UCdcnKfhTgKycX42Ai
         /9FyskgguEOzFVa7w9cMkmq769Y1F+RI9Ou6dtQtLOSweaFff8fMC+59yT6aUpgHKKHZ
         LiSw==
X-Gm-Message-State: AOAM530Aaq4Qxc717re0dEI4W9ZcELkTDDDvkB1XGpMLLYNX6irZ1jrC
        IO+7f9EMSJOQSBzZcqplh8JIjzBRYhIb4Ni6
X-Google-Smtp-Source: ABdhPJxyNstIrbUKBbOzsrobgwORgxd4WP4kUAnJKu6jx+gUq0o0zG8VyD7kpBcF5UUwdcwFANkrig==
X-Received: by 2002:a02:95e7:0:b0:331:5fd2:396c with SMTP id b94-20020a0295e7000000b003315fd2396cmr14965154jai.78.1654552566197;
        Mon, 06 Jun 2022 14:56:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cv9-20020a056638498900b00331c58086d8sm524739jab.147.2022.06.06.14.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:56:05 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:56:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
Subject: [PATCH 1/2] builtin/show-ref.c: rename `found_match` to `matches_nr`
Message-ID: <c02ec101ce70a94eb7cc6085249a40d5b30d1474.1654552560.git.me@ttaylorr.com>
References: <cover.1654552560.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1654552560.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable `found_match` has been used since 358ddb62cf (Add "git
show-ref" builtin command, 2006-09-15) to keep track of whether or not
any references were shown by `show-ref` so that the command could exit
with status code "1" when no references were presented to the caller.

`found_match` has always been treated as a boolean, even though it is
incremented every time a reference is shown. Prepare for the subsequent
patch, which will treat this variable as a count, by renaming it
accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/show-ref.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7f8a5332f8..17d5f98fe4 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -14,7 +14,7 @@ static const char * const show_ref_usage[] = {
 	NULL
 };
 
-static int deref_tags, show_head, tags_only, heads_only, found_match, verify,
+static int deref_tags, show_head, tags_only, heads_only, matches_nr, verify,
 	   quiet, hash_only, abbrev, exclude_arg;
 static const char **pattern;
 static const char *exclude_existing_arg;
@@ -78,7 +78,7 @@ static int show_ref(const char *refname, const struct object_id *oid,
 	}
 
 match:
-	found_match++;
+	matches_nr++;
 
 	show_one(refname, oid);
 
@@ -217,7 +217,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	if (show_head)
 		head_ref(show_ref, NULL);
 	for_each_ref(show_ref, NULL);
-	if (!found_match) {
+	if (!matches_nr) {
 		if (verify && !quiet)
 			die("No match");
 		return 1;
-- 
2.36.1.94.gb0d54bedca

