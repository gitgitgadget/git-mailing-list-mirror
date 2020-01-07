Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2076C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926622087F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM/r+pjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgAGTEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:04:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38407 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:04:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so497233edr.5
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 11:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3gXKRAvTu+3LzMxF27FMurYKK31ck4/8Pu2yXCAbB6U=;
        b=VM/r+pjGEa12vPUE6phU/8fmPUA6puJxKuy2nS/HHqjaoIrM3alZ6Oczy0UNQQJke7
         +Vo5TqwP0+Syr7cyQDX+2Z+HXBuXjG43MXy0Law7eCOr8azdwJPO1TvvwMPbwDj7Y7qC
         V4tlDYtKEM2nBJZVz18POCjW2qE9uoy6oXeHI8iybPXUP5EFtLOhs4PQfLWAtCpk3xL1
         0X1FcTIEGn/xf5ymL6sPHuBNVPZQaVbV6ZIbzsb4o82pSm2y22Qd9hcbOvmKX1nJ+5Wh
         XslymuU4EZdj6C2fzqbUwh//UOibzT5PfzLL6FMFrxbyaP5Xku0jDgTtQajdOyDqz6dK
         Yh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3gXKRAvTu+3LzMxF27FMurYKK31ck4/8Pu2yXCAbB6U=;
        b=JCryIWrAr9PyZMgOZz6wJ6Mxc0agaaYF4/Jbc65I1WHFzVs28JHyaPU4EWPFhMkmDf
         klELbFWrdVs7fz3IapbFzg3DesO/SJcPAIQv+vSetJK3ftBOvEbtzp4urzaTZY6MSgr2
         bHpf0t1YVTuOiZcZh5FcuPkr5lyHjNh+1AIds60f/+ppCMMAnnLVJjmdreBObpojfIdf
         CIDHFXfphlq87tMz1bB1kuauX/detmU6W8EvaBGlho4US0H0ggSzxajqZ8c3I6sp6pYr
         lZTZggrXBFk3m4g+3gsagaLSrJQy605dLRFT5lxaQd09KcrPQRTQAHyfb4UAisfaGYRD
         k30g==
X-Gm-Message-State: APjAAAV4ATTGhcuhODOsYt5l+kBlmq0wtR/ZgVMMkgQo3PpEu+3M8k7p
        Pi/y7+ai4TdneJp9MtsrBQT+tzU2
X-Google-Smtp-Source: APXvYqznJjlsAgsOjJuOL4/3piIh2EDP8ScMr7cNv5nifFyjJEWpcFvzmlPklJ7Xchvwph0Zv0axfA==
X-Received: by 2002:a17:906:b2c3:: with SMTP id cf3mr876774ejb.247.1578423874952;
        Tue, 07 Jan 2020 11:04:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm19493edy.51.2020.01.07.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:04:34 -0800 (PST)
Message-Id: <e1fd5924d0441d1f4d6cce9f504a6a91f234c486.1578423871.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.git.1578423871.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 19:04:30 +0000
Subject: [PATCH 3/4] fsmonitor: add fsmonitor hook scripts for version 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <Kevin.Willford@microsoft.com>

Version 2 of the fsmonitor hooks is passed the version and an update
token and must pass back a last update token to use for subsequent calls
to the hook.

Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
---
 t/t7519/fsmonitor-all-v2                   |  21 +++
 t/t7519/fsmonitor-watchman-v2              | 173 +++++++++++++++++++++
 templates/hooks--fsmonitor-watchman.sample | 138 ++++++++++------
 3 files changed, 281 insertions(+), 51 deletions(-)
 create mode 100755 t/t7519/fsmonitor-all-v2
 create mode 100755 t/t7519/fsmonitor-watchman-v2

