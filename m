Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D820AC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJUDLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJUDLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E416DC0D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o65so1277949iof.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpsOH8MNNjaXe8PFoD/jp7TaZ7ac3hJ14pF51hYOfwY=;
        b=zhK0hgOOrgOmtvKNc3USU+RAZd0fLQfwNvc6B2q8w1ej8z8x1uF6zzHu1rz+OsZzCH
         bmegYrt2rY19IHK74WQ+E7n5WhgyVsErzrPurtuAEYGA4pfwu4ROtxouYi72FgXp3j4m
         lHrsgHC/ge6C30J9kca4tTtAqq319vlM0HFGgn2kpCTP3Jp2GWWFjp94OBZYgM0hS/2U
         aa7hFzTe0ZdR4E8Fe3TFNpVGGCrd6S5AOHSOJCpGxMlI6WBuurhGrwR9Tm0YmQGHOaRU
         +OVxehAG0/6bMSN4hFWxrGMX+/kUxQC1Scf0YTe4yFuwfS0YUPw82t5W7ebQRfdHOWdW
         J4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpsOH8MNNjaXe8PFoD/jp7TaZ7ac3hJ14pF51hYOfwY=;
        b=Wt4idooAG25F7gp0aBZLA1DL3Ptpj6bJ+YM3Omm1V4TyGz6C+jutrrV7XvI4f76njo
         Yy8xo6F49P02/Goy9KoF1IixjF8tXaEQhBJWP2o4Iovh6E8fVtD+ORbv4sQ9jOzasLXB
         zDq7Gxl62yFjDWKc7nTsF7YErjLr6clAsCb67wMZJi0K9UFll7yIMjHq6fOkXepizi0Z
         gVCXM6ElOItBfkN8/1dQtR70U3uhUABMkauGuQkW4MRzXsbAmbFsld73dF534hrkD62j
         3boQYZvKaeUWlWLn29ne7vGFGK7ZGZLKT5tdNNQcDtbQrTPWGAvPEq7IsBza1mW8vFJv
         dSuA==
X-Gm-Message-State: ACrzQf0RjFUR2GEDX7gEiGQulHKHWPY22DEbj12l3lpYJ9zkLj4NB50A
        T73MVmnIulL+R6JGqNJTu9jpzjz4pq18ZrJQ
X-Google-Smtp-Source: AMsMyM4y71vRxK+wOHoD+d/drgfGxaASgpGAZpfp863F1JHfDd3xt5dQE9kLw3zLKAzLsb7fwa/2gQ==
X-Received: by 2002:a05:6638:2049:b0:364:ef8:868e with SMTP id t9-20020a056638204900b003640ef8868emr12810908jaj.75.1666321893549;
        Thu, 20 Oct 2022 20:11:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w29-20020a056638379d00b00368d1654e9bsm690493jal.165.2022.10.20.20.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:33 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 2/6] shortlog: make trailer insertion a noop when
 appropriate
Message-ID: <7decccad7ccb39eed67bab87ed665beccf5d392f.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there are no trailers to insert, it is natural that
insert_records_from_trailers() should return without having done any
work.

But instead we guard this call unnecessarily by first checking whether
`log->groups` has the `SHORTLOG_GROUP_TRAILER` bit set.

Prepare to match a similar pattern in the future where a function which
inserts records of a certain type does no work when no specifiers
matching that type are given.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 53c379a51d..18f0800c82 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -170,6 +170,9 @@ static void insert_records_from_trailers(struct shortlog *log,
 	const char *commit_buffer, *body;
 	struct strbuf ident = STRBUF_INIT;
 
+	if (!log->trailers.nr)
+		return;
+
 	/*
 	 * Using format_commit_message("%B") would be simpler here, but
 	 * this saves us copying the message.
@@ -240,9 +243,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
-	if (log->groups & SHORTLOG_GROUP_TRAILER) {
-		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
-	}
+	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
 	strbuf_release(&ident);
-- 
2.38.0.16.g393fd4c6db

