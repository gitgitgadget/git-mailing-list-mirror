Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CAC6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 08:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiIWIIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiIWIH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 04:07:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B512AEF6
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:07:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i26so18520998lfp.11
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hLPJ7JduAoT7OZaTUKI8VFODXvJF01dznIoqEapXXSA=;
        b=oktAUAOQhsV6Yp6O13mraJqVS05Jw4EAgGSVVyjQMAfitS8qkRrYBV5KB2UlJxt4X9
         3m8PKvDPjCz6gDDmgic+4SuHkCfwQU6shMEOBZz92CqeoOKk1qM4MYVT95rFcR8c8Tkh
         zThB/PY+KTuPNNYYcMU4CNZSRZZ7mZWGZF2KXBM0YsHmxE7msTbRsm2etXp5KqGr6QDU
         RDm8uyExTSoBgStwOHV8MtiRBbYsPzq+58i/PEg+/+pNCbF3o3uArnkMDoZCTCIjJK/h
         nQNWbTpy90ixCsocYjY7FUPyNPcI1iPacus8lKcDQjY7l2x99lBCjM8jrWNIwefNYxOG
         u/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hLPJ7JduAoT7OZaTUKI8VFODXvJF01dznIoqEapXXSA=;
        b=kZFSrRFN/TSwXr2MGPrslxM/L+I00TM9AFXT9sa96An5iY3vUjL/sxI7Cti1J7knCx
         ffrro3uGztOfByiF715JAPihfKEi+Xxgh9kvXRcNIgNqQRG9XDelDS6diq5VZ2Kz5bOQ
         OUF4mHi8kXKmGAv+GDp56ud7WDlVo2jaicUWGOEsQV9XyEYA9Cre8KVpnBw8Ba4rGfsq
         XzvDNfxOZ7tvmcpBmA8ki9JOBX2ZTHIrFaz3xuyrMGCqxdWnrnitxXCIZQkVFbpGjWoe
         QYE8qB2YDiAEpB9ePLvXY+3UJYbzQhAqxlMxLdsoZCK2yJPjqOMk15wQD3hBK/Kxlv3o
         fUOQ==
X-Gm-Message-State: ACrzQf2LVLSa+E98+ZXBO3A7iYB55w77aCzK63BYtpFhsUAPg/d4u5/r
        kG1LB3q4zhfA7tD3tmSZEVo=
X-Google-Smtp-Source: AMsMyM6nUHpzYKmbcQapRinsUqBHnnpfrb+ij3LN+euL2s+LuLUtZdXLiHJl/9kJfaUOGYvonqfq7Q==
X-Received: by 2002:ac2:484d:0:b0:4a0:5399:9b70 with SMTP id 13-20020ac2484d000000b004a053999b70mr560801lfy.216.1663920472861;
        Fri, 23 Sep 2022 01:07:52 -0700 (PDT)
Received: from localhost.localdomain (81-233-167-126-no2216.tbcn.telia.com. [81.233.167.126])
        by smtp.gmail.com with ESMTPSA id i26-20020a056512007a00b00498f570aef2sm1328132lfo.209.2022.09.23.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:07:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: [PATCH v2] cmd-list.perl: fix identifying man sections
Date:   Fri, 23 Sep 2022 10:07:33 +0200
Message-Id: <20220923080733.1995862-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.355.g7147cddc23
In-Reply-To: <220923.86wn9u4joo.gmgdl@evledraar.gmail.com>
References: <220923.86wn9u4joo.gmgdl@evledraar.gmail.com>
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

Restore the man sections by not capturing the (git|scalar) part of the
match into `$1`.

As noted by Ævar [1], we could even match any "foo" rather than just
"gitfoo" and "scalarfoo", but that's a larger change. For now, just fix
the regression in cc75e556a9.

[1] https://lore.kernel.org/git/220923.86wn9u4joo.gmgdl@evledraar.gmail.com/#t

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Thanks Ævar for having a look at v1.

 Documentation/cmd-list.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 9515a499a3..755a110bc4 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -10,7 +10,7 @@ sub format_one {
 	$state = 0;
 	open I, '<', "$name.txt" or die "No such file $name.txt";
 	while (<I>) {
-		if (/^(git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
+		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
 			$mansection = $1;
 			next;
 		}
-- 
2.38.0.rc1.355.g7147cddc23

