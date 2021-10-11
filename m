Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C36C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ECC60F38
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhJKEM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJKEM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 00:12:56 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCAC061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:56 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v10so1349071qvb.10
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJuDLi2hWx0KJ/kmEy9PcZCjsXC1/TDltLuoGbIzuA0=;
        b=RTbzjAwbfb/2j+aUAll1fgEmiS5iig7od8fzUprglHvYdin94NVou3XFEWZKrANLwM
         bfwToM/eC4hmM9014ygXwAWzhJObSwecNoSy8eM9nrB+X5TNrkWMjDKSS7XoVSInuzVa
         A8YKepNAV6qa000uH4VN+LuCy2aGAQken0Gmii3Dj+8M7aTmEccbDiBFnGPt04wuyq/I
         CZeboxppATSB8SK1tHC1t62w9eBO0xOuzXXWY4LUGwa6nN6CI9XZimoiiQWh6Hq6jdEZ
         EZdfo25MOHvYmlZxLo036BSJLxVU+w1yTPiS5C0P9Hgu8fGzoHlliVo9PFk1CduJfAZ+
         3jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJuDLi2hWx0KJ/kmEy9PcZCjsXC1/TDltLuoGbIzuA0=;
        b=wzn+7fYfFY+qUusEAVLIWZLd+M2Cj41YxQXJ1ETl412zrh6ZhBf///2LidPhWvb5zb
         gu9AE8humd0DrExyel+pqrqwVNse26U860Xhhm2qDnGdcieES4wSTmSyXC9ETQEDwDfM
         kU1a/IsLPGhSZ+dTIcvaQgC3tYSYmj9vcJSs0Y3noyqkX3kF6Qaaguz8OGUGf6T3KdG8
         UiO9veXQiltofx05mm0XCMFhVCbsa+6VeocVZc2l491L+KNw+btdQZhdB2FVx7EZ3b5K
         mX+eNVIDnA8lME4FBOkdrIhB+uKjs3i3Upwhbx09mGsGdSeUt9k67HxJRWZ2BDoBDhYV
         TLkw==
X-Gm-Message-State: AOAM533aZS1F4hFcKfWkGHCYDbh08hzy01u1mT2y3ZI6oaoRPyXQJmAC
        JQ4DRtpkNe0uF7xWmnXh944WNHVg03Y=
X-Google-Smtp-Source: ABdhPJwbfBiJYEuVsQwq/ZPo7UA+nacHXo58ZZIwbOAicFB7k1FrH1t1oJ9tg6nXET5E9arbzC9hPA==
X-Received: by 2002:a05:6214:c64:: with SMTP id t4mr21649917qvj.5.1633925455717;
        Sun, 10 Oct 2021 21:10:55 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id 74sm3683814qke.109.2021.10.10.21.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 21:10:55 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v7 2/3] send-email: programmatically generate bash completions
Date:   Mon, 11 Oct 2021 00:10:32 -0400
Message-Id: <20211011041033.20004-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
References: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-email --git-completion-helper" only prints "format-patch"
flags. Make it print "send-email" flags as well, generating them
programmatically from the usage.

Extract flags from the three existing `GetOptions`.

Introduce a uniq subroutine, otherwise --cc-cover, --to-cover and other
flags would show up twice. In addition, deduplicate options common to
both send-email and format-patch, like --from.

Remove extraneous flags: --, --h and --git-completion-helper.

Add a completion test for "send-email --validate", a send-email flag.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/completion/git-completion.bash |  11 +-
 git-send-email.perl                    | 153 ++++++++++++++-----------
 t/t9902-completion.sh                  |   3 +
 3 files changed, 91 insertions(+), 76 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc8..1b73a4dcc0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2359,16 +2359,7 @@ _git_send_email ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin send-email "--annotate --bcc --cc --cc-cmd --chain-reply-to
-			--compose --confirm= --dry-run --envelope-sender
-			--from --identity
-			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
-			--no-suppress-from --no-thread --quiet --reply-to
-			--signed-off-by-cc --smtp-pass --smtp-server
-			--smtp-server-port --smtp-encryption= --smtp-user
-			--subject --suppress-cc= --suppress-from --thread --to
-			--validate --no-validate
-			$__git_format_patch_extra_options"
+		__gitcomp_builtin send-email "$__git_format_patch_extra_options"
 		return
 		;;
 	esac
