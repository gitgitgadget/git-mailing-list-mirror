Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9AFC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA7F60F3A
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 17:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhJKRPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJKRPo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 13:15:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0309C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 10:13:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bi9so3163243qkb.11
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIW58EOxVqxS+/0852BkrzztwzbGmglQLv59k/JXriE=;
        b=T9+eD4hHrq9JZs/Ey+a/spau+U0k8sOZMz+s5RRXM0cRMDZExN7bLQQjHHLHQNm6Ll
         7uC865sMQE+TEoWsUQ8UfSNBCHTAJ65zeT6do30M2j3bUbYbFxaSQpRaLym/ulDnwPro
         wdcHgERJjmfuqOEUVdSKXoS4TfaSkTxuCc3jvkedD9NxLtHWvPQn3EhmHXN74nLKe7fl
         DxYV0UxsKx10eEQ21LasWddXMjVGAyp1MeWF7D6+IGwnBxtdjiYWO7wwAIN1wAjMX20o
         /OQDy/MesKanLd7Y6VtyO6QSAGSov877/TFTg+R9oQoUxzjj+0A/+V1rNUvivylhswMH
         0mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIW58EOxVqxS+/0852BkrzztwzbGmglQLv59k/JXriE=;
        b=48s+ovT+K3MVyxVoVVsaGdn0pAxcDsmEAmebxrdbUJ4tIUzzaYvT3Vc4k/nc5IkAAI
         23NL6qyARXrLObbpE8Ke7YBGoOak4/SsOQ4uAxgXOFqWN/c7zNuVY4Hc2qIwGQz96Om+
         sYorPqRsW2zdB6vLrxrv5/kuxAO9IpogSXqMLyKhKJzbp8FbnhekOmA63Cy1omQcuas8
         HzCcRq5nmpwQtehUEDsZySDxLmNLuZRKCiiSdVHbBdLAou5zHvuUKV6mYOk+uZELXLJd
         7NHt0ivkMT+6Aw1nRn4gJYuSFlvVSEDN9k7O7M+P4KMccmqZueogB+UGSdQv7MjZ3L3F
         uslw==
X-Gm-Message-State: AOAM5300VS/VAujQe5DboptQQJxcfUfX7n+q0ab08Y3H8kGTqHsf0D8Z
        X3Hb46t+7/PYuYRcsC67ua+N6ckWNXE=
X-Google-Smtp-Source: ABdhPJzCbM1KgJwaBklvW/DM2r5TPQesTLz55K2E7ohz4QnN160D6ENsgN7cpYLXxOfNEqB/4A0IYw==
X-Received: by 2002:a37:bf85:: with SMTP id p127mr15173723qkf.259.1633972422828;
        Mon, 11 Oct 2021 10:13:42 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id a3sm5147321qta.48.2021.10.11.10.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:13:42 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     tbperrotta@gmail.com
Subject: [DRAFT/WIP PATCH] send-email: programmatically generate bash completions
Date:   Mon, 11 Oct 2021 13:12:22 -0400
Message-Id: <20211011171221.70231-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
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

Remove extraneous flags: --, --h and --git-completion-helper.

Add a completion test for "send-email --validate", a send-email flag.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

> ...I think that re-indentation is better left alone for the patch
> readability.

Reverted the `GetOptions` indentation. Noise is now gone :-)

> First, in your 1/3 you're adding a \n, but in 2/3 we end up with \n\n. I
> think you can just skip 1/3, maybe mention "how it also has a "\n" in
> the commit message.

I don't quite see how this would fit into the commit message. A comment in the
code seems to fit better to account for this detail. That's what I did, but if
you still disagree, please elaborate where in the commit message this sentence
should be added.

> You then strip out "--" arguments from the combined list, but isn't this
> something we do need to emit? I.e. it's used as syntax by the bash
> completion isn't it? (I just skimmed the relevant C code in
> parse-options.c).

I interpreted that standalone `--` as an extraneous / useless token. If it's
there intentionally, then I am reverting my stripping it. At the end of the day
whether to include it or not is a small detail, but FYI, when I do:

  git clone -<TAB>

in bash, nothing happens. I would have expected it to be expanded to "--"
because of the explicit "--", but it doesn't. Therefore my conclusion is that
"--" in the output of "--git-completion-helper" is useless. Am I missing
something?

Finally, as per your comments about "=": OK, I see what you mean. For the record
I had produced a quick-and-dirty version earlier (on top of V6), but didn't
include it in V7 because I didn't deem it polished enough, but I'll include it
here for reference. I'll take your new comments to see if I can produce a better
polished version before I send V8:

diff --git a/git-send-email.perl b/git-send-email.perl
index 465e9867b9..f0f83330d3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -123,12 +123,13 @@ sub completion_helper {
     my @send_email_opts = map {
       "--$_"
     } map {
-      s/(?:[:=][si]|!)$//;
+      s/!$//;
+      s/[:=][si]$/=/;
       split /\|/, $_;
     } keys %$options;
-    my @format_patch_opts = Git::command('format-patch', '--git-completion-helper');
-    my @options = uniq @send_email_opts, @format_patch_opts;
-    @options = grep !/--git-completion-helper|--h/, @options;
+    my @format_patch_opts = split(/ /, Git::command('format-patch', '--git-completion-helper'));
+    my @options = (@send_email_opts, @format_patch_opts);
+    @options = uniq (grep !/^$|^--$|--git-completion-helper|--h/, @options);
     print "@options\n";
     exit(0);
 }

> That it's a map/map/keys is just some off-the-cuff Perl hacking on my

part, I think for validation etc. it's usually better to just turn it
into a plain old boring for-loop.

Oh, okay, I didn't find it hacky at all, the `map` seemed quite elegant and
functional to me, but then again I am a perl newbie :-P.

Differences from V7 (so far):

As per Ævar's comments:

- completely drop 1/3 since we'now using split instead of print to incorporate
  format-patch options. Side effect: then-extraneous '\n' is now gone.

- revert indentation (tabs) on GetOptions to eliminate diff noise (as per Ævar's
  interpretation of original Carlos's comment)

- re-add "--" to the output of "git send-email --git-completion-helper"

 contrib/completion/git-completion.bash | 11 +------
 git-send-email.perl                    | 40 ++++++++++++++++++++------
 t/t9902-completion.sh                  |  3 ++
 3 files changed, 35 insertions(+), 19 deletions(-)

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
index e65d969d0b..b632313192 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -113,9 +113,25 @@ sub usage {
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
+	my @send_email_opts = map {
+		"--$_"
+	} map {
+		s/(?:[:=][si]|!)$//;
+		split /\|/;
+	} keys %$original_opts;
+	my @format_patch_opts = split(/ /, Git::command('format-patch', '--git-completion-helper'));
+	my @options = (@send_email_opts, @format_patch_opts);
+	@options = uniq (grep !/^$|--git-completion-helper|--h/, @options);
+	# There's an implicit '\n' here already, no need to add an explicit one.
+	print "@options";
+	exit(0);
 }
 
 # most mail servers generate the Date: header, but not all...
@@ -425,10 +441,11 @@ sub config_regexp {
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
 
@@ -444,14 +461,17 @@ sub config_regexp {
 
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
@@ -508,7 +528,8 @@ sub config_regexp {
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
-	 );
+);
+$rc = GetOptions(%options);
 
 # Munge any "either config or getopt, not both" variables
 my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
@@ -516,7 +537,8 @@ sub config_regexp {
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

