Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4392AC352A1
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKXJGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKXJFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:05:54 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229C10FED8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ci10so904945pjb.1
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAb3t3bjN4IKVbIWfZ6Ww3nZ+MGVdw3Zjx53wX9WxCM=;
        b=o9W/PbvXy/DJ8HwQV6f1jrZzRDzSwT5mcMctj9VNhAKWEnKQRXTx4+eAYaUjgyBwQ7
         PWMygsznEGKwvZQj6oi1BN5LPDptPgETYmbAcpRCishjXp+wcMEhpaIoy90WHDVfnc7A
         LgGdVW5XKXe5bdmoNgwkosHI1kbENtmp9U2TCXgDwbou/jawLWeq9m8ZLe4HUQpkmXc0
         2ZT9nUc6/7TILw8r4rK84yFy2YQGoIZBXUlodlt/jTeG43Qt8BDpxaNZqryGXYi1fLxk
         zuUSxQScXjYl+MFrXydIg2MYlJihrARnciLeXQTsgQa3tOxg24fe2SelCrRXbIdILMCv
         OwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAb3t3bjN4IKVbIWfZ6Ww3nZ+MGVdw3Zjx53wX9WxCM=;
        b=UUZFev+XJzXwaYmK6Z6hODVB1SQV0FPFizB+xE0bmIRu7ojn0/p/Po6RFMAWSjNMO5
         /dI79p/R1k8xbDYF5FHzC0cZxxRogxaIUGuzHssmxOoZUqLZ/TfzCVS2z5S8kesyxO7+
         JEKqZ0lroGJYwGyRXdkdwsE+SxkbDPmlk3iapPxwBEgcj1MS6ryJXbTlTvBa/xvnzEXB
         tddnHaSY4cnbDhh21R0oztNl6JQRYkcc3d6rMUTw0tqw/mHCU2XV1cttz5Q7hd6fSNMc
         VzWyRHSAQBebKerZnZmgC501f6GmrUO7sLTIs9iSclbyZlKJjj/mcPyUqPP6kaRXQ6i8
         j2fw==
X-Gm-Message-State: ANoB5pkXPaNcIcTLOb5AOpb405WsMAfzbnTQZbWxx4KjgXpCc7nUR1B6
        O90cLqq21zJVNtuc3dq+9OOwSjZ/eC0=
X-Google-Smtp-Source: AA0mqf7PGVXE0J3mv4dAcRm3ri9ru6lhSzsoLttAXwFD+uJYdIJYgc3Kgs3wbfAQY7vR9wDGqCLsgA==
X-Received: by 2002:a17:90a:62c2:b0:20d:bc7f:4fee with SMTP id k2-20020a17090a62c200b0020dbc7f4feemr41045105pjs.168.1669280753320;
        Thu, 24 Nov 2022 01:05:53 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001893dbd8963sm689356plg.239.2022.11.24.01.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:05:52 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 3/3] ci: install python on ubuntu
Date:   Thu, 24 Nov 2022 17:05:45 +0800
Message-Id: <20221124090545.4790-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221123150233.13039-1-worldhello.net@gmail.com>
References: <20221123150233.13039-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Python is missing from the default ubuntu-22.04 runner image, which
prevent git-p4 from working. To install python on ubuntu, we need to
provide correct package name:

 * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
   "python" package, and "/usr/bin/python3" is provided by the "python3"
   package.

 * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
   the "python2" package which has a different name from bionic, and
   "/usr/bin/python3" is provided by "python3".

Since the "ubuntu-latest" runner image has a higher version, so its safe
to use "python2" or "python3" package name.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 291e49bdde..e28d93a154 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -15,7 +15,7 @@ case "$runs_on_os" in
 ubuntu)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS $CC_PACKAGE
+		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
diff --git a/ci/lib.sh b/ci/lib.sh
index a618d66b81..ebe702e0ea 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -235,8 +235,10 @@ ubuntu)
 	if [ "$jobname" = linux-gcc ]
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
+		PYTHON_PACKAGE=python3
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
+		PYTHON_PACKAGE=python2
 	fi
 
 	export GIT_TEST_HTTPD=true
-- 
2.39.0.rc0