diff --git a/git-send-email.perl b/git-send-email.perl
index d1731c1755..587e52d1d8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -113,9 +113,24 @@ sub usage {
 	exit(1);
 }
 
+sub uniq {
+	my %seen;
+	grep !$seen{$_}++, @_;
+}
+
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper'), "\n";
-    exit(0);
+	my ($original_opts) = @_;
+	my @send_email_opts = map {
+		"--$_"
+	} map {
+		s/(?:[:=][si]|!)$//;
+		split /\|/;
+	} keys %$original_opts;
+	my @format_patch_opts = split(/ /, Git::command('format-patch', '--git-completion-helper'));
+	my @options = (@send_email_opts, @format_patch_opts);
+	@options = uniq (grep !/^$|^--$|--git-completion-helper|--h/, @options);
+	print "@options\n";
+	exit(0);
 }
 
 # most mail servers generate the Date: header, but not all...
@@ -425,10 +440,11 @@ sub config_regexp {
 	my $key = "sendemail.identity";
 	$identity = Git::config(@repo, $key) if exists $known_config_keys{$key};
 }
-my $rc = GetOptions(
+my %identity_options = (
 	"identity=s" => \$identity,
 	"no-identity" => \$no_identity,
 );
+my $rc = GetOptions(%identity_options);
 usage() unless $rc;
 undef $identity if $no_identity;
 
@@ -444,71 +460,75 @@ sub config_regexp {
 
 my $help;
 my $git_completion_helper;
-$rc = GetOptions("h" => \$help,
-                 "dump-aliases" => \$dump_aliases);
+my %dump_aliases_options = (
+	"h" => \$help,
+	"dump-aliases" => \$dump_aliases,
+);
+$rc = GetOptions(%dump_aliases_options);
 usage() unless $rc;
 die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
-$rc = GetOptions(
-		    "sender|from=s" => \$sender,
-                    "in-reply-to=s" => \$initial_in_reply_to,
-		    "reply-to=s" => \$reply_to,
-		    "subject=s" => \$initial_subject,
-		    "to=s" => \@getopt_to,
-		    "to-cmd=s" => \$to_cmd,
-		    "no-to" => \$no_to,
-		    "cc=s" => \@getopt_cc,
-		    "no-cc" => \$no_cc,
-		    "bcc=s" => \@getopt_bcc,
-		    "no-bcc" => \$no_bcc,
-		    "chain-reply-to!" => \$chain_reply_to,
-		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
-		    "sendmail-cmd=s" => \$sendmail_cmd,
-		    "smtp-server=s" => \$smtp_server,
-		    "smtp-server-option=s" => \@smtp_server_options,
-		    "smtp-server-port=s" => \$smtp_server_port,
-		    "smtp-user=s" => \$smtp_authuser,
-		    "smtp-pass:s" => \$smtp_authpass,
-		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
-		    "smtp-encryption=s" => \$smtp_encryption,
-		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
-		    "smtp-debug:i" => \$debug_net_smtp,
-		    "smtp-domain:s" => \$smtp_domain,
-		    "smtp-auth=s" => \$smtp_auth,
-		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
-		    "annotate!" => \$annotate,
-		    "no-annotate" => sub {$annotate = 0},
-		    "compose" => \$compose,
-		    "quiet" => \$quiet,
-		    "cc-cmd=s" => \$cc_cmd,
-		    "suppress-from!" => \$suppress_from,
-		    "no-suppress-from" => sub {$suppress_from = 0},
-		    "suppress-cc=s" => \@suppress_cc,
-		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
-		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
-		    "cc-cover|cc-cover!" => \$cover_cc,
-		    "no-cc-cover" => sub {$cover_cc = 0},
-		    "to-cover|to-cover!" => \$cover_to,
-		    "no-to-cover" => sub {$cover_to = 0},
-		    "confirm=s" => \$confirm,
-		    "dry-run" => \$dry_run,
-		    "envelope-sender=s" => \$envelope_sender,
-		    "thread!" => \$thread,
-		    "no-thread" => sub {$thread = 0},
-		    "validate!" => \$validate,
-		    "no-validate" => sub {$validate = 0},
-		    "transfer-encoding=s" => \$target_xfer_encoding,
-		    "format-patch!" => \$format_patch,
-		    "no-format-patch" => sub {$format_patch = 0},
-		    "8bit-encoding=s" => \$auto_8bit_encoding,
-		    "compose-encoding=s" => \$compose_encoding,
-		    "force" => \$force,
-		    "xmailer!" => \$use_xmailer,
-		    "no-xmailer" => sub {$use_xmailer = 0},
-		    "batch-size=i" => \$batch_size,
-		    "relogin-delay=i" => \$relogin_delay,
-		    "git-completion-helper" => \$git_completion_helper,
-	 );
+my %options = (
+	"sender|from=s" => \$sender,
+	"in-reply-to=s" => \$initial_in_reply_to,
+	"reply-to=s" => \$reply_to,
+	"subject=s" => \$initial_subject,
+	"to=s" => \@getopt_to,
+	"to-cmd=s" => \$to_cmd,
+	"no-to" => \$no_to,
+	"cc=s" => \@getopt_cc,
+	"no-cc" => \$no_cc,
+	"bcc=s" => \@getopt_bcc,
+	"no-bcc" => \$no_bcc,
+	"chain-reply-to!" => \$chain_reply_to,
+	"no-chain-reply-to" => sub {$chain_reply_to = 0},
+	"sendmail-cmd=s" => \$sendmail_cmd,
+	"smtp-server=s" => \$smtp_server,
+	"smtp-server-option=s" => \@smtp_server_options,
+	"smtp-server-port=s" => \$smtp_server_port,
+	"smtp-user=s" => \$smtp_authuser,
+	"smtp-pass:s" => \$smtp_authpass,
+	"smtp-ssl" => sub { $smtp_encryption = 'ssl' },
+	"smtp-encryption=s" => \$smtp_encryption,
+	"smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
+	"smtp-debug:i" => \$debug_net_smtp,
+	"smtp-domain:s" => \$smtp_domain,
+	"smtp-auth=s" => \$smtp_auth,
+	"no-smtp-auth" => sub {$smtp_auth = 'none'},
+	"annotate!" => \$annotate,
+	"no-annotate" => sub {$annotate = 0},
+	"compose" => \$compose,
+	"quiet" => \$quiet,
+	"cc-cmd=s" => \$cc_cmd,
+	"suppress-from!" => \$suppress_from,
+	"no-suppress-from" => sub {$suppress_from = 0},
+	"suppress-cc=s" => \@suppress_cc,
+	"signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
+	"no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
+	"cc-cover|cc-cover!" => \$cover_cc,
+	"no-cc-cover" => sub {$cover_cc = 0},
+	"to-cover|to-cover!" => \$cover_to,
+	"no-to-cover" => sub {$cover_to = 0},
+	"confirm=s" => \$confirm,
+	"dry-run" => \$dry_run,
+	"envelope-sender=s" => \$envelope_sender,
+	"thread!" => \$thread,
+	"no-thread" => sub {$thread = 0},
+	"validate!" => \$validate,
+	"no-validate" => sub {$validate = 0},
+	"transfer-encoding=s" => \$target_xfer_encoding,
+	"format-patch!" => \$format_patch,
+	"no-format-patch" => sub {$format_patch = 0},
+	"8bit-encoding=s" => \$auto_8bit_encoding,
+	"compose-encoding=s" => \$compose_encoding,
+	"force" => \$force,
+	"xmailer!" => \$use_xmailer,
+	"no-xmailer" => sub {$use_xmailer = 0},
+	"batch-size=i" => \$batch_size,
+	"relogin-delay=i" => \$relogin_delay,
+	"git-completion-helper" => \$git_completion_helper,
+);
+$rc = GetOptions(%options);
 
 # Munge any "either config or getopt, not both" variables
 my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
@@ -516,7 +536,8 @@ sub config_regexp {
 my @initial_bcc = @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bcc);
 
 usage() if $help;
-completion_helper() if $git_completion_helper;
+my %all_options = (%options, %dump_aliases_options, %identity_options);
+completion_helper(\%all_options) if $git_completion_helper;
 unless ($rc) {
     usage();
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 11573936d5..a4faf64184 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2139,6 +2139,9 @@ test_expect_success PERL 'send-email' '
 	--cover-from-description=Z
 	--cover-letter Z
 	EOF
+	test_completion "git send-email --val" <<-\EOF &&
+	--validate Z
+	EOF
 	test_completion "git send-email ma" "main "
 '
 
-- 
2.33.0

