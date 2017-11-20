Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84A9202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbdKTVXB (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:23:01 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:39862 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbdKTVW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:22:58 -0500
Received: by mail-it0-f66.google.com with SMTP id x13so3562629iti.4
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2fdmRfAUwM3Zx5C1LeP6gTU0i3csJuwIy//nT6lse0=;
        b=b8WWGNkP/lpCzIMEOqkb8VNisxyrJt0SctbXbTui57Ejn8jIIjCPv/lXEZXl2S9OZH
         gGgTC483kBATyYe3LBIDmgxb8ZFRSIzh9affnvoCCfsITtz3l4LT3qL9b1QW/Au8g3f9
         ACuHCgPtMxCMSM4aoX8jkrYvo71GTFGpxMJqIrG0MLHpAhjL0D2Yr3vXuM5BUbM6LIdy
         Cbixx/lgpblnkjXBOWprnGzEWU7qpqdNQCQgAbi4NYmn9hOQSf4P4+RVJ9g/E+BcZhSI
         CsXXL8OgS6me24xW0X/amp0xe650Yq/P5/35s6qOSbAai/tcNJjQPkRbxjkKpl27eHzC
         hCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2fdmRfAUwM3Zx5C1LeP6gTU0i3csJuwIy//nT6lse0=;
        b=DF4kLmJqTBxAOLF8WeLRzap28iFqwF0qbquBjqEgVEnIA169jSJafPVk75J+97dWe2
         F3RaUJbKYxsw8fHjLGf1ImTImtmOPIUyXc0mDCAGlSd7b3a7aRr2ZkDfJBoRmpL5a56k
         AEvQPLoGhZgn3r63VrKhYI9cQum2GFu6JMdiMZfbqujfJcmyEiuPo6ICNVav84CtE8uH
         NBSGk3aTihI/V9QzM700SolWngjQajN8fSDPSa0i8bFOIT2pyTdrqkARWk0iAABV5BbB
         5/M8QhKpmYpvG47B0XmE2lunMMlRoyHIGt6K4eKXHh/+n6td+xVasWIA80ounJJuTTbl
         NkCg==
X-Gm-Message-State: AJaThX5v60GiohZ1YKzHyT28l7+Vsv9PepeYreQzipbZtb0m41gIt0Bx
        E9GaseNLxwGbZQAY1ChFYDscf6rZ
X-Google-Smtp-Source: AGs4zMbk/Hy5HcrQG+Wj4nMh2fz2b2tMNmHpNJryE/jzoLO16Eeky+qnbbfMwmsQd/dPg9x9I00Jsg==
X-Received: by 10.36.230.3 with SMTP id e3mr20445551ith.15.1511212977343;
        Mon, 20 Nov 2017 13:22:57 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m87sm1122001ioi.2.2017.11.20.13.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:22:56 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:22:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 2/8] connect: move no_fork fallback to git_tcp_connect
Message-ID: <20171120212254.ab6ata2mwvdbbdmw@aiede.mtv.corp.google.com>
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

git_connect has the structure

	struct child_process *conn = &no_fork;

	...
	switch (protocol) {
	case PROTO_GIT:
		if (git_use_proxy(hostandport))
			conn = git_proxy_connect(fd, hostandport);
		else
			git_tcp_connect(fd, hostandport, flags);
		...
		break;
	case PROTO_SSH:
		conn = xmalloc(sizeof(*conn));
		child_process_init(conn);
		argv_array_push(&conn->args, ssh);
		...
		break;
	...
	return conn;

In all cases except the git_tcp_connect case, conn is explicitly
assigned a value. Make the code clearer by explicitly assigning
'conn = &no_fork' in the tcp case and eliminating the default so the
compiler can ensure conn is always correctly assigned.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/connect.c b/connect.c
index 7fbd396b35..aa994d1518 100644
--- a/connect.c
+++ b/connect.c
@@ -582,12 +582,25 @@ static int git_tcp_connect_sock(char *host, int flags)
 #endif /* NO_IPV6 */
 
 
-static void git_tcp_connect(int fd[2], char *host, int flags)
+/*
+ * Dummy child_process returned by git_connect() if the transport protocol
+ * does not need fork(2).
+ */
+static struct child_process no_fork = CHILD_PROCESS_INIT;
+
+int git_connection_is_socket(struct child_process *conn)
+{
+	return conn == &no_fork;
+}
+
+static struct child_process *git_tcp_connect(int fd[2], char *host, int flags)
 {
 	int sockfd = git_tcp_connect_sock(host, flags);
 
 	fd[0] = sockfd;
 	fd[1] = dup(sockfd);
+
+	return &no_fork;
 }
 
 
@@ -761,8 +774,6 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	return protocol;
 }
 
-static struct child_process no_fork = CHILD_PROCESS_INIT;
-
 static const char *get_ssh_command(void)
 {
 	const char *ssh;
@@ -851,11 +862,11 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 }
 
 /*
- * This returns a dummy child_process if the transport protocol does not
- * need fork(2), or a struct child_process object if it does.  Once done,
- * finish the connection with finish_connect() with the value returned from
- * this function (it is safe to call finish_connect() with NULL to support
- * the former case).
+ * This returns the dummy child_process `no_fork` if the transport protocol
+ * does not need fork(2), or a struct child_process object if it does.  Once
+ * done, finish the connection with finish_connect() with the value returned
+ * from this function (it is safe to call finish_connect() with NULL to
+ * support the former case).
  *
  * If it returns, the connect is successful; it just dies on errors (this
  * will hopefully be changed in a libification effort, to return NULL when
@@ -865,7 +876,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
-	struct child_process *conn = &no_fork;
+	struct child_process *conn;
 	enum protocol protocol;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -901,7 +912,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		if (git_use_proxy(hostandport))
 			conn = git_proxy_connect(fd, hostandport);
 		else
-			git_tcp_connect(fd, hostandport, flags);
+			conn = git_tcp_connect(fd, hostandport, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
@@ -1041,11 +1052,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 	return conn;
 }
 
-int git_connection_is_socket(struct child_process *conn)
-{
-	return conn == &no_fork;
-}
-
 int finish_connect(struct child_process *conn)
 {
 	int code;
-- 
2.15.0.448.gf294e3d99a

