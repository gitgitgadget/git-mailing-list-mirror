Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E0CC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2567610C7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhDIPDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhDIPDS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1DC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:03:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g66-20020a1c39450000b0290125d187ba22so2614004wma.2
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKhVInmuZMg4jp9fL/udfgXs8etq68PCtq+/iZAdSKw=;
        b=lxD+REcCZFzg9YGkunoQTfMPnoH3mbtzIlqqGjE+8nntfAgVGnNoOqBGTOZkrv8oiU
         jkuFJiIxBNEwW/oBcuPfT685dEHUzEIR5KcFoSLyHI1lRM4jWBr3QM4UQdlI/BQdwHY6
         egtD/eKbdZ4ePcFYKpTFXrsDArkfqBpQ4pz4ACIvEv2Kk83HXxdr1DPRLs+4zkGaL74w
         09LQTGRq0ijTezRib14MrhS3CcGaoscf0OF1NAMvcljRy5GR+KXOrt5PLpDXegJNufm0
         x0u84hxm7hXXOwlTFcx2PG6YdjabhXg9DX14DWMtHiNiQ2W9uRVFz5QuPIj5/jVZu2QW
         X9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKhVInmuZMg4jp9fL/udfgXs8etq68PCtq+/iZAdSKw=;
        b=Ft+4sfQ1y+mG9cnIjhZs4dB4bV/cEyKWL+WZUwJ3KK3DMRpHuVnF9fvuAf2hoO1I7g
         XzyBcqe/11QUmZxcUtv75skLPF+MA9Xa6CtjgF5RmVtvaYKUKazbD5PEkDZR0QBPR2ov
         ha5Bd0nzqKSjEl/JtBHAdAnjfIHNRqDqoUQq6meurIkjNSOtQLVE7hsJtqA5SChMKGsS
         YFwbD/wbiTTXAbKa9TXtWfBmye1qO/7zTfhUZAJA5+TG6OC/Zin6FRMDL2LXtZuSSIEv
         GcgwI7D/Y+44rSfUGDSqYFMDt/3cOFdAQ0+arJUh57E01LeqM6/7cnwvVSUywkpDOWyY
         5qYA==
X-Gm-Message-State: AOAM532bU+p+P7XV/SnEcIohijswNs8F8mIP+yXQkAEKguyRRxr6is4g
        1HsEQC2YVcCCQkFm8vX5KIpEXgXS9IWSGw==
X-Google-Smtp-Source: ABdhPJzcWHexEtkBeCI6sF8cgIU6QLt5856mvR4mdtK65tsuuyUp+/sUmn7FtJjYyONVFBI+gAOu7A==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr14612455wmj.154.1617980582607;
        Fri, 09 Apr 2021 08:03:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:03:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] docs: fix linting issues due to incorrect relative section order
Date:   Fri,  9 Apr 2021 17:02:50 +0200
Message-Id: <patch-7.7-9cb100826e-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-order the sections of a few manual pages to be consistent with the
entirety of the rest of our documentation. This allows us to remove
the just-added whitelist of "bad" order from
lint-man-section-order.perl.

I'm doing that this way around so that code will be easy to dig up if
we'll need it in the future. I've intentionally not added some other
sections such as EXAMPLES to the list of known sections.

If we were to add that we'd find some out of order. Perhaps we'll want
to order those consistently as well in the future, at which point
whitelisting some of them might become handy again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-cvsserver.txt           | 24 ++++-----
 Documentation/git-grep.txt                | 64 +++++++++++------------
 Documentation/git-mktag.txt               | 16 +++---
 Documentation/git-rebase.txt              | 12 ++---
 Documentation/git-svn.txt                 | 38 +++++++-------
 Documentation/lint-man-section-order.perl | 22 +-------
 6 files changed, 78 insertions(+), 98 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 1b1c71ad9d..f2e4a47ebe 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -24,6 +24,18 @@ Usage:
 [verse]
 'git-cvsserver' [<options>] [pserver|server] [<directory> ...]
 
+DESCRIPTION
+-----------
+
+This application is a CVS emulation layer for Git.
+
+It is highly functional. However, not all methods are implemented,
+and for those methods that are implemented,
+not all switches are implemented.
+
+Testing has been done using both the CLI CVS client, and the Eclipse CVS
+plugin. Most functionality works fine with both of these clients.
+
 OPTIONS
 -------
 
@@ -57,18 +69,6 @@ access still needs to be enabled by the `gitcvs.enabled` config option
 unless `--export-all` was given, too.
 
 
-DESCRIPTION
------------
-
-This application is a CVS emulation layer for Git.
-
-It is highly functional. However, not all methods are implemented,
-and for those methods that are implemented,
-not all switches are implemented.
-
-Testing has been done using both the CLI CVS client, and the Eclipse CVS
-plugin. Most functionality works fine with both of these clients.
-
 LIMITATIONS
 -----------
 
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4e0ba8234a..3d393fbac1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -38,38 +38,6 @@ are lists of one or more search expressions separated by newline
 characters.  An empty string as search expression matches all lines.
 
 
-CONFIGURATION
--------------
-
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
-
-
 OPTIONS
 -------
 --cached::
@@ -363,6 +331,38 @@ with multiple threads might perform slower than single threaded if `--textconv`
 is given and there're too many text conversions. So if you experience low
 performance in this case, it might be desirable to use `--threads=1`.
 
