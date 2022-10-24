Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F352AFA3744
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiJXUtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiJXUtS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B454B2B7B78
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:35 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id g13so5692123ile.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyHeWTxfGr8Hm/O3/pb8HgpGjoq2yivukCGYdAxs5ko=;
        b=Iik6CBPyPbKmAI/Ro4EqOJNcTan5iFxIHduXxgqS+YG7HJoxnvbhRiN2mPoYOSNJND
         jxay3MhvI/CeRbMMZZlgw98GbRhLeQq7YyLPVxZbO4r+5vLymjkuvalWlgsQamz5s5I7
         hV72JUumn1ThP+773uDfty0n4LMGdSkJXbxOCKMtESKudRLR2WGp5b+84Ct1j8wjf+Np
         /kAibpfa3hd6z+bNFEplQ7RRXJm53O9oayIT1FBDXukSRoxXYYCZpVeV5+L95XDUm2p/
         PcLrHkdZkIQQpm84NA4yX78xavLXVXEGiMDIpl8tGOV7vObVIkfCDuMf6v59kzn1RdQw
         7etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyHeWTxfGr8Hm/O3/pb8HgpGjoq2yivukCGYdAxs5ko=;
        b=is30GnqEWLx/OUTcQoBJGZGTA3bVMAiITMp4AJS90+sgAlR9XFOnWpjkQ0S+99MgX2
         boA+JEmsFkxs+sjmZLigH48dbBzU/ilA8qNyVvQyFsWx6TEzb9TUdK94oAjSmQrZPgps
         epnsteh73Kw6vfCrIE1zSd0U2DBYPuV3AOEBrZjhon0i+GY0AzEy9Thkb7ebMOlYKs7i
         hOoefl+CYib3v03TRS1IaW7PJ357KiN8nFLt/YOj63/6K4HCwsVMLUlQzT9HiVaDtRRa
         hCArJwKdvKUTvi/XY5iDqJfCz+2JQbmz/gMXQMhL/qJnCHkUezaE14iQmz12K+dGMAzJ
         +cGQ==
X-Gm-Message-State: ACrzQf0+ZzZoneHgZft991Jw/EyzDBry6ZgIfPt33FRNmjagmGbQt7D9
        MR2mQSfToC4oi/wOOmtvNqNRlcSWNHHiVWtB
X-Google-Smtp-Source: AMsMyM4AZdU9M/Rua9VHBkr+FsY2sfrJ9BtcFMNvr5fpxjbB40mCrbd0pbsE5T64OjQxnl4A1M0pQw==
X-Received: by 2002:a05:6e02:20e9:b0:2ff:f2ee:4a4 with SMTP id q9-20020a056e0220e900b002fff2ee04a4mr3940889ilv.238.1666637742876;
        Mon, 24 Oct 2022 11:55:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w18-20020a0566022c1200b0069e1bcbddaesm218066iov.16.2022.10.24.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:42 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 5/7] shortlog: extract `shortlog_finish_setup()`
Message-ID: <3c565450654673134bd4c8584350d475b9f1b38d.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a function which finishes setting up the shortlog struct for
use. The caller in `make_cover_letter()` does not care about trailer
sorting, so it isn't strictly necessary to add a call there in this
patch.

But the next patch will add additional functionality to the new
`shortlog_finish_setup()` function, which the caller in
`make_cover_letter()` will care about.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/log.c      | 1 +
 builtin/shortlog.c | 7 ++++++-
 shortlog.h         | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d45..b4d5420217 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	log.in2 = 4;
 	log.file = rev->diffopt.file;
 	log.groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_finish_setup(&log);
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f3b237c5ff..808bae9baa 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -381,6 +381,11 @@ void shortlog_init(struct shortlog *log)
 	log->format.strdup_strings = 1;
 }
 
+void shortlog_finish_setup(struct shortlog *log)
+{
+	string_list_sort(&log->trailers);
+}
+
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	struct shortlog log = { STRING_LIST_INIT_NODUP };
@@ -450,7 +455,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	if (!log.groups)
 		log.groups = SHORTLOG_GROUP_AUTHOR;
-	string_list_sort(&log.trailers);
+	shortlog_finish_setup(&log);
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
diff --git a/shortlog.h b/shortlog.h
index 4850a8c30f..28d04f951a 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -33,6 +33,7 @@ struct shortlog {
 };
 
 void shortlog_init(struct shortlog *log);
+void shortlog_finish_setup(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
 
-- 
2.38.0.16.g393fd4c6db

