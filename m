From: Lea Wiemann <lewiemann@gmail.com>
Subject: [RFC/PATCH v3] test suite for Git.pm
Date: Mon,  2 Jun 2008 01:30:00 +0200
Message-ID: <1212363000-22581-1-git-send-email-LeWiemann@gmail.com>
References: <1212360116-18727-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 01:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2x10-0008Cj-1Y
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 01:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYFAXaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 19:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757415AbYFAXaI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 19:30:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:4091 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523AbYFAXaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 19:30:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so597750fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=xPyIIWtzESVja+8mf8QIa5SgJ98bI69qQLN4U5lu3ng=;
        b=yIHbgHzrVQW9BzxyWha+6pNMxr/EUp0tfeneLWQd+kJnTtFlAFezXTd7nobZpTM4GKBs1yY6tYNLfxwih9DcSuqYO0Fu+kGZF0DhMauewGuQFziqXBqCpFvBLh9mYvj7nxZSul+Di064aTCGHgHAkn0N0riU95J7trlIq4ilD0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=FONJgfBHi5BlY7FGNIr7gFtzQVYJySuMt8Qpc9EKO/fwlxfWWybHjnMPYacM0gsxaNJAdjC4CV+Znt9lqFWyW9t6OGiPbRY/zAMQpqwEvmfwKRkeKaIiG3LG2Fxi9nAjgzMw4YJR32SO4DAZrRhkeChSZss951+5wbBwSEWUjTk=
Received: by 10.86.100.19 with SMTP id x19mr10565396fgb.12.1212363002569;
        Sun, 01 Jun 2008 16:30:02 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id l19sm3409932fgb.7.2008.06.01.16.30.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 16:30:01 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2wzw-0005sd-6P; Mon, 02 Jun 2008 01:30:00 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1212360116-18727-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83480>

Added a shell script (t/t9700-perl-git.sh) that sets up a git
repository and a perl script (t/t9700/test.pl) that runs the actual
tests.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Shouldn't have sent v2 so early. ;-)  Changed since v2:

