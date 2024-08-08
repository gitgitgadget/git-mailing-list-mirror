Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86515A851
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151410; cv=none; b=qYPg4ISS2KCKw+RFnYKEQajeMOd76LevA0ExnUwiCrzh3MbWC0xHmHIeIBZVWHwutvfgTHhdkRjKDzCPDKrgerRG7QsPk5MgNM0etqmyLijKEtMMgXIkdFIKGB1P6YFqOwWbKJbLVy6knwDo484xBenBQ6WGJcqqMtsv5CrO/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151410; c=relaxed/simple;
	bh=siP5iokUTyPzsnXB8orDpXLz4GYX4vS2b4ePT2cW7N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wp/D6f9F/XWAP3qFpbCxV+sXb8lneX8WyxS9HQh5OBTPxBqOZ3Jl0eSk028lw7iPAe9v8rf+uNZURkzsAWfRCBIWEJWUuSeyDSTX0kOchI4ZqEhW6Jp0rsG4HvV8YMEmF/F9J9W1P4aTKFYpJU9164SqcCAi6eUZznR/l0Duock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgGyeUIW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgGyeUIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723151408; x=1754687408;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=siP5iokUTyPzsnXB8orDpXLz4GYX4vS2b4ePT2cW7N4=;
  b=KgGyeUIWLkptuCOVChGAdN1w9th7AR78rZW4M+SXRbHrOKoACBl87Zqr
   /JkfTHpanp+lMfSSWxPPNFla9YnwSQftbinuIZGAIZtbXGUIuWimaign3
   ytssGuap803bOfCHj100FP8PkHy5VBxqa/nbJyDFTVufoUVNinr5Kn1wL
   HRr0MQxgb3r+f/lYWAB05OumCXC9sH4eKQVxz+g+rSMcB8Unf62zhyKoS
   DagPbg3BzJAMxfumx1UohrN1jmkoNl9hm7CTspYCmImYN8lHIvCJCBSAY
   MRQ91R6Wv8a7Th5FKPIgrOjpAR9QCYrDouRt5wp9/ro1ClX5PdCZmV2PV
   Q==;
X-CSE-ConnectionGUID: BNDKdfuPRCqel1PYgnBAZA==
X-CSE-MsgGUID: ZZKXJ4MqS3+/TGMwUNkUsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46712898"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="46712898"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
X-CSE-ConnectionGUID: qIYt7JzESDu7y9A+i1pvFA==
X-CSE-MsgGUID: 8zMh4NnBQemA89ms893FSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61991234"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 08 Aug 2024 14:10:00 -0700
Subject: [PATCH 3/3] send-email: teach git send-email option to translate
 aliases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-jk-translate-alias-send-email-v1-3-10a03b3d6b06@gmail.com>
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
In-Reply-To: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

Add a new "--translate-aliases" option to git send-email which allows
other programs to convert email aliases according to the configured
alias file. This is intended to allow b4 send the ability to use the
same aliases as git send-email.

There is one tricky part of handling the new option, since
--translate-aliases wants to consume the rest of @ARGV. Currently, the
pass_through option is set for perl's Getopt::Long::Configure, which
causes unknown options to get passed through to other option parsers.

This is required in order to handle passing format-patch options, and is
tricky to work around. --dump-aliases handles this by testing @ARGV
before calling the full option parser. We can't do this with
--translate-aliases because it wants to consume the arguments.

Instead, skip calling GetOptions a second time of --translate-aliases is
set. This has the effect that known options will instead be translated
as aliases instead of producing a warning, but this seems like the best
trade off of the available options.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-send-email.txt |  7 ++++
 git-send-email.perl              | 17 +++++++-
 t/t9001-send-email.sh            | 89 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c5d664f4519b..6964c9914a9c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git send-email' [<options>] (<file>|<directory>)...
 'git send-email' [<options>] <format-patch-options>
 'git send-email' --dump-aliases
