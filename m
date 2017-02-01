Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC03C1FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 11:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdBAL6E (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 06:58:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:61249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751883AbdBAL6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 06:58:03 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrNE4-1cTD9X1rXY-0137zx; Wed, 01
 Feb 2017 12:57:43 +0100
Date:   Wed, 1 Feb 2017 12:57:41 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] Handle PuTTY (plink/tortoiseplink) even in
 GIT_SSH_COMMAND
In-Reply-To: <cover.1485442231.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1485950225.git.johannes.schindelin@gmx.de>
References: <cover.1485442231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Xmckw7X17YZ0rK8nZIvl8z9ef4+bqiTvuSAAJakzZLmUE5GT8NP
 RvWJgkqVEth8foci4pqMedjitiqdR/5S5RGbnxyhHCM9vGRzhLxxXW1aYn1QQm5sDjfGt9P
 TJtb9EYzuRYtBXO9Rjs+F84QbQbrPhuq+2oBpbfEYmSEm5PaZ3tKBZQw6vpS4M5acqaA1BQ
 70jYeJ+jR39D1ATVsnsiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLm1/skhKDc=:rQVvmrOgW28U7c0J+EDHPi
 owHij6nBLdlq6t7qCI8bkLJqCQdcNScadMY30Xf0Gt2yKI2IcmOVMn56q17bHzmDLdBrAMo/v
 /FbstKHQV4eM1AnoBJ2GAkREJ58zT1TrRFdW+Sb7G4N4CZvawPHSXyQbnlWgRZMkRivotgbQc
 beFwLcWj7fcoK7nE2VzAM1AVNef/RUj+6PQHdzV3wRUVnpbKQS4D0/x6Xjs2DW1NpcDGFInzm
 9Ip2V5IilVV67sZqDkdpOinKi0KCJC9gCIbbQwPTc7MNGaME3tJPIYZNNwwYjteSNYBIHrBxD
 goGz4eXSe5/t7IkWRbNGW9LDfZKBVnP8XadMzLLxAzXb1pzrFtRddy3a8nt01m7a2IQnKxz+V
 RcCRvg2utwP+oXP4GHh6Y8TmGR/QwtrH7eDz3ekLPp6ypTpCTZ8gDDjvbvFYxQ2qmh1KyPuc4
 ulICOeZrM18R4epSZ6WbtICP2TOXaLOojty3yJ+ktnXpuw4TeOsGU/nuvumYBVnnOobtAn6GJ
 3jazxHtODLyBK8LmpItST4rqwBMsNJfJXCW5+uIrX/1aiIFW0SsqDt/bU/z+X1tVggd1JBIuc
 u97TFXtqcRjVd5QdTkHbw+peJPnxwnSpfg2Zdwr+jJqXKS3nG2u0BOIYH7/HCkog86MgdRpci
 JxW5ZZpe1wifo+hTpHIQlevGwEFURQvTF+a6lXx2lwgrABuSSo/NV7hzQJHe5k4U52E5OPIWX
 ApGAxbh6QGeozSN8hBSfO/yNj1lZCT55dyIWTpxZQSyt/qyxA4/YSQOYAXxCH2PnqQPP2wfz1
 tlUaaa/ElI+GjcQb/vRRnDjXAip6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already handle PuTTY's plink and TortoiseGit's tortoiseplink in
GIT_SSH by automatically using the -P option to specify ports, and in
tortoiseplink's case by passing the --batch option.

For users who need to pass additional command-line options to plink,
this poses a problem: the only way to do that is to use GIT_SSH_COMMAND,
but Git does not handle that specifically, so those users have to
manually parse the command-line options passed via GIT_SSH_COMMAND and
replace -p (if present) by -P, and add --batch in the case of
tortoiseplink.

This is error-prone and a bad user experience.

To fix this, the changes proposed in this patch series introduce
handling this by splitting the GIT_SSH_COMMAND value and treating the
first parameter with the same grace as GIT_SSH. To counter any possible
misdetection, the user can also specify explicitly via GIT_SSH_VARIANT
or ssh.variant which SSH variant they are using.

