Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDAE1202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbdKTVaK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:30:10 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:46680 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdKTVaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:30:08 -0500
Received: by mail-it0-f68.google.com with SMTP id r127so13701820itb.5
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tzs+IsKJXfvpOQGxpr+QnA8OvjoQerOZ3vwNBeTp3Ow=;
        b=jgAnqTXO0f3jjUiqvDfFI+86AsvKKUXsT9NgZEvOjdbg4th96cCkYX8TFWxo50XQeP
         xK/Uup80zpBCd67iaRnymHB3/xTiCpRnkHqDJz4Kot8icAcCqFjnW/A0ekrs6hyLP73p
         KQJCYXT1E5eUoaUUTloAnmn5xbk3oKWfgKzqnwdCrqk2WG8rvxaka6/eYcmgh8jt2sKv
         fWdkyHfKwxK+s5FeL4dn/UF/3ct9w/hwnxa7PPbVZzRStKPOxh7nWs1CO+WnI8SHEKxp
         o12emp03gCB1ZF2uhfS3VjiHU++7rU25vgZwhi3UXnJ4L/TQxh8YCOSKs+lMem2zKbW+
         Tfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tzs+IsKJXfvpOQGxpr+QnA8OvjoQerOZ3vwNBeTp3Ow=;
        b=O0vCBX1i+k0Qean7PznJty3obbLhloiek+kSV0pop66wPUbdMsADZfLh77d35E8gLU
         MmHmCBAWyht2kjuFwZnxsh1xI7B9GMQFm6iRrdGeP1g7lUDyBhv9cCVBvZ0NM0yNrlLo
         ep/e29zwqECo6ckOZcdpsDwGMcZ7/i1P2p5hWrOOXJn3XXZq/XSMJw1NWwqXUKL0GW+V
         g1TWY2aKVNLdPfHjNnfJlqQAKHQf1GGFXdZFo4CGWD7GIYd0G44GykUXZsLy8YyEhCoX
         Zy6KMEL/WptZeGZd596JewP1SW0EM46+PgTLPXixuKw6TcYoyQP6Yw28AapY7DdRwcmU
         JLMw==
X-Gm-Message-State: AJaThX7ykT1Ru3VYadaFXUoNh/1O+O9NPEe3JWjkkTmreEMFXe8+N0/U
        US1QFtDlBw5EtpntxllFLDyHnyXT
X-Google-Smtp-Source: AGs4zMaP4JhS1aPkDFzDtVBCLo8kTh+SedRnDZZOYI6S2//7Ymz1oCBdW/ZGB83WTrMNK11/gv8Z/Q==
X-Received: by 10.36.2.19 with SMTP id 19mr20939484itu.76.1511213407271;
        Mon, 20 Nov 2017 13:30:07 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j71sm2825412itj.2.2017.11.20.13.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:30:06 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:30:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 6/8] ssh: 'auto' variant to select between 'ssh' and 'simple'
Message-ID: <20171120213004.57552ja3nmxy6pmc@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Android's "repo" tool is a tool for managing a large codebase
consisting of multiple smaller repositories, similar to Git's
submodule feature.  Starting with Git 94b8ae5a (ssh: introduce a
'simple' ssh variant, 2017-10-16), users noticed that it stopped
handling the port in ssh:// URLs.

The cause: when it encounters ssh:// URLs, repo pre-connects to the
server and sets GIT_SSH to a helper ".repo/repo/git_ssh" that reuses
that connection.  Before 94b8ae5a, the helper was assumed to support
OpenSSH options for lack of a better guess and got passed a -p option
to set the port.  After that patch, it uses the new default of a
simple helper that does not accept an option to set the port.

The next release of "repo" will set GIT_SSH_VARIANT to "ssh" to avoid
that.  But users of old versions and of other similar GIT_SSH
implementations would not get the benefit of that fix.

So update the default to use OpenSSH options again, with a twist.  As
observed in 94b8ae5a, we cannot assume that $GIT_SSH always handles
OpenSSH options: common helpers such as travis-ci's dpl[*] are
configured using GIT_SSH and do not accept OpenSSH options.  So make
the default a new variant "auto", with the following behavior:

 1. First, check for a recognized basename, like today.

 2. If the basename is not recognized, check whether $GIT_SSH supports
    OpenSSH options by running

	$GIT_SSH -G <options> <host>

    This returns status 0 and prints configuration in OpenSSH if it
    recognizes all <options> and returns status 255 if it encounters
    an unrecognized option.  A wrapper script like

	exec ssh -- "$@"

    would fail with

	ssh: Could not resolve hostname -g: Name or service not known

    , correctly reflecting that it does not support OpenSSH options.
    The command is run with stdin, stdout, and stderr redirected to
    /dev/null so even a command that expects a terminal would exit
    immediately.

 3. Based on the result from step (2), behave like "ssh" (if it
    succeeded) or "simple" (if it failed).

This way, the default ssh variant for unrecognized commands can handle
both the repo and dpl cases as intended.

This autodetection has been running on Google workstations since
2017-10-23 with no reported negative effects.

[*] https://github.com/travis-ci/dpl/blob/6c3fddfda1f2a85944c544446b068bac0a77c049/lib/dpl/provider.rb#L215

Reported-by: William Yan <wyan@google.com>
Improved-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Added two notes to the commit message:
 - describing the real-world testing this patch has undergone
 - stdin, stdout, and stderr go to /dev/null, preventing a
   hypothetical ssh variant that *ignores* -G from hanging waiting for
   input from the terminal.

This is to address the worries at
https://public-inbox.org/git/xmqq60b59toe.fsf@gitster.mtv.corp.google.com/
and https://public-inbox.org/git/CAGZ79kZTjUvcq_hKHCqTDoaBxt2x+9XcqYc6ao1bhcET2SM-PQ@mail.gmail.com/
about hanging.

