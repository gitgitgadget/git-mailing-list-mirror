Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96918C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B012067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spinsrsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFGQXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQXn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 12:23:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7DC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 09:23:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i4so918455pjd.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XCzuQhg3iQ7V9xrSENY/y+bvxsTLmM5RQEgQ0DcuwLo=;
        b=spinsrsylkcyA50/ycZN+t7ZaBw1sCzPpXKoCY4EkhgMxA6bJl1xpgFY4JMDyaUfRI
         GIpcXFw46pxihkR5XNP8OCxZREnGuxY5nhi7WDvD7jrwTbOrD/MzI2lZq8DPWYBgaUE8
         Z/IhCRd9tpUlSgiFpUc3HHKxjhVqU3idtaQkpVuTPFWkVOgMyW8c+ONGvsHdvIObS4dM
         1JQNf6zEbmcD7rvurJOPVUPSOpqZLK2wSFFoSouNKb3waGsA5VvTg0XPxu2GWzc5e0xC
         Ss4BbAkuibtYVhW9DwOD+mAR4sb52xESV5fcTC2PertKjpAHV0qwWj1EphqzICS9diO9
         kEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XCzuQhg3iQ7V9xrSENY/y+bvxsTLmM5RQEgQ0DcuwLo=;
        b=om8WAl21ETd9vclFz08Nh/YJv9XSEp3kK70nV0ZEq8ARRoJwKal/tmviGGE8sDJEJD
         WHKH6bbv3EFH40bxqeYjrdzE9+j7oriVDsI6GMUSFdHQ4zSbGkZE26SbriogZCaTEu58
         2h8CtVCSfWBR4NSexXy1fh6aFUueisML98iyVHhgmeY7pKnVg/jkEeSQmYzQX6PdxM9B
         3c/cNJYOjfeA8t4IXozXWTrNjLYGepjxKCDtJm3rjV5CnRlit347h1s24hPM4taPG5tB
         OjahSvQ+7AnlCxQrwOoB8xLFikSbSwvBIokA2Z3mM1l5EagqliHCTMCy28ZTABJfEZnB
         H4mA==
X-Gm-Message-State: AOAM530q6L4dUwT8o3mCFOlg47FrmWdgWlJmNJOb95YdoHUuRsXt8nEk
        nRbSBJKzkTNqAxYG6jGATZc=
X-Google-Smtp-Source: ABdhPJwcD4JuSIV611CkU5eNjsnkfSpdbq1cHDFoJ6uBiMOOTFWpG2RdQv0/NQR0lGpdBXcQEYi50A==
X-Received: by 2002:a17:90a:ff0e:: with SMTP id ce14mr13613163pjb.65.1591547022322;
        Sun, 07 Jun 2020 09:23:42 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:8c4b:deea:298c:b06f? ([2601:8c0:37f:6012:8c4b:deea:298c:b06f])
        by smtp.gmail.com with ESMTPSA id gt22sm3135452pjb.2.2020.06.07.09.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 09:23:41 -0700 (PDT)
Subject: [PATCH 1/3] Clean up t6016-rev-list-graph-simplify-history
From:   Antonio Russo <antonio.e.russo@gmail.com>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
References: <456a1271-4f17-5503-5d13-d0c97115e2fd@gmail.com>
Message-ID: <b215afe1-b6f2-03ca-4d25-f3e369a4f7e3@gmail.com>
Date:   Sun, 7 Jun 2020 10:23:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <456a1271-4f17-5503-5d13-d0c97115e2fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplifies the logic used to test rev-list, making adding new tests
easier.  Uses a heredoc and sed expansion of the expected output,
instead of shell substitutions and manually escaped echo's.

Reviewed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
---
 t/t6016-rev-list-graph-simplify-history.sh | 350 ++++++++++-----------
 1 file changed, 167 insertions(+), 183 deletions(-)

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f5e6e92f5b..b6b2ab33ab 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -9,6 +9,13 @@ test_description='--graph and simplified history'

 . ./test-lib.sh

+check_graph () {
+	sed -f expand_tag_to_oid.sed >expect &&
+	git rev-list --graph "$@" >actual &&
+	sed 's/ *$//' actual >actual.sanitized &&
+	test_cmp expect actual.sanitized
+}
+
 test_expect_success 'set up rev-list --graph test' '
 	# 3 commits on branch A
 	test_commit A1 foo.txt &&
@@ -43,76 +50,62 @@ test_expect_success 'set up rev-list --graph test' '

 	test_commit A7 bar.txt &&

-	# Store commit names in variables for later use
-	A1=$(git rev-parse --verify A1) &&
-	A2=$(git rev-parse --verify A2) &&
-	A3=$(git rev-parse --verify A3) &&
-	A4=$(git rev-parse --verify A4) &&
-	A5=$(git rev-parse --verify A5) &&
-	A6=$(git rev-parse --verify A6) &&
-	A7=$(git rev-parse --verify A7) &&
-	B1=$(git rev-parse --verify B1) &&
-	B2=$(git rev-parse --verify B2) &&
-	C1=$(git rev-parse --verify C1) &&
-	C2=$(git rev-parse --verify C2) &&
-	C3=$(git rev-parse --verify C3) &&
-	C4=$(git rev-parse --verify C4)
-	'
+	git for-each-ref --format="s/%(refname:short)/%(objectname)/" \
+		refs/tags >expand_tag_to_oid.sed
+'

 test_expect_success '--graph --all' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |   " >> expected &&
