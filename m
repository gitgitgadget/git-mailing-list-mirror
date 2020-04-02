Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BAC2BA12
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897AF20787
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSLAvwqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbgDBQfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:35:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40731 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbgDBQfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:35:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so2077093pgj.7
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=kSLAvwqYCYEqXFP0dqlppT0TyqfZdtBbr1ekG3qIt+l46zqn07Knrm0Pb7SsS3E19a
         h5hO6bf1Z7dV6zh1XAZCP32BJL1UbqJd5eXDmKp2PEYHBd6qqDK6mNRIMfekWhVk7eeh
         wfVPBF2snYut4taHS4ForAM/9uOMiyJaX5FJi+LEV2mXOKvOYKF92nJKmLo3CsAlwAru
         6a7DkREnJP8qp/6S6MejEwzcmdwYwvVUrvF8ecOal3FHHlk0+0SDRFlC2qDZu5OQ5w35
         wEK73br/iQXWxLFBOg6k0k/TVDOWTNjkxpONCEVZXBw9YKpf5wwMEqTmw/HGHSbJbGUk
         tp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=Yld3tOAHGIE4k0ebK4bzmM6a2FPkFt8PwEF08cY8fILbWnfGgRGN0glDBhpAZQ6Ki1
         YnGpDsQG7s7vp4krCjeQlKRkHtD8Eqq4LOtzklzjLj0pHF92fnJue+mPUYz6bJ0ABEY8
         K0mYl0B3cKUkYAjKK9ucDwL+0UG6DY45D1WkbcLICyWrYPpwO9LZ7lXZlfj6QsxHjlrm
         qr1XclbAP9+rVNAzvhX1AjVDf83k2nJcLEHd7fP5yCOgx6svX1p/xJTmbMSgPBz8GWie
         WT4TM1jRvZgBUcHCditpzJHK4XwjHEx3E0H/RbftU886vdcE1sWqIFxSx1KEyXh3awB7
         o2vw==
X-Gm-Message-State: AGi0PubyIUB75aTysisVuxnbBXa+AOO5OsyftEtqxSTAiDTq2UUP6N5G
        yRoqKe9VhjQhUzvAnMlr1oI=
X-Google-Smtp-Source: APiQypIflVj5O72v1qnyzdXaNsAxystkFCaL6s/av+8FflMOOAL6o4O2BplmeZnPCd05T7FMKjRztA==
X-Received: by 2002:aa7:96f0:: with SMTP id i16mr4207653pfq.198.1585845333098;
        Thu, 02 Apr 2020 09:35:33 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 1sm4178140pjc.32.2020.04.02.09.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 09:35:32 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 3/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Thu,  2 Apr 2020 12:35:16 -0400
Message-Id: <20200402163520.1338-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.24.1.15.g448c31058d.agit.4.5

