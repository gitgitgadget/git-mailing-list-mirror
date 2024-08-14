Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160B1859
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593924; cv=none; b=rAQ/nSz4+TmH0mMxiw17Sd22eK3eBX0fHp06KXZzCtcNiJtXX1BrCod6GUEt7g+9mKTgOo7RhmpoTp4rG+mxwXBQO/nKW+R1pVdovrjiEsdZpgA7eSv3VTFxPMoGnxI/VhfQkqmQfDUNpuK9+63XDN5Gk75JMQplNmv6dVlQ4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593924; c=relaxed/simple;
	bh=s4zsAUmsX6CjNcIGRWwNYkKH7Xp2sSHe2KJBquoMgZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4ud0iBRr3LcCAH+BZlAZxU/xQ6cVGwBKiDydmZ3gA1zv4/XTCsiFbsahXkXHR7sCIfBvCxOlMFx1h1TV3j5vJpBTU/lQvsocob4OnUXcE3HU3181s9AB86uxc5Z7pDvVerKWFAkKAip+p0/+7YnXX5SP9parPzIIE7062EhaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRHJ9tmF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRHJ9tmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723593922; x=1755129922;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=s4zsAUmsX6CjNcIGRWwNYkKH7Xp2sSHe2KJBquoMgZc=;
  b=iRHJ9tmFINaJNNxE9mVmnc8FYNOHQorZPQVlA0mV1Fju1iOfPWTvq2kT
   Vfr5icg3BeAdK8U6nMCM/6wY25E1uhOMVwFuveUgynkNn5fqDp6CCl4oa
   0WX34O6g6lLpB1pQVaaSHK+2OmjN8jCD1UxxzGiuxeRCfC/KZgzOU6Vna
   r4mYC7R9FtbA1izjzxGggJIjw+HRBDQs1zo0br4D26QtjNDMPBIJalQJz
   NxH3SK+1Ibz8t9M7yocgOF8/MK6dSlmCoVyWlT3DCaL0tl4Ob8RBOq1/l
   FazatnAaULSiOd8rpcUCG3CiQB9QcXzD8OelMyX/+YHVZoNGNBueVuXmj
   A==;
X-CSE-ConnectionGUID: 8gyGTcoSRUimyq3vMC33Gw==
X-CSE-MsgGUID: Dzhw1ZtBToWIcrAsDoqmCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32933067"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32933067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
X-CSE-ConnectionGUID: Coail+75TUetAevQ5vDq4w==
X-CSE-MsgGUID: dzYkpkXJQx+a42veLgtn0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63767466"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 13 Aug 2024 17:05:11 -0700
Subject: [PATCH v2 3/3] send-email: teach git send-email option to
 translate aliases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-jk-translate-alias-send-email-v2-3-912db4eb6846@gmail.com>
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

git send-email has support for converting shorthand alias names to
canonical email addresses via the alias file. It supports a wide variety
of alias file formats based on popular email program file formats.

Other programs, such as b4, would like the ability to convert aliases in
the same way as git send-email without needing to re-implement the logic
for understanding the many file formats.

Teach git send-email a new option, --translate-aliases, which will
enable this functionality. Similar to --dump-aliases, this option works
like a new mode of operation for git send-email.

When run with --translate-aliases, git send-email reads from standard
input and converts any provided alias into its canonical name and email
according to the alias file. Each expanded name and address is printed
to standard output, one per line.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-send-email.txt |   7 +++
 git-send-email.perl              |  21 +++++++-
 t/t9001-send-email.sh            | 104 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c5d664f4519b..2e6f1d63ae4a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git send-email' [<options>] (<file>|<directory>)...
 'git send-email' [<options>] <format-patch-options>
 'git send-email' --dump-aliases
+'git send-email' --translate-aliases
 
 
 DESCRIPTION
@@ -475,6 +476,12 @@ Information
 	that this only includes the alias name and not its expanded email addresses.
 	See 'sendemail.aliasesFile' for more information about aliases.
 
+--translate-aliases::
+	Instead of the normal operation, read from standard input and
+	interpret each line as an email alias. Translate it according to the
+	configured alias file(s). Output each translated name and email
+	address to standard output, one per line. See 'sendemail.aliasFile'
+	for more information about aliases.
 
 CONFIGURATION
 -------------
