Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBBC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbiCJN6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbiCJN6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5C714FFD5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e24so8078325wrc.10
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgzhy2ku0o3GoDlMBMdtPBxvUe5eGsJ7sFFXGcRiBd8=;
        b=Kn6ae0aPZe4ZXTIMInVUtD8zVO4JcT5GfEW+dF4rqzL64tTmQRPqkXjVnmqFVB9K0w
         qLYR4BtrVcuSus2gHuEvmzRtboBJyHFucV8D9gcU+WXXkhR8W7bKXIbUDudsFJ7ZkWNQ
         ES4B5CPA2kzYJOJaG2/9FFX+nsYMk7JS0GsCKFYtCiidKfXtOJfaZHGGRdEsdEupWnOI
         hhFxL1LxSyzpuYPp1tTxdEpyoa/K2Cui/3rI4l8rGky4hPQvy32GH5GMhhNFyhPvZ4l9
         1ifpyu/W1E2yWM/ThsSEWNfg91bi6y28KuMtzxX2nkzQsCGCAhoU0jvDLROg+art5F+p
         +M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgzhy2ku0o3GoDlMBMdtPBxvUe5eGsJ7sFFXGcRiBd8=;
        b=0b3aJlOaiSed35W4VHol6I1BNz7Wb2mbdtpen7iBPrDJFate3/gpitBMe8Q7hgn3uc
         zbXHRKmfyw4KoTCAFqD0ML0QiBLPuqL0qK/KLoFUkSpt+wuBXeZJxqsYiFvkV7p3LwhQ
         Wa/FDYwUrfW4Z7POgJ+YyjtvAv1azJZEsaheXeh96iFWVyoD8gB94CFJYahC6nh3XPbH
         aydb1M17Ars9SIhuIQP7ey2C31DbYuoCyM3rfRXvC496OJmDU4XIHUYUF1Y9xBlHDWAK
         bg0whBzPMeWb+/OVLzcUox/rbwnwLuiO7yXm92VohO/uk6lZ1DVsEgQSEgLjtjyqJ3j7
         5jUQ==
X-Gm-Message-State: AOAM5339T6Ll7qhz873dNNu3DgwK3pz5PwvJ0tHOjaGshiZzYM3c2VGQ
        fRK1ZhMIbcExdeotIgP5OQPnS89Ip8+o9w==
X-Google-Smtp-Source: ABdhPJx1d0RcIqHZbViXFkNw32rtsdC1RpJ4V7heUzZivPkLbDB33Q883r438KL/x0h2mmEaBMFhaw==
X-Received: by 2002:adf:c5ca:0:b0:1f0:aa2:494b with SMTP id v10-20020adfc5ca000000b001f00aa2494bmr3730899wrg.275.1646920631618;
        Thu, 10 Mar 2022 05:57:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 4/7] ls-tree: remove unused "MODE_UNSPECIFIED"
Date:   Thu, 10 Mar 2022 14:57:00 +0100
Message-Id: <patch-4.7-05959f0fe4c-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "MODE_UNSPECIFIED" added in a preceding commit. We don't
need it, instead let's start the "command mode" enum at 1, as
e.g. builtin/help.c does for its similar pattern.

In addition let's change this from "mutx_option" to a more obvious
"ls-tree_cmdmode", even if the type name isn't used anywhere else. The
previous name sounded as though it had something to do with
a (thread?) mutex.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f04733a9be1..95816709d38 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -49,11 +49,10 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static enum mutx_option {
-	MODE_UNSPECIFIED = 0,
+static enum ls_tree_cmdmode {
+	MODE_LONG = 1,
 	MODE_NAME_ONLY,
 	MODE_OBJECT_ONLY,
-	MODE_LONG,
 } cmdmode;
 
 static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
-- 
2.35.1.1295.g6b025d3e231

