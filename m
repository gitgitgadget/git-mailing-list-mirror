Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4FAC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjBCMQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjBCMQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1F9DCB6
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:16:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mf7so14802819ejc.6
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu3vo5KFEPY8C96Ix8vUUWNfKabwfcfA4rWSBTVVUFI=;
        b=CxmZRR+saBvy83yUOcDGABZkzR2k5OOmOjnFn9GuQVtO5YSK61vK5ArDXdzdjZ9pEc
         bmacR5mWjZPuxMTBmKRyPtzPitji3LBi/m+/Yxt6MyzJwrLo0o/xqnw4QMCeyDutTZTm
         ZAMyjDdq//7pcheig1zDPLl5pxMfbe+eA32h05/8tmuNZU4xtefolGwnxUAx3iL1fcDL
         sfO6AxcAAS+LaAJzZsX5TvRxbJFwa3Lo+9HusXAYniWqdpwDb180+z5D75lFlJcMplu8
         lG8ZU6PpU6ppnwn0jv+a7DMLjDhpo6pJ4dY8YowBlq1l6AT+zj6k91f//+7bsKruYg8C
         QOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu3vo5KFEPY8C96Ix8vUUWNfKabwfcfA4rWSBTVVUFI=;
        b=hJNtoE1pA6eDVVbds+cZbyRJTMUYCUZwh9L3uJkONS52ulKrfw2mCADP7mh4tIlGGR
         PZg8K8uKvrB6kX5bjIehTUz6mUcmnM885kjEJRNHye+Bt1KS7U0GEzSjSotxdLhlwog4
         YyYzPLY6Sb2MbkQbJvt9/3NJIOi0Ibl7VU3ncZZO7ICPgDJI2tpJkmwXcpsNMg26ovXV
         iH2z4JhyDb210XZA2vVPuzSytQJTiBC0eaJotTSGrq92Q+MmviVsvJ12sRfauO5/5m+/
         VvIef4zjFYAlGZoSZvwfMSsArlVEPy73PCGj7FU1yZbIK3RWM8IpSjqiA3GbAyo7NN+g
         azsA==
X-Gm-Message-State: AO0yUKWJ9aCmAlhDmU82F/xbnhBZvv0k84ySWQfJ7dWhGbhgaZUbqRLx
        5j23qynhe1gaEnWh7P5+1zBTDu/iX4f2UDNF
X-Google-Smtp-Source: AK7set/pG3DeDCcRCvKZ6YXXkGfHpZEtGM4n/qsCt7emEahUjvImYR9w+xfSusRWnZ8UCYOiGBqTJA==
X-Received: by 2002:a17:906:948c:b0:84d:4325:7f7a with SMTP id t12-20020a170906948c00b0084d43257f7amr8843045ejx.65.1675426580172;
        Fri, 03 Feb 2023 04:16:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1286313ejx.183.2023.02.03.04.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:16:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] run-command.c: remove dead assignment in while-loop
Date:   Fri,  3 Feb 2023 13:15:31 +0100
Message-Id: <patch-v2-1.5-488b24e1c98-20230203T104319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that's been unused since it was added in
c553c72eed6 (run-command: add an asynchronous parallel child
processor, 2015-12-15).

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
2.39.1.1397.g8c8c074958d

