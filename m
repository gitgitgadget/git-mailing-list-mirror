Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FE256D
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112484; cv=none; b=JfS1+9lS4v+tfG7B8FhVXJL8E607Wl0ADVgO0gusKZ1FKKqgkO3xtEFAGMNkgWK0MwbcssAgR6yVVuBc7TGoZNTtmfWrRyw1FKd3XSDNVnaepEQWIl+NiY1XG+6jro/XSQe9Y2k9Otd6HkS10x4mtKenAi8lgCVj8haO39MSrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112484; c=relaxed/simple;
	bh=R9iWmJ0X1ApjTVgxpL2yib0dM5JnDS/DDko2IU6DZgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ScZhJrwp+rBfFIELhoEiquJkSAUTTAdepZyKKqnO8UKZ5EeNBS8jzE+cj/BpcDHHP9XedP5iczhw25/AVoWPnU2nv8K0F3GyOo6HEU5GcQ9P4GSVuTgGFHvZBoTgfRTj2CZ20NcmXP59kkaIO/C1oSd82pvFzv1cQZs3dYy4f6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Je9582dR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Je9582dR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724112483; x=1755648483;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=R9iWmJ0X1ApjTVgxpL2yib0dM5JnDS/DDko2IU6DZgM=;
  b=Je9582dR3vm2O9HkMglPW6bUkBKeY9IB03ixO5pu3AbWXFpXX/gklWe2
   T/CO5ykhCtsu8YPnYkKPhFZ1dtOzd/JAZRwQy0jLnE8K7rto3xZ5pjmgB
   Sg4Mqvr1xkJ0wUMMen9FOeA7JLQcFrt9aeVVLGiM4taJMVHRtcoEcJvFg
   eEPvcMfE9qGqXlCU12sZvoZSvE6Xq1Fbl8Nm3QwZyqCqs2JiyfEJiLir6
   JqXY1HMtyq/GMvsVoQJdVfBfCVRtY+xJR4XOxj471Xeu8jSAcCNVffwpc
   4eWcn4o8ji5M7SBAmaGTawIXXUVZdLsDvYfOhxuMPRdbdyXzmD/tKXUtR
   A==;
X-CSE-ConnectionGUID: xg0LsX3RSGumK6O5ai3qyA==
X-CSE-MsgGUID: lRBRRVXmQ+6JBabbfj6zQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33542539"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33542539"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:07:59 -0700
X-CSE-ConnectionGUID: f/ShnT4eQZuXlujRH/SprQ==
X-CSE-MsgGUID: uZCqBV3WRTiGk7UO1GrJHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="91277720"
Received: from unknown (HELO localhost.localdomain) ([10.166.241.20])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:07:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 19 Aug 2024 17:07:51 -0700
Subject: [PATCH v2 3/3] send-email: add mailmap support via
 sendemail.mailmap and --mailmap
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-jk-send-email-mailmap-support-v2-3-d212c3f9e505@gmail.com>
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
In-Reply-To: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
To: Josh Steadmon <steadmon@google.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

In some cases, a user may be generating a patch for an old commit which
now has an out-of-date author or other identity. For example, consider a
team member who contributes to an internal fork of an upstream project,
but leaves before this change is submitted upstream.

In this case, the team members company address may no longer be valid,
and will thus bounce when sending email.

This can be manually avoided by editing the generated patch files, or by
carefully using --suppress-<cc|to> options. This requires a lot of
manual intervention and is easy to forget.

Git has support for mapping old email addresses and names to a canonical
name and address via the .mailmap file (and its associated mailmap.file,
mailmap.blob, and log.mailmap options).

Teach git send-email to enable mailmap support for all addresses. This
ensures that addresses point to the canonical real name and email
address.

Add the sendemail.mailmap configuration option and its associated
--mailmap (and --use-mailmap for compatibility with git log) options.
For now, the default behavior is to disable the mailmap in order to
avoid any surprises or breaking any existing setups.

These options support per-identity configuration via the
sendemail.identity configuration blocks. This enables identity-specific
configuration in cases where users may not want to enable support.

In addition, support send-email specific mailmap data via
sendemail.mailmap.file, sendemail.mailmap.blob and their
identity-specific variants.

