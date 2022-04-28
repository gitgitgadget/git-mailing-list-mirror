Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BFCC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 11:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbiD1LDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbiD1LCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 07:02:53 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CCA2050
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c1so3252142qkf.13
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guVDKogfG3oQKgGegLo7TonuJFaFJsfLFKFxxzoJAoY=;
        b=eZcNgFmQ+0nuMQ7hOTpIbJX9AQt93XWZEf+1AE+X0trYPBKhH9PgX9wqg7ORJVIrlP
         kxtVvq6yr2I+C+VNVgI1Gd21vYAY79vItdv2Es5zs48LW/OR8rrLE9IjUABuXfsMnvOc
         PnDnveWNrpat+R9Nzkld21RdH+auRbYdU0qs+USJww+EBXmZ24hury1MoyVr4urYVQ9A
         xAGuhup6fJlE/AHdAlgauO0yDqVJ/eYv0gZ56fvxcm4NHb9jSFjyWoxvHGQ3XL5vpGda
         KH5lvgyJLlHe8FLjYEoZdAjrDTAr0ooIstkNJc1zIZZVbeAbTsu8rwuT+8xZdvD60q8f
         3hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guVDKogfG3oQKgGegLo7TonuJFaFJsfLFKFxxzoJAoY=;
        b=vxOAFLgUrKE784b6s2cmkh1svodnnq9hj3eQ4RQCHxs/QX4GmaEIJc1TYY1vMFZQQP
         mye8I9FbyggU6Zvn7aCJ2AIsutfVYkv9lsY9VH/g+xWjBNzhTTiAtXGSGfWd3X0SV/Ks
         58xXdwePwGSVd1RIdLTtys/RW/5fIGHJ+hMBFe11upwDUnWnwfnTlGgFiaYoX7XW/D6a
         MqbAs5eRy/aVvrO6THakW0GRupSbK4UEUsMEye2YRRl7XcZN2RVGTJaWlyTtxd8ir3cP
         YgYg5+JzkLVAYyulp4SMZePP1KgVJaJ3UykgKN+9r3OwTKEfe+9VwX52NYu02agK0JIH
         BGbQ==
X-Gm-Message-State: AOAM532tD7TpFyyKwp/i9nt5D8UaUtxR/G4lAdel2OR0wE4iKk2dtG0Z
        QnC89BBaVN3sgXgOcosA11N92baVQak=
X-Google-Smtp-Source: ABdhPJx82bFcTo9xNa0zXf5MrQVmE02gR1htTZW10eyz1pNo6/V5zh3qWQQOa9G6n7waYtQC+L/8Ag==
X-Received: by 2002:a05:620a:171f:b0:69f:60aa:3d2f with SMTP id az31-20020a05620a171f00b0069f60aa3d2fmr11016907qkb.23.1651143544031;
        Thu, 28 Apr 2022 03:59:04 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm12950299qtw.64.2022.04.28.03.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:59:03 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/3] Documentation: explain how safe.directory works when running under sudo
Date:   Thu, 28 Apr 2022 03:58:51 -0700
Message-Id: <20220428105852.94449-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220428105852.94449-1-carenas@gmail.com>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous patch, the behavior of git was changed so it will be able
to find the "effective uid" that is required when git was invoked with
sudo to root, for example the internal calls made to git when calling
the following in git's own repository:

  $ sudo make install

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/safe.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0ccf..ee558ced8c7 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -26,3 +26,12 @@ directory was listed in the `safe.directory` list. If `safe.directory=*`
 is set in system config and you want to re-enable this protection, then
 initialize your list with an empty value before listing the repositories
 that you deem safe.
++
+When git tries to check for ownership of git repositories, it will
+obviously do so with the uid of the user that is running git itself,
+but if git is running as root, it will check first if it might have
+been started through `sudo`, and if that is the case, will instead
+use the uid of the user that did so.
+If that is not what you would prefer and want git to only trust
+repositories that are owned by root instead, then you should remove
+the `SUDO_UID` variable from root's environment.
-- 
2.36.0.352.g0cd7feaf86f

