Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164FCC35240
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF571207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="HzmnlOkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgA2LM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52778 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgA2LMz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so5757960wmc.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dsmiyTARkFqDevIc+YwspPmFh9PwC8q1S/woPGIxIc=;
        b=HzmnlOkgovA/LaKN4/7NwPi2qDde+XyKiRqcmCBvzqP9aiJfUokpT0EYYDd1bqcr75
         LdtPCZVpE8o1HgQagGvEzazowwTAMPOuprigcpMzsBFNZsIQeW6SNyU5vO1aDAkzu5aJ
         bf094nyQjlx1DZIhE28AlFQtyIHi9oe/hK3y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dsmiyTARkFqDevIc+YwspPmFh9PwC8q1S/woPGIxIc=;
        b=NRbBB2cioyPKwSw1tYhH3G2/px5BMEMTPUbzJN2rU3NzrUpne7i+1AhPb+rIE69t67
         V+4VzBKI1Tq2ceByyMPNQ1P7dQhR/vmjhbRWIepzblfblPXYcn4MFCAGcD7ut2TqP+Si
         5xnyKU/gMaVADwLJJdU+1+LIEuaVEJ+NiJMgnTSZBK+w9qsRRryajaYY5L+2BelY+zNw
         IMUd2dLrbBKpUDjdOwywhU/1gxbcG6YF9wfalTyeYTAmuXmcJ8Z6IreJMNKEoSyUbIRY
         xW1kr3mj84e4zs+4OuRFEt5kSx5dy96q6FdodBFrnD+PlRPpReKGPoXdCTJ9tl1Om1nO
         P6iA==
X-Gm-Message-State: APjAAAWfWarCDhlSz2SGbucyQ1OshrW5QLb++o4nLXpoKqBUB7Q3nRZ+
        Q3EQpqm4cE3S3iOYiNXQfkpIe5yJgeU=
X-Google-Smtp-Source: APXvYqzO5prcE4QMEoYRTi3uWucU978FHA8lmYCDVT0C7hF2UT4tjDknS2no11wLThwLcFckZqeFyQ==
X-Received: by 2002:a1c:20c4:: with SMTP id g187mr10381442wmg.29.1580296373238;
        Wed, 29 Jan 2020 03:12:53 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:52 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 3/6] git-p4: disable some pylint warnings, to get pylint output to something manageable
Date:   Wed, 29 Jan 2020 11:12:43 +0000
Message-Id: <20200129111246.12196-4-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200129111246.12196-3-luke@diamand.org>
References: <20200129111246.12196-1-luke@diamand.org>
 <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pylint is incredibly useful for finding bugs, but git-p4 has never used
it, so there are a lot of warnings that while important, don't actually
result in bugs.

Let's turn those off for now, so we can get some useful output.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index df2a956622..d796074b87 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -7,6 +7,14 @@
 #            2007 Trolltech ASA
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
+# pylint: disable=invalid-name,missing-docstring,too-many-arguments,broad-except
+# pylint: disable=no-self-use,wrong-import-position,consider-iterating-dictionary
+# pylint: disable=wrong-import-order,unused-import,too-few-public-methods
+# pylint: disable=too-many-lines,ungrouped-imports,fixme,too-many-locals
+# pylint: disable=line-too-long,bad-whitespace,superfluous-parens
+# pylint: disable=too-many-statements,too-many-instance-attributes
+# pylint: disable=too-many-branches,too-many-nested-blocks
+#
 import sys
 if sys.hexversion < 0x02040000:
     # The limiter is the subprocess module
-- 
2.20.1.390.gb5101f9297

