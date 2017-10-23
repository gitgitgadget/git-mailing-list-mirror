Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7274202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdJWVcE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:32:04 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:54744 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdJWVcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:32:03 -0400
Received: by mail-io0-f182.google.com with SMTP id e89so21687272ioi.11
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7BjojxOOstqeTWECqGoTPoPOq0qhZlJTEBMIJbSLTDQ=;
        b=PWiPNYjaiRUm5nqrtB4K0sMmvpHrr2k7x24HTTRvPOhd0qgB7krekNH7OEds73dq0a
         8p+FoDXKvEXaHh//cpFOe8HTiyUzWu534EWO0TYsaQ/PWDvqwcrJpSVrZUtypwL2V1EN
         mRCh4drzLgwOhQTz6oaEON2BGWFtM8EVmOaqAh+uod/UDAEWvr30xs92zDQ+Bs/FjWEx
         ykvdg1X31HY/01Q/LfIrsn/pvFmRRe1P8B7Z2mPZXY/accVGbSM1xwlmkWTsnpOiuvvr
         OLmscb/qLFBUoH83Dy8tTsBJoTRYOZrD/TrsJ/HJZVvH9Pxs928wkByNNKxy58b+VL40
         q2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BjojxOOstqeTWECqGoTPoPOq0qhZlJTEBMIJbSLTDQ=;
        b=B0ToACq53dV06tOr7opb4okGVtzCimPJ1xwx2WrCa+TO7tnaWzXokaS8dMIQ0o4Dvd
         C85+hZwB443tgmNmASzuEIK8QyhsaXF61ER3FStyKtBA2Knr7lOZml575aVEvzCf2W0j
         RA/EmxCHEFb+gr+M2/dfrzUfBakRTUyhFGQ3PZ2ZYVuPuNHv2wiQTJP2eD1Feq31V4ko
         Qq2j7yoNJT87U/q5sWJNp+LiUMJ2nnGl0NwXzHANk8dbHGnpthuy8ZzaM1p19Rf6GQBF
         rXUZG+ouSpwr+X4nUMddmhnnGBoongJL2Hi30UInzvikds6xk9gc/LOBVmD+wpKBt4yK
         nofQ==
X-Gm-Message-State: AMCzsaWEKuRkHPrZJwXiZW82fKPIH6sWLhf8gAPV4yXx77H3++rXHl4v
        JXziQtLnLCgWDaw8/vgQIpY=
X-Google-Smtp-Source: ABhQp+RFp4ZUe9/zxd1jbYJFV6UMzpOh9WdR7F/SYq/sC2AN6Z+fwY/lZvfo84VPDLFfjvpCCNHfdg==
X-Received: by 10.107.11.219 with SMTP id 88mr19940975iol.78.1508794322144;
        Mon, 23 Oct 2017 14:32:02 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c80sm2821856itd.31.2017.10.23.14.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:32:01 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:31:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com, William Yan <wyan@google.com>
Subject: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and 'simple'
Message-ID: <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
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

 1. First, check whether $GIT_SSH supports OpenSSH options by running

	$GIT_SSH -G <options> <host>

    This returns status 0 and prints configuration in OpenSSH if it
    recognizes all <options> and returns status 255 if it encounters
    an unrecognized option.  A wrapper script like

	exec ssh -- "$@"

    would fail with

	ssh: Could not resolve hostname -g: Name or service not known

    , correctly reflecting that it does not support OpenSSH options.

 2. Based on the result from step (1), behave like "ssh" (if it
    succeeded) or "simple" (if it failed).

This way, the default ssh variant for unrecognized commands can handle
both the repo and dpl cases as intended.

If the GIT_SSH command name is recognized (e.g., "ssh") then continue
to use that variant directly without the autodetection step (1), as
before.

[*] https://github.com/travis-ci/dpl/blob/6c3fddfda1f2a85944c544446b068bac0a77c049/lib/dpl/provider.rb#L215

Reported-by: William Yan <wyan@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
repo fix: https://gerrit-review.googlesource.com/c/git-repo/+/134950

 Documentation/config.txt | 17 ++++++++----
 connect.c                | 72 ++++++++++++++++++++++++++++++++----------------
 t/t5601-clone.sh         | 14 ++++++++++
 3 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0460af37e2..4a16b324f0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2083,14 +2083,19 @@ visited as a result of a redirection do not participate in matching.
 ssh.variant::
 	Depending on the value of the environment variables `GIT_SSH` or
 	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
-	auto-detects whether to adjust its command-line parameters for use
-	with ssh (OpenSSH), plink or tortoiseplink, as opposed to the default
-	(simple).
+	auto-detects whether to pass command-line parameters for use
+	with a simple wrapper script (simple), OpenSSH (ssh), plink, or
+	tortoiseplink.
++
+The default is `auto`, which means to auto-detect whether the ssh command
+implements OpenSSH options using the `-G` (print configuration) option.
+If the ssh command supports OpenSSH options, it then behaves like `ssh`;
+otherwise, it behaves like `simple`.
 +
 The config variable `ssh.variant` can be set to override this auto-detection;
