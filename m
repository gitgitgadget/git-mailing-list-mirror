Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3595A20373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbdCNAdO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:33:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34187 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbdCNAdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:33:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id v125so39103615qkh.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 17:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=emcacjmdzOUmDtT3ElV89dOBWS8aBpg5n/J47sqSMjQ=;
        b=nUk17ZOJqT3cXU3PZOOO+HroxD6kTw3F0WTP3DmyfJBsbRjTzVEyYSO1fB7Al3yc0X
         /MKpNdj4l/BfASM8UNr53KPkdlOE1QG3Et5hNIYN5r9cPRt3VYGdJLLI+lappd/Hifl7
         rcHCP9GfA3yK3FBZz3ZT8BqHYmLTurh0bdoGCNOlC9zJ0opHh67SukTHF0cPN3onmgyS
         gjDXdo4sxV6NrGRuYMa/DydaHjmaGjMyZMZ1giisTnMYsGnF9vKwW/JlketaevK1qVgk
         Q8tY1mEDkNzazqzIQn5mru6uGHnse4xyVNPwJ8NYHb5rG70EDspcWuUTY4orSmqJdP5S
         31JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=emcacjmdzOUmDtT3ElV89dOBWS8aBpg5n/J47sqSMjQ=;
        b=TfYlCmUeerOv/scE5acC9ofE4y/Ciy5TtWxnUNtUugVxK4weH4KPw7lT7A9qh9Fy7M
         k2xt9EcK0ajgTp7pRlVO/slXK1Qn9wPPLUPdZJdV9eNHi6j9+15zvkm0W2wHOHmcYBNr
         bi3a4/3g01/O0h0kL4VZa9hLXVYTjFHX7Sd0OiRKaUYkuJxRR/3vofuuytTzvHeiWzsp
         Sq5dRhS5sbpu+DEKc7a18F1oveX/FuhrB82HwVE9aV4PY4q1OokktUHDMPtL651n4Ra0
         k5QFwfzp24zAiVvVjG7+PRHxWRzdHHqjkouefbEVDuUIcRv33J6V3IeqgHezaKBf3nBx
         VLSg==
X-Gm-Message-State: AFeK/H1eN1aUh7wa3+NFkaOWsU0EW0XDOu64ihBR7W/CQiwaQYSthTBPN3X1z/ba1wXFlg==
X-Received: by 10.55.190.69 with SMTP id o66mr33298221qkf.0.1489451591006;
        Mon, 13 Mar 2017 17:33:11 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.googlemail.com with ESMTPSA id z196sm13327954qkb.11.2017.03.13.17.33.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 17:33:10 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket if a socket
Date:   Mon, 13 Mar 2017 20:32:46 -0400
Message-Id: <20170314003246.71586-4-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170314003246.71586-1-lehmacdj@gmail.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create function is_socket.
Make get_socket_path return check if ~/.git-credential-cache/socket is a
socket and not just a file. If file_exists behavior could change in an
unexpected way. Additionally a file at ~/.git-credential-cache/socket
could cause false positives which would otherwise lead to crashes.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 credential-cache.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/credential-cache.c b/credential-cache.c
index db1343b46..63236adc2 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -83,12 +83,18 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
+static int is_socket(char *path) {
+	struct stat sb;
+	int ret = lstat(path, &sb);
+	return ret && S_IFSOCK(sb.st_mode);
+}
+
 static char *get_socket_path(void) {
 	char *home_socket;
 
 	home_socket = expand_user_path("~/.git-credential-cache/socket");
 	if (home_socket) {
-		if (file_exists(home_socket))
+		if (is_socket(home_socket))
 			return home_socket;
 		else
 			free(home_socket);
-- 
2.11.0

