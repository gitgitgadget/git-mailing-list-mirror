Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5341FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754488AbdCMRXB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:23:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36209 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdCMRWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:22:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id n37so7043728qtb.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=O3kWyHC1Z85Xh4/uyZlxt7WdvXFQrEfMtqJ+ZoVS68g=;
        b=EFuxknjGs2D5dIRXU28lGR31Rj33lZVkMbA+BdkTL0s+2gzt275SRuB3b3TO8u/aDf
         1po/SSM5YWPaYthFgktSNdgeSaqIGs6VKd86wRrCvWmv/21x8nGwDcoLUCkwlUL4+dEV
         6ToqBXNhe8WGiNDTbTgv4Ua6zBY7G4YTn08QQ3tlJP2+0zK0arII1zvFx4+KwKD8eaoz
         GAl3a8mkTefJuENYTMc8hyuwpGNLl9qmEVdHkJR5SqsBD3x2NHmtvNeUx4ADWEdIirvZ
         rYM8fPSx/03yByw3dFRBq3eafr8ObNBkUkmU1XlbhT8h8Ub5D7qKiXMIAWdhU6pPvMil
         2KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=O3kWyHC1Z85Xh4/uyZlxt7WdvXFQrEfMtqJ+ZoVS68g=;
        b=B0AFjUahQQjsJplS5mD7+RccKFIQ2y9LOvmrS+w1J4oSVWy+qZJhg2Qp/5fhedgu9+
         XSF9fOwgCPrCUq7E3kI9ESVoz9aEsamDLqpl9itE8bj+D0QMo441lABCu7Nr6n6dv1Dh
         ThACxPYrcYMUTynbOQtCRDJJp3bqVfrsUzCLUuVCQN0+u/Ls4Y3qZQ/AiuCUoV0OYHTy
         jSlr7UPLLghTdMpsxqFCWjrV/YBqMw4baYyCKhGrBfCWgpAwNTxiDFh+gaIyOAlj1lfN
         m+zX1loPLaUjTjPHVnLBNTNA2u8iMBRHH/zkfYxGumgaTEyh8h1LSNgbYY0uJhDTn266
         BtNw==
X-Gm-Message-State: AMke39nVYEHvjcBX+oBiHcD7A4gCM+u2XJZmydBMNDiif/ejm75T4/NBuLvMReVgT63ttQ==
X-Received: by 10.200.41.176 with SMTP id 45mr36332425qts.26.1489425772208;
        Mon, 13 Mar 2017 10:22:52 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-821.cit.cornell.edu. [128.84.127.53])
        by smtp.googlemail.com with ESMTPSA id n19sm12579114qtn.35.2017.03.13.10.22.51
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 10:22:51 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME for credentials
Date:   Mon, 13 Mar 2017 13:22:31 -0400
Message-Id: <20170313172232.96678-3-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170313172232.96678-1-lehmacdj@gmail.com>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-credential-cache will now use the socket
$XDG_CACHE_HOME/git/credential/socket if there is not already a socket
at ~/.git-credential-cache/socket. This ensures that if another process
already created a socket at the old location it will be used over the
new one if it exists.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 credential-cache.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/credential-cache.c b/credential-cache.c
index cc8a6ee19..75c917de7 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -83,6 +83,19 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
+static char* get_socket_path(void) {
+	char *home_socket;
+
+	home_socket = expand_user_path("~/.git_credential_cache/socket");
+	if (home_socket)
+		if (file_exists(home_socket))
+			return home_socket;
+		else
+			free(home_socket);
+
+	return xdg_cache_home("credential/socket");
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	char *socket_path = NULL;
@@ -106,7 +119,7 @@ int cmd_main(int argc, const char **argv)
 	op = argv[0];
 
 	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
+		socket_path = get_socket_path();
 	if (!socket_path)
 		die("unable to find a suitable socket path; use --socket");
 
-- 
2.11.0

