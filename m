Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA6C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 08:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAOIDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 03:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAOIDm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 03:03:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8A7B450
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 00:03:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso26617064pjl.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 00:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEpxlPdEcwsAbV+83ihIBKvT2nPkkcnt88MP8paeuuY=;
        b=BJ1sOE15TKYTUVZZYVis4t8UDCy/auFu8RnGOKFQtIiFsZXo7+h587faG8Ko9AEYud
         4aUMHtZvqdPeta3z3INKLIrMycP44hqQBay2h47owzEQyLwQD3AYSzTWaMXQBDBVTVYQ
         CJeCb7zZNWIPyVVggj+tjYvGK5y95/UeGXf2n/+93ZNgs7uvPqGxpfmraSsZKy/T/KDU
         cjPkJ1sp09N4JCKY1gXsvzILqW/BHhVJyQ+q/Uc/eNjlUFcjEHWM9oHSNkGYvxiiHtzV
         +YMpBw9Ql4a3CZyQpgsTJ3faptDJWaur4PGA8KG8XwZyz2deJwaBH3T+QQUWQgWY9jRd
         DW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEpxlPdEcwsAbV+83ihIBKvT2nPkkcnt88MP8paeuuY=;
        b=iAQzcQjRdKZR52tZS79vr7I5yaGnRJjM0DXQk3Fdy6G4iPJdxsYqX+NMcne+xwcuYK
         IH2NeV0p5w3fYYyxRZNrg7VB/7gxvtShwD8Cp8YRjtw4AK1y7nIoOlDFHzOYmQ5ieQYE
         TNAQAsLNoYzXxw2DcvTosO1RIo5l/0583UQti+YFktVN997h7O1+O6WZLf9BQ4XaWI4R
         sW94QxTwp9OKDaRBnlc0VvHaXTO5Ph+gPKLD/6IOjJK4QBduiP76mE4JYoY8JPibH7kH
         WdesghYW7BLNl3Kzs+LTxr0EbTuyjOksqEJMuGIJUVFt0zYjJBiP5TBDT5yVD/2ets38
         RhaQ==
X-Gm-Message-State: AFqh2krMqRy356GMJb0NbAaEvgcmoqZ6ExrA5H9Zrrki+ZFSPxdXCCiK
        W7F8wKOgVNdD7TKdbbOnmGFbMcKgxaQ=
X-Google-Smtp-Source: AMrXdXtmbaN3IOBDzjpNaOvoomnPPW0Q5+nA/WbL7TCatPZl5OubSUEAoIALvs7ULSkFB9+nbcu8MQ==
X-Received: by 2002:a17:902:ea43:b0:194:3dce:deb5 with SMTP id r3-20020a170902ea4300b001943dcedeb5mr23544825plg.27.1673769820337;
        Sun, 15 Jan 2023 00:03:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cp19-20020a170902e79300b00189947bd9f7sm16986669plb.50.2023.01.15.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 00:03:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] format-patch: unleak "-v <num>"
Date:   Sun, 15 Jan 2023 00:03:39 -0800
Message-ID: <xmqqv8l8gr6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "subject_prefix" member of "struct revision" usually is always
set to a borrowed string (either a string literal like "PATCH" that
appear in the program text as a hardcoded default, or the value of
"format.subjectprefix") and is never freed when the containing
revision structure is released.  The "-v <num>" codepath however
violates this rule and stores a pointer to an allocated string to
this member, relinquishing the responsibility to free it when it is
done using the revision structure, leading to a small one-time leak.

Instead, keep track of the string it allocates to let the revision
structure borrow, and clean it up when it is done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e1fe7bbe71..3dddaadc1e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1879,6 +1879,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff1 = STRBUF_INIT;
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
+	struct strbuf sprefix = STRBUF_INIT;
 	int creation_factor = -1;
 
 	const struct option builtin_format_patch_options[] = {
@@ -2019,12 +2020,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
 	if (reroll_count) {
-		struct strbuf sprefix = STRBUF_INIT;
-
 		strbuf_addf(&sprefix, "%s v%s",
 			    rev.subject_prefix, reroll_count);
 		rev.reroll_count = reroll_count;
-		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
+		rev.subject_prefix = sprefix.buf;
 	}
 
 	for (i = 0; i < extra_hdr.nr; i++) {
@@ -2388,6 +2387,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
+	strbuf_release(&sprefix);
 	free(to_free);
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
-- 
2.39.0-198-ga38d39a4c5

