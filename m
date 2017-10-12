Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B4620372
	for <e@80x24.org>; Thu, 12 Oct 2017 18:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdJLSfr (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 14:35:47 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:40662 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751618AbdJLSfq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 14:35:46 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id 2iKWeY2CRkEH62iKge90Tx; Thu, 12 Oct 2017 18:35:46 +0000
Received: from mail.tremily.us ([67.168.186.5])
        by resomta-po-05v.sys.comcast.net with SMTP
        id 2iIiei8UKuQkF2iIjeRfjD; Thu, 12 Oct 2017 18:33:46 +0000
Received: from ullr.tremily.us (ullr.tremily.us [192.168.10.7])
        by mail.tremily.us (Postfix) with SMTP id 7887FFEE628;
        Thu, 12 Oct 2017 11:34:13 -0700 (PDT)
Received: (nullmailer pid 16443 invoked by uid 1000);
        Thu, 12 Oct 2017 18:35:44 -0000
From:   "W. Trevor King" <wking@tremily.us>
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C5=81ukasz=20Gryglicki?= <lukaszgryglicki@o2.pl>,
        "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3] pull: pass --signoff/--no-signoff to "git merge"
Date:   Thu, 12 Oct 2017 11:35:42 -0700
Message-Id: <129274f0cc768b7a309f41315580fe1013636516.1507832722.git.wking@tremily.us>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
References: <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
X-CMAE-Envelope: MS4wfFYTfMVkr7FGK7doyEKHmBBH2qsaWsr8PXnzYr6Qa7lP6JNaqa0tbSiA+D9pZICk9HvuvmQD7gm7GKCaleNcLmA1NtPS27SJJlQSdmvInPP7691NkExg
 Jfvtspmcn8WHxt8ITnFQlD7WIOV2VG5WCcvBE6TDhPZHi8dviwD+BiMy57yTl8L2qqIkoeI/0t00Q8uCAbOzLeip7y7g04vlvWiAFGFVSP2FK0YKW59YdoQf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge can take --signoff, but without pull passing --signoff down, it
is inconvenient, so let's pass it through.

The order of options in merge-options.txt is mostly alphabetical by
long option since 7c85d274 (Documentation/merge-options.txt: order
options in alphabetical groups, 2009-10-22).  The long-option bit
didn't make it into the commit message, but it's under the fold in
[1].  I've put --signoff between --log and --stat to preserve the
alphabetical order.

[1]: https://public-inbox.org/git/87iqe7zspn.fsf@jondo.cante.net/

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: W. Trevor King <wking@tremily.us>
---
Changes since v2 [1]:

* Replace the two motivational paragraphs with Junio's suggested
  sentence [2].
* Drop test_hash_trailer in favor of --pretty='format:%(trailers)'
  [3].  It turns out that the builtin tooling I was looking for while
  working on test_hash_trailer already exists :).

This patch (like v1 and v2) is based on v2.15.0-rc1, although I expect
it will apply cleanly to anything in that vicinity.

Cheers,
Trevor

[1]: https://public-inbox.org/git/51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us/
[2]: https://public-inbox.org/git/xmqqk200znel.fsf@gitster.mtv.corp.google.com/
[3]: https://public-inbox.org/git/xmqq7ew0zkqv.fsf@gitster.mtv.corp.google.com/

 Documentation/git-merge.txt     |  8 --------
 Documentation/merge-options.txt | 10 +++++++++
 builtin/pull.c                  |  6 ++++++
 t/t5521-pull-options.sh         | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4df6431c34..0ada8c856b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -64,14 +64,6 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
---signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
-
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign the resulting merge commit. The `keyid` argument is
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 4e32304301..f394622d65 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -51,6 +51,16 @@ set to `no` at the beginning of them.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
 
+--signoff::
+--no-signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
++
+With --no-signoff do not add a Signed-off-by line.
 
 --stat::
 -n::
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f772e8a22..0413c78a3a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static enum rebase_type opt_rebase = -1;
 static char *opt_diffstat;
 static char *opt_log;
+static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
@@ -142,6 +143,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
 		N_("add (at most <n>) entries from shortlog to merge commit message"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU(0, "signoff", &opt_signoff, NULL,
+		N_("add Signed-off-by:"),
+		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
 		N_("create a single commit instead of doing a merge"),
 		PARSE_OPT_NOARG),
@@ -594,6 +598,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_diffstat);
 	if (opt_log)
 		argv_array_push(&args, opt_log);
+	if (opt_signoff)
+		argv_array_push(&args, opt_signoff);
 	if (opt_squash)
 		argv_array_push(&args, opt_squash);
 	if (opt_commit)
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ded8f98dbe..c19d8dbc9d 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -165,4 +165,49 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	)
 '
 
+test_expect_success 'git pull does not add a sign-off line' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --no-ff &&
+	git -C dst show -s --pretty="format:%(trailers)" HEAD >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'git pull --no-signoff does not add sign-off line' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --no-signoff --no-ff &&
+	git -C dst show -s --pretty="format:%(trailers)" HEAD >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'git pull --signoff add a sign-off line' '
+	test_when_finished "rm -fr src dst expected actual" &&
+	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --signoff --no-ff &&
+	git -C dst show -s --pretty="format:%(trailers)" HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --signoff --no-signoff --no-ff &&
+	git -C dst show -s --pretty="format:%(trailers)" HEAD >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.13.6