+'git send-email' --translate-aliases (<alias>)...
 
 
 DESCRIPTION
@@ -475,6 +476,12 @@ Information
 	that this only includes the alias name and not its expanded email addresses.
 	See 'sendemail.aliasesFile' for more information about aliases.
 
+--translate-aliases::
+	Instead of the normal operation, interpret all command line
+	arguments as shorthand alias names using the configured alias
+	file(s). Output each translated email address, one per line, in the
+	order the aliases appear. See 'sendemail.aliasFile' for more
+	information about aliases.
 
 CONFIGURATION
 -------------
diff --git a/git-send-email.perl b/git-send-email.perl
index 72044e5ef3a8..2ae6cc0d7a36 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -31,6 +31,7 @@ sub usage {
 git send-email [<options>] <file|directory>
 git send-email [<options>] <format-patch options>
 git send-email --dump-aliases
+git send-email --translate-aliases <alias>
 
   Composing:
     --from                  <str>  * Email From:
@@ -99,6 +100,11 @@ sub usage {
 
   Information:
     --dump-aliases                 * Dump configured aliases and exit.
+    --translate-aliases            * Interpret all other command line arguments
+                                     as email aliases. Translate them
+                                     according to the configured alias file,
+                                     outputing each address one per line, then
+                                     exit.
 
 EOT
 	exit(1);
@@ -212,6 +218,7 @@ sub format_2822_time {
 my $compose_filename;
 my $force = 0;
 my $dump_aliases = 0;
+my $translate_aliases = 0;
 
 # Variables to prevent short format-patch options from being captured
 # as abbreviated send-email options
@@ -476,11 +483,14 @@ sub config_regexp {
 my %dump_aliases_options = (
 	"h" => \$help,
 	"dump-aliases" => \$dump_aliases,
+	"translate-aliases" => \$translate_aliases,
 );
 $rc = GetOptions(%dump_aliases_options);
 usage() unless $rc;
 die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
+die __("--dump-aliases and --translate-aliases are mutually exclusive\n")
+    if !$help and $dump_aliases and $translate_aliases;
 my %options = (
 		    "sender|from=s" => \$sender,
 		    "in-reply-to=s" => \$initial_in_reply_to,
@@ -534,7 +544,7 @@ sub config_regexp {
 		    "git-completion-helper" => \$git_completion_helper,
 		    "v=s" => \$reroll_count,
 );
-$rc = GetOptions(%options);
+($rc = GetOptions(%options)) unless $translate_aliases;
 
 # Munge any "either config or getopt, not both" variables
 my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
@@ -724,6 +734,11 @@ sub parse_sendmail_aliases {
     exit(0);
 }
 
+if ($translate_aliases) {
+	print "$_\n" for (process_address_list(@ARGV));
+	exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c96d6955b9f2..78c451918145 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2120,6 +2120,95 @@ test_expect_success '--dump-aliases must be used alone' '
 	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting
 '
 
+test_translate_aliases () {
+	msg="$1" && shift &&
+	filetype="$1" && shift &&
+	aliases="$1" && shift &&
+	printf '%s\n' "$@" >expect &&
+	cat >.tmp-email-aliases &&
+
+	test_expect_success $PREREQ "$msg" '
+		clean_fake_sendmail && rm -fr outdir &&
+		git config --replace-all sendemail.aliasesfile \
+			"$(pwd)/.tmp-email-aliases" &&
+		git config sendemail.aliasfiletype "$filetype" &&
+		git send-email --translate-aliases $aliases 2>errors >actual &&
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
+test_expect_success '--translate-aliases passes unknown aliases through' '
+	cat >expect <<-\EOF &&
+	Other <o@example.com>
+	EOF
+	git send-email --translate-aliases "Other <o@example.com>" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success $PREREQ 'aliases and sendemail.identity' '
 	test_must_fail git \
 		-c sendemail.identity=cloud \

-- 
2.46.0.124.g2dc1a81c8933

