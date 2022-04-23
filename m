Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D403C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 14:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiDWO3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiDWO3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 10:29:18 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD9101DB
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:20 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so12150631oix.12
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0wj2xoZBMsvO/Xau1e9Rw1SFEQUkRzX4CsF/i9Xvkw=;
        b=nrn8AFaRUjf3sXu5nhV1DSyOLz/ll9bRKYTCnFrwnrAHZxqAlBD8DFdUUDwJauUOjr
         R0hNNuIHWvTK3x3PPxksTULKxpLz8Y0+BFMg7jLCbHZGO5gpC+VLlGu5J3aOVTsgzALo
         pkaxN9hCOHE9iDXZjFONKhMPFZWBNKzqfDA+o17m/QWyFA5lHgpZQZ8Y5AXpzMCgzrfW
         ZCqfI/mgHl1KWXiI2pSbvGM67OeUxK0r/qE0k40nruJ1/PUhkExzFVzNgzyVoBfw7qDY
         aeq3p4zc3lE/tfxI8Ht3J6sRzYnfsbjZSjyLiUDN7lt5Wda1cOUviT4l2KG2XhFSHBCC
         uvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0wj2xoZBMsvO/Xau1e9Rw1SFEQUkRzX4CsF/i9Xvkw=;
        b=5VeKhUn2RgxeB8r0qfCUv66IsHTAqS2rgJ6ctIEBepcYRXcl+lvE4xkDYb9Ukim0KC
         EjZqZvK2iaoXHJZESjPLEf5x9PAbOGcvwF0g4/HLEG5LKMscGQcTaOBFUHlQ7KyXw0nO
         p1fR+Gi+cLNIldCA7sMwRFK8xZeN06PNMfv0QkY1X19fivb/0t+Heg8nAc7MHdSyj5uz
         RZynWP3erQkYqol2agpt7JqT8Dd99bOA7BoVsk0bg3YRsk7a6w4NYPUOD8Oxp/feAyP4
         l1sHD1PbPtEJfakt17U+hJqRtTZp7j9tPu+usuBT4/q3X3x5L08AARF3N04q8RNlbdOa
         K8Sw==
X-Gm-Message-State: AOAM532DIh40HrpQPQ/M6SKHAbdMRmQ3BdwpvGOwNb9almCRpdlRonYN
        eph3KvM1g5XKWxTxTZSYmHoDNxfY4zg=
X-Google-Smtp-Source: ABdhPJyZnA5LdH/EvXX3/owaKSNNqqln58OSj35Xc6lCmR5hH2mC5kx2oKj7+kiBj+Fe3IBKYT2axQ==
X-Received: by 2002:aca:654a:0:b0:323:1b2c:f419 with SMTP id j10-20020aca654a000000b003231b2cf419mr4673812oiw.235.1650723979318;
        Sat, 23 Apr 2022 07:26:19 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568301e0400b006015bafee43sm1869993otr.46.2022.04.23.07.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:26:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 1/4] ci: make failure to find perforce more user friendly
Date:   Sat, 23 Apr 2022 07:25:56 -0700
Message-Id: <20220423142559.32507-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220423142559.32507-1-carenas@gmail.com>
References: <20220422013911.7646-1-carenas@gmail.com>
 <20220423142559.32507-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a future change that will make perforce installation
optional in macOS, make sure that the check for it is done without
triggering scary looking errors and add a user friendly message instead.

All other existing uses of 'type <cmd>' in our shell scripts that
check the availability of a command <cmd> send both standard output
and error stream to /dev/null to squelch "<cmd> not found" diagnostic
output, but this script left the standard error stream shown.

Redirect it just like everybody else to squelch this error message that
we fully expect to see.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..41e9290fbdd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -78,15 +78,19 @@ linux-gcc-default)
 	;;
 esac
 
-if type p4d >/dev/null && type p4 >/dev/null
+if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
 	p4d -V | grep Rev.
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
 	p4 -V | grep Rev.
+else
+	echo "WARNING: perforce wasn't installed, see above for clues why" >2
 fi
-if type git-lfs >/dev/null
+if type git-lfs >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
 	git-lfs version
+else
+	echo "WARNING: git-lfs wasn't installed, see above for clues why" >2
 fi
-- 
2.36.0.266.g59f845bde02

