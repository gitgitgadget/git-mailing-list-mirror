Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C65C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbjEKTtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbjEKTtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:49:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F156F83E6
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-52857fc23b1so8492748a12.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834515; x=1686426515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+9aIyZsHKWt/WXrctl0MWBZHtOrnvY1GGul+Q1rxBQ=;
        b=wa/lIRtKxWNR5Q7oN8MrZDaeL/jjh/+qr0tIiCOX6au5SqKtBhlSYYGA+XANUEONBU
         Oae92BEIxaEKNAwu7kQMrlrojWxjzN+sMYXSyDY9bp1d21Fa6d+hP7RtDU4ljF6wPTvY
         rfS8lwVxtzYplmvENjquS7CxIkxFRL71mL8PLWnB1lXzer88Spc4U5ml6j+C1VCaSr1J
         nUcz/aqHjI8opvZYavLqpHCx/rFdKc9pyK87aQWiytk5AUPoDnyoXCPx39EHeQJ6p4oI
         7a+NUAjw3QHxvxCOy2vQrjTowsJjGcmLYqFySDo05XpgJhZ4DiBBT1qZVN1Cfydae9pO
         mBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834515; x=1686426515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+9aIyZsHKWt/WXrctl0MWBZHtOrnvY1GGul+Q1rxBQ=;
        b=lZ2chkFJnaVQhc4qX9tB53CI1boVEdlbFElyRRMKw4IvPEg5icb4qp+xaJnvcxou4+
         Oo6yJw1LLdm3PvW3FmR98NTilIdnrDns3nv3SGWCmqleF96o7PWlKxNdS2vz52hxqAbK
         V4OLKVlPzoJaj2DpH63xwSRIDP/o1ZjAYOhqVOhy63ldsIW7xQAbmYY8K7MJPhBQbXcX
         9q/GR4ukjZvJmN0K26DeSt+Gur4ErTyY6wkJWalY9Nxmtr+HQqUyP0o6TxnKWiX3+paY
         AzMPCfdaAoWx676QjIRCrctsIT8bmDQjS5MS4kcAFjbZNlSNCAyMDQYfj3el7diZtBmb
         OJwQ==
X-Gm-Message-State: AC+VfDzVtJiPIxkLVyhIEEcgbeAqMa4cnQmgGpHESlkaYWKSfgbnCPfe
        N7XMCN+YkijKnMa1P974lIvxxO2J9W78CNVHqT7Yu8eFmo6P6JwTTmSR414zyRu3VDXo/OJleFM
        f7qrykZVBKQKF4khyygn6A9LGIHIi90exaDDTu3tFMgMvh+TOkaHKOvZ0iDBzcqBG/Q==
X-Google-Smtp-Source: ACHHUZ6TEJe1h+ywhZYROa9xPD9fFhiy75YgTdJEQTejwqqXxk+OBw0RTMApxRoM78cFi9m0dk9zDUOq7sH4l/Y=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:8a4a:0:b0:52c:a2b8:5dda with SMTP id
 y71-20020a638a4a000000b0052ca2b85ddamr6373209pgd.11.1683834514841; Thu, 11
 May 2023 12:48:34 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:21 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-6-calvinwan@google.com>
Subject: [PATCH v5 6/7] strbuf: clarify dependency
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs.h was once needed but is no longer so as of 6bab74e7fb8 ("strbuf:
move strbuf_branchname to sha1_name.c", 2010-11-06). strbuf.h was
included thru refs.h, so removing refs.h requires strbuf.h to be added
back.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 178d75f250..d5978fee4e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
-- 
2.40.1.606.ga4b1b128d6-goog

