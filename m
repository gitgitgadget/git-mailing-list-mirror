Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05DF1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdAYXht (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:37:49 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33927 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdAYXhs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:37:48 -0500
Received: by mail-wm0-f53.google.com with SMTP id f73so421787wmf.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNke/S2Mrm/T7MZTM9hetGQH3YBb/zEGzDgGYh2HTsU=;
        b=c0H0d7di9n8lsRPAcyeH1toI2aAWy5BTrh1mxSlMfwpyzDPYl60zxiPblXsS7qa2Aj
         dFOs5Beo4RxOWboNrmwN+8+brtB6QoDqMdce4Ifrs8Gm2PGOdF2B+F6/DQMmS9EUt4Zk
         n+htAbAfeTq/2QTpEWmm3BY4NSfFYWC6nAexVBzc1vad9xLqs88uU24rqzwKg96noDDf
         PDkYnCM98r1aEs4aiSjmuNYmwQOsBB2rsAmd0LWizlHTC/uQCTdXKU7j9t79gPoNk08v
         9Rj8otX6vJzGpnPKrPvk7UV91uS+7/qdZleJTwK3M5pCosmj8q5+G24q46U0T/l2y4sJ
         p+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNke/S2Mrm/T7MZTM9hetGQH3YBb/zEGzDgGYh2HTsU=;
        b=Tu/+DfyPyKMOy2Djqs8oZFog6Y/dhaaL9kO/ekVr/ncawj1jj4EZ9TXi4Pzo+IiG4e
         ck3dp0I+5I/E59ywDy8ucNRmGhplB0+KoEOyALTHDypCtABiop9TjO3kkXngQQvMoBnf
         ARMNu11malYS58ieiInH3ZXxFa3P4pHsk6cUTDEGR8twRNiL61vIjuTi+SbSe2g7V/s8
         ErU4MKAYU/jFU9MhhtHTPzNhg+BPkiqhAFVIrFMEFQ91rklZQ/KhoelGG1rK4ejL/1Ia
         p3brP6pjTGPlFuwaHiCEBS0gV3icqrhEt8cl6Mr3kR7EGFN4YS8WM8HJaKsVZZWx93qe
         8cgQ==
X-Gm-Message-State: AIkVDXKrnjL6clJWGgduiy4+OXXw8ZVA2F56KgWpWkeJRR/unoTN60HyOYKzgid00EVNpDwB
X-Received: by 10.223.165.76 with SMTP id j12mr34782063wrb.17.1485387467104;
        Wed, 25 Jan 2017 15:37:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3993:32c0:4ba2:a648])
        by smtp.gmail.com with ESMTPSA id n13sm23737251wrn.40.2017.01.25.15.37.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 15:37:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, judge.packham@gmail.com,
        olsonse@umich.edu, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule update: run custom update script for initial populating as well
Date:   Wed, 25 Jan 2017 15:37:42 -0800
Message-Id: <20170125233742.30370-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <CAGZ79kbi-cweTe-ydcRYFFnGT4EmN+O1TZDiGYFyg8-Ex8abUw@mail.gmail.com>
References: <CAGZ79kbi-cweTe-ydcRYFFnGT4EmN+O1TZDiGYFyg8-Ex8abUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1b4735d9f3 (submodule: no [--merge|--rebase] when newly cloned,
2011-02-17), all actions were defaulted to checkout for populating
a submodule initially, because merging or rebasing makes no sense
in that situation.

Other commands however do make sense, such as the custom command
that was added later (6cb5728c43, submodule update: allow custom
command to update submodule working tree, 2013-07-03).

I am unsure about the "none" command, as I can see an initial
checkout there as a useful thing. On the other hand going strictly
by our own documentation, we should do nothing in case of "none"
as well, because the user asked for it.

Reported-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  5 ++++-
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9788175979..63fc4fe9bc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -607,7 +607,10 @@ cmd_update()
 		if test $just_cloned -eq 1
 		then
 			subsha1=
-			update_module=checkout
+			case "$update_module" in
+			merge | rebase | none)
+				update_module=checkout ;;
+			esac
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 725bbed1f8..2f83243c7d 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -441,6 +441,19 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	test_i18ncmp actual expect
 '
 
+test_expect_success 'submodule update - command run for initial population of submodule' '
+	cat <<-\ EOF >expect
+	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
+	EOF
+	(
+		cd super &&
+		rm -rf submodule
+		test_must_fail git submodule update >../actual
+	)
+	test_cmp expect actual
+	git -C super submodule update --checkout
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
 Failed to recurse into submodule path '../super'
@@ -493,6 +506,7 @@ test_expect_success 'submodule init picks up merge' '
 '
 
 test_expect_success 'submodule update --merge  - ignores --merge  for new submodules' '
+	test_config -C super submodule.submodule.update checkout &&
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
@@ -505,6 +519,7 @@ test_expect_success 'submodule update --merge  - ignores --merge  for new submod
 '
 
 test_expect_success 'submodule update --rebase - ignores --rebase for new submodules' '
+	test_config -C super submodule.submodule.update checkout &&
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
-- 
2.11.0.495.g04f60290a0.dirty

