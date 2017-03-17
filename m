Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E492B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 12:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdCQMg7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 08:36:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33805 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdCQMg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 08:36:57 -0400
Received: by mail-qk0-f195.google.com with SMTP id v127so9563724qkb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTuw6H7X+0/CIRw5XvZLNPDDZFkvS1yq2qNKv4UMHxo=;
        b=quHiwriPZUxSTbalG/2s5IdInSd9p93//rVmqmkty5nO+l1ApAaNlDTnpHuHLRMVcF
         ue9uvak+knwRpf64aEnWkeN5N4qyq4Aw1lzjvV5/5Ynb/mwysNZsDu/F180brN1/r/ef
         hvufkSVvEsnnEMWTvPNu0vc5chrzjRF5/0KmW1t+Ez8Jjmt3+wv9pv57hW2dXgTiPjUq
         cPxcaVVXaAesavv11xSlCJjPfWHktipFhPgXUODb45P6ppWifLVBUJRb9nEXCSEhhDai
         jYGZRci0moMpGQrjVQQP46r18aoDhHBZuGXBe1JtITBsVHwAPwDm+MAzbu7S57c31LQa
         s96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTuw6H7X+0/CIRw5XvZLNPDDZFkvS1yq2qNKv4UMHxo=;
        b=RCQOiK4kxZjjzZ7YaL2Enq1cs2pCfJQRtNKEQaDO7HA3nmFhkK9qqftdbLegLbG96y
         GWWheOYUNuptJXIUrDy2f7X+H/rHDoditwCpsnOx1h7jz1C/Elg6ysTbACqmpjvyXVKC
         Ym+h0L21PrZlh/9aeFNS7wstLhjpjVHELORek+ZfzWZuS8uw0DO9cHKdSEZfmLxb/h4F
         A2RKhfR95m8k6CZFcb8ZLVMoohdp3Plc66RUUtuMIX6/Z6U76apDJh62l6gX9W027vJO
         4h0vOMDS4Ru7J+rpvvbJfqSvjf8oxEtBEuw6LViZtZCN3MWTiKjr1jIrlPmztoln2EEl
         CF5w==
X-Gm-Message-State: AFeK/H2dxpPOw024EVWB2dHs2jcaRYSK/9rq7XqJqV3kuc9+FxeAHLKsoBICkVIHImfdgw==
X-Received: by 10.55.175.195 with SMTP id y186mr12546641qke.26.1489754197293;
        Fri, 17 Mar 2017 05:36:37 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.googlemail.com with ESMTPSA id h33sm5811607qtc.42.2017.03.17.05.36.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 05:36:36 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [GSoC][PATCH v6 2/3] credential-cache: use XDG_CACHE_HOME for socket
Date:   Fri, 17 Mar 2017 08:36:33 -0400
Message-Id: <20170317123634.10863-2-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170317123634.10863-1-lehmacdj@gmail.com>
References: <20170317025315.84548-3-lehmacdj@gmail.com>
 <20170317123634.10863-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git-credential-cache follow the XDG base path specification by
default. This increases consistency with other applications and helps
keep clutter out of users' home directories.

Check the old socket location, ~/.git-credential-cache/, and use
~/.git-credential-cache/socket if that directory exists rather than
forcing users who have used `git credential-cache` before to migrate to
the new XDG compliant location.
Otherwise use the socket $XDG_CACHE_HOME/git/credential/socket following
XDG base path specification. Use the subdirectory credential/ in case
other files are cached under $XDG_CACHE_HOME/git/ in the future and to
make the socket's purpose clear.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 Documentation/git-credential-cache.txt | 11 +++++++----
 credential-cache.c                     | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 96208f822..2b8582639 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -33,10 +33,13 @@ OPTIONS
 --socket <path>::
 
 	Use `<path>` to contact a running cache daemon (or start a new
-	cache daemon if one is not started). Defaults to
-	`~/.git-credential-cache/socket`. If your home directory is on a
-	network-mounted filesystem, you may need to change this to a
-	local filesystem. You must specify an absolute path.
+	cache daemon if one is not started).
+	Defaults to `$XDG_CACHE_HOME/git/credential/socket` unless
+	`~/.git-credential-cache/` exists in which case
+	`~/.git-credential-cache/socket` is used instead.
+	If your home directory is on a network-mounted filesystem, you
+	may need to change this to a local filesystem. You must specify
+	an absolute path.
 
 CONTROLLING THE DAEMON
 ----------------------
diff --git a/credential-cache.c b/credential-cache.c
index cc8a6ee19..3cbd42001 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -83,6 +83,19 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
+static char *get_socket_path(void)
+{
+	struct stat sb;
+	char *old_dir, *socket;
+	old_dir = expand_user_path("~/.git-credential-cache");
+	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
+		socket = xstrfmt("%s/socket", old_dir);
+	else
+		socket = xdg_cache_home("credential/socket");
+	free(old_dir);
+	return socket;
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