Changes relative to v2:

- touched up the documentation for ssh.variant to make it even easier to
  understand

- free()d the config variable

- completely refactored the code to fulfil Junio's burning desire to
  avoid split_cmdline() when unnecessary

It is quite preposterous to call this an "iteration" of the patch
series, because the code is so different now. I say this because I want
to caution that this code has not been tested as thoroughly, by far, as
the first iteration.

The primary purpose of code review is correctness, everything else is
either a consequence of it, or a means to make reviewing easier.

That means that I highly encourage those who pushed for these extensive
changes that make the patch series a lot less robust to balance things
out by at least *rudimentary* testing.


Johannes Schindelin (1):
  git_connect(): factor out SSH variant handling

Junio C Hamano (1):
  connect: rename tortoiseplink and putty variables

Segev Finer (2):
  connect: handle putty/plink also in GIT_SSH_COMMAND
  connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config

 Documentation/config.txt | 11 +++++++
 Documentation/git.txt    |  6 ++++
 connect.c                | 75 ++++++++++++++++++++++++++++++++++++------------
 t/t5601-clone.sh         | 41 ++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 19 deletions(-)


base-commit: 8f60064c1f538f06e1c579cbd9840b86b10bcd3d
Published-As: https://github.com/dscho/git/releases/tag/putty-w-args-v3
Fetch-It-Via: git fetch https://github.com/dscho/git putty-w-args-v3

