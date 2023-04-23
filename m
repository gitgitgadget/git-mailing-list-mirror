Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7D7C77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 12:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDWM2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWM2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 08:28:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10C173F
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 05:28:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef112cac17so15469201cf.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682252889; x=1684844889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkhJSv8/swODw2xHkq2NfpfAwOys9g6FqeCScSfSqWw=;
        b=M8ttp+/qs9VemXkQ6SJiWga1U11xZkGbSGgv2TpBYYD2dOTHJnEGM4QWcfocrwP+VI
         44jwHnv9QRffdfBOgeaK2cua3XVkuWkjR93l1MtNZP4WRirYFqRh67WUa93pH8Dg+L8C
         O39ubB9svWLRf0NUrUHCHOT/sr523BRBaTZFuILQ7QKF56nzDXZwsZ+/QhFFekLHVhxx
         WOGMD76hdq/ggwAW0x4hIO6d0vVR3/3DNHD8XA1JllX3ruZ8ILMSYAL+B2RvNGvPjsOy
         KpkfTZVQ66gvWX4woxAdc7yXinWFwTM1OYU5F+/fhBGbvl7ujIc5KLN5PC4SZqFQyE7U
         lYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682252889; x=1684844889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkhJSv8/swODw2xHkq2NfpfAwOys9g6FqeCScSfSqWw=;
        b=VWZnQWzhn50rI0eWo0yswo3p208LjNhWc9zH9bYykizxAD0j9JxuivGqh3yrJ9izP1
         kiLVDH1FjvsTpk8IULfbgl8+eEs44ajiBNe/h/6Bdr4KcLRY6PCqDiep06IxlUfdrjSs
         XjJBGvEeqtfzlzG6g0elZKV2905PQR3UdqtFFzp2zStVwOwDHf6p3LbDtLVC0QCWdfre
         hinb44hVdQVaLg5iM9oQmF76NaB0lvVz77jYPZn7Nie16bJNLdsg3rUWh4JqG9XSSKq2
         iJijQWsrVfOCxSsgElcU2Fs0IKL8/3BVH4DKr1qegQ93QrcYFAjkX8zKrUSyNXuhknhv
         73hQ==
X-Gm-Message-State: AAQBX9fzVkA1B+m1bsFKLIZHWlpGA7NOEh7RKwAMkb5B6oSOkWDS87Rk
        9/VILDF+zsSgi0OVRjrV6yKZTZ1OwMQ=
X-Google-Smtp-Source: AKy350brjiYNrJpH+AX5x9eqb+nSwUPgEF2E+4XrZYjbidz3QyQ7SmJtrRC9OR1ysHHs4y2t10tYwQ==
X-Received: by 2002:ac8:5884:0:b0:3e4:ce24:99b3 with SMTP id t4-20020ac85884000000b003e4ce2499b3mr17125917qta.15.1682252889521;
        Sun, 23 Apr 2023 05:28:09 -0700 (PDT)
Received: from localhost.localdomain (dsl-141-20.b2b2c.ca. [66.158.141.20])
        by smtp.gmail.com with ESMTPSA id b10-20020a05622a020a00b003e65228ef54sm2827654qtx.86.2023.04.23.05.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:28:09 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH 2/2] send-email: add --header-cmd option
Date:   Sun, 23 Apr 2023 08:27:44 -0400
Message-Id: <20230423122744.4865-3-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, adding a header different than CC or TO is desirable; for
example, when using Debbugs, it is best to use 'X-Debbugs-Cc' headers
to keep people in CC; this is an example use case enabled by the new
'--header-cmd' option.
---
 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   |  5 +++++
 git-send-email.perl                | 12 +++++++++---
 t/t9001-send-email.sh              | 21 +++++++++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 51da7088a8..3d0f516520 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -58,6 +58,7 @@ sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
 sendemail.ccCmd::
+sendemail.headerCmd::
 sendemail.chainReplyTo::
 sendemail.envelopeSender::
 sendemail.from::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b0f438ec99..354c0d06db 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -320,6 +320,11 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
 
+--header-cmd=<command>::
+	Specify a command to execute once per patch file which should
+	generate arbitrary, patch file specific header entries.
+	Default is the value of `sendemail.headerCmd` configuration value.
+
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
diff --git a/git-send-email.perl b/git-send-email.perl
index d2febbda1f..676dd83d89 100755
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
@@ -1777,6 +1780,9 @@ sub process_file {
 			push(@header, $_);
 		}
 	}
+	# Add computed headers, if applicable.
+	push @header, execute_cmd("header-cmd", $header_cmd, $t)
+		if defined $header_cmd;
 	# Now parse the header
 	foreach(@header) {
 		if (/^From /) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0de83b5d2b..3393725107 100755
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
@@ -410,6 +413,20 @@ test_expect_success $PREREQ 'cccmd works' '
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
 test_expect_success $PREREQ 'reject long lines' '
 	z8=zzzzzzzz &&
 	z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
-- 
2.39.2