diff --git a/git-send-email.perl b/git-send-email.perl
index 72044e5ef3a8..cdcee1d0cf96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -31,6 +31,7 @@ sub usage {
 git send-email [<options>] <file|directory>
 git send-email [<options>] <format-patch options>
 git send-email --dump-aliases
+git send-email --translate-aliases
 
   Composing:
     --from                  <str>  * Email From:
@@ -99,6 +100,10 @@ sub usage {
 
   Information:
     --dump-aliases                 * Dump configured aliases and exit.
+    --translate-aliases            * Translate aliases read from standard
+                                     input according to the configured email
+                                     alias file(s), outputting the result to
+                                     standard output.
 
 EOT
 	exit(1);
@@ -212,6 +217,7 @@ sub format_2822_time {
 my $compose_filename;
 my $force = 0;
 my $dump_aliases = 0;
+my $translate_aliases = 0;
 
 # Variables to prevent short format-patch options from being captured
 # as abbreviated send-email options
@@ -476,11 +482,14 @@ sub config_regexp {
 my %dump_aliases_options = (
 	"h" => \$help,
 	"dump-aliases" => \$dump_aliases,
+	"translate-aliases" => \$translate_aliases,
 );
 $rc = GetOptions(%dump_aliases_options);
 usage() unless $rc;
 die __("--dump-aliases incompatible with other options\n")
-    if !$help and $dump_aliases and @ARGV;
+    if !$help and ($dump_aliases or $translate_aliases) and @ARGV;
+die __("--dump-aliases and --translate-aliases are mutually exclusive\n")
+    if !$help and $dump_aliases and $translate_aliases;
 my %options = (
 		    "sender|from=s" => \$sender,
 		    "in-reply-to=s" => \$initial_in_reply_to,
@@ -724,6 +733,16 @@ sub parse_sendmail_aliases {
     exit(0);
 }
 
+if ($translate_aliases) {
+	while (<STDIN>) {
+		my @addr_list = parse_address_line($_);
+		@addr_list = expand_aliases(@addr_list);
+		@addr_list = sanitize_address_list(@addr_list);
+		print "$_\n" for @addr_list;
+	}
+	exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c96d6955b9f2..13f1453eebb9 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2120,6 +2120,110 @@ test_expect_success '--dump-aliases must be used alone' '
 	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting
 '
 
+test_translate_aliases () {
+	msg="$1" && shift &&
+	filetype="$1" && shift &&
+	aliases="$1" && shift &&
+	printf '%s\n' "$@" >expect &&
+	cat >.tmp-email-aliases &&
+	printf '%s\n' "$aliases" >aliases &&
+
+	test_expect_success $PREREQ "$msg" '
+		clean_fake_sendmail && rm -fr outdir &&
+		git config --replace-all sendemail.aliasesfile \
+			"$(pwd)/.tmp-email-aliases" &&
+		git config sendemail.aliasfiletype "$filetype" &&
+		git send-email --translate-aliases <aliases 2>errors >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_translate_aliases '--translate-aliases sendmail format' \
+	'sendmail' \
+	'alice bcgrp' \
+	'Alice W Land <awol@example.com>' \
+	'Robert Bobbyton <bob@example.com>' \
+	'chloe@example.com' \
+	'Other <o@example.com>' <<-\EOF
+	alice: Alice W Land <awol@example.com>
+	bob: Robert Bobbyton <bob@example.com>
+	chloe: chloe@example.com
+	abgroup: alice, bob
+	bcgrp: bob, chloe, Other <o@example.com>
+	EOF
+
+test_translate_aliases '--translate-aliases mutt format' \
+	'mutt' \
+	'donald bob' \
+	'Donald C Carlton <donc@example.com>' \
+	'Robert Bobbyton <bob@example.com>' <<-\EOF
+	alias alice Alice W Land <awol@example.com>
+	alias donald Donald C Carlton <donc@example.com>
+	alias bob Robert Bobbyton <bob@example.com>
+	alias chloe chloe@example.com
+	EOF
+
+test_translate_aliases '--translate-aliases mailrc format' \
+	'mailrc' \
+	'chloe eve alice' \
+	'chloe@example.com' \
+	'Eve <eve@example.com>' \
+	'Alice W Land <awol@example.com>' <<-\EOF
+	alias alice   "Alice W Land <awol@example.com>"
+	alias eve     "Eve <eve@example.com>"
+	alias bob     "Robert Bobbyton <bob@example.com>"
+	alias chloe   chloe@example.com
+	EOF
+
+test_translate_aliases '--translate-aliases pine format' \
+	'pine' \
+	'eve bob bcgrp' \
+	'eve@example.com' \
+	'bob@example.com' \
+	'bob@example.com' \
+	'chloe@example.com' \
+	'Other <o@example.com>' <<-\EOF
+	alice	Alice W Land	awol@example.com		Friend
+	eve	Eve	eve@example.com
+	bob	Robert Bobbyton	bob@example.com
+	chloe		chloe@example.com
+	bcgrp		(bob, chloe, Other <o@example.com>)
+	EOF
+
+test_translate_aliases '--translate-aliases gnus format' \
+	'gnus' \
+	'alice chloe eve' \
+	'awol@example.com' \
+	'chloe@example.com' \
+	'eve@example.com' <<-\EOF
+	(define-mail-alias "alice" "awol@example.com")
+	(define-mail-alias "eve" "eve@example.com")
+	(define-mail-alias "bob" "bob@example.com")
+	(define-mail-alias "chloe" "chloe@example.com")
+	EOF
+
+test_expect_success '--translate-aliases passes valid addresses through' '
+	cat >expect <<-\EOF &&
+	Other <o@example.com>
+	EOF
+	cat >aliases <<-\EOF &&
+	Other <o@example.com>
+	EOF
+	git send-email --translate-aliases <aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--translate-aliases passes unknown aliases through' '
+	cat >expect <<-\EOF &&
+	blargh
+	EOF
+	cat >aliases <<-\EOF &&
+	blargh
+	EOF
+	git send-email --translate-aliases <aliases >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success $PREREQ 'aliases and sendemail.identity' '
 	test_must_fail git \
 		-c sendemail.identity=cloud \

-- 
2.46.0.124.g2dc1a81c8933

