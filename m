Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E4C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2382424656
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="yXY6MzyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgAPClW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34826 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAPClW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:41:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so17820411qka.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8k77/N+3JsMemHxL8SIhD2kSKvmM6jkTaOkS1tNbwM=;
        b=yXY6MzyIcmvpb+VdiuSbM/5AkmSz2YfygN9/NWRSCD/041owY1qLszTKFEMsuxWwQV
         Gkk9xCCASEHMnQlt6h2U5JrMpuasQT2nIrXPUL/H9RVk57WzVvdq3csCgU9HJpzK23oa
         PLYRV1CJqq08Ja958CpsSkgUrsEJHvQSVrIHTYR5Kb/SHN9GK6zb0Il2t4HPynKjz/UN
         SO0K1usemsVYzxDazprI7ZMndaT4SIiFVx3LAJQck6jUvNz9HJHDAaiKOADxhEMAlexS
         q+x1SMoT3RQ7ZlgF+YMaBoBhntK42BIPxRu3axf3Fj7h4yYLlZKu9waReA++3KdMz62r
         WBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8k77/N+3JsMemHxL8SIhD2kSKvmM6jkTaOkS1tNbwM=;
        b=LC9pAiHBR75WtpKK/4SJQvz1Q/LuH7HcBUFr13KbaYTMQOME3Y7sXiAaeyT5JfR4rG
         rWORA7gk7u4xbR3ctUekyobiOWU/TOYnCUP/+5Pb4FHdPXnPRgYyZrr4UYfr9x+Ygejy
         3e+Kto7YoNPKiRlSQZuZiJiwOKEWYgZoqB9TwVYLD9mgIglPc4GFYNNbLNHv/uQ4Iy1U
         WUPHS7+Myi/rg9GYx2GkPd7DnRC1OWbJo+yhjT85xs1QlBQvHGoczMJGPe8MBcXhSfYC
         cs7FtUy6SoTKtJzI/JtfTrrSoZHZF8IPFs1FSekteA9urVagUO0jUVTJL3qsRZPr+djl
         0kpg==
X-Gm-Message-State: APjAAAXuT7WrVm1J1r+lJVWkxFDJ9YtGdYfdKTsmFP90kHdo+B4/fCdq
        tZGXMOi6NmSAItU+v4FOU0Q+tWguHEU=
X-Google-Smtp-Source: APXvYqz1qpRLGdRcPUdkeQiyOiYfhb8sNrA+TrqHe+sa0pOJXqS2d/B/cHKM77Yg79Yi2/m6tL31SQ==
X-Received: by 2002:a05:620a:100d:: with SMTP id z13mr31466133qkj.475.1579142480273;
        Wed, 15 Jan 2020 18:41:20 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:41:19 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Alex Henrie <alexhenrie24@gmail.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v3 11/12] grep: move driver pre-load out of critical section
Date:   Wed, 15 Jan 2020 23:39:59 -0300
Message-Id: <2f72f3034118432381f3c9378e70a65d27e3dfbb.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/grep.c:add_work() we pre-load the userdiff drivers before
adding the grep_source in the todo list. This operation is currently
being performed after acquiring the grep_mutex, but as it's already
thread-safe, we don't need to protect it here. So let's move it out of
the critical section which should avoid thread contention and improve
performance.

Running[1] `git grep --threads=8 abcd[02] HEAD` on chromium's
repository[2], I got the following mean times for 30 executions after 2
warmups:

        Original         |  6.2886s
-------------------------|-----------
 Out of critical section |  5.7852s

[1]: Tests performed on an i7-7700HQ with 16GB of RAM and SSD, running
     Manjaro Linux.
[2]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
         04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6aaa8d4406..a85b710b48 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -92,8 +92,11 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(struct grep_opt *opt, const struct grep_source *gs)
+static void add_work(struct grep_opt *opt, struct grep_source *gs)
 {
+	if (opt->binary != GREP_BINARY_TEXT)
+		grep_source_load_driver(gs, opt->repo->index);
+
 	grep_lock();
 
 	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
@@ -101,9 +104,6 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 	}
 
 	todo[todo_end].source = *gs;
-	if (opt->binary != GREP_BINARY_TEXT)
-		grep_source_load_driver(&todo[todo_end].source,
-					opt->repo->index);
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
-- 
2.24.1

