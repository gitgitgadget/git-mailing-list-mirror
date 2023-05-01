Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A71C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 14:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjEAOja (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjEAOjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 10:39:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C4A6
        for <git@vger.kernel.org>; Mon,  1 May 2023 07:39:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-61b5a6865dfso6359886d6.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682951936; x=1685543936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGLtdglHW+BdAhhN0zEv+FneHUeBu/CZhD8A1NtP7Fw=;
        b=g4U05tGFWLH2eTztm1ALAq1/+GlQ5ZTJ5QQBbW7Ll/9jAERwkckabKkpoES49t53b/
         KAimY9QYfffY9LUpIMLeFctpSrMQGbQrTg8h2uavgt16Z7BUjP4m/etS1SM26YN3hp37
         2zh2nhC4lqXSMFVlb22o+XsuZnkO0DffGRB/GodCw++8FB/Qw8nbfWhjF3Dbji1khxUl
         VBfuazVhnfL8O2J8/1Znhe6YY6sOQU002QQ8TXsRU0RWPHArGUBKYFle5sDr817ewbUk
         UmoTwOnp9EvC4ai1NJp6n32F3rr23RdpqGU0CkfYkM6dUUzExhkuq4fNSKuGaBLFv0cq
         291Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682951936; x=1685543936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGLtdglHW+BdAhhN0zEv+FneHUeBu/CZhD8A1NtP7Fw=;
        b=YBgMAIgn2c287XkJD243tWMztdODcooqVhVtJ9sADGzgxB4Ozl0AQAVMxysdKvJlF0
         Ac/uue5z9imWtQyDnPbL5NSdas4iTINPH12kLmSAK5BnGxCcPkdTDsY/pCJwvD7Qf4uh
         TfAhthbX7D4Oc6XCAc9ejwNsfwhmhoEU1y/XCdSM8/u0a+rzkzhcXH895wWyC1DdTaBd
         80W9vu6+VY7KpiGBiQOcQWLGd1xWrqDzLf9arfMXv0p4t3+ljr4GAEGgv6G4PMTnuFEN
         l/77EZu/39LWYAIXAkV6HEZkmLiERwJ+z5tH5wQXrGH4ZAYaAs+5jdhR7A2uMpYiuPmh
         XdcQ==
X-Gm-Message-State: AC+VfDy68FSCbDD63HAAnguRr/SgRMWuSi1KQU/5beHud0LefHHhO86H
        O5ZZX5MlQb8eiavJ5iYTm6h96q3h700rZw==
X-Google-Smtp-Source: ACHHUZ7a2xN4twZkktQW9dv45UfE2Q+8e0ltO9r2g4Z7+5o74wEfw+CSssNH8p2RmLIm3lc2zah14Q==
X-Received: by 2002:a05:6214:501c:b0:5dd:aee7:dffb with SMTP id jo28-20020a056214501c00b005ddaee7dffbmr152577qvb.22.1682951935769;
        Mon, 01 May 2023 07:38:55 -0700 (PDT)
Received: from localhost.localdomain (dsl-157-118.b2b2c.ca. [66.158.157.118])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cedca000000b005ef493c6bebsm8687211qvr.77.2023.05.01.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:38:55 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/3] send-email: add --header-cmd, --no-header-cmd options
Date:   Mon,  1 May 2023 10:38:47 -0400
Message-Id: <20230501143848.19674-3-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501143848.19674-1-maxim.cournoyer@gmail.com>
References: <xmqqcz3s3oz7.fsf@gitster.g>
 <20230501143848.19674-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, adding a header different than CC or TO is desirable; for
example, when using Debbugs, it is best to use 'X-Debbugs-Cc' headers
to keep people in CC; this is an example use case enabled by the new
'--header-cmd' option.

The header unfolding logic is extracted to a subroutine so that it can
be reused; a test is added for coverage.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---
New in v4:
- Add a --no-header-cmd.

 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   | 11 ++++++
 git-send-email.perl                | 55 +++++++++++++++++++++++-------
 t/t9001-send-email.sh              | 54 +++++++++++++++++++++++++++--
 4 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 51da7088a8..92a9ebe98c 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -61,6 +61,7 @@ sendemail.ccCmd::
 sendemail.chainReplyTo::
 sendemail.envelopeSender::
 sendemail.from::
+sendemail.headerCmd::
 sendemail.signedoffbycc::
 sendemail.smtpPass::
 sendemail.suppresscc::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b0f438ec99..4d2ae061f9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -320,6 +320,17 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
 
