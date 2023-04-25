Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE40C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjDYSv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjDYSvg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:51:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8DC193E9
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:51:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-5ef51c44141so29473256d6.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448623; x=1685040623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VttJntrI2VaeKWvcSOLzxvznrsfLZroTpvzWFLKfr2g=;
        b=IHjjqtgputIKJOUGje+wKFfUQXssSJz9RuXPh4xdgBPNZOVJxT/kxSOBKolcDbctIy
         CzLJL3suqJg+n4A6h7DW/VXXf4hKcNhReq/UcWswLtgNtfo9+3o76PgqKtHxGZOMcnfQ
         3zvYn3RKtIGn5TxjmU6JULw2bAcm30ZlCKG/YnyKKPDmqXM/z0PZv3xJ0UZqG1EpE9zT
         5O2pmTii5+cOpbaN9jfo8qEqsEyiZFJlhIC0wqINK/57wyy9tdvtvKG4FpamOLpoxslC
         Hmbm9yVyl6VGnHbbhT+Ll+TvxwVaf1eqD6sNTLLLYPKJOtoPaajiqOzcluwiCAlv6fSC
         uDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448623; x=1685040623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VttJntrI2VaeKWvcSOLzxvznrsfLZroTpvzWFLKfr2g=;
        b=OKKjJ0LINnr+tSQ9ggModj4ZbsdINtnp9FDGSP7GrTbkpVMhIqu1diRSG+57UPedCs
         43d5goNcXHp0T1thTBYmj8o5Ew3lsaMjLU5mZMlenQvi1rVJMcv+bxa7+Anz36fbO4SN
         eFXcgYZefxCKJ7Xhj9OuSUWWxDBy8bkGewvF0Nk1kSKmKZeulh4NP4znEU412FyyBszJ
         NXtGwcHOoz/08Q/OPV/LtbfGzhMXdHxB2q9RwC4w/QUQyexAsx13NKIG8xRXuC/+MRFI
         f9826gzGsrbfhgX541vpjpeQgdcDkxUdsP8S+1zCPfyqPCDurzV3ZrBbup+dSgW+jrp3
         fFUw==
X-Gm-Message-State: AAQBX9f9woU5KF5KvzLVVimWkviyHgjPNQTZR6P/tRIx6TsBWqG91Xhi
        PgteCrFjmT7jHMVp4pIy2FSCCKk2c+A=
X-Google-Smtp-Source: AKy350acdXCa6IOXqaQjWFWyZi89D2LO6x1/L35VT0Nkk1GGiCqbaA1hPZf21lzd5Ey0DYa5e+nZHg==
X-Received: by 2002:a05:6214:d88:b0:5ef:4bdd:42e0 with SMTP id e8-20020a0562140d8800b005ef4bdd42e0mr28524713qve.51.1682448623443;
        Tue, 25 Apr 2023 11:50:23 -0700 (PDT)
Received: from localhost.localdomain ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf44b000000b005fd79831ac7sm4050080qvm.84.2023.04.25.11.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:50:23 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH v3 2/3] send-email: add --header-cmd option
Date:   Tue, 25 Apr 2023 14:50:12 -0400
Message-Id: <20230425185013.14351-3-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425185013.14351-1-maxim.cournoyer@gmail.com>
References: <xmqqcz3s3oz7.fsf@gitster.g>
 <20230425185013.14351-1-maxim.cournoyer@gmail.com>
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
---
 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   |  8 +++++
 git-send-email.perl                | 49 +++++++++++++++++++++++-------
 t/t9001-send-email.sh              | 39 ++++++++++++++++++++++--
 4 files changed, 84 insertions(+), 13 deletions(-)

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
index b0f438ec99..295a3dd67c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -320,6 +320,14 @@ Automating
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
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
diff --git a/git-send-email.perl b/git-send-email.perl
index b8d77ad214..666b37adc9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,8 +88,9 @@ sub usage {
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
-    --to-cmd                <str>  * Email To: via `<str> \$patch_path`
-    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
+    --to-cmd                <str>  * Email To: via `<str> \$patch_path`.
+    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`.
+    --header-cmd            <str>  * Add headers via `<str> \$patch_path`.
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, misc-by, all.
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
@@ -270,7 +271,7 @@ sub do_edit {
 # Variables with corresponding config settings
 my ($suppress_from, $signed_off_by_cc);
 my ($cover_cc, $cover_to);
-my ($to_cmd, $cc_cmd);
+my ($to_cmd, $cc_cmd, $header_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
 my ($batch_size, $relogin_delay);
@@ -319,6 +320,7 @@ sub do_edit {
     "tocmd" => \$to_cmd,
     "cc" => \@config_cc,
     "cccmd" => \$cc_cmd,
+    "headercmd" => \$header_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@config_bcc,
     "suppresscc" => \@suppress_cc,
@@ -520,6 +522,7 @@ sub config_regexp {
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
+		    "header-cmd=s" => \$header_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "no-suppress-from" => sub {$suppress_from = 0},
 		    "suppress-cc=s" => \@suppress_cc,
@@ -1766,17 +1769,15 @@ sub process_file {
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
 	}
+	@header = unfold_headers(@header_lines);
+	# Add computed headers, if applicable.
+	push @header, invoke_header_cmd($header_cmd, $t) if defined $header_cmd;
 	# Now parse the header
 	foreach(@header) {
 		if (/^From /) {
@@ -2022,6 +2023,32 @@ sub execute_cmd {
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
index 0de83b5d2b..230f436f23 100755
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
@@ -410,6 +413,38 @@ test_expect_success $PREREQ 'cccmd works' '
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