-valid values are `ssh`, `simple`, `plink`, `putty` or `tortoiseplink`. Any
-other value will be treated as normal ssh. This setting can be overridden via
-the environment variable `GIT_SSH_VARIANT`.
+valid values are `ssh`, `simple`, `plink`, `putty`, `tortoiseplink`, and
+`auto`.  Any other value will be treated as normal ssh.  This setting can be
+overridden via the environment variable `GIT_SSH_VARIANT`.
 +
 The current command-line parameters used for each variant are as
 follows:
diff --git a/connect.c b/connect.c
index 77ab6db3bb..2dc9554b30 100644
--- a/connect.c
+++ b/connect.c
@@ -777,6 +777,7 @@ static const char *get_ssh_command(void)
 }
 
 enum ssh_variant {
+	VARIANT_AUTO,
 	VARIANT_SIMPLE,
 	VARIANT_SSH,
 	VARIANT_PLINK,
@@ -791,7 +792,9 @@ static int override_ssh_variant(enum ssh_variant *ssh_variant)
 	if (!variant && git_config_get_string_const("ssh.variant", &variant))
 		return 0;
 
-	if (!strcmp(variant, "plink"))
+	if (!strcmp(variant, "auto"))
+		*ssh_variant = VARIANT_AUTO;
+	else if (!strcmp(variant, "plink"))
 		*ssh_variant = VARIANT_PLINK;
 	else if (!strcmp(variant, "putty"))
 		*ssh_variant = VARIANT_PUTTY;
@@ -808,7 +811,7 @@ static int override_ssh_variant(enum ssh_variant *ssh_variant)
 static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 					      int is_cmdline)
 {
-	enum ssh_variant ssh_variant = VARIANT_SIMPLE;
+	enum ssh_variant ssh_variant = VARIANT_AUTO;
 	const char *variant;
 	char *p = NULL;
 
@@ -908,6 +911,38 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 	return conn;
 }
 
+static void push_ssh_options(struct argv_array *args, struct argv_array *env,
+			       enum ssh_variant variant, const char *port,
+			       int flags)
+{
+	if (variant == VARIANT_SSH &&
+	    get_protocol_version_config() > 0) {
+		argv_array_push(args, "-o");
+		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
+		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+				 get_protocol_version_config());
+	}
+
+	if (variant != VARIANT_SIMPLE) {
+		if (flags & CONNECT_IPV4)
+			argv_array_push(args, "-4");
+		else if (flags & CONNECT_IPV6)
+			argv_array_push(args, "-6");
+	}
+
+	if (variant == VARIANT_TORTOISEPLINK)
+		argv_array_push(args, "-batch");
+
+	if (port && variant != VARIANT_SIMPLE) {
+		if (variant == VARIANT_SSH)
+			argv_array_push(args, "-p");
+		else
+			argv_array_push(args, "-P");
+
+		argv_array_push(args, port);
+	}
+}
+
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 			  const char *port, int flags)
@@ -937,33 +972,22 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 
 	argv_array_push(&conn->args, ssh);
 
-	if (variant == VARIANT_SSH &&
-	    get_protocol_version_config() > 0) {
-		argv_array_push(&conn->args, "-o");
-		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-				 get_protocol_version_config());
-	}
-
-	if (variant != VARIANT_SIMPLE) {
-		if (flags & CONNECT_IPV4)
-			argv_array_push(&conn->args, "-4");
-		else if (flags & CONNECT_IPV6)
-			argv_array_push(&conn->args, "-6");
-	}
+	if (variant == VARIANT_AUTO) {
+		struct child_process detect = CHILD_PROCESS_INIT;
 
-	if (variant == VARIANT_TORTOISEPLINK)
-		argv_array_push(&conn->args, "-batch");
+		detect.use_shell = conn->use_shell;
+		detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;
 
-	if (port && variant != VARIANT_SIMPLE) {
-		if (variant == VARIANT_SSH)
-			argv_array_push(&conn->args, "-p");
-		else
-			argv_array_push(&conn->args, "-P");
+		argv_array_push(&detect.args, ssh);
+		argv_array_push(&detect.args, "-G");
+		push_ssh_options(&detect.args, &detect.env_array,
+				 VARIANT_SSH, port, flags);
+		argv_array_push(&detect.args, ssh_host);
 
-		argv_array_push(&conn->args, port);
+		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
+	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
 	argv_array_push(&conn->args, ssh_host);
 }
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 86811a0c35..fd94dd40d2 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -384,6 +384,20 @@ test_expect_success 'uplink is treated as simple' '
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
+	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
+	export GIT_SSH &&
+	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
+	expect_ssh "-p 123" myhost src
+'
+
 test_expect_success 'plink is treated specially (as putty)' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 	git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&
-- 
2.15.0.rc1.287.g2b38de12cc