The intention of these options is to enable mapping addresses which are
no longer valid to a current project or team maintainer. Such mappings
may change the actual person being referred to, and may not make sense
in a traditional mailmap file which is intended for updating canonical
name and address for the same individual.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 git-send-email.perl   |  20 +++++++++
 t/t9001-send-email.sh | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 72044e5ef3a8..8995d5f12d9e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -46,6 +46,8 @@ sub usage {
     --compose-encoding      <str>  * Encoding to assume for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
     --transfer-encoding     <str>  * Transfer encoding to use (quoted-printable, 8bit, base64)
+    --[no-]mailmap                 * Use mailmap file to map all email addresses to canonical
+                                     real names and email addresses.
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -272,12 +274,14 @@ sub do_edit {
 my ($auto_8bit_encoding);
 my ($compose_encoding);
 my ($sendmail_cmd);
+my ($mailmap_file, $mailmap_blob);
 # Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 my $thread = 1;
 my $chain_reply_to = 0;
 my $use_xmailer = 1;
 my $validate = 1;
+my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
 
@@ -294,6 +298,7 @@ sub do_edit {
     "annotate" => \$annotate,
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
+    "mailmap" => \$mailmap,
 );
 
 my %config_settings = (
@@ -327,6 +332,8 @@ sub do_edit {
 my %config_path_settings = (
     "aliasesfile" => \@alias_files,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
+    "mailmap.file" => \$mailmap_file,
+    "mailmap.blob" => \$mailmap_blob,
 );
 
 # Handle Uncouth Termination
@@ -524,6 +531,8 @@ sub config_regexp {
 		    "thread!" => \$thread,
 		    "validate!" => \$validate,
 		    "transfer-encoding=s" => \$target_xfer_encoding,
+		    "mailmap!" => \$mailmap,
+		    "use-mailmap!" => \$mailmap,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
@@ -1085,6 +1094,16 @@ sub expand_one_alias {
 our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
 
+sub mailmap_address_list {
+	return @_ unless @_ and $mailmap;
+	my @options = ();
+	push(@options, "--mailmap-file=$mailmap_file") if $mailmap_file;
+	push(@options, "--mailmap-blob=$mailmap_blob") if $mailmap_blob;
+	my @addr_list = Git::command('check-mailmap', @options, @_);
+	s/^<(.*)>$/$1/ for @addr_list;
+	return @addr_list;
+}
+
 sub extract_valid_address {
 	my $address = shift;
 	my $local_part_regexp = qr/[^<>"\s@]+/;
@@ -1294,6 +1313,7 @@ sub process_address_list {
 	@addr_list = expand_aliases(@addr_list);
 	@addr_list = sanitize_address_list(@addr_list);
 	@addr_list = validate_address_list(@addr_list);
+	@addr_list = mailmap_address_list(@addr_list);
 	return @addr_list;
 }
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64a4ab3736ef..4bdc793a53a2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2379,6 +2379,128 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'mailmap support with --to' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=someone@example.org \
+		--mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'sendemail.mailmap configuration' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=someone@example.org \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'sendemail.mailmap.file configuration' '
+	clean_fake_sendmail &&
+	test_config sendemail.mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--to=someone@example.org \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'sendemail.mailmap identity overrides configuration' '
+	clean_fake_sendmail &&
+	test_config sendemail.cloud.mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "false" &&
+	test_config sendemail.cloud.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--identity=cloud \
+		--to=someone@example.org \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ '--no-mailmap overrides configuration' '
+	clean_fake_sendmail &&
+	test_config sendemail.cloud.mailmap.file "mailmap.test" &&
+	test_config sendemail.mailmap "false" &&
+	test_config sendemail.cloud.mailmap "true" &&
+	cat >mailmap.test <<-EOF &&
+	Some Body <someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--identity=cloud \
+		--to=someone@example.org \
+		--no-mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.org!$" commandline1
+'
+
+test_expect_success $PREREQ 'mailmap support in To header' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	cat >mailmap.test <<-EOF &&
+	<someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 --to=someone@example.org >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
+test_expect_success $PREREQ 'mailmap support in Cc header' '
+	clean_fake_sendmail &&
+	test_config mailmap.file "mailmap.test" &&
+	cat >mailmap.test <<-EOF &&
+	<someone@example.com> <someone@example.org>
+	EOF
+	git format-patch --stdout -1 --cc=someone@example.org >a.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--mailmap \
+		a.patch \
+		2>errors >out &&
+	grep "^!someone@example\.com!$" commandline1
+'
+
 test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
 	clean_fake_sendmail &&
 	PATH="$PWD:$PATH" \

-- 
2.46.0.124.g2dc1a81c8933

