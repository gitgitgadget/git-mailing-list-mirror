Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F73C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3152253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fY/TUXKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfLMAnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:43 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51309 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbfLMAnl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:41 -0500
Received: by mail-pf1-f202.google.com with SMTP id h22so372308pfo.18
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=moNPuHjYyDs+iOyyWpo7dGT7iFTwBt05Fs9rna+PXXg=;
        b=fY/TUXKE4sLpgXfwA96C/1tpmnPMp9rFTD1DnzVKfb9fGgJnOOYMD5+zc3Dig/oJdK
         BVowk/ajHIC5txO3cekp+Sdbbk/B0d1jDAQaxBNVm9We/uxFelCteCAWR8rukpVJ8xCs
         FbO109O5gV0SYup3j4l/FgDMgATuY+EOQo1726Hf7LqB1bA7zsSICyDLeAcAcAt+it28
         OK3QGTwlMPU8D5sQL6slxSXs21QtLpbKonLAQbBAb3Er1bzKfzAQZLOAvBejcTH7HGcF
         C0/MGKxoXGl0yOyW9hJ0VnjabtX2FJHuN2/tzxJw2C6OZvqAB92V4mETg/02kYePNBMi
         bJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=moNPuHjYyDs+iOyyWpo7dGT7iFTwBt05Fs9rna+PXXg=;
        b=iLKK1WJN4DvPKT2IiVSVe0eII8Rptw3urPD05rl94ck9Xa/q3/2A/aVNstLU9w/37i
         0y+qofIrGi16qvMPG/iXbTNNi6jCBJHTmOObCfD6LICyLfU6zYWQMMlH9iHXadYGk0SS
         amfvuNChujnq+vU6dE+4YPNOmxfW7JMSFHR5HQkInc7m0EA2xRPTF8Pf2mDpb/juVFpl
         qTSeLBuP4CWgo1nYrgk+esawDIHov888AHbueNO0Srfy3gbE6txjT49GFatieCI1r4I8
         FCNzGlkD4te2LmqnxAEagk8Fh/3KGari1o0AwlJFMEtjsYshQa7j9QxK/Uufl+UcYz9g
         f3ig==
X-Gm-Message-State: APjAAAU7jmRy3tUQqZk/SCWybolGBZX0J99NG1oQGdlKZkMHpT3LBuvq
        Vtn0/5q1EiXMQSJpzwlLgcaNuvwkmXvy7oV0OvrBXwqQZAdK805Ypi0IcRwcur0ZXJMWSrqyRkv
        x9WQZEebdAApe4qebyNq+7UQze0Mn7v7tGFJeaoKwyG32HB6OAntwxGJnoccWoSboZLX5IGDfHw
        ==
X-Google-Smtp-Source: APXvYqwxnRnl6APfuewerGUWe/VownlBcjg1hwOV/ezwQg6srUfWPiMPkYsVvF7nKaNdBQjxlI4BzEmkfJxA9zAIHkA=
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr13907714pgq.417.1576197821103;
 Thu, 12 Dec 2019 16:43:41 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:03 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 06/15] bugreport: add glibc version
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help pinpoint the source of a regression, it is useful to know the
version of libc which the user's Git client was built with. Let's
include it alongside the other versioning information, which is used to
identify how the client was built.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 9c69e3fa34..af715dc157 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "time.h"
 #include "help.h"
+#include <gnu/libc-version.h>
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -27,6 +28,10 @@ static void get_system_info(struct strbuf *sys_info)
 			    uname_info.release,
 			    uname_info.version,
 			    uname_info.machine);
+
+	strbuf_addstr(sys_info, "glibc version: ");
+	strbuf_addstr(sys_info, gnu_get_libc_version());
+	strbuf_complete_line(sys_info);
 }
 
 static const char * const bugreport_usage[] = {
-- 
2.24.1.735.g03f4e72817-goog

