Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DCCC4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737E20709
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcxOuDZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgI3TvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3TvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 15:51:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36297C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 12:51:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n13so2817126ybk.9
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=oQlL3i6uRYYhtkNhA4sSJWFuTl11EwrBolEHSSfIi70=;
        b=IcxOuDZvYC5nbgeES98xY4blMPhbxRiqa2fEkmESW9ewdgYx/HSCGD1icOOvpPVppN
         5YK5L+mU0/7h5wAU0jYNKQctnwq/Ymjwi2ypYMGVWBtBE7jLPb5boAxXpkC4JZh9bHIW
         +L9vYvWA4DFQFuElsC53w1ubMVLNV5NV2flHIEn/LKQULoGDzhH2barMRdcvoorBA/t5
         YyLJmkmySltqbj+ITIBPOA1btKbOi8tjgOoroG8o42QgPRRuS3fnCmsWj9G2Wu2WmLk2
         jk87rOPaAYeToY4Gi+syxmcfMX5IrmUe6AUTGBskgSb769VhMCPRydJQcK/w9w/ILCwP
         RENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=oQlL3i6uRYYhtkNhA4sSJWFuTl11EwrBolEHSSfIi70=;
        b=n+iGhQ3MXs1/NY1bk2U6yoy498GGvWzn+tXvrx5YHf5R8gdEZErNG3vabOrlrZX2iW
         o3wAfMrFs4hQot4tojckxBLdBR7nJH8Ln+NQIsNJozwhQ2tGGp6F4jB7qyOhsfz2QmMa
         PBf2mb0o3Wro0zdZklxjFwRPnwttug16jZ06BVosWvhm+jYoSqKXcGAiLaUtWvYOtfIg
         eMEqt+bQvAU5phNwBqVhntdmJsSGdrP68vhBcmgFdztW4Kht40HoBGgWnCSlcHMftKeU
         WM/RisFWWGU/HGe7XnIJNpxEnQLjo42eAlLWpzTilc+NJ+1anoLGp5RqpaQhAz8dWtAZ
         s62Q==
X-Gm-Message-State: AOAM531bPt0bFvuLRcwfOp7ASDmZsqurXVBk4/jN9+NMdutlv5DnBimc
        Se5kgrqQ1rmQeEOtaT4cU4tWCY+ly2VKqMhkeymfvEHXVBKHiy2cPo08DOPxbi6psbeAaftBF2d
        POBJY0/pEado1ggjyOkEmU8g0Q7x6GY8ZU8szkpYQ8phu7ebzsG0Icko=
X-Google-Smtp-Source: ABdhPJxdMuQJ3ExnDFc4UsuGettwTHKw+XXStWI52eqitx8SYmqU2M1HsbMONOSl29kqxPB7E4I9ulXLkA==
Sender: "tbodt via sendgmr" <tbodt@tbodt.mtv.corp.google.com>
X-Received: from tbodt.mtv.corp.google.com ([2620:0:1000:5000:7220:84ff:fe09:feee])
 (user=tbodt job=sendgmr) by 2002:a25:c747:: with SMTP id w68mr5791657ybe.349.1601495482273;
 Wed, 30 Sep 2020 12:51:22 -0700 (PDT)
Date:   Wed, 30 Sep 2020 12:50:53 -0700
Message-Id: <20200930195052.118199-1-tbodt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v2] Propagate --quiet on submodule update to merge/rebase
From:   Theodore Dubois <tbodt@google.com>
To:     git@vger.kernel.org
Cc:     Theodore Dubois <tbodt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this, commands such as
git pull --rebase --recurse-submodules --quiet
might produce non-quiet output from the merge or rebase.

Also fix the parsing of git submodule update -v. Setting GIT_QUIET to 0
has the same effect as setting GIT_QUIET to 1, because
${GIT_QUIET:+--quiet} only checks whether GIT_QUIET is set or unset.

Signed-off-by: Theodore Dubois <tbodt@google.com>
---
 git-submodule.sh            |  6 +++---
 t/t7406-submodule-update.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git git-submodule.sh git-submodule.sh
index 6fb12585cb..7ce52872b7 100755
--- git-submodule.sh
+++ git-submodule.sh
@@ -440,7 +440,7 @@ cmd_update()
 			GIT_QUIET=1
 			;;
 		-v)
-			GIT_QUIET=0
+			unset GIT_QUIET
 			;;
 		--progress)
 			progress=1
@@ -614,13 +614,13 @@ cmd_update()
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
 				;;
 			rebase)
-				command="git rebase"
+				command="git rebase ${GIT_QUIET:+--quiet}"
 				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
-				command="git merge"
+				command="git merge ${GIT_QUIET:+--quiet}"
 				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
 				must_die_on_failure=yes
diff --git t/t7406-submodule-update.sh t/t7406-submodule-update.sh
index aa19ff3a2e..acb8766ac2 100755
--- t/t7406-submodule-update.sh
+++ t/t7406-submodule-update.sh
@@ -1022,4 +1022,16 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+test_expect_success 'submodule update --quiet passes quietness to merge/rebase' '
+	(cd super &&
+	 test_commit -C rebasing message &&
+	 git submodule update --rebase --quiet >out 2>err &&
+	 test_must_be_empty out &&
+	 test_must_be_empty err &&
+	 git submodule update --rebase -v >out 2>err &&
+	 test_file_not_empty out &&
+	 test_must_be_empty err
+	)
+'
+
 test_done
-- 
2.28.0.709.gb0816b6eb0-goog

