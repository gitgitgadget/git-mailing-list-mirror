Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0CCECAAD8
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 21:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiHZVcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHZVcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 17:32:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD0923FA
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:32:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so791583plb.2
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc;
        bh=gp4Utx1sI2y7ZuD9NMqTEKuMaahJwBIYZx52Hfiwbzw=;
        b=kfZ1+uW9m/MV0zOvIUkmJT1gyed/H/iahYmYA9F6xze663CM1Q72jxr58PgMbRT7G8
         2TjYt6ElMJOplGZAmC85af9MJNYgZrgdCpMo5aXc2c5p6LAJuMmaz8jePHgmzohQbavz
         RCzErhbFqS+kTBpfVnWWs8YVLZgQsT7oQ4hlttDrPKLM5gO68RNHnAFfDDO9MV3bALzU
         ShSMxz9ZfRp4S25LKivF8hi8po92JOPMsla9rKVsQW+upG8wHfHzgUEOQj8Vnt05EQ0x
         6Sq20AU5+yuIFa2NL7SoNBzU2OhrBZJAmjt07w1Qpq1KM01HuoXgDAPMHhCOilE9vltf
         GscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc;
        bh=gp4Utx1sI2y7ZuD9NMqTEKuMaahJwBIYZx52Hfiwbzw=;
        b=WL7PX6B43Y3J6qVcyLOKbdccmzHJJWDS+C49LGlMPWSx4UA06ENn1jx/wVMq7nhJ5P
         4cUTIGZqG9vosFBA1FXmWJ3eEjEUpOkxbhoS7kHtsb8N81YmZY7LguTMujHYkpm0jWNR
         5sGQRa4cP2kDRDWi3tGWS2esu3rZQVqrT26oluvMVTuJKDdm7hcRQLGScjwXdeZl9ho/
         bogSkF/Ud/Ddk5NRDNJg9g+lZHMX2Zeu7QGxVbFpi2d1ttYDdr3VFmUEiEAgLTVm1ttz
         I8wj0botvO6++0UiLUzkEgBhn0lRlNgN3K4l2PBgtCTZ4OnmqE1iNeCPWn7SReAt6T+m
         Y2WQ==
X-Gm-Message-State: ACgBeo1DoYXZt0tpBIuLCcQ2kK3ocFJRZwKxyqDElCvqggyJP3QD/7eY
        OZUctqBTl3F5+oGek4aaI1BwMu2lE0c=
X-Google-Smtp-Source: AA6agR7ZHlIpOE0Quv1shLLrgfjJdPoxmcho3nPtTp/E1AWFc/ji/DgdU6EFt7c/ZglkGaudBcOK4Q==
X-Received: by 2002:a17:902:7b87:b0:172:8ae9:2015 with SMTP id w7-20020a1709027b8700b001728ae92015mr5593909pll.112.1661549525231;
        Fri, 26 Aug 2022 14:32:05 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m1-20020a1709026bc100b00172d9f6e22bsm2067929plt.15.2022.08.26.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:32:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] pretty: separate out the logic to decide the use of in-body from
Date:   Fri, 26 Aug 2022 14:32:02 -0700
Message-Id: <20220826213203.3258022-2-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-587-g47adba97a9
In-Reply-To: <20220826213203.3258022-1-gitster@pobox.com>
References: <20220826213203.3258022-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pretty-printing the log message for a given commit in e-mail
format (e.g. "git format-patch"), we add in-body "From:" header when
the author identity of the commit is different from the identity of
the person who is "sending" the mail.

Split out the logic into a helper function.  Because the "from_ident
must be set" condition is there not because it is used in the
ident_cmp() next, but because the codepath that is entered when this
logic says "Yes, you should use in-body from" requires values there
in from_ident member, so separate it out into an if() statement on
its own to clarify it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 6d819103fb..51e3fa5736 100644
--- a/pretty.c
+++ b/pretty.c
@@ -477,6 +477,15 @@ static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 	}
 }
 
+static int use_inbody_from(const struct pretty_print_context *pp, const struct ident_split *ident)
+{
+	if (!pp->from_ident)
+		return 0;
+	if (ident_cmp(pp->from_ident, ident))
+		return 1;
+	return 0;
+}
+
 void pp_user_info(struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
@@ -503,7 +512,7 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
 	if (cmit_fmt_is_mail(pp->fmt)) {
-		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
+		if (use_inbody_from(pp, &ident)) {
 			struct strbuf buf = STRBUF_INIT;
 
 			strbuf_addstr(&buf, "From: ");
-- 
2.37.2-587-g47adba97a9

