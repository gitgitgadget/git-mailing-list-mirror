Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA69202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdJWVaU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:30:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:47206 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdJWVaT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:30:19 -0400
Received: by mail-it0-f67.google.com with SMTP id p138so7632516itp.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iZ/w3IDPTdRugX4WWCPKYYXrKjIzdEpMT4WL2gguEg=;
        b=ko+22WFNHtIlAwvKScsCMs2iQRSANbXIYNIW0Olr/S2B/EZ9d3m1WpUIQGuiB3e6XI
         Uk7FxnsH+zFTK5fYwDx3D7BAKXaZclXwR9dbjQHo5lSZVKFe/JXTLVa39DUh0C8KIspV
         mj9pp3W+rNiM6OdxCH/vwzzDFqAfAa/3qlgpSFo+CjLln8LfUq8KkEA8SdfVdu2n13Qg
         lHCkPAhCFVbrwgtV+C7S7NhUX82FKltmlNoaG34F1DKH2s32/oJGfUvb+BmQYPhI8UP7
         cbder9lmLJRSSKFDhsTEvtcJrY/ngD/r8hNNWDciImBZeODpx3Ykc3ePIE7uDCSfd9yx
         el6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iZ/w3IDPTdRugX4WWCPKYYXrKjIzdEpMT4WL2gguEg=;
        b=lTDnDLxr7AFblAB+GNZxqpn2JeO6l+rtNwfmDe3Wg6ZTA4zxC/XCDfxPXBrr9kt7hL
         yMxnmeNQhs2jvZyzduQUq/kv6SpdP1VNLWBn5mQlNHAuMNSnv+Y0CMB36MCdBJQmqGi7
         jwLgv4l2uEOPSOiUFweiHijA4i/oh3eDsfcZPy+7gGWQ0BpIF6w365ilJIGwwplF2Cai
         v1MGcFqHm45OfNfDmxWE+6cs+UTDPkJTq21YhsqiA9+pWfxR32kfpPh+66HBkLcLJ9r5
         oFOmBUR0NdnNDvXfCMfunTajjy/0stEVoekoMuAFvk9sfewJV2bLesNIKRveLa1mWHXS
         2rVg==
X-Gm-Message-State: AMCzsaWCxrqXeY1DRnnSrNNUeCIbGS6f2K8bvrxm1DQq+S8oyqTAcCOi
        pVot/EdAEce3iJ2BwFrD9b4=
X-Google-Smtp-Source: ABhQp+ThNKpKv9vuMAMFOuxFNXLu8s+zgdOPJlCoxRlc+t98e9e2QPDrNmuLsWYXuTFWMocdi6Uhwg==
X-Received: by 10.36.44.200 with SMTP id i191mr10920707iti.120.1508794218928;
        Mon, 23 Oct 2017 14:30:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l206sm2866189ita.29.2017.10.23.14.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:30:18 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:30:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com, William Yan <wyan@google.com>
Subject: [PATCH 2/5] connect: split ssh command line options into separate
 function
Message-ID: <20171023213016.4eakv4fok2mfjt6e@aiede.mtv.corp.google.com>
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

The git_connect function is growing long.  Split the portion that
discovers an ssh command and options it accepts before the service
name and path to a separate function to make it easier to read.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c | 116 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/connect.c b/connect.c
index 068e70caad..77ab6db3bb 100644
--- a/connect.c
+++ b/connect.c
@@ -908,6 +908,65 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 	return conn;
 }
 
+/* Prepare a child_process for use by Git's SSH-tunneled transport. */
+static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
+			  const char *port, int flags)
+{
+	const char *ssh;
+	enum ssh_variant variant;
+
+	if (looks_like_command_line_option(ssh_host))
+		die("strange hostname '%s' blocked", ssh_host);
+
+	ssh = get_ssh_command();
+	if (ssh) {
+		variant = determine_ssh_variant(ssh, 1);
+	} else {
+		/*
+		 * GIT_SSH is the no-shell version of
+		 * GIT_SSH_COMMAND (and must remain so for
+		 * historical compatibility).
+		 */
+		conn->use_shell = 0;
+
+		ssh = getenv("GIT_SSH");
+		if (!ssh)
+			ssh = "ssh";
+		variant = determine_ssh_variant(ssh, 0);
+	}
+
+	argv_array_push(&conn->args, ssh);
+
+	if (variant == VARIANT_SSH &&
+	    get_protocol_version_config() > 0) {
+		argv_array_push(&conn->args, "-o");
+		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
+		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+				 get_protocol_version_config());
+	}
+
+	if (variant != VARIANT_SIMPLE) {
+		if (flags & CONNECT_IPV4)
+			argv_array_push(&conn->args, "-4");
+		else if (flags & CONNECT_IPV6)
+			argv_array_push(&conn->args, "-6");
+	}
+
+	if (variant == VARIANT_TORTOISEPLINK)
+		argv_array_push(&conn->args, "-batch");
+
+	if (port && variant != VARIANT_SIMPLE) {
+		if (variant == VARIANT_SSH)
+			argv_array_push(&conn->args, "-p");
+		else
+			argv_array_push(&conn->args, "-P");
+
+		argv_array_push(&conn->args, port);
+	}
+
+	argv_array_push(&conn->args, ssh_host);
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -961,16 +1020,13 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh;
-			enum ssh_variant variant;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
-
 			if (!port)
 				port = get_port(ssh_host);
-
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
@@ -984,57 +1040,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
-
-			if (looks_like_command_line_option(ssh_host))
-				die("strange hostname '%s' blocked", ssh_host);
-
-			ssh = get_ssh_command();
-			if (ssh) {
-				variant = determine_ssh_variant(ssh, 1);
-			} else {
-				/*
-				 * GIT_SSH is the no-shell version of
-				 * GIT_SSH_COMMAND (and must remain so for
-				 * historical compatibility).
-				 */
-				conn->use_shell = 0;
-
-				ssh = getenv("GIT_SSH");
-				if (!ssh)
-					ssh = "ssh";
-				variant = determine_ssh_variant(ssh, 0);
-			}
-
-			argv_array_push(&conn->args, ssh);
-
-			if (variant == VARIANT_SSH &&
-			    get_protocol_version_config() > 0) {
-				argv_array_push(&conn->args, "-o");
-				argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-						 get_protocol_version_config());
-			}
-
-			if (variant != VARIANT_SIMPLE) {
-				if (flags & CONNECT_IPV4)
-					argv_array_push(&conn->args, "-4");
-				else if (flags & CONNECT_IPV6)
-					argv_array_push(&conn->args, "-6");
-			}
-
-			if (variant == VARIANT_TORTOISEPLINK)
-				argv_array_push(&conn->args, "-batch");
-
-			if (port && variant != VARIANT_SIMPLE) {
-				if (variant == VARIANT_SSH)
-					argv_array_push(&conn->args, "-p");
-				else
-					argv_array_push(&conn->args, "-P");
-
-				argv_array_push(&conn->args, port);
-			}
-
-			argv_array_push(&conn->args, ssh_host);
+			fill_ssh_args(conn, ssh_host, port, flags);
 		} else {
 			transport_check_allowed("file");
 			if (get_protocol_version_config() > 0) {
-- 
2.15.0.rc1.287.g2b38de12cc

