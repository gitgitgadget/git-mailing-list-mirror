Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D42C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjDQTKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjDQTKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D05246
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so13605161fa.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758649; x=1684350649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTIVO4CzqYGDdGVLSLZ5Q4oUYJVrpVeyxTmpchSgJYI=;
        b=AoLG7gzpp4S35EEYzEn1YBiDxioZoNwVly8mX3EnuZwnHYJ7aAo/2B1m6+GEAUPfSt
         ViDF3jZFHDLe+YDDUyA2TgDoXUfHK7thqg6xwqUN7QSxPq+g3i2ullsvHGWJc/tyr0z3
         3SLzpSLn73ysFEcNsi3l+sgC6KPhbeRiEkwKOgVAywYPk6gxLqbbBEDelY7WEHcT2AdY
         mabVTcivkyNZ0gg/UIaDi1NXpaYO2RNlKUKgyI5pkg+vGpmj3dRd56UPmGAkeOJ+YUF3
         HG0BFHmC3FKrADOCDmyYKrST4A9MAOnQrmLqsxRzbaWo/PTbckEt5jkT09VrAfTY8Q8O
         cSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758649; x=1684350649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTIVO4CzqYGDdGVLSLZ5Q4oUYJVrpVeyxTmpchSgJYI=;
        b=Q/3YGKGYQB/OR5h9jGdbtM75vta0oHWsfQQXPt3p+oaTHHllxIDAjI7t8gycLK0Mi5
         d+Mjp7USHE8vOp0WVY4aIW9zurBL3oDzQfa1Zd/0BstDXJHK29/AxnJm05HjDuOkiOMD
         VSCUohD23D5E8VHxDthbOPk/cCaIA3Xfl2CSP8ZUk2IFgnl9sC0oyb67aSccqo+dGwg5
         /RPKHlh7zn9SUh146BWbxcEXPJLcfY0bq5GgPkhpgdv3M2/+6/+4eYUCseUolarDuA3y
         uaYUNcMdFH+fLAdhB1bebRzAaZoHy54HwpSCoFCEq1LXt0XtbZy/sdni1J5ncc3t38Zk
         lLrQ==
X-Gm-Message-State: AAQBX9c2gsKLaNSPF3P7283VnChLnHhigQN0xasJQs+zCq+HVKb62UTU
        9nJOhrl1jcSYHnEdM60tPqLXi+wKE7oFxfzenCA=
X-Google-Smtp-Source: AKy350bHMzfY/pKkGu834sNoOHyJzdtv4pkugY/s2Md9BKMGl1WQEze+39uVAUPKNP+gGa/82NSzTg==
X-Received: by 2002:ac2:5399:0:b0:4e9:aeaa:ddb5 with SMTP id g25-20020ac25399000000b004e9aeaaddb5mr2069752lfh.14.1681758648514;
        Mon, 17 Apr 2023 12:10:48 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:47 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/6] t0300: don't create unused file
Date:   Mon, 17 Apr 2023 21:10:39 +0200
Message-Id: <20230417191044.909094-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'credential config with partial URLs' in t0300-credentials.sh
contains three "git credential fill" invocations.  For two of the
invocations, the test asserts presence or absence of string "yep" in the
standard output.  For the third test it checks for an error message in
standard error.

Don't redirect standard output of "git credential" to file "stdout" in
t0300-credentials.sh to avoid creating an unnecessary file when only
standard error is checked.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t0300-credentials.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index c66d91e82d..b8612ede95 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -808,7 +808,7 @@ test_expect_success 'credential config with partial URLs' '
 
 	git -c credential.$partial.helper=yep \
 		-c credential.with%0anewline.username=uh-oh \
-		credential fill <stdin >stdout 2>stderr &&
+		credential fill <stdin 2>stderr &&
 	test_i18ngrep "skipping credential lookup for key" stderr
 '
 
-- 
2.40.0

