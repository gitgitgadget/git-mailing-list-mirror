Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84007EE14C3
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 22:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjIIWNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344863AbjIIWNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 18:13:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68778CC0
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694297576; x=1694902376; i=l.s.r@web.de;
 bh=ZnDUcId+mVVrL40SAu6UsFOENizOqUSN1Mo8/+cRIM4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tNMeGom4KJCqj3KaBtiIZeoOOt67h1UlnUuTFdqp99HTp2lUgvZfJ8I+5JNcqWfOFRmrtBI
 DKldY9kRhvfUdN5n955skTL0x6FPcF5hVu9Jrnum45gohZBIbJ57RoDi/X8+5zW3n81dPnSTE
 sR3PskdfQbCrExpvkDHHAZKrxGT8Z3SGZKUSQxM+8yoT22Gl1xq6xmFHg3Fv4ruMJ/j9FsUJA
 dJs1CBBlnA8XCYEMs4nhO2v34fgI7YAR4g4w/KtAu64Vaw6w2kR9VOngnFAdivr4kYolgUCuM
 3EYkDf86Puy+UWmmMSQKnOENmRiwnPgle19Fg6C0I3BecBY2rfgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.6]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CUb-1peQmr1Qtp-01159R; Sun, 10
 Sep 2023 00:12:56 +0200
Message-ID: <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
Date:   Sun, 10 Sep 2023 00:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: [PATCH] diff --no-index: fix -R with stdin
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Storsj=c3=b6?= <martin@martin.st>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AO/STFgBhC/r6lUDvSQIh5wY2qtqxdxHChel6c+AxZa5+e18fP1
 aJuHyAGSOj0sP9Dsxk4e1PzGqPPEOLI24MuvDbVIs8wKdIOn2EZsmMWCize5J+FRaDfBEKl
 OnNIuXxufPUfG1+PMlyN1KNEH/PRHBsZAjceyFj9PtpNGES8iz0T9UeF2rfh5Es3bDbilJ2
 43yv7wqCxts00Zed9UEzw==
UI-OutboundReport: notjunk:1;M01:P0:OhfvvJ6AR7k=;0HqYlu6iZycUDYeQEvqhK0KYPsT
 d6NDlkMH5uq29S7A+5ymoezUmhDGRNtxBc3Wyk7r2aAXeoTrxH69gvXSfWtoIeTp4hM3cjab4
 PMj7xbcHRoK2ZKIhWb5TjJJ2ZeptJGlxn2Ay+nPSEYHdilAaB+oDRk0IxwLN+he+Uh4XiIT1s
 Waj1r9ol1QxnjWfSPUYijPrDoPXs183vvbDdRMqUjcaRtt1zP5/FUGUxHEg6GfkaWipuVAqjo
 pY9GmHIOj/TDkcUeCjEuouJHE2Sx/yrRkKh3Q1KFgjRufl1k2NMo6IncMGX1F9MhHczLJnCPX
 BNdVVUMneREugePqYCG1k5M6tApT0PcZohPfwl/0jX9NILBf9fuoM6PzrihO5vVFbUQSmKznF
 1AqZaYm99X2VHZkdHja+GqDuxW4/1pWCpQw8lrXCPgvtF4StUMdxKwajG28juPtwoI1GDNtjl
 pJKkK4em8OJGmlVdlMKP1v6ojcgA8HH2CrdtYagAsvun7eMJ0MDmSDfbAsACAr9/tA7pWI7oj
 gjbGMLCuiWCf9PvQBq2FI9qrKlghf7j+KzViaFxMG6M5+Kr2F3bUajTlyhuijhoXzBBQ9V7ba
 FJK1M+ydcyTlL2YJTtsr3tz+26tFjkg8KyGyx6beITZfMg12UGn+dZPAvWRJVbpAsqLh1Hr4j
 ehNkKPzKLKhl+5zTNnpw4TDJN9pDybDZOP27Ox1C8FCyKFR7+scbK5uIUbz/YxlH1wSGBM9Gn
 XDS66yr/jnVJkOI2wKDa1/WmEMNb9IFafCStZcuvZsRKkAOfDfs6jrB63g7/56WdQB3CYCw8e
 p1y0Tof6d7+2120719uKCJlLwKJCMSWxrI6l1fHzkbqz4gIsN5mfzc6ulTvyI9DVx0TZjK9vC
 hPg2eeO4lotjH+PpOzezS8l/8HAqwPAAoE3Fh6Cq/IEt5xvAhVc5eRQW8PqLeeHv3wnaoAKDh
 ipTDYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When -R is given, queue_diff() swaps the mode and name variables of the
two files to produce a reverse diff.  1e3f26542a (diff --no-index:
support reading from named pipes, 2023-07-05) added variables that
indicate whether files are special, i.e named pipes or - for stdin.
These new variables were not swapped, though, which broke the handling
of stdin with with -R.  Swap them like the other metadata variables.

Reported-by: Martin Storsj=C3=B6 <martin@martin.st>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Great bug report, thank you!

 diff-no-index.c          |  1 +
 t/t4053-diff-no-index.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8aead3e332..e7041b89e3 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -232,6 +232,7 @@ static int queue_diff(struct diff_options *o,
 		if (o->flags.reverse_diff) {
 			SWAP(mode1, mode2);
 			SWAP(name1, name2);
+			SWAP(special1, special2);
 		}

 		d1 =3D noindex_filespec(name1, mode1, special1);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 6781cc9078..5f059f65fc 100755
=2D-- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -224,6 +224,25 @@ test_expect_success "diff --no-index treats '-' as st=
din" '
 	test_must_be_empty actual
 '

+test_expect_success "diff --no-index -R treats '-' as stdin" '
+	cat >expect <<-EOF &&
+	diff --git b/a/1 a/-
+	index $(git hash-object --stdin <a/1)..$ZERO_OID 100644
+	--- b/a/1
+	+++ a/-
+	@@ -1 +1 @@
+	-1
+	+x
+	EOF
+
+	test_write_lines x | test_expect_code 1 \
+		git -c core.abbrev=3Dno diff --no-index -R -- - a/1 >actual &&
+	test_cmp expect actual &&
+
+	test_write_lines 1 | git diff --no-index -R -- a/1 - >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'diff --no-index refuses to diff stdin and a director=
y' '
 	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
 	grep "fatal: cannot compare stdin to a directory" err
=2D-
2.42.0
