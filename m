Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67E0202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdJWV3V (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:29:21 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:53738 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdJWV3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:29:20 -0400
Received: by mail-io0-f194.google.com with SMTP id 189so21687993iow.10
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oooOD9cqRFxf11d/UWPqZ7uGwwzGw6Bfj4zIvJn/H7g=;
        b=GZINXRm1JVlU1wq1C88JShD0ZMLD+LjWV/50EI3P1Dvfdfplyufy8pzkoLOSI2JDt6
         9klswHW0Sm22bTYsgsQWoVtpZOi8CUm/xtzk98thY/PTOSqaUS5+bnvSm0jfnvdoKF8B
         dm+oD7cX70xGYyW1+4c28L3ipRM6f2pXM8dF6oQkSWdhtDyDpqmJXau3TJ/rtfdx5BBp
         CihUW0cWqrWAR6Unw+xcydvmRwo5JXR0NUiAHirfEmnGXuxopVV4Foc25BPZkWfmUydc
         V9ekL5+zpFGrRphfxKXplxiBVG/QW/OXXUgHz3N6a/kQb31HqhhHGtV95O6eX37CjHXT
         IK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oooOD9cqRFxf11d/UWPqZ7uGwwzGw6Bfj4zIvJn/H7g=;
        b=Voi5axwgWBw7aNtoCjK8UOxS2OZDb1zJdO0J3hq7cGFUVbG55R52eXGxRb3VO5q3Xm
         dCMro3etrUinWBDQ2T4/Q3lJf+UCCwYyIcM29fgEi2PYtWvRONEDaSaVElpUEFhZ9rpu
         jsQqodeZD11kQqHL+ivTbSrys781kQ7fz86nJg0EEcUwUdtfdl8syzZscdoQNac254pU
         Er4Ar9sGb09sdAeviDQ1si5CN89R0qERlePTRhMdXvBWy2nk09s6dPU5f9jpfCt1/Xse
         fu1rmQKN2iAHQzT3fz+bN9kPVPPyWAb46NuxD9EiM48wG8U/XrxnTPZ65z0paJFX78X1
         540g==
X-Gm-Message-State: AMCzsaX2xHJPLqYq0PKPrMF5YYto6wgMiOVWHSn17rukkZXnNUQXU5RN
        udg6Fo7PR0snj+P33QrTBmE=
X-Google-Smtp-Source: ABhQp+R9Dd+Er/ZLPgVZbmllCZfgd2N/IYEeRexDKszPj653GDIp2HvjXdTfnjlAx89TwfiFmDZmBA==
X-Received: by 10.107.20.130 with SMTP id 124mr19062302iou.36.1508794159345;
        Mon, 23 Oct 2017 14:29:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c141sm3256339ioc.81.2017.10.23.14.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:29:18 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:29:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com, William Yan <wyan@google.com>
Subject: [PATCH 1/5] connect: split git:// setup into a separate function
Message-ID: <20171023212916.4aarismli6io4ro6@aiede.mtv.corp.google.com>
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

The git_connect function is growing long.  Split the
PROTO_GIT-specific portion to a separate function to make it easier to
read.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c | 103 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/connect.c b/connect.c
index 7fbd396b35..068e70caad 100644
--- a/connect.c
+++ b/connect.c
@@ -850,6 +850,64 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 	return ssh_variant;
 }
 
+/*
+ * Open a connection using Git's native protocol.
+ *
+ * The caller is responsible for freeing hostandport, but this function may
+ * modify it (for example, to truncate it to remove the port part).
+ */
+static struct child_process *git_connect_git(int fd[2], char *hostandport,
+					     const char *path, const char *prog,
+					     int flags)
+{
+	struct child_process *conn = &no_fork;
+	struct strbuf request = STRBUF_INIT;
+	/*
+	 * Set up virtual host information based on where we will
+	 * connect, unless the user has overridden us in
+	 * the environment.
+	 */
+	char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
+	if (target_host)
+		target_host = xstrdup(target_host);
+	else
+		target_host = xstrdup(hostandport);
+
+	transport_check_allowed("git");
+
+	/* These underlying connection commands die() if they
+	 * cannot connect.
+	 */
+	if (git_use_proxy(hostandport))
+		conn = git_proxy_connect(fd, hostandport);
+	else
+		git_tcp_connect(fd, hostandport, flags);
+	/*
+	 * Separate original protocol components prog and path
+	 * from extended host header with a NUL byte.
+	 *
+	 * Note: Do not add any other headers here!  Doing so
+	 * will cause older git-daemon servers to crash.
+	 */
+	strbuf_addf(&request,
+		    "%s %s%chost=%s%c",
+		    prog, path, 0,
+		    target_host, 0);
+
+	/* If using a new version put that stuff here after a second null byte */
+	if (get_protocol_version_config() > 0) {
+		strbuf_addch(&request, '\0');
+		strbuf_addf(&request, "version=%d%c",
+			    get_protocol_version_config(), '\0');
+	}
+
+	packet_write(fd[1], request.buf, request.len);
+
+	free(target_host);
+	strbuf_release(&request);
+	return conn;
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -881,50 +939,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
-		struct strbuf request = STRBUF_INIT;
-		/*
-		 * Set up virtual host information based on where we will
-		 * connect, unless the user has overridden us in
-		 * the environment.
-		 */
-		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
-		if (target_host)
-			target_host = xstrdup(target_host);
-		else
-			target_host = xstrdup(hostandport);
-
-		transport_check_allowed("git");
-
-		/* These underlying connection commands die() if they
-		 * cannot connect.
-		 */
-		if (git_use_proxy(hostandport))
-			conn = git_proxy_connect(fd, hostandport);
-		else
-			git_tcp_connect(fd, hostandport, flags);
-		/*
-		 * Separate original protocol components prog and path
-		 * from extended host header with a NUL byte.
-		 *
-		 * Note: Do not add any other headers here!  Doing so
-		 * will cause older git-daemon servers to crash.
-		 */
-		strbuf_addf(&request,
-			    "%s %s%chost=%s%c",
-			    prog, path, 0,
-			    target_host, 0);
-
-		/* If using a new version put that stuff here after a second null byte */
-		if (get_protocol_version_config() > 0) {
-			strbuf_addch(&request, '\0');
-			strbuf_addf(&request, "version=%d%c",
-				    get_protocol_version_config(), '\0');
-		}
-
-		packet_write(fd[1], request.buf, request.len);
-
-		free(target_host);
-		strbuf_release(&request);
+		conn = git_connect_git(fd, hostandport, path, prog, flags);
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
-- 
2.15.0.rc1.287.g2b38de12cc