-	echo "|  \\  " >> expected &&
-	echo "*-. | $A4" >> expected &&
-	echo "|\\ \\| " >> expected &&
-	echo "| | * $C2" >> expected &&
-	echo "| | * $C1" >> expected &&
-	echo "| * | $B2" >> expected &&
-	echo "| * | $B1" >> expected &&
-	echo "* | | $A3" >> expected &&
-	echo "| |/  " >> expected &&
-	echo "|/|   " >> expected &&
-	echo "* | $A2" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --all > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	| |
+	|  \
+	*-. | A4
+	|\ \|
+	| | * C2
+	| | * C1
+	| * | B2
+	| * | B1
+	* | | A3
+	| |/
+	|/|
+	* | A2
+	|/
+	* A1
+	EOF
+'

 # Make sure the graph_is_interesting() code still realizes
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
-	rm -f expected &&
 	git tag -d A4 &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |   " >> expected &&
-	echo "|  \\  " >> expected &&
-	echo "*-. | $A4" >> expected &&
-	echo "|\\ \\| " >> expected &&
-	echo "| | * $C2" >> expected &&
-	echo "| | * $C1" >> expected &&
-	echo "| * | $B2" >> expected &&
-	echo "| * | $B1" >> expected &&
-	echo "* | | $A3" >> expected &&
-	echo "| |/  " >> expected &&
-	echo "|/|   " >> expected &&
-	echo "* | $A2" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --all --simplify-by-decoration > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all --simplify-by-decoration <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	| |
+	|  \
+	*-. | A4
+	|\ \|
+	| | * C2
+	| | * C1
+	| * | B2
+	| * | B1
+	* | | A3
+	| |/
+	|/|
+	* | A2
+	|/
+	* A1
+	EOF
+'

 test_expect_success 'setup: get rid of decorations on B' '
 	git tag -d B2 &&
@@ -122,142 +115,133 @@ test_expect_success 'setup: get rid of decorations on B' '

 # Graph with branch B simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A4" >> expected &&
-	echo "|\\| " >> expected &&
-	echo "| * $C2" >> expected &&
-	echo "| * $C1" >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --simplify-by-decoration --all > actual &&
-	test_cmp expected actual
-	'
+	check_graph --simplify-by-decoration --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	* | A4
+	|\|
+	| * C2
+	| * C1
+	* | A3
+	|/
+	* A2
+	* A1
+	EOF
+'

 test_expect_success '--graph --full-history -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A4" >> expected &&
-	echo "|\\| " >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --full-history --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --full-history --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	* | A4
+	|\|
+	* | A3
+	|/
+	* A2
+	EOF
+'

 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --full-history --simplify-merges --all \
-		-- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	* | A3
+	|/
+	* A2
+	EOF
+'

 test_expect_success '--graph -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "* $A3" >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all -- bar.txt <<-\EOF
+	* A7
+	* A5
+	* A3
+	| * C4
+	|/
+	* A2
+	EOF
+'

 test_expect_success '--graph --sparse -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A6" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "* $A4" >> expected &&
-	echo "* $A3" >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "| * $C2" >> expected &&
-	echo "| * $C1" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --sparse --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --sparse --all -- bar.txt <<-\EOF
+	* A7
+	* A6
+	* A5
+	* A4
+	* A3
+	| * C4
+	| * C3
+	| * C2
+	| * C1
+	|/
+	* A2
+	* A1
+	EOF
+'

 test_expect_success '--graph ^C4' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A6" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "*   $A4" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $B2" >> expected &&
-	echo "| * $B1" >> expected &&
-	echo "* $A3" >> expected &&
-	git rev-list --graph --all ^C4 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all ^C4 <<-\EOF
+	* A7
+	* A6
+	* A5
+	*   A4
+	|\
+	| * B2
+	| * B1
+	* A3
+	EOF
+'

 test_expect_success '--graph ^C3' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "*   $A4" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $B2" >> expected &&
-	echo "| * $B1" >> expected &&
-	echo "* $A3" >> expected &&
-	git rev-list --graph --all ^C3 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* A5
+	*   A4
+	|\
+	| * B2
+	| * B1
+	* A3
+	EOF
+'

 # I don't think the ordering of the boundary commits is really
 # that important, but this test depends on it.  If the ordering ever changes
 # in the code, we'll need to update this test.
 test_expect_success '--graph --boundary ^C3' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| * | | $B2" >> expected &&
-	echo "| * | | $B1" >> expected &&
-	echo "* | | | $A3" >> expected &&
-	echo "o | | | $A2" >> expected &&
-	echo "|/ / /  " >> expected &&
-	echo "o / / $A1" >> expected &&
-	echo " / /  " >> expected &&
-	echo "| o $C3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "o $C2" >> expected &&
-	git rev-list --graph --boundary --all ^C3 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --boundary --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	| |
+	|  \
+	*-. \   A4
+	|\ \ \
+	| * | | B2
+	| * | | B1
+	* | | | A3
+	o | | | A2
+	|/ / /
+	o / / A1
+	 / /
+	| o C3
+	|/
+	o C2
+	EOF
+'

 test_done
-- 
2.27.0