No change to the code from last time.

 Documentation/config.txt | 24 +++++++++++++++---------
 connect.c                | 32 +++++++++++++++++++++++++-------
 t/t5601-clone.sh         | 21 +++++++++++++++++++++
 3 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0460af37e2..0c371ad786 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2081,16 +2081,22 @@ matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
 ssh.variant::
-	Depending on the value of the environment variables `GIT_SSH` or
-	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
-	auto-detects whether to adjust its command-line parameters for use
-	with ssh (OpenSSH), plink or tortoiseplink, as opposed to the default
-	(simple).
+	By default, Git determines the command line arguments to use
+	based on the basename of the configured SSH command (configured
+	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
+	the config setting `core.sshCommand`). If the basename is
+	unrecognized, Git will attempt to detect support of OpenSSH
+	options by first invoking the configured SSH command with the
+	`-G` (print configuration) option and will subsequently use
+	OpenSSH options (if that is successful) or no options besides
+	the host and remote command (if it fails).
 +
-The config variable `ssh.variant` can be set to override this auto-detection;
-valid values are `ssh`, `simple`, `plink`, `putty` or `tortoiseplink`. Any
-other value will be treated as normal ssh. This setting can be overridden via
-the environment variable `GIT_SSH_VARIANT`.
+The config variable `ssh.variant` can be set to override this detection.
+Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
+`tortoiseplink`, `simple` (no options except the host and remote command).
+The default auto-detection can be explicitly requested using the value
+`auto`.  Any other value is treated as `ssh`.  This setting can also be
+overridden via the environment variable `GIT_SSH_VARIANT`.
 +
 The current command-line parameters used for each variant are as
 follows:
diff --git a/connect.c b/connect.c
index d2fbb15cc5..455c54a2ec 100644
--- a/connect.c
+++ b/connect.c
@@ -788,6 +788,7 @@ static const char *get_ssh_command(void)
 }
 
 enum ssh_variant {
+	VARIANT_AUTO,
 	VARIANT_SIMPLE,
 	VARIANT_SSH,
 	VARIANT_PLINK,
@@ -795,14 +796,16 @@ enum ssh_variant {
 	VARIANT_TORTOISEPLINK,
 };
 
-static int override_ssh_variant(enum ssh_variant *ssh_variant)
+static void override_ssh_variant(enum ssh_variant *ssh_variant)
 {
 	const char *variant = getenv("GIT_SSH_VARIANT");
 
 	if (!variant && git_config_get_string_const("ssh.variant", &variant))
-		return 0;
+		return;
 
-	if (!strcmp(variant, "plink"))
+	if (!strcmp(variant, "auto"))
+		*ssh_variant = VARIANT_AUTO;
+	else if (!strcmp(variant, "plink"))
 		*ssh_variant = VARIANT_PLINK;
 	else if (!strcmp(variant, "putty"))
 		*ssh_variant = VARIANT_PUTTY;
@@ -812,18 +815,18 @@ static int override_ssh_variant(enum ssh_variant *ssh_variant)
 		*ssh_variant = VARIANT_SIMPLE;
 	else
 		*ssh_variant = VARIANT_SSH;
-
-	return 1;
 }
 
 static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 					      int is_cmdline)
 {
-	enum ssh_variant ssh_variant = VARIANT_SIMPLE;
+	enum ssh_variant ssh_variant = VARIANT_AUTO;
 	const char *variant;
 	char *p = NULL;
 
-	if (override_ssh_variant(&ssh_variant))
+	override_ssh_variant(&ssh_variant);
+
+	if (ssh_variant != VARIANT_AUTO)
 		return ssh_variant;
 
 	if (!is_cmdline) {
@@ -982,6 +985,21 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 		variant = determine_ssh_variant(ssh, 0);
 	}
 
+	if (variant == VARIANT_AUTO) {
+		struct child_process detect = CHILD_PROCESS_INIT;
+
+		detect.use_shell = conn->use_shell;
+		detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;
+
+		argv_array_push(&detect.args, ssh);
+		argv_array_push(&detect.args, "-G");
+		push_ssh_options(&detect.args, &detect.env_array,
+				 VARIANT_SSH, port, flags);
+		argv_array_push(&detect.args, ssh_host);
+
+		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
+	}
+
 	argv_array_push(&conn->args, ssh);
 	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
 	argv_array_push(&conn->args, ssh_host);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9d007c0f8d..209e2d5604 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -369,6 +369,12 @@ test_expect_success 'variant can be overriden' '
 	expect_ssh myhost src
 '
 
+test_expect_success 'variant=auto picks based on basename' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
+	git -c ssh.variant=auto clone -4 "[myhost:123]:src" ssh-auto-clone &&
+	expect_ssh "-4 -P 123" myhost src
+'
+
 test_expect_success 'simple is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
 	git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple &&
@@ -381,6 +387,21 @@ test_expect_success 'uplink is treated as simple' '
 	expect_ssh myhost src
 '
 
+test_expect_success 'OpenSSH-like uplink is treated as ssh' '
+	write_script "$TRASH_DIRECTORY/uplink" <<-EOF &&
+	if test "\$1" = "-G"
+	then
+		exit 0
+	fi &&
+	exec "\$TRASH_DIRECTORY/ssh$X" "\$@"
+	EOF
+	test_when_finished "rm -f \"\$TRASH_DIRECTORY/uplink\"" &&
+	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
+	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
+	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
+	expect_ssh "-p 123" myhost src
+'
+
 test_expect_success 'plink is treated specially (as putty)' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 	git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&
-- 
2.15.0.448.gf294e3d99a

