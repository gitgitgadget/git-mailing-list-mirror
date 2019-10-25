Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8A81F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391177AbfJYCvq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:46 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56525 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCvq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:46 -0400
Received: by mail-pg1-f202.google.com with SMTP id u4so619236pgp.23
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xvl0O5lJZZJyQGcddpD2RGvFZUD/xOX/vy5BRm8zyC4=;
        b=SfhNY0Oyw2uczWnV3KndeYZXa81PZfA7EY0V4eOnGSKYb38Xds1kOaaCeP9/3PBHn0
         lwX+sZe1T3SrwSTBID+hU59XLlIGkomE3xDv/xOusClgpLprOS9Garjzwg8XpcD/f3Wl
         cb0MlosdPcxBOUGroFlerrE3h5vXAVFZ9WwmutSjF1TBCxkUksI8b+cXJDXeD+NqCIW4
         7lbkcySJtXU0F3A1o5YpoAkUUMPX8T+SxRMNOBYi0bczbv3cMcT45elIq1kmr8oQBRke
         rl9uFzDS1sQE1UE1kzpQTI4tk8KQUQx1eC68v54UtU391+/5eYM72eKypY36JGDPtcIn
         sFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xvl0O5lJZZJyQGcddpD2RGvFZUD/xOX/vy5BRm8zyC4=;
        b=Sz0RdQ5KwT2nbBmHu79eogsUHP+fWtuaKt6hlUILiTxnEVZeQKXekB4nBZP2kE27GY
         3/jXMtSKQy3tPibMWbdJrWdMhkL2+Z4YZkISvpalhu6t5xfbX6YIQQNztIT3WUx/4Zf1
         IvIrodJe3VFDHW0OgDlFladOJF1uK7va+LmC07vKwHwMh8OQ5ScsccnzizQxI+CfQ7BV
         rIe/GkAKZ5JSFOnkJ1euehmdJCBt7WB3y+EmWhNfM+Upj6Pri/6uLMj3mq5knEZXtz4N
         +8x2pTIEZi59KZVuioKMGUXH2jIx7GV1GpPT4BxunLc6OsZUy7Pn5+pzU3MRPrWETR+0
         hQ8Q==
X-Gm-Message-State: APjAAAW+iVHRRXXGy9CJ4ItUtXq4ULBr7qjz29LDwBlkpTvkehbWNzf9
        hbNC4d/XYGcRxoHXci433rjKAj9N1JVPiirf3bIGPiEfKBqb9R97vb0UzHaHIK0ObN6u0c+xIHo
        dTlSILWdc8Yf48Av9nmkz4eSKatGuE7+rvmFA2ZYjKDXD4aBud0EClhBZZVPMiI31BteSHwebpg
        ==
X-Google-Smtp-Source: APXvYqz9dApX1x44AC/ynBFqoWh+Ht9JNUvLNUTvujFYuSHaNYVTnUvXAxwP8Ysb5kGqrTbxpVsE/LPlYjPLN3BTky4=
X-Received: by 2002:a63:d809:: with SMTP id b9mr1443476pgh.143.1571971904673;
 Thu, 24 Oct 2019 19:51:44 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:22 -0700
In-Reply-To: <20191025025129.250049-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191025025129.250049-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 2/9] bugreport: generate config whitelist based on docs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new step to the build to generate a whitelist of git-config
variables which are appropriate to include in the output of
git-bugreport. New variables can be added to the whitelist by annotating
their documentation in Documentation/config with the line
"// bugreport-include".

Some configs are private in nature, and can contain remote URLs,
passwords, or other sensitive information. In the event that a user
doesn't notice their information while reviewing a bugreport, that user
may leak their credentials to other individuals, mailing lists, or bug
tracking tools inadvertently. Heuristic blacklisting of configuration
keys is imperfect and prone to false negatives; given the nature of the
information which can be leaked, a whitelist is more reliable.

In order to prevent staleness of the whitelist, add a mechanism to
generate the whitelist from annotations in the config documentation,
where contributors are already used to documenting their new config
keys.

Additionally, add annotations to the sendemail config documentation in
order to demonstrate a proof of concept.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                             |  1 +
 Documentation/config/sendemail.txt     | 68 +++++++++++++-------------
 Makefile                               |  9 +++-
 bugreport-generate-config-whitelist.sh |  4 ++
 4 files changed, 47 insertions(+), 35 deletions(-)
 create mode 100755 bugreport-generate-config-whitelist.sh

diff --git a/.gitignore b/.gitignore
index 89b3b79c1a..055a84c4a8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,6 +25,7 @@
 /git-bisect--helper
 /git-blame
 /git-branch
+/git-bugreport
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 0006faf800..69f3e4f219 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -1,63 +1,63 @@
-sendemail.identity::
+sendemail.identity:: // bugreport-exclude
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
 
