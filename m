Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342DC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjDQTLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjDQTKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809396EB7
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h8so11736770ljf.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758651; x=1684350651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzyaut080C5Mk+YZcbpDJgzsXvOXxhqZg0mRjZEaONM=;
        b=CpRWj2efE9/yn357DrE//YZ1ALUJMyHIL4N5pN4vkZkOIsM2RVP4u+JLCGKyDBwtaw
         1aFDsWhYOtU+0+tBqmg3m1DDNeUIsB2wwafAL8Rsig/LDy0h1gr85p5n7Ll1k5PqlzOM
         yIsWWlfkNcIJ7AUR3RwbxnNuNHOfvKJZe6AMf5SjseI7l04SI1ru3aA523WX0tfWlP54
         wo6pidJZxIwoVM3FUkUQYI4SuYpvBysOOrWEjIY+FDlSZSm8QMvWaB3pnz/FUfDO5ZS+
         o3oZlETN7McdPbgM3UMVa+cEvmZxm3SaRwvX3XuXUauGUEgD/El31XgiqL7ftJMf2QYE
         dHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758651; x=1684350651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzyaut080C5Mk+YZcbpDJgzsXvOXxhqZg0mRjZEaONM=;
        b=LhxD2wcb8+T0ZsMfS+Hy/qJLQ2cxKMn/HwNwiiku7y0TKbJVnXiFAo7GAB+KqeDrEk
         n2MT/50caeuozk2tPY2mGsClX+yv0yfvY7MrdaAHTIPMvM38plVgWdT5aadF/+SZawPM
         dluitNDtPLLN1Fg3I+NTE62tPM6gnH/c0KRzXKop9TxhK+UtmiHh9Zvc6hhYXi/vW1YF
         zUMFho9Qzo/GRuATuGO2wU/ikLh+Xnaby98l2E6Ug4Dybyr/kIK+FUosydUk8CWrMFtf
         ++vLvIHmbyg6NWxoCKiyBYUesz4xZyYa06L/U/gGH0ETk1xr9cT3d5BjgO9H9Ok3/z8z
         h4rg==
X-Gm-Message-State: AAQBX9eu5v9Sx4axickHgGip4YHQc9qBHvjlLJBjfbYHQHT0brR6KsI6
        Iqz80y+1j1F9ImjNRCuLb/6oGpdiwloK0A==
X-Google-Smtp-Source: AKy350bk5GrscBBSdj2zgVIkegCWIqZzjqUVJkZTFzsw8s8YiQ6obgJgCgW2EcKveJ7hSUCpo54rxQ==
X-Received: by 2002:a2e:854b:0:b0:2a7:b165:7db6 with SMTP id u11-20020a2e854b000000b002a7b1657db6mr7015ljj.20.1681758651457;
        Mon, 17 Apr 2023 12:10:51 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:51 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/6] t1450: don't create unused files
Date:   Mon, 17 Apr 2023 21:10:42 +0200
Message-Id: <20230417191044.909094-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'fsck error and recovery on invalid object type' in file
t1450-fsck.sh redirects output of a failing "git fsck" invocation to
files "out" and "err" to assert presence of error messages in the output
of the command.  Commit 31deb28f5e (fsck: don't hard die on invalid
object types, 2021-10-01) changed the way assertions in this test are
performed.  The test doesn't compare the whole standard error with
prepared file "err.expect" and it doesn't assert that standard output is
empty.

Don't create unused files "err.expect" and "out" in test 'fsck error and
recovery on invalid object type'.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1450-fsck.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bca46378b2..8c442adb1a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -989,10 +989,7 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 
 		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
 
-		cat >err.expect <<-\EOF &&
-		fatal: invalid object type
-		EOF
-		test_must_fail git fsck >out 2>err &&
+		test_must_fail git fsck 2>err &&
 		grep -e "^error" -e "^fatal" err >errors &&
 		test_line_count = 1 errors &&
 		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
-- 
2.40.0

