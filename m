Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE1C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C16061058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhJGDjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbhJGDjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 23:39:48 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FBEC061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 20:37:55 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o13so3340334qvm.4
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBjDMclAxXWT/hB1dHABDNuB5atk8u6IqJA/WCSTlpw=;
        b=N/CQJsPWncbeOZt0FRuqmpv3bUSZMyBZ+enRhQ2UMW/U8YG31rhF9y6ZnYoDfWdUJV
         PJiJPwOJHnTvZJc5RyArUT9Ia3TV6CNb0+NI9KROrp/FcTQn3hfcIXTkIwFceDNjkIEN
         14BSGjeudXb8t78tBYBgTh4XsHhNe1D/piaKi8iY3AlyWMbRcRQ6WQC92MyOXgUpvrkp
         VsD/c9jVLhr212XuJpi977oSPvUnFzA63BgyKfomwqzJ18x29WlP6o+ShDgSr1Pu8tfV
         OMSK9YHp+EUQibODC8sCVKaKSrsXpAvJRADFCUM92cDwZMLrE4gPacrc32iegR0vgeqw
         Yv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBjDMclAxXWT/hB1dHABDNuB5atk8u6IqJA/WCSTlpw=;
        b=IrYG844VnE+yMKF1jB0eDJo2GhGr46IlrJ+Rnw8C0O18qYtDXSvpGGYGe2LTJmi4bq
         BMWhsNya1lK4oq07u0j52rIIQ1UXn659rHnHXd34UKIkLUIjUfFvXOJ+bGck6v8zDbfr
         FNuXbc+DTnfK9XQW/VdOo9pzeUIJBs+y+d1WrQ9UBG7VBZkNLdVyiLwLXsLUOHFIVXUs
         y1101jWPwcJ8+T4SjAQS9wXi2E8VYQ+JlgRYIcas1pyGRoHEKT5PrzirHCvl/fCJjFG+
         dER5+TVqRwUpRNuu3CVYwJW57H+Av++SFXKulpHKMa/G/F7zfzXpeyHMoJ8di2lEblS4
         9TiQ==
X-Gm-Message-State: AOAM531laLnHmFo7UTU19BNERE9PTNmbpnAwOzmruLUJeYLXVfHi0DFr
        I/1J2i/aXDryy+TbPQwEpGA=
X-Google-Smtp-Source: ABdhPJzVtpl2HHNXg4oKCFoR20WPKS88pv25jHKQKgXaVDGWKm+R1h3GpMvYesWGK5GC4xDkT/nscw==
X-Received: by 2002:a0c:dc81:: with SMTP id n1mr2072176qvk.36.1633577874744;
        Wed, 06 Oct 2021 20:37:54 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id x6sm13892860qts.79.2021.10.06.20.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:37:54 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v6 2/3] send-email: programmatically generate bash completions
Date:   Wed,  6 Oct 2021 23:36:51 -0400
Message-Id: <20211007033652.80793-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
References: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
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
flags would show up twice.

Remove two extraneous flags: --h and --git-completion-helper.

Add a completion test for "send-email --validate", a send-email flag.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +------
 git-send-email.perl                    | 43 +++++++++++++++++++-------
 t/t9902-completion.sh                  |  3 ++
 3 files changed, 36 insertions(+), 21 deletions(-)

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
index d1731c1755..465e9867b9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -40,7 +40,7 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory | rev-list options >
+git send-email [options] <file | directory | rev-list options>
 git send-email --dump-aliases
 
   Composing:
@@ -113,8 +113,23 @@ sub usage {
 	exit(1);
 }
 
+sub uniq {
+    my %seen;
+    grep !$seen{$_}++, @_;
+}
+
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper'), "\n";
+    my ($options) = @_;
+    my @send_email_opts = map {
+      "--$_"
+    } map {
+      s/(?:[:=][si]|!)$//;
+      split /\|/, $_;
+    } keys %$options;
+    my @format_patch_opts = Git::command('format-patch', '--git-completion-helper');
+    my @options = uniq @send_email_opts, @format_patch_opts;
+    @options = grep !/--git-completion-helper|--h/, @options;
+    print "@options\n";
     exit(0);
 }
 
@@ -425,10 +440,11 @@ sub config_regexp {
 	my $key = "sendemail.identity";
 	$identity = Git::config(@repo, $key) if exists $known_config_keys{$key};
 }
-my $rc = GetOptions(
-	"identity=s" => \$identity,
-	"no-identity" => \$no_identity,
+my %identity_options = (
+  "identity=s" => \$identity,
+  "no-identity" => \$no_identity,
 );
+my $rc = GetOptions(%identity_options);
 usage() unless $rc;
 undef $identity if $no_identity;
 
@@ -444,14 +460,17 @@ sub config_regexp {
 
 my $help;
 my $git_completion_helper;
-$rc = GetOptions("h" => \$help,
-                 "dump-aliases" => \$dump_aliases);
+my %dump_aliases_options = (
+  "h" => \$help,
+  "dump-aliases" => \$dump_aliases,
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
@@ -508,7 +527,8 @@ sub config_regexp {
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
-	 );
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