diff --git a/t/t7519/fsmonitor-all-v2 b/t/t7519/fsmonitor-all-v2
new file mode 100755
index 0000000000..061907e88b
--- /dev/null
+++ b/t/t7519/fsmonitor-all-v2
@@ -0,0 +1,21 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+#
+# An test hook script to integrate with git to test fsmonitor.
+#
+# The hook is passed a version (currently 2) and since token
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+#echo "$0 $*" >&2
+my ($version, $last_update_token) = @ARGV;
+
+if ($version ne 2) {
+	print "Unsupported query-fsmonitor hook version '$version'.\n";
+	exit 1;
+}
+
+print "last_update_token\0/\0"
diff --git a/t/t7519/fsmonitor-watchman-v2 b/t/t7519/fsmonitor-watchman-v2
new file mode 100755
index 0000000000..14ed0aa42d
--- /dev/null
+++ b/t/t7519/fsmonitor-watchman-v2
@@ -0,0 +1,173 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use IPC::Open2;
+
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to speed up detecting
+# new and modified files.
+#
+# The hook is passed a version (currently 2) and last update token
+# formatted as a string and outputs to stdout a new update token and
+# all files that have been modified since the update token. Paths must
+# be relative to the root of the working tree and separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-watchman" and set
+# 'git config core.fsmonitor .git/hooks/query-watchman'
+#
+my ($version, $last_update_token) = @ARGV;
+
+# Uncomment for debugging
+# print STDERR "$0 $version $last_update_token\n";
+
+# Check the hook interface version
+if ($version ne 2) {
+	die "Unsupported query-fsmonitor hook version '$version'.\n" .
+	    "Falling back to scanning...\n";
+}
+
+my $git_work_tree = get_working_dir();
+
+my $retry = 1;
+
+my $json_pkg;
+eval {
+	require JSON::XS;
+	$json_pkg = "JSON::XS";
+	1;
+} or do {
+	require JSON::PP;
+	$json_pkg = "JSON::PP";
+};
+
+launch_watchman();
+
+sub launch_watchman {
+	my $o = watchman_query();
+	if (is_work_tree_watched($o)) {
+		output_result($o->{clock}, @{$o->{files}});
+	}
+}
+
+sub output_result {
+	my ($clockid, @files) = @_;
+
+	# Uncomment for debugging watchman output
+	# open (my $fh, ">", ".git/watchman-output.out");
+	# binmode $fh, ":utf8";
+	# print $fh "$clockid\n@files\n";
+	# close $fh;
+
+	binmode STDOUT, ":utf8";
+	print $clockid;
+	print "\0";
+	local $, = "\0";
+	print @files;
+}
+
+sub watchman_clock {
+	my $response = qx/watchman clock "$git_work_tree"/;
+	die "Failed to get clock id on '$git_work_tree'.\n" .
+		"Falling back to scanning...\n" if $? != 0;
+
+	return $json_pkg->new->utf8->decode($response);
+}
+
+sub watchman_query {
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
+	or die "open2() failed: $!\n" .
+	"Falling back to scanning...\n";
+
+	# In the query expression below we're asking for names of files that
+	# changed since $last_update_token but not from the .git folder.
+	#
+	# To accomplish this, we're using the "since" generator to use the
+	# recency index to select candidate nodes and "fields" to limit the
+	# output to file names only. Then we're using the "expression" term to
+	# further constrain the results.
+	if (substr($last_update_token, 0, 1) eq "c") {
+		$last_update_token = "\"$last_update_token\"";
+	}
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"since": $last_update_token,
+			"fields": ["name"],
+			"expression": ["not", ["dirname", ".git"]]
+		}]
+	END
+
+	# Uncomment for debugging the watchman query
+	# open (my $fh, ">", ".git/watchman-query.json");
+	# print $fh $query;
+	# close $fh;
+
+	print CHLD_IN $query;
+	close CHLD_IN;
+	my $response = do {local $/; <CHLD_OUT>};
+
+	# Uncomment for debugging the watch response
+	# open ($fh, ">", ".git/watchman-response.json");
+	# print $fh $response;
+	# close $fh;
+
+	die "Watchman: command returned no output.\n" .
+	"Falling back to scanning...\n" if $response eq "";
+	die "Watchman: command returned invalid output: $response\n" .
+	"Falling back to scanning...\n" unless $response =~ /^\{/;
+
+	return $json_pkg->new->utf8->decode($response);
+}
+
+sub is_work_tree_watched {
+	my ($output) = @_;
+	my $error = $output->{error};
+	if ($retry > 0 and $error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
+		$retry--;
+		my $response = qx/watchman watch "$git_work_tree"/;
+		die "Failed to make watchman watch '$git_work_tree'.\n" .
+		    "Falling back to scanning...\n" if $? != 0;
+		$output = $json_pkg->new->utf8->decode($response);
+		$error = $output->{error};
+		die "Watchman: $error.\n" .
+		"Falling back to scanning...\n" if $error;
+
+		# Uncomment for debugging watchman output
+		# open (my $fh, ">", ".git/watchman-output.out");
+		# close $fh;
+
+		# Watchman will always return all files on the first query so
+		# return the fast "everything is dirty" flag to git and do the
+		# Watchman query just to get it over with now so we won't pay
+		# the cost in git to look up each individual file.
+		my $o = watchman_clock();
+		$error = $output->{error};
+
+		die "Watchman: $error.\n" .
+		"Falling back to scanning...\n" if $error;
+
+		output_result($o->{clock}, ("/"));
+		$last_update_token = $o->{clock};
+
+		eval { launch_watchman() };
+		return 0;
+	}
+
+	die "Watchman: $error.\n" .
+	"Falling back to scanning...\n" if $error;
+
+	return 1;
+}
+
+sub get_working_dir {
+	my $working_dir;
+	if ($^O =~ 'msys' || $^O =~ 'cygwin') {
+		$working_dir = Win32::GetCwd();
+		$working_dir =~ tr/\\/\//;
+	} else {
+		require Cwd;
+		$working_dir = Cwd::cwd();
+	}
+
+	return $working_dir;
+}
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index ef94fa2938..31d2070b2c 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -8,58 +8,83 @@ use IPC::Open2;
 # (https://facebook.github.io/watchman/) with git to speed up detecting
 # new and modified files.
 #
