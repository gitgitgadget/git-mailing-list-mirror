Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF0C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C36C604E9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhJYV3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhJYV3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:29:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0273FC061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:27:24 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id br18so461894qkb.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7YbOT/82EFLcdy2iGhZGc8vRRz7q8zxuCgeMhUisT8=;
        b=PgBd7NQoEXmr/o9We/wBft9GXqLcafjW9z3YS9LHnOdA9CLPijdEwBYfjIITCbAxka
         UysPlLZJMFGBBwugTvl4NtwdpkUSHn1ey+yoBYdawHQifzGNZUZD7J6MhkFlsaBvSQ1t
         XTMLfkqlwxoXGd1CUK9HQLwFaip04WnekNcB5ufXzdO1mvBEDqDXUJssIFiJEamljN4Q
         LD3EQ+V5MTzswTKzhv4/b7r9shYYbzp3qjVxyzuy5Mv+xhJ9k1+hdY6/NhR0I0ozzU+l
         IDNjOA5LPi2nFDkixEchRQKh2cUlWeAQyUjOrjV2LbCRnzLezKN2CRf0MY3ApF82QWW2
         BuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7YbOT/82EFLcdy2iGhZGc8vRRz7q8zxuCgeMhUisT8=;
        b=UV4DCNFWOV4Cihxk4XXxq84VEMgUoMSDo4+O598Yd7nZlqvjhg1ZApXJdUIFM1GTIg
         +rjAj8V2wF52374nDuTGl84YZQVwsk9rfJrJblghkIHWnz9gHL+n3VH7vTNmh9I0THcj
         s5395iD1GjWTH4F5kd71/XeSyVKBhhsGWy8M5zOh7L4S77ApyYg61mf/UxXyrInAwHMb
         j+IuPCgPYYciLAaRXAJqj32MQuRCS3nH6QEUrdBH7l5B4F9hsSlcvsk7EVcrl3O+WGD7
         dro2OlGvSgkMMJDXYba2E4Q7ns5bV9TKio3o7R7YJYv6JxoYODY/K2ItTXkfu9vOefSg
         Nj1A==
X-Gm-Message-State: AOAM532dF5GjwInmBA3KMV9kQmcGNMRZHVECdryn7JKJqigMC1chgMYv
        X1I/ClODp3/REDSGxXMzNzQgwFHOPCHM9A==
X-Google-Smtp-Source: ABdhPJx2uti5EAoccJhZ+PxIgmMZULKPdmkQwLsBpMXaZ5gN1S3PFLxyC1S5P3ZZz+atMLBXOVWI5Q==
X-Received: by 2002:a05:620a:28d5:: with SMTP id l21mr15509136qkp.98.1635197243057;
        Mon, 25 Oct 2021 14:27:23 -0700 (PDT)
Received: from localhost.localdomain (bras-base-ktnron0919w-grc-11-76-71-43-238.dsl.bell.ca. [76.71.43.238])
        by smtp.gmail.com with ESMTPSA id bk13sm9288672qkb.58.2021.10.25.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:27:22 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org, carenas@gmail.com, gitster@pobox.com,
        bagasdotme@gmail.com, avarab@gmail.com
Cc:     tbperrotta@gmail.com
Subject: [PATCH v8 1/2] send-email: programmatically generate bash completions
Date:   Mon, 25 Oct 2021 17:27:06 -0400
Message-Id: <20211025212707.188151-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <87fst7lkjx.fsf@evledraar.gmail.com>
References: <87fst7lkjx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-email --git-completion-helper" only prints "format-patch"
flags. Make it print "send-email" flags as well, extracting them
programmatically from its three existing "GetOptions".

Introduce a "uniq" subroutine, otherwise --cc-cover, --to-cover and
other flags would show up twice. In addition, deduplicate flags common
to both "send-email" and "format-patch", like --from.

Remove extraneous flags: --h and --git-completion-helper.

Add trailing "=" to options that expect an argument, inline with
the format-patch implementation.

Add a completion test for "send-email --validate", a send-email flag.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +-----
 git-send-email.perl                    | 53 +++++++++++++++++++++-----
 t/t9902-completion.sh                  |  3 ++
 3 files changed, 48 insertions(+), 19 deletions(-)

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
index e65d969d0b..b45c7da3ab 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -113,9 +113,38 @@ sub usage {
 	exit(1);
 }
 
+sub uniq {
+	my %seen;
+	grep !$seen{$_}++, @_;
+}
+
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper');
-    exit(0);
+	my ($original_opts) = @_;
+	my %not_for_completion = (
+		"git-completion-helper" => undef,
+		"h" => undef,
+	);
+	my @send_email_opts = ();
+
+	foreach my $key (keys %$original_opts) {
+		unless (exists $not_for_completion{$key}) {
+			$key =~ s/!$//;
+
+			if ($key =~ /[:=][si]$/) {
+				$key =~ s/[:=][si]$//;
+				push (@send_email_opts, "--$_=") foreach (split (/\|/, $key));
+			} else {
+				push (@send_email_opts, "--$_") foreach (split (/\|/, $key));
+			}
+		}
+	}
+
+	my @format_patch_opts = split(/ /, Git::command('format-patch', '--git-completion-helper'));
+	my @opts = (@send_email_opts, @format_patch_opts);
+	@opts = uniq (grep !/^$/, @opts);
+	# There's an implicit '\n' here already, no need to add an explicit one.
+	print "@opts";
+	exit(0);
 }
 
 # most mail servers generate the Date: header, but not all...
@@ -425,10 +454,11 @@ sub config_regexp {
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
 
@@ -444,14 +474,17 @@ sub config_regexp {
 
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
+my %options = (
 		    "sender|from=s" => \$sender,
-                    "in-reply-to=s" => \$initial_in_reply_to,
+		    "in-reply-to=s" => \$initial_in_reply_to,
 		    "reply-to=s" => \$reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@getopt_to,
@@ -508,7 +541,8 @@ sub config_regexp {
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
-	 );
+);
+$rc = GetOptions(%options);
 
 # Munge any "either config or getopt, not both" variables
 my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
@@ -516,7 +550,8 @@ sub config_regexp {
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
2.33.1

