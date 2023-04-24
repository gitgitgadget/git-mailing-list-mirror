Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F9FC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjDXQu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjDXQuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AF6580
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38be107e467so1572018b6e.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355049; x=1684947049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQcKAEYzHB9sfB9/cYFsqe1sV8FF6PP6yTX0Z7OGj9A=;
        b=O8drfHWH3ZT6AEeBYGaJnVvw61q0sOeXi1THsbssfMSJRICWnIcLnfY+PmkHZm9XZ2
         tnJ1Wen+fOPuDoVZi880ozaXaJ9i76PAe10wgYfaAK/qy4tpFK+KZkN72jHW+VWwhD4G
         1ENfN613I/UBcbq7Li5xePCskkrKGphjhmw4A5pdL/wSrfEqTCk+NwgFOqyN+faL4ehY
         tkdpGnatfSzTS+vWFrj/BJUbJAq47Kl7+J12feNX1ngUBlvrPO73ekYJsBMzxKzTqLHV
         9ET+vGviFcyvk4DB+KSwiXo9HJ+WRiIUzWA7IkoUo0+HmiRKVY3ILzUDtHAYzxZf6ee3
         UqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355049; x=1684947049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQcKAEYzHB9sfB9/cYFsqe1sV8FF6PP6yTX0Z7OGj9A=;
        b=VVFg8mKIU7SggU+2wGzBMEmcddqY0gk1FxVUvlK0hgWs9Db1on47gL+DZikDZA6L8L
         MOB8kLSq+Tz6tZ3EWqKEptsdxAtfZiSx+QYumf1iCFcFE5FwpsEhaXqbJhvH+mNkn4P6
         oDhulrYyW0ormZKDFPG0LAfy7K+RZkxGhvs5FCVyvPN961FvXGoQAPRBBA85vWAQ4EdT
         Mcx5A7dSAglppqYeZm38vzkb2dK28rejALBP+KEfRAXpxORK3A3iakOVdC+jJz7gh7Bx
         9wE7KQve9cGzhvDXAHQ2YM5RGNDuxjNl0qjWQ4jxoG3oQThbC9mazjidPAm0j5uPMOYr
         CiIw==
X-Gm-Message-State: AAQBX9d6O26xcFjCPQUBaLA6U7sEW686Z4gKLjupR24wwWmkFcVpG897
        1sgKThX2zRjXWcwxawZtCgictBE8fRw=
X-Google-Smtp-Source: AKy350agvYyJ4S+Kda8cU+dR8XkswMu0NgMTTOr7My8Zc0jZKrtlxuQJhs7q710FWDGGDEh+sDC0YA==
X-Received: by 2002:a54:4488:0:b0:35e:9090:2969 with SMTP id v8-20020a544488000000b0035e90902969mr7427299oiv.13.1682355049024;
        Mon, 24 Apr 2023 09:50:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i204-20020aca3bd5000000b0038c235e24fesm4706632oia.48.2023.04.24.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/15] version-gen: simplify update check
Date:   Mon, 24 Apr 2023 10:50:31 -0600
Message-Id: <20230424165041.25180-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to extract the version when we can compare the whole
contents.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index c0f6bb242f..34f561752b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -35,11 +35,5 @@ fi
 
 VN=${VN#v}
 
-if test -r $GVF
-then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-else
-	VC='unset'
-fi
-test "$VN" = "$VC" && exit
+test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
 echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

