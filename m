Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D9C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDQTK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjDQTKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4775246
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r9so13873212ljp.9
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758650; x=1684350650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHlsklKDtGHBtdf2RNlEwL2fSwX7wLVYtDR4NomFA70=;
        b=b/EbPXDAJxSycFggh8UJ1hDWClzoEiW4Cp+QoG4YmuJrgiq5bfLqdDwgE3GtXM1Vip
         Lg/P/KeYv+dIJ7N9mXLIG4fUeQpetwVw7rbzmeZm7y1NI7VU2MKSfRjtZTYI3vhDEx3e
         RtM+qo/JPOFBm1r96CoS3ItzVbEM38Ea87qwZ62zsBPdmxzt1oH4H2VZV8FfD6brfbcU
         CGJVxW+c6kRwspcJY0X2luy41LHJbeNx16JFzsXMtSmy8nEb0Bj6A+4nOyNvqtdB6RYQ
         LODPnJvj5G+eMxNEl6QWKpChkDQBS16ahYWloeAbkfyZVRFlQtSpUggS5UHIFTmLnqKJ
         1Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758650; x=1684350650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHlsklKDtGHBtdf2RNlEwL2fSwX7wLVYtDR4NomFA70=;
        b=W+Wh+kESwG1cHbTt3im1hm4H1LPKHjYdxeqgFrGAeVaDk20NjzF8QvcajTd6xbJmQm
         7LD1I9GHm1H7aJrAW2Pbsciz9WUNiJOd3tOqKz7lq4GBc8ouaDE6z/W1xYCdhyy0CxFb
         7o/nvKAapB0UmSzMeJUXWhXba1ABBKwfg7fNgBF47Fz0ILyJaiM0eSUa/FCt1o1k0wX4
         rgOu0Df+Aj4YSCjtKdg5UQLChw7p+hRz8QY0mItAGodOMXLKgp9POCIAb2dhvWYr/ZKk
         xgKwZ+7YR1wbemXjrUmtJq3zQbOv9K4Xa588epwJhKBZuKuZbbeN/yBeJeZo4wWfvOGL
         RElw==
X-Gm-Message-State: AAQBX9fhsTs0DTspGMQgwjtYMbQjyaHO5gInnMGRqN8dHt5Zoa1+JIXI
        EeyGeegYqnWDqlCqF5y4Nx2KQMth3keAbQ==
X-Google-Smtp-Source: AKy350a0tUfwbkuBI52Gy+cLyPa6GWhXFWbOSm2TXRPobQO9jsGwvggSf1RtOlLUyAP/HXXJxDGTSw==
X-Received: by 2002:a2e:3511:0:b0:2a8:d94b:c0db with SMTP id z17-20020a2e3511000000b002a8d94bc0dbmr5124ljz.22.1681758650625;
        Mon, 17 Apr 2023 12:10:50 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:50 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/6] t1300: don't create unused files
Date:   Mon, 17 Apr 2023 21:10:41 +0200
Message-Id: <20230417191044.909094-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in t1300-config.sh check that "git config --get" barfs when
syntax errors are present in the config file.  The tests redirect
standard output and standard error of "git config --get" to files,
"actual" and "error" correspondingly.  They assert presence of an error
message in file "error".  However, these tests don't use file "actual"
for assertions.

Don't redirect standard output of "git config --get" to file "actual" in
t1300-config.sh to avoid creating unnecessary files.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d566729d74..8ac4531c1b 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1575,7 +1575,7 @@ test_expect_success 'barf on syntax error' '
 	[section]
 	key garbage
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --get section.key 2>error &&
 	test_i18ngrep " line 3 " error
 '
 
@@ -1585,7 +1585,7 @@ test_expect_success 'barf on incomplete section header' '
 	[section
 	key = value
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --get section.key 2>error &&
 	test_i18ngrep " line 2 " error
 '
 
@@ -1595,7 +1595,7 @@ test_expect_success 'barf on incomplete string' '
 	[section]
 	key = "value string
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --get section.key 2>error &&
 	test_i18ngrep " line 3 " error
 '
 
-- 
2.40.0

