Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8630CC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555BB2082E
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cePPpApO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGAsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:48:41 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39701 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGAsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 19:48:41 -0500
Received: by mail-pl1-f201.google.com with SMTP id q24so280536pls.6
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 16:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=N0nNIXMLN8kqDQQT8t2ENQSbz3USBMZWm12tm62waak=;
        b=cePPpApOo0sRiGzRGuX3f26XGK5daSOtDlSS5IW+yTipvOsV/ITaOrBsQdBbSQNafu
         qw01N0LXQ5Ss/B59wTJrOqZNDpCaAqu4Ouw7p2jQ/LmUuTzsHx7+nyVfJ1S1WJP6GLOU
         8+IanEIRQsS8h23bCRqnQkmGVkaSBpPzaaPoFJbLLIc5TLRs+VDmDZFJ7TEpLCTJ5i/S
         4AstPNJH260qDIOg32KRD55Ono8xpBpAkpfo4PMp6cWMyKfcvLKyjTKjZ5i5UNIcn0u/
         OFDN5ZdpTI524Q94LNAn8j3CNMHKa/n9io+EW9fxB+EUOBbtihJFrsxmAOo0utZoe2jX
         KkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=N0nNIXMLN8kqDQQT8t2ENQSbz3USBMZWm12tm62waak=;
        b=E/k8ep/YCnUuMZ/tw4B2rAkfUKHstuSjzUSM3uM+0Vb/iz7+Op4uINgUrwFoIHvfm9
         3kID1LxOr5I+ykKzkbjVItZPyZx+xKtftA1PGMXkAGU7Q6PGRPq70XMdDxo5g2vpUbJG
         aqpV845650LEGZVaZ8+95ViRsJPs/bGZB5x03TaAgoYLdehHU0Md0x2XH7GZC3DUQIpw
         1OussLidVrFvNbc0/M6D51eh7SUA0vzerbNuVZ7nl4Dt0vGPLSRCgRgj85hw0boes6VX
         V0q/tnU9YZvCJbTa9QBb8Vb/ohFgHMKXphIXHf7uHtzCnumyvPakydIBM4RAbeozYVA7
         z4ig==
X-Gm-Message-State: APjAAAWvMGZ0VlvR/1wCPZ5KWV1Okcv9suvpLtWcRoyN/m3jzhUe3pwf
        rNJqrwO+zhXTUOTWXH989uG6bqXwB406ovDUpfj+xp+GrymDXr+gGxdP6ULdSd8WI5xrr7vETAZ
        F6GQDCFpXave+KXj4EQ31oqkR685XIxFpn2XtbKe205qJGtYt4dxzx+8v1zQUJv7DKeNJjCjWRg
        ==
X-Google-Smtp-Source: APXvYqzi07UtJx18QpeWEXv1Cn+1myh6A6k80jqEcIfdMshY01RmbJ7bAX5x46oqfcCSpkRFTbW8BvAYKZbJcef1aq0=
X-Received: by 2002:a63:e14b:: with SMTP id h11mr6434308pgk.297.1581036518869;
 Thu, 06 Feb 2020 16:48:38 -0800 (PST)
Date:   Thu,  6 Feb 2020 16:48:33 -0800
Message-Id: <20200207004833.255965-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] submodule: add newline on invalid submodule error
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 'err' contains output for multiple submodules and is printed all
at once by fetch_populated_submodules(), errors for each submodule
should be newline separated for readability. The same strbuf is added to
with a newline in the other half of the conditional where this error is
detected, so make the two consistent.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 3a184b66ab..d63f4476d9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1480,7 +1480,7 @@ static int get_next_submodule(struct child_process *cp,
 			    !is_empty_dir(ce->name)) {
 				spf->result = 1;
 				strbuf_addf(err,
-					    _("Could not access submodule '%s'"),
+					    _("Could not access submodule '%s'\n"),
 					    ce->name);
 			}
 		}
-- 
2.25.0.341.g760bfbb309-goog

