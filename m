Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91611F453
	for <e@80x24.org>; Thu, 18 Oct 2018 21:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeJSFSt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 01:18:49 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36677 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeJSFSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 01:18:49 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so2187840itd.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4MNgtrLPhDuMHHK0vkdtggUkadOmmLMfoHbH9DVwMB4=;
        b=NwsGxtUqjCI9q5QHrPAqf02+GTMt5A/zNQqbf6P/k4VjDesDTtDVXBYqif8jkL/b9z
         Cht7zWoFhXXd3uAD9JhEQVRPLocB1GDsiA6NGbHjSD8maceApgms0kw21PETz9lsIcUn
         MHG2uJl1fkjynInpA/nuQbaLps1kV/qWLSYaV72/jUdqHXOvKnVarewlEUoJZWbLdAqA
         8DtG+o7GdhQyL/I7rWKQqU8miC2uhVxqkNOy/jD7U9NZe34C5KY4H1UQzTs943i5x7WN
         idb6WnjLSuUMcfCg0OKCCQRo47+71cpiW2ipT6ZMDtG1uke+/01LUqVSSVTXRm4rvOas
         SaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4MNgtrLPhDuMHHK0vkdtggUkadOmmLMfoHbH9DVwMB4=;
        b=kRY89pFSSEzOz00B8q7u1n+SBOKIQWz54+gxyrlXMtm3WtbfJqn+cKGdcEh3gZmWrC
         Jo3zLvm0SaDYRfZ07oXO93H73SkJZoA19aZ6Dgn6YU45OIUtoUiuGkydg8kCOvGpo1PW
         G+4tGI5iJGjUBAlmlFyspgomzb/l2Y5i3BnncZnjMPsOyurPM52QbhXkrQhAI9Ekl8KC
         E99ThP0Diix865s33RzJbHkKV7s2OMT7mJtTDVQo5+5GfUbMfIlYBrhrGfuRzM2aFChz
         /PPsDDfi+txsJGXOvF0xLZkn2v7+YFszhtxJjmAldbv1d4ya9MbJMO6eDxVcD7LbktbG
         gXSA==
X-Gm-Message-State: ABuFfoj7ZA7qdrZg6BvSTmEieiFArNsiWi99GIuU4T5DeV/Mi5BgQBY1
        7NWZXHAlq9vN3ndu6sUyo5nYs67Y
X-Google-Smtp-Source: ACcGV62YRU+0L9gQcKhQkbi74RXNGG3etNTcPdMCQlgt8A9QjqD0AShO+vJaBZ9dtBjeG7ovBW9x4Q==
X-Received: by 2002:a24:d30d:: with SMTP id n13-v6mr1475458itg.97.1539897355093;
        Thu, 18 Oct 2018 14:15:55 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id g18-v6sm6640593iob.79.2018.10.18.14.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 14:15:54 -0700 (PDT)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To:     git@vger.kernel.org
Cc:     Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH] send-email: explicitly disable authentication
Date:   Thu, 18 Oct 2018 16:15:27 -0500
Message-Id: <20181018211527.25597-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be necessary to disable SMTP authentication by a mechanism other
than sendemail.smtpuser being undefined. For example, if the user has
sendemail.smtpuser set globally but wants to disable authentication
locally in one repository.

--smtp-auth and sendemail.smtpauth now understand the value 'none' which
means to disable authentication completely, even if an authentication
user is specified.

The value 'none' is lower case to avoid conflicts with any RFC 4422
authentication mechanisms.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 Documentation/git-send-email.txt | 4 +++-
 git-send-email.perl              | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 465a4ecbe..751a4851e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -190,7 +190,9 @@ $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
 If at least one of the specified mechanisms matches the ones advertised by the
 SMTP server and if it is supported by the utilized SASL library, the mechanism
 is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
-is specified, all mechanisms supported by the SASL library can be used.
+is specified, all mechanisms supported by the SASL library can be used. The
+special value 'none' maybe specified to completely disable authentication
+independently of `--smtp-user`
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac33..4a74cd350 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -82,7 +82,8 @@ sub usage {
                                      Pass an empty string to disable certificate
                                      verification.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
-    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms.
+    --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
+                                     "none" to disable authentication.
                                      This setting forces to use one of the listed mechanisms.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
@@ -1241,7 +1242,7 @@ sub smtp_host_string {
 # (smtp_user was not specified), and 0 otherwise.
 
 sub smtp_auth_maybe {
-	if (!defined $smtp_authuser || $auth) {
+	if (!defined $smtp_authuser || $auth || $smtp_auth eq "none") {
 		return 1;
 	}
 
-- 
2.17.1