-# The hook is passed a version (currently 1) and a time in nanoseconds
-# formatted as a string and outputs to stdout all files that have been
-# modified since the given time. Paths must be relative to the root of
-# the working tree and separated by a single NUL.
+# The hook is passed a version (currently 2) and last update token
+# formatted as a string and outputs to stdout a new update token and
+# all files that have been modified since the update token. Paths must
+# be relative to the root of the working tree and separated by a single NUL.
 #
 # To enable this hook, rename this file to "query-watchman" and set
 # 'git config core.fsmonitor .git/hooks/query-watchman'
 #
-my ($version, $time) = @ARGV;
+my ($version, $last_update_token) = @ARGV;
 
 # Check the hook interface version
-
-if ($version == 1) {
-	# convert nanoseconds to seconds
-	# subtract one second to make sure watchman will return all changes
-	$time = int ($time / 1000000000) - 1;
-} else {
+if ($version ne 2) {
 	die "Unsupported query-fsmonitor hook version '$version'.\n" .
 	    "Falling back to scanning...\n";
 }
 
-my $git_work_tree;
-if ($^O =~ 'msys' || $^O =~ 'cygwin') {
-	$git_work_tree = Win32::GetCwd();
-	$git_work_tree =~ tr/\\/\//;
-} else {
-	require Cwd;
-	$git_work_tree = Cwd::cwd();
-}
+my $git_work_tree = get_working_dir();
 
 my $retry = 1;
 
+my $json_pkg;
+eval {
+	require JSON::XS;
+	$json_pkg = "JSON::XS";
+	1;
+} or do {
+	require JSON::PP;
+	$json_pkg = "JSON::PP";
+};
+
 launch_watchman();
 
 sub launch_watchman {
+	$o = watchman_query();
+	if (is_work_tree_watched($o)) {
+		output_result($o->{clock}, @{$o->{files}});
+	}
+}
+
+sub output_result {
+	my ($clockid, @files) = @_;
+
+	binmode STDOUT, ":utf8";
+	print $clockid;
+	print "\0";
+	local $, = "\0";
+	print @files;
+}
+
+sub watchman_clock {
+	my $response = qx/watchman clock "$git_work_tree"/;
+	die "Failed to get clock id on '$git_work_tree'.\n" .
+		"Falling back to scanning...\n" if $? != 0;
 
+	return $json_pkg->new->utf8->decode($response);
+}
+
+sub watchman_query {
 	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
-	    or die "open2() failed: $!\n" .
-	    "Falling back to scanning...\n";
+	or die "open2() failed: $!\n" .
+	"Falling back to scanning...\n";
 
 	# In the query expression below we're asking for names of files that
-	# changed since $time but were not transient (ie created after
-	# $time but no longer exist).
+	# changed since $last_update_token but not from the .git folder.
 	#
 	# To accomplish this, we're using the "since" generator to use the
 	# recency index to select candidate nodes and "fields" to limit the
-	# output to file names only.
-
+	# output to file names only. Then we're using the "expression" term to
+	# further constrain the results.
+	if (substr($last_update_token, 0, 1) eq "c") {
+		$last_update_token = "\"$last_update_token\"";
+	}
 	my $query = <<"	END";
 		["query", "$git_work_tree", {
-			"since": $time,
-			"fields": ["name"]
+			"since": $last_update_token,
+			"fields": ["name"],
+			"expression": ["not", ["dirname", ".git"]]
 		}]
 	END
 
@@ -68,24 +93,16 @@ sub launch_watchman {
 	my $response = do {local $/; <CHLD_OUT>};
 
 	die "Watchman: command returned no output.\n" .
-	    "Falling back to scanning...\n" if $response eq "";
+	"Falling back to scanning...\n" if $response eq "";
 	die "Watchman: command returned invalid output: $response\n" .
-	    "Falling back to scanning...\n" unless $response =~ /^\{/;
-
-	my $json_pkg;
-	eval {
-		require JSON::XS;
-		$json_pkg = "JSON::XS";
-		1;
-	} or do {
-		require JSON::PP;
-		$json_pkg = "JSON::PP";
-	};
-
-	my $o = $json_pkg->new->utf8->decode($response);
-
-	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
-		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
+	"Falling back to scanning...\n" unless $response =~ /^\{/;
+
+	return $json_pkg->new->utf8->decode($response);
+}
+
+sub is_work_tree_watched {
+	my ($output) = @_;
+	if ($retry > 0 and $output->{error} and $output->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
 		$retry--;
 		qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
@@ -95,15 +112,34 @@ sub launch_watchman {
 		# return the fast "everything is dirty" flag to git and do the
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
-		print "/\0";
+		my $o = watchman_clock();
+		$error = $output->{error};
+
+		die "Watchman: $error.\n" .
+		"Falling back to scanning...\n" if $error;
+
+		output_result($o->{clock}, ("/"));
+		$last_update_token = $o->{clock};
+
 		eval { launch_watchman() };
-		exit 0;
+		return 0;
 	}
 
-	die "Watchman: $o->{error}.\n" .
-	    "Falling back to scanning...\n" if $o->{error};
+	die "Watchman: $output->{error}.\n" .
+	"Falling back to scanning...\n" if $output->{error};
 
-	binmode STDOUT, ":utf8";
-	local $, = "\0";
-	print @{$o->{files}};
+	return 1;
+}
+
+sub get_working_dir {
+	my $working_dir;
+	if ($^O =~ 'msys' || $^O =~ 'cygwin') {
+		$working_dir = Win32::GetCwd();
+		$working_dir =~ tr/\\/\//;
+	} else {
+		require Cwd;
+		$working_dir = Cwd::cwd();
+	}
+
+	return $working_dir;
 }
-- 
gitgitgadget

