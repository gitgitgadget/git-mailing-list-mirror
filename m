Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80AC8202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdKTWT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:19:57 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:45257 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdKTWTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:19:47 -0500
Received: by mail-it0-f66.google.com with SMTP id x13so5407368iti.4
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDVpP8e7PRYJWw87Er+MISP+qPkwgsSglBN6TCjleik=;
        b=W12tSwgg+pgRVvq0N91mwe6a4Zy/CTHFUCWFjdw1IWxde2FjCxTx6f2DaaYnz9ydtx
         OaQ14x4dJJ1c3CABHAgwSwY8xuBrY1VhTTGwnAHEpLv3qA35dELsH+Et+lJcBezRIl5f
         oT1ROkeTao8usy3BLm0cMZcUTwZQ9Mo0kZIeGmDwwISuNyfTHkzq9dBvAcMK38MqYn7z
         qlUjmd5PNiKU6OO9fYIeRrpHQif2XI7sUBHAyz6nMo2czBpxOErrAEzWIWwXDlpIf7aT
         ZKekoH0k+bTHTxx9CP46CpbMfJxVYebfgn3b/Xh7sBIUyZsFMsJiubihumVZuZKGEzST
         0j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDVpP8e7PRYJWw87Er+MISP+qPkwgsSglBN6TCjleik=;
        b=N58qABCY8Er2RhK718093GsEFEs+rehGw2+tqcpT5Tw2/YQrXvnq3KO1gWPZfk8siQ
         BZV93A6pHSz2eQ7PMrFETlRv43h2oShIjSmjJ+TATBRJetxGFtAVSSekppcFdXWxjLeu
         H7Bcwi1gBVqtzMei5683zpMmGYzpnAcXRIcbkpcO5UXLG8AJFMamVEF/mdji/Kf3Ocgo
         r+hWkSENXJ7KDyodq4s5FKpGcaMLzhug7u1TMI85XD365CQZ04NcIeVZvBCGIqgwdgQ2
         th0T4+4ii/co+SRauloXszp7B6fy6JtQim2e1zpDNNnwRgsg4IgI8RiXI/w6zGD9ZkFV
         8EEA==
X-Gm-Message-State: AJaThX7UML7oKC6hEWzBYEWvXbdq7D9X7pIKy8gFNXDfW0LUT0kLTLzV
        3kTDTnM52N5eX4A7RSfvlrU=
X-Google-Smtp-Source: AGs4zMY4vM8thBRFIxAkUerOHEvv2nJyCX4hfiki4WgKZ/X1qnZPdPmjWQSfRY7Ttm8/+EoerRAWOQ==
X-Received: by 10.36.6.142 with SMTP id 136mr20043967itv.121.1511216385762;
        Mon, 20 Nov 2017 14:19:45 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n68sm4938159ion.57.2017.11.20.14.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 14:19:45 -0800 (PST)
Date:   Mon, 20 Nov 2017 14:19:43 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH v4 4/8] connect: split ssh command line options into separate
 function
Message-ID: <20171120221943.5slenc6lovg73kif@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212505.5t6vzvkfvhmjqwsd@aiede.mtv.corp.google.com>
 <20171120215404.GC92506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120215404.GC92506@google.com>
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
Reviewed-by: Stefan Beller <sbeller@google.com>
---
Brandon Williams wrote:
> On 11/20, Jonathan Nieder wrote:

>> @@ -972,16 +1031,13 @@ struct child_process *git_connect(int fd[2], const char *url,
>>  		conn->use_shell = 1;
>>  		conn->in = conn->out = -1;
>>  		if (protocol == PROTO_SSH) {
>> -			const char *ssh;
>> -			enum ssh_variant variant;
>>  			char *ssh_host = hostandport;
>>  			const char *port = NULL;
>> +
>>  			transport_check_allowed("ssh");
>>  			get_host_and_port(&ssh_host, &port);
>> -
>>  			if (!port)
>>  				port = get_port(ssh_host);
>> -
>
> Are these random additions and deletions intentional?

Thanks again for noticing this.  After looking more closely, I don't
see any reason for these whitespace changes.  Here's a corrected
patch.

 connect.c | 113 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 60 insertions(+), 53 deletions(-)

diff --git a/connect.c b/connect.c
index 9425229206..2113feb4f8 100644
--- a/connect.c
+++ b/connect.c
@@ -919,6 +919,65 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
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
  * This returns the dummy child_process `no_fork` if the transport protocol
  * does not need fork(2), or a struct child_process object if it does.  Once
@@ -972,8 +1031,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh;
-			enum ssh_variant variant;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			transport_check_allowed("ssh");
@@ -995,57 +1052,7 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.15.0.448.gf294e3d99a