+CONFIGURATION
+-------------
+
+grep.lineNumber::
+	If set to true, enable `-n` option by default.
+
+grep.column::
+	If set to true, enable the `--column` option by default.
+
+grep.patternType::
+	Set the default matching behavior. Using a value of 'basic', 'extended',
+	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
+	value 'default' will return to the default matching behavior.
+
+grep.extendedRegexp::
+	If set to true, enable `--extended-regexp` option by default. This
+	option is ignored when the `grep.patternType` option is set to a value
+	other than 'default'.
+
+grep.threads::
+	Number of grep worker threads to use. If unset (or set to 0), Git will
+	use as many threads as the number of logical cores available.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
+
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 17a2603a60..466a697519 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -11,14 +11,6 @@ SYNOPSIS
 [verse]
 'git mktag'
 
-OPTIONS
--------
-
---strict::
-	By default mktag turns on the equivalent of
-	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
-	disable it.
-
 DESCRIPTION
 -----------
 
@@ -45,6 +37,14 @@ the appropriate `fsck.<msg-id>` varible:
 
     git -c fsck.extraHeaderEntry=ignore mktag <my-tag-with-headers
 
+OPTIONS
+-------
+
+--strict::
+	By default mktag turns on the equivalent of
+	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
+	disable it.
+
 Tag Format
 ----------
 A tag signature file, to be fed to this command's standard input,
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f08ae27e2a..8423d46372 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -200,12 +200,6 @@ Alternatively, you can undo the 'git rebase' with
 
     git rebase --abort
 
-CONFIGURATION
--------------
-
-include::config/rebase.txt[]
-include::config/sequencer.txt[]
-
 OPTIONS
 -------
 --onto <newbase>::
@@ -1266,6 +1260,12 @@ merge tlsv1.3
 merge cmake
 ------------
 
+CONFIGURATION
+-------------
+
+include::config/rebase.txt[]
+include::config/sequencer.txt[]
+
 BUGS
 ----
 The todo list presented by the deprecated `--preserve-merges --interactive`
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 67b143cc81..d5776ffcfd 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1061,25 +1061,6 @@ with different name spaces.  For example:
 	branches = stable/*:refs/remotes/svn/stable/*
 	branches = debug/*:refs/remotes/svn/debug/*
 
-BUGS
-----
-
-We ignore all SVN properties except svn:executable.  Any unhandled
-properties are logged to $GIT_DIR/svn/<refname>/unhandled.log
-
-Renamed and copied directories are not detected by Git and hence not
-tracked when committing to SVN.  I do not plan on adding support for
-this as it's quite difficult and time-consuming to get working for all
-the possible corner cases (Git doesn't do it, either).  Committing
-renamed and copied files is fully supported if they're similar enough
-for Git to detect them.
-
-In SVN, it is possible (though discouraged) to commit changes to a tag
-(because a tag is just a directory copy, thus technically the same as a
-branch). When cloning an SVN repository, 'git svn' cannot know if such a
-commit to a tag will happen in the future. Thus it acts conservatively
-and imports all SVN tags as branches, prefixing the tag name with 'tags/'.
-
 CONFIGURATION
 -------------
 
@@ -1166,6 +1147,25 @@ $GIT_DIR/svn/\**/.rev_map.*::
 if it is missing or not up to date.  'git svn reset' automatically
 rewinds it.
 
+BUGS
+----
+
+We ignore all SVN properties except svn:executable.  Any unhandled
+properties are logged to $GIT_DIR/svn/<refname>/unhandled.log
+
+Renamed and copied directories are not detected by Git and hence not
+tracked when committing to SVN.  I do not plan on adding support for
+this as it's quite difficult and time-consuming to get working for all
+the possible corner cases (Git doesn't do it, either).  Committing
+renamed and copied files is fully supported if they're similar enough
+for Git to detect them.
+
+In SVN, it is possible (though discouraged) to commit changes to a tag
+(because a tag is just a directory copy, thus technically the same as a
+branch). When cloning an SVN repository, 'git svn' cannot know if such a
+commit to a tag will happen in the future. Thus it acts conservatively
+and imports all SVN tags as branches, prefixing the tag name with 'tags/'.
+
 SEE ALSO
 --------
 linkgit:git-rebase[1]
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index 5767e7e456..b05f9156dd 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -18,24 +18,13 @@
 		'DESCRIPTION' => {
 			required => 1,
 			order => $order++,
-			bad => {
-				'git-mktag.txt' => 'OPTIONS',
-				'git-cvsserver.txt' => 'OPTIONS',
-			},
 		},
 		'OPTIONS' => {
 			order => $order++,
 			required => 0,
-			bad => {
-				'git-grep.txt' => 'CONFIGURATION',
-				'git-rebase.txt' => 'CONFIGURATION',
-			},
 		},
 		'CONFIGURATION' => {
 			order => $order++,
-			bad => {
-				'git-svn.txt' => 'BUGS',
-			},
 		},
 		'BUGS' => {
 			order => $order++,
@@ -77,16 +66,7 @@ sub report {
 
 		my $expected_last = $expected_order[-2];
 		my $actual_last = $actual_order[-2];
-		my $except_last = $SECTIONS{$line}->{bad}->{$ARGV} || '';
-		if (($SECTIONS{$line}->{bad}->{$ARGV} || '') eq $actual_last) {
-			# Either we're whitelisted, or ...
-			next
-		} elsif (exists $SECTIONS{$actual_last}->{bad}->{$ARGV}) {
-			# ... we're complaing about the next section
-			# which is out of order because this one is,
-			# don't complain about that one.
-			next;
-		} elsif ($actual_last ne $expected_last) {
+		if ($actual_last ne $expected_last) {
 			report("section '$line' incorrectly ordered, comes after '$actual_last'");
 		}
 		next;
-- 
2.31.1.622.g1b8cc22e65

