Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA75CC54EAA
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjAWRPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjAWRPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F36A2CC5C
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mp20so32312396ejc.7
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxyi4RjxwTHoDnmCH1hoIfI/9xsPSTQv9k1R0cXtVKg=;
        b=ZrKfXd6QazJ46K4MXvJ9TC9cCYv+JWOuwW0cN6+UHrMv00g3R5dCvLwpicdcoYe2A1
         pNmaxSw84k9BJnIuGSgVCkXYpOmWFLGQ4oSo4r8xrm5SHrEdtqpnBsTBUlibALlDdh7C
         84R9AKb/wm5mwGP+TMBoKI2Yu3/pevGszRiHRTuJkiyGV8m6TFTknah+EVVRmKgX009I
         eggA1S9nMDJmV064CA1B/9JRa52MQiEB9n5bs/l1Z9rs+vq22vIqQNmd3KHF2hU6E9+9
         JsOfTZqp3LoQUJcY61kk/HwBsLCC2KG+FxVDjzTi4lWxLi+z0ZfPLpCzwa5WLcOVRia+
         HrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxyi4RjxwTHoDnmCH1hoIfI/9xsPSTQv9k1R0cXtVKg=;
        b=bpyO5wWx6WRvslM2IlBIr5xWH8zFgk79Zf8in72TRm/321mg6xCBEQJgzESoXT1FBm
         0YKh3yH2svxYIMCFrUO8Vv1iGu+Kzu6peZyXv1p2jGNf5zdyWFmOHNEp51f4A0ys1r6h
         KONvQ5TPGhhS8CRsxJc0bkpln1J727cq/Mc10MvCjBIOKY4rH4dWoKXe/kyNTr6kp2Fv
         y+JjJ5QEgnW8UlkM1qlnhpQ7eggR7YlVleJYwkuLDlQt07qda5COqniOWbYHrMNHUzYk
         36D9WNtZgBS1ZGj2hNAqO+qfKa0z3E/Cg0j0LVClS+PSPZ0pCBdUViPbUPjGT6gqNZF9
         1+fA==
X-Gm-Message-State: AFqh2kpVDfc2viV8k1dm1YS9AkIuTLIiOU717ub9H9SybdzRClakYDJ/
        5weP1o1NN/wN5azKStJ1PKhaTx81chaQAw==
X-Google-Smtp-Source: AMrXdXuKsQaoL3nswcjA0QywoULGIeQiSWOGX/MN9NIgSarMX7oLI10lbjH92QpAupemIIAG+/sY2w==
X-Received: by 2002:a17:906:848e:b0:818:3ef8:f2fc with SMTP id m14-20020a170906848e00b008183ef8f2fcmr25020456ejx.5.1674494113534;
        Mon, 23 Jan 2023 09:15:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm22771754ejd.91.2023.01.23.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] run-command.c: remove dead assignment in while-loop
Date:   Mon, 23 Jan 2023 18:15:05 +0100
Message-Id: <patch-1.5-351c6a55a41-20230123T170551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
In-Reply-To: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that's been unused since it was added in
c553c72eed6 (run-command: add an asynchronous parallel child
processor, 2015-12-15), the next use of "i" in this function is:

	for (i = 0; ...

So we'll always clobber the "i" that's set here. Presumably the "i"
assignment is an artifact of WIP code that made it into our tree.

A subsequent commit will need to adjust the type of the "i" variable
in the otherwise unrelated for-loop, which is why this is being
removed now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 50cc011654e..b439c7974ca 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1632,9 +1632,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 			     const struct run_process_parallel_opts *opts,
 			     int output_timeout)
 {
-	int i;
-
-	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
+	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp, opts);
-- 
2.39.1.1301.gffb37c08dee