Interdiff vs v2:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index f2c210f0a0..b88df57ab6 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1950,11 +1950,15 @@ matched against are those given directly to Git commands.  This means any URLs
  visited as a result of a redirection do not participate in matching.
  
  ssh.variant::
 -	Override the autodetection of plink/tortoiseplink in the SSH
 -	command that 'git fetch' and 'git push' use. It can be set to
 -	either `ssh`, `plink`, `putty` or `tortoiseplink`. Any other
 -	value will be treated as normal ssh. This is useful in case
 -	that Git gets this wrong.
 +	Depending on the value of the environment variables `GIT_SSH` or
 +	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
 +	auto-detects whether to adjust its command-line parameters for use
 +	with plink or tortoiseplink, as opposed to the default (OpenSSH).
 ++
 +The config variable `ssh.variant` can be set to override this auto-detection;
 +valid values are `ssh`, `plink`, `putty` or `tortoiseplink`. Any other value
 +will be treated as normal ssh. This setting can be overridden via the
 +environment variable `GIT_SSH_VARIANT`.
  
  i18n.commitEncoding::
  	Character encoding the commit messages are stored in; Git itself
 diff --git a/Documentation/git.txt b/Documentation/git.txt
 index c322558aa7..a0c6728d1a 100644
 --- a/Documentation/git.txt
 +++ b/Documentation/git.txt
 @@ -1021,11 +1021,10 @@ personal `.ssh/config` file.  Please consult your ssh documentation
  for further details.
  
  `GIT_SSH_VARIANT`::
 -	If this environment variable is set, it overrides the autodetection
 -	of plink/tortoiseplink in the SSH command that 'git fetch' and 'git
 -	push' use. It can be set to either `ssh`, `plink`, `putty` or
 -	`tortoiseplink`. Any other value will be treated as normal ssh. This
 -	is useful in case that Git gets this wrong.
 +	If this environment variable is set, it overrides Git's autodetection
 +	whether `GIT_SSH`/`GIT_SSH_COMMAND`/`core.sshCommand` refer to OpenSSH,
 +	plink or tortoiseplink. This variable overrides the config setting
 +	`ssh.variant` that serves the same purpose.
  
  `GIT_ASKPASS`::
  	If this environment variable is set, then Git commands which need to
 diff --git a/connect.c b/connect.c
 index 7b4437578b..7f1f802396 100644
 --- a/connect.c
 +++ b/connect.c
 @@ -691,20 +691,45 @@ static const char *get_ssh_command(void)
  	return NULL;
  }
  
 -static int handle_ssh_variant(int *port_option, int *needs_batch)
 +static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 +			      int *port_option, int *needs_batch)
  {
 -	const char *variant;
 +	const char *variant = getenv("GIT_SSH_VARIANT");
 +	char *p = NULL;
 +
 +	if (variant)
 +		; /* okay, fall through */
 +	else if (!git_config_get_string("ssh.variant", &p))
 +		variant = p;
 +	else if (!is_cmdline) {
 +		p = xstrdup(ssh_command);
 +		variant = basename(p);
 +	} else {
 +		const char **ssh_argv;
  
 -	if (!(variant = getenv("GIT_SSH_VARIANT")) &&
 -		git_config_get_string_const("ssh.variant", &variant))
 -		return 0;
 +		p = xstrdup(ssh_command);
 +		if (split_cmdline(p, &ssh_argv)) {
 +			variant = basename((char *)ssh_argv[0]);
 +			/*
 +			 * At this point, variant points into the buffer
 +			 * referenced by p, hence we do not need ssh_argv
 +			 * any longer.
 +			 */
 +			free(ssh_argv);
 +		} else
 +			return 0;
 +	}
  
 -	if (!strcmp(variant, "plink") || !strcmp(variant, "putty"))
 +	if (!strcasecmp(variant, "plink") ||
 +	    !strcasecmp(variant, "plink.exe") ||
 +	    !strcasecmp(variant, "putty"))
  		*port_option = 'P';
 -	else if (!strcmp(variant, "tortoiseplink")) {
 +	else if (!strcasecmp(variant, "tortoiseplink") ||
 +		 !strcasecmp(variant, "tortoiseplink.exe")) {
  		*port_option = 'P';
  		*needs_batch = 1;
  	}
 +	free(p);
  
  	return 1;
  }
 @@ -791,7 +816,6 @@ struct child_process *git_connect(int fd[2], const char *url,
  			int port_option = 'p';
  			char *ssh_host = hostandport;
  			const char *port = NULL;
 -			char *ssh_argv0 = NULL;
  			transport_check_allowed("ssh");
  			get_host_and_port(&ssh_host, &port);
  
 @@ -812,15 +836,10 @@ struct child_process *git_connect(int fd[2], const char *url,
  			}
  
  			ssh = get_ssh_command();
 -			if (ssh) {
 -				char *split_ssh = xstrdup(ssh);
 -				const char **ssh_argv;
 -
 -				if (split_cmdline(split_ssh, &ssh_argv))
 -					ssh_argv0 = xstrdup(ssh_argv[0]);
 -				free(split_ssh);
 -				free((void *)ssh_argv);
 -			} else {
 +			if (ssh)
 +				handle_ssh_variant(ssh, 1, &port_option,
 +						   &needs_batch);
 +			else {
  				/*
  				 * GIT_SSH is the no-shell version of
  				 * GIT_SSH_COMMAND (and must remain so for
 @@ -831,26 +850,12 @@ struct child_process *git_connect(int fd[2], const char *url,
  				ssh = getenv("GIT_SSH");
  				if (!ssh)
  					ssh = "ssh";
 -
 -				ssh_argv0 = xstrdup(ssh);
 +				else
 +					handle_ssh_variant(ssh, 0,
 +							   &port_option,
 +							   &needs_batch);
  			}
  
 -			if (!handle_ssh_variant(&port_option, &needs_batch) &&
 -			    ssh_argv0) {
 -				const char *base = basename(ssh_argv0);
 -
 -				if (!strcasecmp(base, "tortoiseplink") ||
 -				    !strcasecmp(base, "tortoiseplink.exe")) {
 -					port_option = 'P';
 -					needs_batch = 1;
 -				} else if (!strcasecmp(base, "plink") ||
 -					   !strcasecmp(base, "plink.exe")) {
 -					port_option = 'P';
 -				}
 -			}
 -
 -			free(ssh_argv0);
 -
  			argv_array_push(&conn->args, ssh);
  			if (flags & CONNECT_IPV4)
  				argv_array_push(&conn->args, "-4");

-- 
2.11.1.windows.prerelease.2.9.g3014b57

