Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CDBC07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C222B610F7
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhGSNuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhGSNuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 09:50:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328FC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:57:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c12so4289137wrt.3
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4YUUSopuFQMS7owtc8aoqbcGlAbAFDXe8UR/3KzqXQ=;
        b=PN9isiJP7dl4D4sPOGdlv4oAR8gqPN65nC4t+fRM7RVmOSMnKkuPKcya+ayl8CGRiz
         Ku/rCR6RDXW9EMYlYodLy8DZlr6h20y/huptlBFg/4RpKB0DTm+EXjhZG5ZiJVIdf2QO
         dKLH5flJpECh+HR21ltdn7Z8NzF/J9e1/TbzBylsLp9ewUsa8mRxvaS7cHvfGV4K99ZI
         A0Q9toYnqGmOB6jtge4NiEESHUv5e3PocojJuzzspS81zSwyd+AILS5KErYWyCWBngEj
         bbsljPJ9D8w0SivRdbdOWkn5M30RMqqEqHC4EslTYZeC/35Cy+Ynum6gWmBQ/Su58S0P
         IcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4YUUSopuFQMS7owtc8aoqbcGlAbAFDXe8UR/3KzqXQ=;
        b=QYGr2GPibwNvaoOA4B7jbEhRFgiI1eFfXoH2maDFZHlsOuKXItwnle9JtBp3/JpT3w
         EUoOUTESU4x2GpDhPy4IR4MrzhzPn7aVGNPfZVuh8YqNfj62XxRPMnMeAPwqz8B1NYpd
         vIl4Ur2QSshQUMn9fy+m+gZm3WDWr5uYCAuGAE/0qycQrBKclRhCpVH/PP6rj/VXSuGH
         8PV7J8gew2Ss8uEuCx0OzmzXXBmYuZ9Sln3g5SCR5ZpwFyRcmk1sdR7jaC0xoud6CpgE
         yxmkNpdIbcaOT/F6SdhoPqRSm9cHp8BlYU6It05XvRH20aw+zxdQtgIAiyg9yYsiMFmh
         LhYg==
X-Gm-Message-State: AOAM530UUi1m3nJltW86lCMNZSN677Av1hwkyqEfjXfl8EPw3SLludwS
        As4lpzTakE6zUlZViHIUMGQDVqGx4aw=
X-Google-Smtp-Source: ABdhPJxNJ1/+lsgIl5JSEySdvbYglO7xg49lswSbshRUylbVjauIsaTn0E/TUDjdp2JbVtXdmIkhgQ==
X-Received: by 2002:a5d:6090:: with SMTP id w16mr3908005wrt.294.1626705054255;
        Mon, 19 Jul 2021 07:30:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm20270220wmb.20.2021.07.19.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 07:30:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Fruhwirth <clemens@endorphin.org>,
        =?UTF-8?q?Jan=20Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] pull, fetch: fix segfault in --set-upstream option
Date:   Mon, 19 Jul 2021 16:30:51 +0200
Message-Id: <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <8636b96be256b47d207e543995abbecde9ca5055.camel@fnusa.cz>
References: <8636b96be256b47d207e543995abbecde9ca5055.camel@fnusa.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in the --set-upstream option added in
24bc1a12926 (pull, fetch: add --set-upstream option, 2019-08-19) added
in v2.24.0.

The code added there did not do the same checking we do for "git
branch" itself since 8efb8899cfe (branch: segfault fixes and
validation, 2013-02-23), which in turn fixed the same sort of segfault
I'm fixing now in "git branch --set-upstream-to", see
6183d826ba6 (branch: introduce --set-upstream-to, 2012-08-20).

The error message I'm adding here is an amalgamation of the error
added for "git branch" in 8efb8899cfe, and the error output
install_branch_config() itself emits, i.e. it trims "refs/heads/" from
the name and says "branch X on remote", not "branch refs/heads/X on
remote".

Reported-by: Clemens Fruhwirth <clemens@endorphin.org>
Reported-by: Jan Pokorný <poki@fnusa.cz>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Jul 19 2021, Jan Pokorný wrote:

> Hello,
>
> Clemens Fruhwirth píše v Po 05. 07. 2021 v 17:46 +0200:
>> What did you do before the bug happened? (Steps to reproduce your
>> issue)
>> 
>> Run "git pull origin nixos-unstable --rebase --set-upstream"
>> on a repo that had no branch set, e.g. when running "git branch" gave
>> "* (no branch)"
>> 

Thanks for the report both & sorry that this fell through the cracks
for so long.

The bug itself seems rather obvious given the benefit of that
reproduction scenario & backtrace, as noted above we've been playing
whack-a-mole with a related segfault since 2012.

It would be nice if you could test this patch and confirm, but given
the trivality of the segfault it shouldn't be necessary, I'm confident
that this fixes the bug you two reported. Thanks both!

 builtin/fetch.c         | 11 +++++++++++
 t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9191620e50c..c2eac8f15e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1623,6 +1623,17 @@ static int do_fetch(struct transport *transport,
 			}
 		}
 		if (source_ref) {
+			if (!branch) {
+				const char *shortname = NULL;
+				if (!skip_prefix(source_ref->name,
+						 "refs/heads/", &shortname))
+					shortname = source_ref->name;
+				    
+				die(_("could not set upstream of HEAD to '%s' from '%s' when "
+				      "it does not point to any branch."),
+				    shortname, transport->remote->name);
+			}
+
 			if (!strcmp(source_ref->name, "HEAD") ||
 			    starts_with(source_ref->name, "refs/heads/"))
 				install_branch_config(0,
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index b1d614ce18c..ae90554645e 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -91,6 +91,17 @@ test_expect_success 'fetch --set-upstream with valid URL sets upstream to URL' '
 	check_config_missing other2
 '
 
+test_expect_success 'fetch --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	fatal: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	test_must_fail git fetch --set-upstream upstream main 2>actual.raw &&
+	grep ^fatal: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 # tests for pull --set-upstream
 
 test_expect_success 'setup bare parent pull' '
@@ -178,4 +189,15 @@ test_expect_success 'pull --set-upstream with valid URL and branch sets branch'
 	check_config_missing other2
 '
 
+test_expect_success 'pull --set-upstream with a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_when_finished "git checkout -" &&
+	cat >expect <<-\EOF &&
+	fatal: could not set upstream of HEAD to '"'"'main'"'"' from '"'"'upstream'"'"' when it does not point to any branch.
+	EOF
+	test_must_fail git pull --set-upstream upstream main 2>actual.raw &&
+	grep ^fatal: actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.874.ge7a9d58bfcf

