Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B8FC47258
	for <git@archiver.kernel.org>; Fri,  1 May 2020 10:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2287B2192A
	for <git@archiver.kernel.org>; Fri,  1 May 2020 10:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLpBPSoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEAKwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728352AbgEAKwq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 06:52:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C025C08E859
        for <git@vger.kernel.org>; Fri,  1 May 2020 03:52:46 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h6so4534589qvz.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kAZzcEVp3VoAEoGZgzPUA++C4jHckFplg2x1cG1QvDs=;
        b=DLpBPSoT76Gf1CWHB2lZNNADLQ2xSXOHmnYJWToKY58YDGW4ZwXHM80PH1npWCa7rs
         wqL/0KdORqFGlo9eNKEgQGzL7HXYZgO1EI7xhXmxzjfwbfzPCWipMfFTdh3vcFfbTmA9
         kc9QhRVi45rrHXbl86HV9eJDYtpNo19+mJUhakI3kAppzSOrZakPY20jAdUBwK4M4fIT
         HzePu4IYamsueIEx0nazMzG69NoTdQr00e6K0pR7USHfEFXGP5sboBtwvH/U+YiiGACm
         MrucidgM/fbIsZN0318+ZkSIh30olQmbOj6tWfETYWUgLw/B1OoCjH6BOQRE8ZCbzDMZ
         AjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kAZzcEVp3VoAEoGZgzPUA++C4jHckFplg2x1cG1QvDs=;
        b=GfA0PN+5i9CtHMWNWFKTTdPfEX0tREI0gdLN+v7geKwAW/pjW0MEJWRgVDPm3tKyQA
         uMCf1rGfIub+wyPvD4ieJvbckGAhsCF+kGDS6/XsJUaXidjTz5691S0sSfLy3/5c3DYk
         r5TKQ43rjbh1dwKc49LRceOxJN7490XUBYO1piubbjnSzRjatbLV7BfeRYrFbigUb/Q5
         wqY1wsFHpElE9+qfftIqaeICsl/2b+Q7/rmhF57rrTk/uBFjlaOtUJi/Vo80vY8pXOKD
         5qVCVBm0tDSyEe3PP5XSkaE4QCRd/+W7n8td0PHzTviofmtdz+xjRwTn5OuTn3w3iKm+
         D3tA==
X-Gm-Message-State: AGi0PuZNAayxU2Nv8zkl8foKuYajWKxkeDKXqCg723ZmFN9Fow3/xFs8
        qe9jAlBo/0ODOq9xJkb2B6oyVVKg
X-Google-Smtp-Source: APiQypI1IxLyCUiGpb+8Cv9xK3bVVWvzKmdnFim0QwtxKtBTgaBUiJ0TOs6X38hsqZWaEMt12agmpw==
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr3457128qvz.45.1588330364236;
        Fri, 01 May 2020 03:52:44 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-207-208.dynamic.desktop.com.br. [179.125.207.208])
        by smtp.gmail.com with ESMTPSA id q32sm2514687qta.13.2020.05.01.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 03:52:43 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     git@vger.kernel.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH] send-email: Defines smtpPassCmd config option
Date:   Fri,  1 May 2020 07:51:31 -0300
Message-Id: <20200501105131.297457-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Defines smtpPassCmd config option, to allow the user to pass a command
that is used to output the password.

Its useful for users that store the password encrypted on disk, and
want a easy way to send-email without typing it again.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   |  5 +++--
 git-send-email.perl                | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 0006faf800..f71e58862d 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -34,6 +34,7 @@ sendemail.from::
 sendemail.multiEdit::
 sendemail.signedoffbycc::
 sendemail.smtpPass::
+sendemail.smtpPassCmd::
 sendemail.suppresscc::
 sendemail.suppressFrom::
 sendemail.to::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0a69810147..8e9da5ed64 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -203,8 +203,9 @@ independently of `--smtp-user`
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
 `--smtp-user` or a `sendemail.smtpUser`), but no password has been
-specified (with `--smtp-pass` or `sendemail.smtpPass`), then
-a password is obtained using 'git-credential'.
+specified (with `--smtp-pass` or `sendemail.smtpPass`, or as an output
+of `sendemail.smtpPassCmd`), then a password is obtained using
+'git-credential'.
 
 --no-smtp-auth::
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`
diff --git a/git-send-email.perl b/git-send-email.perl
index dc95656f75..d953ebb058 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -170,6 +170,7 @@ sub format_2822_time {
 my $smtp;
 my $auth;
 my $num_sent = 0;
+my $smtp_authpass_cmd;
 
 # Regexes for RFC 2047 productions.
 my $re_token = qr/[^][()<>@,;:\\"\/?.= \000-\037\177-\377]+/;
@@ -271,6 +272,7 @@ sub do_edit {
     "smtpserveroption" => \@smtp_server_options,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
+    "smtppasscmd" => \$smtp_authpass_cmd,
     "smtpdomain" => \$smtp_domain,
     "smtpauth" => \$smtp_auth,
     "smtpbatchsize" => \$batch_size,
@@ -1303,6 +1305,15 @@ sub smtp_auth_maybe {
 		die "invalid smtp auth: '${smtp_auth}'";
 	}
 
+	# Check password command if password was not provided.
+	if(!defined $smtp_authpass && defined $smtp_authpass_cmd){
+		open my $pass, "$smtp_authpass_cmd |"
+			or die sprintf(__("Could not execute '%s'"), $smtp_authpass_cmd);
+		#Cut newline char
+		$smtp_authpass = substr <$pass>, 0, -1;
+		close($pass);
+	}
+
 	# TODO: Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
-- 
2.25.4