-sendemail.smtpEncryption::
+sendemail.smtpEncryption:: // bugreport-include
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl (deprecated)::
+sendemail.smtpssl (deprecated):: // bugreport-exclude
 	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
 
-sendemail.smtpsslcertpath::
+sendemail.smtpsslcertpath:: // bugreport-exclude
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
 
-sendemail.<identity>.*::
+sendemail.<identity>.*:: // bugreport-exclude
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
-sendemail.aliasesFile::
-sendemail.aliasFileType::
-sendemail.annotate::
-sendemail.bcc::
-sendemail.cc::
-sendemail.ccCmd::
-sendemail.chainReplyTo::
-sendemail.confirm::
-sendemail.envelopeSender::
-sendemail.from::
-sendemail.multiEdit::
-sendemail.signedoffbycc::
-sendemail.smtpPass::
-sendemail.suppresscc::
-sendemail.suppressFrom::
-sendemail.to::
-sendemail.tocmd::
-sendemail.smtpDomain::
-sendemail.smtpServer::
-sendemail.smtpServerPort::
-sendemail.smtpServerOption::
-sendemail.smtpUser::
-sendemail.thread::
-sendemail.transferEncoding::
-sendemail.validate::
-sendemail.xmailer::
+sendemail.aliasesFile:: // bugreport-exclude
+sendemail.aliasFileType:: // bugreport-exclude
+sendemail.annotate:: // bugreport-include
+sendemail.bcc:: // bugreport-include
+sendemail.cc:: // bugreport-include
+sendemail.ccCmd:: // bugreport-include
+sendemail.chainReplyTo:: // bugreport-include
+sendemail.confirm:: // bugreport-include
+sendemail.envelopeSender:: // bugreport-include
+sendemail.from:: // bugreport-include
+sendemail.multiEdit:: // bugreport-include
+sendemail.signedoffbycc:: // bugreport-include
+sendemail.smtpPass:: // bugreport-exclude
+sendemail.suppresscc:: // bugreport-include
+sendemail.suppressFrom:: // bugreport-include
+sendemail.to:: // bugreport-include
+sendemail.tocmd:: // bugreport-include
+sendemail.smtpDomain:: // bugreport-include
+sendemail.smtpServer:: // bugreport-include
+sendemail.smtpServerPort:: // bugreport-include
+sendemail.smtpServerOption:: // bugreport-include
+sendemail.smtpUser:: // bugreport-exclude
+sendemail.thread:: // bugreport-include
+sendemail.transferEncoding:: // bugreport-include
+sendemail.validate:: // bugreport-include
+sendemail.xmailer:: // bugreport-include
 	See linkgit:git-send-email[1] for description.
 
-sendemail.signedoffcc (deprecated)::
+sendemail.signedoffcc (deprecated):: // bugreport-exclude
 	Deprecated alias for `sendemail.signedoffbycc`.
 
-sendemail.smtpBatchSize::
+sendemail.smtpBatchSize:: // bugreport-include
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
 
-sendemail.smtpReloginDelay::
+sendemail.smtpReloginDelay:: // bugreport-include
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
diff --git a/Makefile b/Makefile
index 132e2a52da..78767ecdde 100644
--- a/Makefile
+++ b/Makefile
@@ -634,6 +634,10 @@ SCRIPT_PYTHON += git-p4.py
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
+SCRIPT_DEPENDENCIES = git-bugreport-config-whitelist
+
+$(SCRIPT_DEPENDENCIES): Documentation/config/*.txt
+	sh bugreport-generate-config-whitelist.sh
 
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
@@ -651,17 +655,20 @@ install-perl-script: $(SCRIPT_PERL_GEN)
 install-python-script: $(SCRIPT_PYTHON_GEN)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
-.PHONY: clean-perl-script clean-sh-script clean-python-script
+.PHONY: clean-perl-script clean-sh-script clean-python-script clean-script-dependencies
 clean-sh-script:
 	$(RM) $(SCRIPT_SH_GEN)
 clean-perl-script:
 	$(RM) $(SCRIPT_PERL_GEN)
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
+clean-script-dependencies:
+	$(RM) $(SCRIPT_DEPENDENCIES)
 
 SCRIPTS = $(SCRIPT_SH_GEN) \
 	  $(SCRIPT_PERL_GEN) \
 	  $(SCRIPT_PYTHON_GEN) \
+	  $(SCRIPT_DEPENDENCIES) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
diff --git a/bugreport-generate-config-whitelist.sh b/bugreport-generate-config-whitelist.sh
new file mode 100755
index 0000000000..ca6b232024
--- /dev/null
+++ b/bugreport-generate-config-whitelist.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+grep -RhPo ".*(?=:: \/\/ bugreport-include)" Documentation/config \
+  >git-bugreport-config-whitelist
-- 
2.24.0.rc0.303.g954a862665-goog

