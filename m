Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBAC6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 07:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIWHDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIWHDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 03:03:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA311ED4B
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 00:03:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a3so18320409lfk.9
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0fgk0xTeAJhk1T3zj7bdRj3KPwWj2kVoqpTx43FNrlI=;
        b=J0c5LsfiL0ZwT+DoMF6Zzl1bvYavq4WUoGf6gqjk2HR9AIKBKl2t5DCMqLGvXcwz0o
         ALmJALrsv3uIT5ZNXzcdrLamRTf4/8isAmldxwFuN9sL5XIl2TbKX1E3non/b/27SNzd
         SliMEwGPJQyIq2+PUljLtv5jkeT3kQiG9sjGI2mSdzKidmcovsQwvRvIRI43817MRtOB
         880f0p/a6vYIMUaKDP5+MGXqD5aANDYQZBnxsfDBvdyOamKg+mS3T5opUYgODMZZQNFV
         Pg4fNIgADFC3ICz62K2hHrThWl51L+ddpERuQPyTwSiUP8dhIw/cdNrxKRfhD5q2MCDK
         azrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0fgk0xTeAJhk1T3zj7bdRj3KPwWj2kVoqpTx43FNrlI=;
        b=CsQoL+mpoIjaO8pAaCGgP1rAZdAQvObE0z3HZBCSxrgPnq8hW0q0R/tG+isDB7oOuV
         nnCLdho8LgVI5wvJAFTVQEC1kgru7kMqo67GkUgwQWCNR2t+/vzpyUfiol1MR1qAuaER
         aXjVf9J2XGIWRAFyFggyTF3OBUXJROPY3lhPk2yQuM+S+502UK7fA3Xlhmt+lKy6WZIp
         osNabswd+FH1Vw2OHGqu9eXFpPVH7oBuoMXuYEdKXPDq9CRy0oK0dGJi9OxGKQzQSX0s
         jvzvsfc4P0RWmMwQO1TTTocv71re753nKJOTpDJwaLBpiMupQ2NS/KzWvc2esSxFBcde
         bJiQ==
X-Gm-Message-State: ACrzQf0iKNcqrVP89So0B29/fGySzHYZ3WzugBYon0HTr6DYHCOAuX+f
        gBtM+6yc/AqzuF+oRm1IS6AwEpxgwRY=
X-Google-Smtp-Source: AMsMyM6upJAuLwksgTlymGsSiXi3fBMsoSgLZJc+1N/pN4qpP57Q2mAQq206YogeATWAWcXzoLtaUw==
X-Received: by 2002:a05:6512:2a86:b0:49f:81ed:b28d with SMTP id dt6-20020a0565122a8600b0049f81edb28dmr2576123lfb.520.1663916626266;
        Fri, 23 Sep 2022 00:03:46 -0700 (PDT)
Received: from localhost.localdomain (81-233-167-126-no2216.tbcn.telia.com. [81.233.167.126])
        by smtp.gmail.com with ESMTPSA id w2-20020ac25d42000000b00492eb7205b0sm1303943lfd.210.2022.09.23.00.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 00:03:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] cmd-list.perl: fix identifying man sections
Date:   Fri, 23 Sep 2022 09:03:34 +0200
Message-Id: <20220923070334.1970213-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.355.g7147cddc23
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We attribute each documentation text file to a man section by finding a
line in the file that looks like "gitfoo(<digit>)". Commit cc75e556a9
("scalar: add to 'git help -a' command list", 2022-09-02) updated this
logic to look not only for "gitfoo" but also "scalarfoo". In doing so,
it forgot to account for the fact that after the updated regex has found
a match, the man section is no longer to be found in `$1` but now lives
in `$2`.

This makes our git(1) manpage look as follows:

  Main porcelain commands
       git-add(git)
           Add file contents to the index.

  [...]

       gitk(git)
           The Git repository browser.

       scalar(scalar)
           A tool for managing large Git repositories.

Restore the man sections by grabbing the correct value out of the regex
match.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This is a v2.38.0-rc1 regression.

 Documentation/cmd-list.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 9515a499a3..16451d81b8 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -11,7 +11,7 @@ sub format_one {
 	open I, '<', "$name.txt" or die "No such file $name.txt";
 	while (<I>) {
 		if (/^(git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
-			$mansection = $1;
+			$mansection = $2;
 			next;
 		}
 		if (/^NAME$/) {
-- 
2.38.0.rc1.355.g7147cddc23

