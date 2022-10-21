Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4044BC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUDMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJUDLs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:48 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9092F51
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:46 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i9so969489ilv.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdWuD1/2/zu6rykPbsAZpn6b0T0k1/un84tJMHJduSY=;
        b=FD1OENBCnaexEYA9qtnGQ50ibAI1X8GqJxMSvGcaCHcMYzoKkQjtDt/ahQuKq6huQC
         iKrNiNhxMmMrIQqgDYCGIyNXGk836YLIn+Qb6G67A6Sk7PufoZqWrRWV2H1BWhSq7JN6
         9D2e3fTgeFCcdD/+dI0dvTY/8hFMVmnY/E68aZH8uUxOCY3KdZOP1K8TU2mdy6dvY3oJ
         R35CIoGn6Kv/V4O6NCDtWNxlZlbim9Zvd2qIYe7ARAzgx54D4GHfetvZkCRh2/LlUgct
         IcUXshdgFV2yXiutyKequ17M6y0IuYyOAWZ/Q6ugQERyvMyLCt0vsodRVJ0jbeT5u/kN
         zMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdWuD1/2/zu6rykPbsAZpn6b0T0k1/un84tJMHJduSY=;
        b=PyNJP9QY5ctUEcZi6oZqC3RLWkN86gcuBf6xsSXICWmjWNg+HH29XrkFgOSrkkOqbs
         Ko/ZO94+0F1VQaNzJBg9mw1WVh0RZ0p9cnvN0eKCXguNPoLL/IqU44rTbVEO2kNPdaW+
         naDCdX4hZMqx3+9hIba0CQhjEgmZgwXojs0VYZxnnPVNxIQ6qdTDuYkKefu1iYxFRIFI
         DtRPtKsvlTI1w08MHbzi2fRyanz71l7nAkMq6sVOUUoppCvLhnpyn3Vi2m8Ti4RPwgDE
         9tLzBZRQLArO2N2JhFCW6OCMUTmXE4X4jv4qj1vaBDS3TQODm9fbwK/lv+q9P6cLguG4
         ruhg==
X-Gm-Message-State: ACrzQf3bL44eZpTEqBR0wXyiah/A1uogWkgKeItf/wm1Vn0XYEOLyKi2
        5nthl9wsGQzOk3GCWja+T1vMxjyoojM9K0jf
X-Google-Smtp-Source: AMsMyM5ZtAHCOQ9vEwpjcwF6hem9CAV8qqO8Fmfr6zJ7VYmpjc/ITdwaix/TX1pWxyyMiF2M9VoM5A==
X-Received: by 2002:a05:6e02:1bc7:b0:2fa:876e:95a7 with SMTP id x7-20020a056e021bc700b002fa876e95a7mr12850268ilv.240.1666321905531;
        Thu, 20 Oct 2022 20:11:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l41-20020a026669000000b00363a30a154asm3788440jaf.94.2022.10.20.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:45 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 6/6] shortlog: implement `--group=committer` in terms of
 `--group=<format>`
Message-ID: <6a9e204177d486e786574ec682e6d73907a3ce7e.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the same spirit as the previous commit, reimplement
`--group=committer` as a special case of `--group=<format>`, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index fceb84f12f..b9f5af22d3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -229,7 +229,6 @@ static void insert_records_from_format(struct shortlog *log,
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct strset dups = STRSET_INIT;
 	struct pretty_print_context ctx = {0};
@@ -249,20 +248,10 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
-		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%cN <%cE>" : "%cN",
-				      &ident, &ctx);
-		if (!HAS_MULTI_BITS(log->groups) ||
-		    strset_add(&dups, ident.buf))
-			insert_one_record(log, ident.buf, oneline_str);
-	}
 	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
-	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
 
@@ -373,6 +362,9 @@ void shortlog_finish_setup(struct shortlog *log)
 	if (log->groups & SHORTLOG_GROUP_AUTHOR)
 		string_list_append(&log->format,
 				   log->email ? "%aN <%aE>" : "%aN");
+	if (log->groups & SHORTLOG_GROUP_COMMITTER)
+		string_list_append(&log->format,
+				   log->email ? "%cN <%cE>" : "%cN");
 
 	string_list_sort(&log->trailers);
 }
-- 
2.38.0.16.g393fd4c6db
