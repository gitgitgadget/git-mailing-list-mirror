Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535FA201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbdELWih (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:38:37 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35299 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdELWig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:38:36 -0400
Received: by mail-pg0-f44.google.com with SMTP id q125so16698092pgq.2
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDCONqAXF5f08dFuvCYR21UbC980iZMuRBWfYX+sNBs=;
        b=timOuEw1xw8+OVrcz5zTcziYrymEolO6kb8D3mKOOngMoy6egctkE/drPwfQUDWE1P
         F9NS83dSPRkSFJtd324+pHAKQ28apZHGj7mdMoAiTE8Si/rXH5sJUpUdbzISe2yysmPG
         HZK/Jqr8r0oXHcc+SAe5AGXxdobWncxt4AiQsCsA0yN6ZMCa24VzEqbmQEr2XW8Ke4ys
         xCpRe3zVvGcxxf5eWQd9zznT3rcLm2SrSyLilPp4P7ZWkmsG46furzWlxpbvSOu3E8la
         CCD1Zz60Fb+oO4F9+KCBJVQ6xQKK8XDE7CLxrNRlCYlI63oPgmEU8ZNQ3Q2qGBOsw0DY
         wgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDCONqAXF5f08dFuvCYR21UbC980iZMuRBWfYX+sNBs=;
        b=Y2Tz6lMqz9LfWsKVpc8Oz5fi/Iyn49viEQv3Qzbd1jnrMqamKXuMgmT4EnOEq8Rpnk
         pyO3WMd/0AgTADvb1AZ89eKwvqW7IzG2DRQ4UEbdZcUD+SJ5wNpuf/if2x1ciKrdJDhS
         dLefszrt3LlvnAIDwRPJULoz11QpXJ4ELk3okcmEysWcaqIE5epWr6YCqJXJLGLzIMrD
         5XPtM3bo0LbX/Wbr4FeGGUe7e2sM+H5ahZyzds647dweYhED9QC2ejqc3PCasJJqiHje
         HlJ4vnACBDwN2rUe/xJWmH8O5GlsUizVg32BWdl4CmBjwRcIHhy0qcaZZJqVZKxqw9gU
         3JCw==
X-Gm-Message-State: AODbwcAbKzHDoAAWjBGYW29Mhqh5BQ8M7RlR6r6CplaTQcMqnuP3OTlq
        38AeLxAwgi5az/2W
X-Received: by 10.99.142.73 with SMTP id k70mr6775965pge.0.1494628715536;
        Fri, 12 May 2017 15:38:35 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id p84sm7454225pfi.25.2017.05.12.15.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 May 2017 15:38:34 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2] send-email: support validate hook
Date:   Fri, 12 May 2017 15:38:26 -0700
Message-Id: <20170512223827.21372-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170511193753.19594-1-jonathantanmy@google.com>
References: <20170511193753.19594-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, send-email has support for rudimentary e-mail validation.
Allow the user to add support for more validation by providing a
sendemail-validate hook.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Change from v1: followed Ævar's suggestions, and also moved the new
functionality into validate_patch().
---
 Documentation/git-send-email.txt |  1 +
 Documentation/githooks.txt       |  8 ++++++++
 git-send-email.perl              | 20 +++++++++++++++++++-
 t/t9001-send-email.sh            | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d66166f6..bb23b02ca 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -377,6 +377,7 @@ have been specified, in which case default to 'compose'.
 	Currently, validation means the following:
 +
 --
+		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
 		*	Warn of patches that contain lines longer than 998 characters; this
 			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
 --
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 706091a56..b2514f4d4 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -447,6 +447,14 @@ rebase::
 The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
+sendemail-validate
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by 'git send-email'.  It takes a single parameter,
+the name of the file that holds the e-mail to be sent.  Exiting with a
+non-zero status causes 'git send-email' to abort before sending any
+e-mails.
+
 
 GIT
 ---
diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f..c314cc2b5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -25,8 +25,9 @@ use Getopt::Long;
 use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
-use File::Spec::Functions qw(catfile);
+use File::Spec::Functions qw(catdir catfile);
 use Error qw(:try);
+use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
 
@@ -1737,6 +1738,23 @@ sub unique_email_list {
 
 sub validate_patch {
 	my $fn = shift;
+
+	my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
+				    'sendemail-validate');
+	my $hook_error;
+	if (-x $validate_hook) {
+		my $target = abs_path($fn);
+		# The hook needs a correct cwd and GIT_DIR.
+		my $cwd_save = cwd();
+		chdir($repo->wc_path() or $repo->repo_path())
+			or die("chdir: $!");
+		local $ENV{"GIT_DIR"} = $repo->repo_path();
+		$hook_error = "rejected by sendemail-validate hook"
+			if system($validate_hook, $target);
+		chdir($cwd_save) or die("chdir: $!");
+	}
+	return $hook_error if $hook_error;
+
 	open(my $fh, '<', $fn)
 		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 60a80f60b..f3f238d40 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1913,4 +1913,44 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'invoke hook' '
+	mkdir -p .git/hooks &&
+
+	write_script .git/hooks/sendemail-validate <<-\EOF &&
+		# test that we have the correct environment variable, pwd, and
+		# argument
+		case "$GIT_DIR" in
+			*.git)
+				true
+				;;
+			*)
+				false
+				;;
+		esac &&
+		test -e 0001-add-master.patch &&
+		grep "add master" "$1"
+	EOF
+
+	mkdir subdir &&
+	(
+		# Test that it works even if we are not at the root of the
+		# working tree
+		cd subdir &&
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/../fake.sendmail" \
+			../0001-add-master.patch &&
+
+		# Verify error message when a patch is rejected by the hook
+		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/../fake.sendmail" \
+			../another.patch 2>err
+		test_i18ngrep "rejected by sendemail-validate hook" err
+	)
+'
+
 test_done
-- 
2.13.0.rc2.291.g57267f2277-goog