+--header-cmd=<command>::
+	Specify a command that is executed once per outgoing message
+	and output RFC 2822 style header lines to be inserted into
+	them. When the `sendemail.headerCmd` configuration variable is
+	set, its value is always used. When --header-cmd is provided
+	at the command line, its value takes precedence over the
+	`sendemail.headerCmd` configuration variable.
+
+--no-header-cmd::
+	Disable any header command in use.
+
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
diff --git a/git-send-email.perl b/git-send-email.perl
index 04503e3c3c..32febe9af3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -87,8 +87,10 @@ sub usage {
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
-    --to-cmd                <str>  * Email To: via `<str> \$patch_path`
-    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
+    --to-cmd                <str>  * Email To: via `<str> \$patch_path`.
+    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`.
+    --header-cmd            <str>  * Add headers via `<str> \$patch_path`.
+    --no-header-cmd                * Disable any header command in use.
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, misc-by, all.
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
@@ -202,7 +204,7 @@ sub format_2822_time {
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 # Things we either get from config, *or* are overridden on the
 # command-line.
-my ($no_cc, $no_to, $no_bcc, $no_identity);
+my ($no_cc, $no_to, $no_bcc, $no_identity, $no_header_cmd);
 my (@config_to, @getopt_to);
 my (@config_cc, @getopt_cc);
 my (@config_bcc, @getopt_bcc);
@@ -269,7 +271,7 @@ sub do_edit {
 # Variables with corresponding config settings
 my ($suppress_from, $signed_off_by_cc);
 my ($cover_cc, $cover_to);
-my ($to_cmd, $cc_cmd);
+my ($to_cmd, $cc_cmd, $header_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
 my ($batch_size, $relogin_delay);
@@ -318,6 +320,7 @@ sub do_edit {
     "tocmd" => \$to_cmd,
     "cc" => \@config_cc,
     "cccmd" => \$cc_cmd,
+    "headercmd" => \$header_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@config_bcc,
     "suppresscc" => \@suppress_cc,
@@ -519,6 +522,8 @@ sub config_regexp {
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
+		    "header-cmd=s" => \$header_cmd,
+		    "no-header-cmd" => \$no_header_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "no-suppress-from" => sub {$suppress_from = 0},
 		    "suppress-cc=s" => \@suppress_cc,
@@ -1780,16 +1785,16 @@ sub process_file {
 	$subject = $initial_subject;
 	$message = "";
 	$message_num++;
-	# First unfold multiline header fields
+	# Retrieve and unfold header fields.
+	my @header_lines = ();
 	while(<$fh>) {
 		last if /^\s*$/;
-		if (/^\s+\S/ and @header) {
-			chomp($header[$#header]);
-			s/^\s+/ /;
-			$header[$#header] .= $_;
-	    } else {
-			push(@header, $_);
-		}
+		push(@header_lines, $_);
+	}
+	@header = unfold_headers(@header_lines);
+	# Add computed headers, if applicable.
+	unless ($no_header_cmd || ! $header_cmd) {
+		push @header, invoke_header_cmd($header_cmd, $t);
 	}
 	# Now parse the header
 	foreach(@header) {
@@ -2036,6 +2041,32 @@ sub execute_cmd {
 	return @lines;
 }
 
+# Process headers lines, unfolding multiline headers as defined by RFC
+# 2822.
+sub unfold_headers {
+	my @headers;
+	foreach(@_) {
+		last if /^\s*$/;
+		if (/^\s+\S/ and @headers) {
+			chomp($headers[$#headers]);
+			s/^\s+/ /;
+			$headers[$#headers] .= $_;
+		} else {
+			push(@headers, $_);
+		}
+	}
+	return @headers;
+}
+
+# Invoke the provided CMD with FILE as an argument, which should
+# output RFC 2822 email headers. Fold multiline headers and return the
+# headers as an array.
+sub invoke_header_cmd {
+	my ($cmd, $file) = @_;
+	my @lines = execute_cmd("header-cmd", $header_cmd, $file);
+	return unfold_headers(@lines);
+}
+
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6520346246..dfc5be581f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -374,13 +374,16 @@ test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email'
 	)
 '
 
-test_expect_success $PREREQ 'setup tocmd and cccmd scripts' '
+test_expect_success $PREREQ 'setup cmd scripts' '
 	write_script tocmd-sed <<-\EOF &&
 	sed -n -e "s/^tocmd--//p" "$1"
 	EOF
-	write_script cccmd-sed <<-\EOF
+	write_script cccmd-sed <<-\EOF &&
 	sed -n -e "s/^cccmd--//p" "$1"
 	EOF
+	write_script headercmd-sed <<-\EOF
+	sed -n -e "s/^headercmd--//p" "$1"
+	EOF
 '
 
 test_expect_success $PREREQ 'tocmd works' '
@@ -410,6 +413,53 @@ test_expect_success $PREREQ 'cccmd works' '
 	grep "^	cccmd@example.com" msgtxt1
 '
 
+test_expect_success $PREREQ 'headercmd works' '
+	clean_fake_sendmail &&
+	cp $patches headercmd.patch &&
+	echo "headercmd--X-Debbugs-CC: dummy@example.com" >>headercmd.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--header-cmd=./headercmd-sed \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		headercmd.patch \
+		&&
+	grep "^X-Debbugs-CC: dummy@example.com" msgtxt1
+'
+
+test_expect_success $PREREQ '--no-header-cmd works' '
+	clean_fake_sendmail &&
+	cp $patches headercmd.patch &&
+	echo "headercmd--X-Debbugs-CC: dummy@example.com" >>headercmd.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--header-cmd=./headercmd-sed \
+                --no-header-cmd \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		headercmd.patch \
+		&&
+	! grep "^X-Debbugs-CC: dummy@example.com" msgtxt1
+'
+
+test_expect_success $PREREQ 'multiline fields are correctly unfolded' '
+	clean_fake_sendmail &&
+	cp $patches headercmd.patch &&
+	write_script headercmd-multiline <<-\EOF &&
+	echo "X-Debbugs-CC: someone@example.com
+FoldedField: This is a tale
+ best told using
+ multiple lines."
+	EOF
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--header-cmd=./headercmd-multiline \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		headercmd.patch &&
+	grep "^FoldedField: This is a tale best told using multiple lines.$" msgtxt1
+'
+
 test_expect_success $PREREQ 'reject long lines' '
 	z8=zzzzzzzz &&
 	z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
-- 
2.39.2

