Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F70C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0729F2082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ6/qnaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK0TxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41873 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0TxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so3058342pfd.8
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgQrv7WEr9BNerWgrMuku+xWg7Wefls9OMP9Y4CHDT8=;
        b=UZ6/qnaUmoRlrwlzwXHem5SX8u580wdI5JZGGWzNxTiBzxecLF+HYOSHe+afIgXtno
         +42/GvyTMpwjvmBinFpsfX5li0sFP3bb335lh4jXOCCJtn+jrK7TMAQul4C6saZumCSg
         Gf9qd9uJNu6PsJC9Vz7IzwcWPvQsO6glML5aHyxNCX5yZFlXVK4kOk99FJuZQCCiF/A4
         O+GBZSWJg0zvEntUwc6p7YNZt5fw93erUbX8v7voUFaZJsvblU3GQt6yz16zLDHVMQ5G
         XH/Xd96/x7AMIzStib/u0Bo0/df1thWgXyKDbqfKr2ICBjRD1hvmT4XW4LoA0fAhyrtn
         D4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgQrv7WEr9BNerWgrMuku+xWg7Wefls9OMP9Y4CHDT8=;
        b=lMSmiKZII6xIqihva+nCGJDv/TgTtT5vMkFIkQ9cWsA5IMCCtsTvSHTaa2v1u8tcYe
         QPjHx3aBL4T9hfPtr2PubvNRjtXRKTuXyKPRaynftQRllr358+lg1tOrDaysTQ/hws3V
         G1bZ0lL2PNxGE7Jb6kCteBr+NpYWDH1r8ladGqYNoIoBJ4CCn2fBQO+kpkUc63z+NKla
         qgSqURiasGOxSTP45vCMAkZKaOV16pxaQsbMlq9IVEs5IXmKsjSFHE793LwD1jFr77+k
         ZAMAedkz+vXhbxaywqgOZHc2z4Xlm/nd3fukrrHaBYDBULi2Pd0Wg/uHxGW7MahoM7I1
         VpXA==
X-Gm-Message-State: APjAAAW8ZP0/TQgcEMEYjXQ3oR9E5/6WDjFToXrgS86dDYlSd3bnNwRq
        lWgVrjwW0WlyQh8RDRXS6SJyl21g
X-Google-Smtp-Source: APXvYqzv3tcf+bQXPDbh+Kbe6S0ILlR7py+3BE5YYlVAgRRtmOHCHQJSL2AcH6yLqC5Vjj9M/095jg==
X-Received: by 2002:aa7:8dcf:: with SMTP id j15mr50153077pfr.233.1574884388497;
        Wed, 27 Nov 2019 11:53:08 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id f30sm17181010pga.20.2019.11.27.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:07 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 02/26] apply-one-time-sed.sh: modernize style
Message-ID: <86f625c65e00b24d1de183c3a993e6acb7c8325e.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert `[ ... ]` to use `test` and test for the existence of a regular
file (`-f`) instead of any file (`-e`).

Move the `then`s onto their own lines so that it conforms with the
general test style.

Instead of redirecting input into sed, allow it to open its own input.

Use `cmp -s` instead of `diff` since we only care about whether the two
files are equal and `diff` is overkill for this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-httpd/apply-one-time-sed.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-httpd/apply-one-time-sed.sh b/t/lib-httpd/apply-one-time-sed.sh
index fcef728925..bf7689d020 100644
--- a/t/lib-httpd/apply-one-time-sed.sh
+++ b/t/lib-httpd/apply-one-time-sed.sh
@@ -7,11 +7,13 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if [ -e one-time-sed ]; then
+if test -f one-time-sed
+then
 	"$GIT_EXEC_PATH/git-http-backend" >out
-	sed "$(cat one-time-sed)" <out >out_modified
+	sed "$(cat one-time-sed)" out >out_modified
 
-	if diff out out_modified >/dev/null; then
+	if cmp -s out out_modified
+	then
 		cat out
 	else
 		cat out_modified
-- 
2.24.0.504.g3cd56eb17d

