Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B5C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiGACMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiGACML (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADABE5927B
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z5-20020aa785c5000000b00527d84dfb49so254107pfn.21
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1W8J32CwXeXzfRle6UA+Blg4bciYwwQD89cvBI0xtp8=;
        b=oWgUI3r6uUpjkpidLKG9K+FNUffRMEPGDFBatoXBBBgy66rp5dqRap9Xd+pM0BDbRJ
         REAQtdFCElG6wZSl6vrzPbmyoQ7RMfH9dft3NDBl7K1DzpC/sSNtogduOujNmnyj5oZX
         p2eJOpQPtk5qVg1kUdC1IieTsDgVz5CR+qtye9Wrp0JpV5Wiu2WbVISC0vJRkDVOsjTz
         36hHYx9asApNzwV3tZSWaqyle4/1oqt1zCb/Zqcsal9CYAFl8EYGYNla8Piz5q9vNzXf
         P4z/CVthB30JO9BaZnKRIX3Wt36k7DwCYFRbGPRxJz000qrCUXxswfv+N4IQ0T4YtkhE
         gQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1W8J32CwXeXzfRle6UA+Blg4bciYwwQD89cvBI0xtp8=;
        b=TNs/ZhaZf5fI49AA6L0N6Wx9npFT5cpJnUbWVmfLENEBPVJjYtA4clbOMXRnEvjFQy
         cS6AwHNmSmjFkaCpWWxOpLuYFiAOYlEqCRxOND94vQboRDJ0vq9hahgC/jgujJqrDBW7
         VfuCIOonRypsG/gBsDli7cwKultZhmbtH+Ho/LoyRQA48BNly0EvibJnf3KvAag1qYgA
         T43SKTfjmpg/qdDmXRftI5hO3nW0+5BfHXE1jQMpdwUegyfKlT4nSf44z3RSNq36Nty6
         fuz41BTkR1id8W1tcGyxxWPMixDlRUHPHqimMWCO0HIFtp/RnDzO6qxwaCNJRDoU38o0
         azbA==
X-Gm-Message-State: AJIora/kjm5kocqi3+vRcKeAZRPBrvOApJ1iRPFpXW0TI1SzMuO+CmTy
        m3QFhIGbC6RI07J2P40HkFINq2Z7LVKyhRqGRD5NWt7+oOoUcStCEDuEd1RXJII5CEd3BbEz0oX
        itABjcVdScp7vj/ZGaK5vfFULBQZrdVgew9a5z50nFhj1EOFvG1ZX3gW9b4sQW2M=
X-Google-Smtp-Source: AGRyM1vIy92Dz/5PI7CjiJDrqaHgyTdpQ3EL/5X+XpH0hIedoeRqOHS3Ez2ezzsJfNON4jdRUGTSlI88RaKnug==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:b514:0:b0:525:1ccd:4506 with SMTP id
 y20-20020a62b514000000b005251ccd4506mr17472757pfe.8.1656641530136; Thu, 30
 Jun 2022 19:12:10 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:51 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 1/7] submodule--helper tests: add missing "display path" coverage
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two locations in prepare_to_clone_next_submodule() that
manually calculate the submodule display path. As discussed in the
next commit the "Skipping" output isn't exactly what we want, but
let's test how we behave now, before changing the existing behavior.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 t/t7406-submodule-update.sh | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 06d804e213..9a076e025f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1116,4 +1116,66 @@ test_expect_success 'submodule update --filter sets =
partial clone settings' '
 	test_cmp_config -C super-filter/submodule blob:none remote.origin.partial=
clonefilter
 '
=20
+# NEEDSWORK: Clean up the tests so that we can reuse the test setup.
+# Don't reuse the existing repos because the earlier tests have
+# intentionally disruptive configurations.
+test_expect_success 'setup clean recursive superproject' '
+	git init bottom &&
+	test_commit -C bottom "bottom" &&
+	git init middle &&
+	git -C middle submodule add ../bottom bottom &&
+	git -C middle commit -m "middle" &&
+	git init top &&
+	git -C top submodule add ../middle middle &&
+	git -C top commit -m "top" &&
+	git clone --recurse-submodules top top-clean
+'
+
+test_expect_success 'submodule update should skip unmerged submodules' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	# Create an upstream commit in each repo, starting with bottom
+	test_commit -C bottom upstream_commit &&
+	# Create middle commit
+	git -C middle/bottom fetch &&
+	git -C middle/bottom checkout -f FETCH_HEAD &&
+	git -C middle add bottom &&
+	git -C middle commit -m "upstream_commit" &&
+	# Create top commit
+	git -C top/middle fetch &&
+	git -C top/middle checkout -f FETCH_HEAD &&
+	git -C top add middle &&
+	git -C top commit -m "upstream_commit" &&
+
+	# Create a downstream conflict
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle add bottom &&
+	git -C top-cloned/middle commit -m "downstream_commit" &&
+	git -C top-cloned/middle fetch --recurse-submodules origin &&
+	test_must_fail git -C top-cloned/middle merge origin/main &&
+
+	# Make the update of "middle" a no-op, otherwise we error out
+	# because of its unmerged state
+	test_config -C top-cloned submodule.middle.update !true &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	cat >expect.err <<-\EOF &&
+	Skipping unmerged submodule middle//bottom
+	EOF
+	test_cmp expect.err actual.err
+'
+
+test_expect_success 'submodule update --recursive skip submodules with str=
ategy=3Dnone' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle config submodule.bottom.update none &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	cat >expect.err <<-\EOF &&
+	Skipping submodule '\''../middle/'\''
+	EOF
+	test_cmp expect.err actual.err
+'
+
 test_done
--=20
2.37.0.rc0.161.g10f37bed90-goog

