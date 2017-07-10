Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E2120357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754835AbdGJV4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:31 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33378 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbdGJV43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:29 -0400
Received: by mail-lf0-f45.google.com with SMTP id z78so72008503lff.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLApJ2SVb+0wCWardUobs+UcxH66yR5p5KKMPjfQnV4=;
        b=PA7CgL+B69y4rXxcWJCspkp8dNxk0NBXLvNaOrhASKn8J3auu3Tx5FaKzpaJG/UF+9
         NpHWtZkUWbMv3mBB/AfP3S8gfczNCnxdSH1Je5ftYvFmtJF70YCZQDY6UiZOk9RdYpqo
         1M3UxdWOFg15poR0kyFdLKe2BfctmH16IKkEkWZ94otoSQZALFcvQpLXt4nkVUJMR+Ql
         j6JT5GocffckcufiQ+D+tRPi04608civ8mQdX4oGCObizth/w2+8sGqeMxtxuzFGyqCH
         q5G3ZfUNVhGSG/FbOIfyg94nJXtRpy6J/Q+W6XA9+7Kp55WTIggtHhepk/KeSFClP4a2
         R/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLApJ2SVb+0wCWardUobs+UcxH66yR5p5KKMPjfQnV4=;
        b=t6qMAIJ9dkNjGPAEsYs/3/mqlIue5292KxUMwsyIlu9ERdalsSCwCBd8Npj7oh6qqT
         9mY68QUQX0kbMItAdbTPjT1Itf89LLQil6M+7+c2Z1u9lDXTt92YDjrIAxLcA90lazlY
         F4UzlyOZKkIqU5cTCbtcGUKSDywRncgnrEwf/5mA0X50p19PtsE68vs7M/Wjibzaf/2p
         0nT5GLBhKwBJ/z840jGXcwcaK2ZMoqsJ1LQwssEr/9EEaa/DPEYEAagl/aHnwZibT87e
         NhN3a4limS2HGBOIUtzofAMwTN6eJw8hO3jRA2/TBvSQWlpQIz5VkoJWlC/MdsYbibIf
         Xq0w==
X-Gm-Message-State: AIVw113i5b/o5/pglF4L0pZCUelEw0ElCzQiXjOy4U8ocL3IbFnl0Znd
        FQwSOiFWneQcw+JCa3k=
X-Received: by 10.25.25.65 with SMTP id 62mr2028746lfz.91.1499723787611;
        Mon, 10 Jul 2017 14:56:27 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/7] t7006: add tests for how git tag paginates
Date:   Mon, 10 Jul 2017 23:55:17 +0200
Message-Id: <2615e64041d7918a89143cd724aa8cec5faface3.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as
"Vim: Warning: Output is not to a terminal" and a garbled terminal. A
user who makes use of `git tag -a` and `git tag -l` will probably choose
not to configure `pager.tag` or to set it to "no", so that `git tag -a`
will actually work, at the cost of not getting the pager with `git tag
-l`.

Since we're about to add some finer granularity to the configuration,
add tests around how git tag respects `pager.tag` and how that
configuration is ignored if --no-pager or --paginate are used.

Construct tests with two different subcommands: using -l and using -a,
where -a is being used essentially as a representative for "not -l".

Make one of the tests demonstrate the behavior mentioned above, where
`git tag -a` respects `pager.tag`. Actually, the tests use `git tag -a`
with -m, in which case no editor is launched, but that is irrelevant,
since we just want to see whether the pager is used or not. (If `git tag
-am` ever learns to avoid the pager, these tests will need to be
updated and two of them will fail.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 20b4d83c2..43cce3694 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,6 +134,46 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	}
 '
 
+test_expect_success TTY 'git tag -l defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git tag -l &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -l respects pager.tag' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag -l &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -l respects --no-pager' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag --no-pager tag -l &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a defaults to not paging' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git tag -am message newtag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a respects pager.tag' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag -am message newtag &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a respects --paginate' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag=false --paginate \
+		tag -am message newtag &&
+	test -e paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-- 
2.13.2.653.gfb5159d

