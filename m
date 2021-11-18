Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609E2C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3920161361
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhKRWEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKRWEo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:04:44 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22EC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:01:44 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m17-20020a170902db1100b001421cb34857so3620421plx.15
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=kG5xgcqaG5/qIFzxF7jbdNmdPXLfRDPj78VS5N17muU=;
        b=KT39uJYModJhzcuGpsfhjdYJDZ4PZsWlC8JHyOywrc+drtynQbnIuegJ5naCC5iDxq
         esMWmgzt2DpKBR59TCcPOjK5PjFDNJWqndXwbr/0/yrPHgVkXn4AODTFosIKZo8ZFwmH
         ZwlmnYqtImUY9ex0ZF+KkTMaUpLDPF7NQKBe/9y8NkLomhMoSYXIumD/NI0jWbtL0hDs
         P0dhACKQgUvPKTv6PyIV5mAi3oJFVIPVjLTBc6sdNaCUt1TJ2ePGA536Tw1gIfBaMKtx
         J9CwPsYLH3xfU+fSHUKzMEzbNzc1LSUvDO9lmYoqQmUYlRJHj/5YboSI5GRIEpDau7fV
         bYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=kG5xgcqaG5/qIFzxF7jbdNmdPXLfRDPj78VS5N17muU=;
        b=hoIu8rJQ1VUmtPxGJLnqF/F/hZtVi+y7sjFC2X4LorzXQ93rJbSSjw73VWXbEFGtES
         bTAW3yC2LaZK4BeYVjf00zNChMBPIIqrVE8aoXjPc3sCEgw7wWLntgAhAhs+rGJ60C6Z
         fOsXGRsdK2LGpN6D2/IGrRi6APNq512H9BE2f9hhrG+8iTaCZ8jqwHuDso3VpOJV+WcS
         8uAnK43XhlF6+w2Qc/WnL/cOFZYssM/9xwh+iSsp2IP3xkR5n5r9otLI1NkG/AyK/pVy
         DUAujwnV8mFjTwvShegMCxu7IqbNd2AZKLI6ZFgCfiOpA3DzIk5ifyfS0brd98i/izKO
         VHMA==
X-Gm-Message-State: AOAM533M80R7Jo/G06tNzU1oPJSVbRTVljChk1vPCKVr7ZYO5UW1NVP1
        VZyi0XtjN+s5sJwlCFaIi0phYGox09IgMbfNwt12J1pjtWYADZGXHkT4cIzxfgMehl6XLcVtT7t
        tRkqc9iqUNvC2I+zGvPKU595+/X1c+fVkuzBZU5usu7wo9maYK1gnCdpCYEGjPSY=
X-Google-Smtp-Source: ABdhPJwzYYyy1fjVQsD5TzEEGgytW8FysfRW+ISWYOtPDpiqaQkzsvl00nQ3tTNe7RSggz9Q+vBnYVuRBJW6Sg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:2795:1675:9bfe:fbf3])
 (user=steadmon job=sendgmr) by 2002:a17:90a:fe87:: with SMTP id
 co7mr14255430pjb.21.1637272903541; Thu, 18 Nov 2021 14:01:43 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:01:41 -0800
Message-Id: <5a9e49e7f1540d762374382e1769edf112cf093f.1637272706.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] trace2: disable tr2_dst before warning on write errors
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If writing a trace2 message fails, we optionally warn the user of this
fact. However, in 0ee10fd (usage: add trace2 entry upon warning(),
2020-11-23), we added a trace entry to the warning() function. This
means that we can enter an infinite loop of failing trace2 writes and
warnings. Fix this by disabling the failing trace2 destination before
issuing the warning.

Additionally, trace2 sets a default SIGPIPE handler
(tr2main_signal_handler) when it is initialized. This handler generates
its own trace2 messages when a signal is received. If a trace2 write
fails due to a broken pipe, this handler will run and then cause another
failed write. Fix this by temporarily ignoring SIGPIPE while writing
trace2 messages. This is safe because the write will still fail, and we
will disable the failing destination.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 trace2/tr2_dst.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index bda283e7f4..8a21dd2972 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "sigchain.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
@@ -360,6 +361,7 @@ int tr2_dst_trace_want(struct tr2_dst *dst)
 void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
 {
 	int fd = tr2_dst_get_trace_fd(dst);
+	ssize_t bytes;
 
 	strbuf_complete_line(buf_line); /* ensure final NL on buffer */
 
@@ -378,12 +380,15 @@ void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
 	 *
 	 * If we get an IO error, just close the trace dst.
 	 */
-	if (write(fd, buf_line->buf, buf_line->len) >= 0)
+	sigchain_push(SIGPIPE, SIG_IGN);
+	bytes = write(fd, buf_line->buf, buf_line->len);
+	sigchain_pop(SIGPIPE);
+	if (bytes >= 0)
 		return;
 
+	tr2_dst_trace_disable(dst);
 	if (tr2_dst_want_warning())
 		warning("unable to write trace to '%s': %s",
 			tr2_sysenv_display_name(dst->sysenv_var),
 			strerror(errno));
-	tr2_dst_trace_disable(dst);
 }

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.34.0.rc2.393.gf8c9666880-goog

