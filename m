Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF2ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiITFG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiITFG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:06:57 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2046D8C
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:06:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p3so1304107iof.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nOlbyeSqa7e0z++7vxKnpi/f4klY1VwcoTnrnpYbcNA=;
        b=TMgYRNgASH+MeB8Pc2Q8qcdk+Qd5T0bTVpdELIioibVF/2PbPrdrxw2HywXndR74mj
         06sI848zbLLNr0KPw6QxUKM6meZ/6B5g1rwXFZK5jubR8RGd05WaNUfFEXoDcihMHPs1
         oz2cgHR/kjxu49vmv9GRy5TAVTfCCgTB+IgY9DMDQDWNNMYZ5SdjLBCWgvy8hk0bThv3
         npZKi9VJXOvf7dxyyhqSjJNy9DmePnXZD3OS0NCrpFf88hQh/s5Rt8rGKKnRShWZTei2
         0ljoOTeN6ktZ7GlBVOA9en3f123LEH6zl9o2UGYql8Xe787wYiT8Sq6a2UNArc4xRm/X
         JrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nOlbyeSqa7e0z++7vxKnpi/f4klY1VwcoTnrnpYbcNA=;
        b=wMWcBHNzK2fouWLPvuaMLqTISZsuoYXZVeMuO6m5S8JdTiJqW2xXgENbaFQAZzBw8T
         Tvug2IvsPYdY3YBU4+XHdSnfj0HCWTsAqES9h3g5n83ncXSuyVuOXdfkDEItCwQppl8l
         N56MlgwX1tgzyprf2HzwJ//gthzr2DV1kjrHG+8gmf/Ddlvh1fJ//wZxm6orppagg2xF
         7FBscEs5Uuk3g3nyjUP9q9LbRbaqFfIudnTTZf8QFGbfU2GmpoqUMltAUNobviEQUL4C
         AdCC5seqVrTI3jDfdT+sGRwFSxHEtK5Ipzvgz3Wgy7T177dkmfA8oJ9+yVnQyvmISixZ
         RocQ==
X-Gm-Message-State: ACrzQf2jKb9JkRNff2RJVJN76+PbSTpzP6nMd4sFUzhiHYf8rSbhglsg
        CiApzrach34IFCwa5c0EDkASyfTFRYw=
X-Google-Smtp-Source: AMsMyM69kg47dguM9FPHcJuHqgFOraBtTFDTs30FM18dl3G/G3uAIy+ijbOjRRWYcsKFcmB70HZfSg==
X-Received: by 2002:a02:344b:0:b0:35a:ffdb:4649 with SMTP id z11-20020a02344b000000b0035affdb4649mr232193jaz.8.1663650415943;
        Mon, 19 Sep 2022 22:06:55 -0700 (PDT)
Received: from xavier.localdomain (75-169-34-129.slkc.qwest.net. [75.169.34.129])
        by smtp.gmail.com with ESMTPSA id e39-20020a02862a000000b00358cfb04225sm274776jai.25.2022.09.19.22.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:06:55 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] builtin/diagnose.c: don't translate the two mode values
Date:   Mon, 19 Sep 2022 23:06:32 -0600
Message-Id: <20220920050632.326307-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These strings are not translatable in the diagnose_options array in
diagnose.c. Don't translate them in builtin/diagnose.c either.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/diagnose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index cd260c2015..576e0e8e38 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -22,7 +22,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 			   N_("specify a destination for the diagnostics archive")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
 			   N_("specify a strftime format suffix for the filename")),
-		OPT_CALLBACK_F(0, "mode", &mode, N_("(stats|all)"),
+		OPT_CALLBACK_F(0, "mode", &mode, "(stats|all)",
 			       N_("specify the content of the diagnostic archive"),
 			       PARSE_OPT_NONEG, option_parse_diagnose),
 		OPT_END()
-- 
2.37.3

