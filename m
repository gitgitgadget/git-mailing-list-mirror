Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E5C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiBUTja (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiBUTjY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:24 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1918220C0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:38:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a23so35749466eju.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6IwN7I7qFa75t+NEsaMO1adiWQQ7mjKnn/Cjgl4Yzk=;
        b=UoUoceF4/xOhRJfQz4mCQkQ04QKArrsje8zNYCYKwcK22EFyGZ4K5BEd6hSSsKtYxS
         XJmSO5OMfh2DUTw82EFbPlSxZz/c/pRBR/wGM33+33JlvInVk/6EAgPd8w7j/bFyCttU
         X/1B93sKh0z3Z6svpqCyCm6yd8I0TCmZJqZ0B1FoMyxO50hwzUoa+BBb+WkrgOQCsika
         J/t4ppxuT1ieiJ7IxAQVMWb5zStmTiq7Y7BHVIdPN7XV2WFs62vCFBwe7cRs7k1A8Hox
         PDQv0THlb3IV0knJ5Pj/QQq7jQRwHf8VZ7uLbvd4AFVRcyuPW9eLypTRAdFx6V3zeBar
         W0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6IwN7I7qFa75t+NEsaMO1adiWQQ7mjKnn/Cjgl4Yzk=;
        b=lRXU7F2ExXUOtt03KNAPezs2jUMVldT+KVg2SBaA557uvReWkdMlOLXx5K6W2G+hAw
         KHCf4S0WVHxZSl1WTzskwaT1W1Y+qFabvQUd63ySDf0BEYtrqMXAtPHQuxy8+SnGjN3R
         MLIewqoEz9qf7mAWsX+uTd9BI0a+PYfLzq8uGbG5q2My0y/xgO9gtDTjWLHwou8iviot
         K0T0uckCQz4/liSNYYPDS8pkAdp5Yqn3kmk2Y6DMBghAMLCSAmj9lKYf9IYq4BEqkbMB
         FcMxOauehTwoKELDjjZZHH0o5iQIiF3RLHqfxOZYLxXMN7TThvwD712ZTCnoPJsVbsGm
         O5xA==
X-Gm-Message-State: AOAM533UxStrtTrIA1IF0tSdsT8cMQdo3n4RaY1RVCYN7wUHPw7KDab0
        J/K5uBS+CDLYuTG1EnyRIw1JgpCl/8y+Sw==
X-Google-Smtp-Source: ABdhPJxnFTO8eowYBrEm/7NugDEK1BMD3XzKNJccSbuoNkzKHXUCtfYKE0TLzOYsT8LACYdhvfjYmw==
X-Received: by 2002:a17:906:ad8d:b0:6ae:9bd6:1e9a with SMTP id la13-20020a170906ad8d00b006ae9bd61e9amr17164014ejb.337.1645472338215;
        Mon, 21 Feb 2022 11:38:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:38:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] help doc: add missing "]" to "[-a|--all]"
Date:   Mon, 21 Feb 2022 20:38:44 +0100
Message-Id: <patch-v2-1.9-c4b66c36c17-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing "]" to documentation added in 63eae83f8f3 (help: add "-a
--verbose" to list all commands with synopsis, 2018-05-20). This made
it seem as though "--[no-]verbose" can only be provided with "--all",
not "-a". The corresponding usage information in the C
code ("builtin_help_usage") does not have the same problem.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 44ea63cc6d3..cf1d53e9499 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all [--[no-]verbose]]
+'git help' [-a|--all] [--[no-]verbose]
 	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
-- 
2.35.1.1132.ga1fe46f8690