Call get_hash instead of parse_rev, as necessitated by the recent
rename at
http://mid.gmane.org/1212361784-20409-1-git-send-email-LeWiemann@gmail.com

 t/t9700-perl-git.sh |   46 +++++++++++++++++++++
 t/t9700/test.pl     |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100755 t/t9700-perl-git.sh
 create mode 100755 t/t9700/test.pl

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
new file mode 100755
index 0000000..71c49bd
--- /dev/null
+++ b/t/t9700-perl-git.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Lea Wiemann
+#
+
+test_description='perl interface (Git.pm)'
+. ./test-lib.sh
+
+# set up test repository
+
+test_expect_success \
+    'set up test repository' \
+    'echo "*.test" > .gitignore &&
+
+     echo "test file 1" > file1 &&
+     echo "test file 2" > file2 &&
+     mkdir directory1 &&
+     echo "in directory1" >> directory1/file &&
+     mkdir directory2 &&
+     echo "in directory2" >> directory2/file &&
+     git add . &&
+     git commit -m "first commit" &&
+     git rev-parse HEAD > revisions.test &&
+
+     git tag -- --silly-name &&
+
+     echo "changed file 1" > file1 &&
+     git add . &&
+     git commit -m "second commit" &&
+     git rev-parse HEAD >> revisions.test &&
+
+     git-config --add color.test.slot1 green &&
+     git-config --add test.string value &&
+     git-config --add test.dupstring value1 &&
+     git-config --add test.dupstring value2 &
+     git-config --add test.booltrue true &&
+     git-config --add test.boolfalse no &&
+     git-config --add test.boolother other &&
+     git-config --add test.int 2k
+     '
+
+test_external_without_stderr \
+    'Perl API' \
+    perl ../t9700/test.pl
+
+test_done
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
new file mode 100755
index 0000000..c76e6ac
--- /dev/null
+++ b/t/t9700/test.pl
@@ -0,0 +1,111 @@
+#!/usr/bin/perl
+
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+
+use Cwd;
+use File::Basename;
+use File::Temp;
+use IO::String;
+
+BEGIN { use_ok('Git') }
+require_ok('Git');
+
+# set up
+our $repo_dir = "trash directory";
+our $abs_repo_dir = Cwd->cwd;
+die "this must be run by calling the t/t97* shell script(s)\n"
+    if basename(Cwd->cwd) ne $repo_dir;
+ok(our $r = Git->repository(Directory => "."), "open repository");
+ok((open REVISIONS, 'revisions.test' and chomp(our @revisions = <REVISIONS>)),
+   "(read revisions)");
+
+# config
+is($r->config("test.string"), "value", "config scalar: string");
+is_deeply([$r->config("test.dupstring")], ["value1", "value2"],
+	  "config array: string");
+is($r->config("test.nonexistent"), undef, "config scalar: nonexistent");
+is_deeply([$r->config("test.nonexistent")], [], "config array: nonexistent");
+is($r->config_int("test.int"), 2048, "config_int: integer");
+is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
+ok($r->config_bool("test.booltrue"), "config_bool: true");
+ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
+our $ansi_green = "\x1b[32m";
+is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
+# Cannot test $r->get_colorbool("color.foo")) because we do not
+# control whether our STDOUT is a terminal.
+
+# Failure cases for config:
+# Save and restore STDERR; we will probably extract this into a
+# "dies_ok" method and possibly move the STDERR handling to Git.pm.
+open our $tmpstderr, ">&", STDERR or die "cannot save STDERR"; close STDERR;
+eval { $r->config("test.dupstring") };
+ok($@, "config: duplicate entry in scalar context fails");
+eval { $r->config_bool("test.boolother") };
+ok($@, "config_bool: non-boolean values fail");
+open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";
+
+# ident
+like($r->ident("aUthor"), qr/^A U Thor <author\@example.com> [0-9]+ \+0000$/,
+     "ident scalar: author (type)");
+like($r->ident("cOmmitter"), qr/^C O Mitter <committer\@example.com> [0-9]+ \+0000$/,
+     "ident scalar: committer (type)");
+is($r->ident("invalid"), "invalid", "ident scalar: invalid ident string (no parsing)");
+my ($name, $email, $time_tz) = $r->ident('author');
+is_deeply([$name, $email], ["A U Thor", "author\@example.com"],
+	 "ident array: author");
+like($time_tz, qr/[0-9]+ \+0000/, "ident array: author");
+is_deeply([$r->ident("Name <email> 123 +0000")], ["Name", "email", "123 +0000"],
+	  "ident array: ident string");
+is_deeply([$r->ident("invalid")], [], "ident array: invalid ident string");
+
+# ident_person
+is($r->ident_person("aUthor"), "A U Thor <author\@example.com>",
+   "ident_person: author (type)");
+is($r->ident_person("Name <email> 123 +0000"), "Name <email>",
+   "ident_person: ident string");
+is($r->ident_person("Name", "email", "123 +0000"), "Name <email>",
+   "ident_person: array");
+
+# get_hash
+is($r->get_hash("HEAD"), $revisions[-1], "get_hash: 'HEAD'");
+is($r->get_hash("HEAD^"), $revisions[-2], "get_hash: 'HEAD^'");
+is($r->get_hash($revisions[0]), $revisions[0], "get_hash: SHA1");
+is($r->get_hash("--silly-name"), $revisions[0], "get_hash: tag");
+is($r->get_hash("nonexistent"), undef, "get_hash: nonexistent name");
+is($r->get_hash("0" x 40), "0" x 40, "get_hash: nonexistent SHA1");
+
+# objects and hashes
+ok(our $file1hash = $r->get_hash("$revisions[1]:file1"), "(get file hash)");
+our $iostring = IO::String->new;
+is($r->cat_blob($file1hash, $iostring), 15, "cat_blob: size");
+is(${$iostring->string_ref}, "changed file 1\n", "cat_blob: data");
+our $tmpfile = File::Temp->new();
+print $tmpfile ${$iostring->string_ref};
+is(Git::hash_object("blob", $tmpfile), $file1hash, "hash_object: roundtrip");
+$tmpfile = File::Temp->new();
+print $tmpfile my $test_text = "test blob, to be inserted\n";
+$tmpfile->close;
+like(our $newhash = $r->hash_and_insert_object($tmpfile), qr/[0-9a-fA-F]{40}/,
+     "hash_and_insert_object: returns hash");
+$iostring = IO::String->new;
+is($r->cat_blob($newhash, $iostring), length $test_text, "cat_blob: roundtrip size");
+is(${$iostring->string_ref}, $test_text, "cat_blob: roundtrip data");
+
+# paths
+is($r->repo_path, "./.git", "repo_path");
+is($r->wc_path, $abs_repo_dir . "/", "wc_path");
+is($r->wc_subdir, "", "wc_subdir initial");
+$r->wc_chdir("directory1");
+is($r->wc_subdir, "directory1", "wc_subdir after wc_chdir");
+TODO: {
+	local $TODO = "commands do not work after wc_chdir";
+	# Failure output is active even in non-verbose mode and thus
+	# annoying, and get_hash even dies.  Hence we skip these tests
+	# as long as they fail.
+	todo_skip 'config and get_hash after wc_chdir', 2;
+	is($r->config("color.string"), "value", "config after wc_chdir");
+	is($r->get_hash("HEAD"), $revisions[-1], "get_hash after wc_chdir");
+}
-- 
1.5.5.GIT
