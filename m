From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/4] clone: use --progress to force progress reporting
Date: Sat, 26 Dec 2009 01:12:06 +0800
Message-ID: <1261761126-5784-5-git-send-email-rctay89@gmail.com>
References: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
 <1261761126-5784-2-git-send-email-rctay89@gmail.com>
 <1261761126-5784-3-git-send-email-rctay89@gmail.com>
 <1261761126-5784-4-git-send-email-rctay89@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 18:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NODif-0002ZR-0w
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 18:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbZLYRMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756526AbZLYRMj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 12:12:39 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34685 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756522AbZLYRMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 12:12:38 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so9018585ywh.4
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B0K8fKHn/A2KtIw8+mEjmxvmkkewPGI2sjfPCh+16CU=;
        b=hOu0PBiPyRYuXzs9a/BWO0A8tljeExa2WsuvRKS1+6p7XwKh1RDheL7/4TUvw400bS
         9oJXft94Y7B3fjL4jDs6JJMihKZ5r4HbtzcPhaAr2JjUepv+4p8+a0cN6OexD1lTigJY
         yIxCQQ7VrTh1mMQMBP2U3h2ezFqzxgEQ4CyNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U6b2UeelRW49tHFsBAq5XYJW+4iDDi0Bm+5I7D6IMXk0pRMxZrVUm/RytBQWKDwyW9
         Q+Jz9qxV0hUta3TH9teRw92odW8ZhwFhXlr/Tn2zxbSxWQimE1eKBSZ4Wem/uvRzjCMq
         kLg4mMYcxFT8Br96EFMDf/n9FHFseWwFZA7Gg=
Received: by 10.90.17.24 with SMTP id 24mr4022668agq.102.1261761157897;
        Fri, 25 Dec 2009 09:12:37 -0800 (PST)
Received: from localhost.localdomain (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4629570gxk.2.2009.12.25.09.12.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Dec 2009 09:12:37 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1261761126-5784-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135680>

Follow the argument convention of git-pack-objects, such that a
separate option (--preogress) is used to force progress reporting
instead of -v/--verbose.

-v/--verbose now does not force progress reporting. Make git-clone.txt
say so.

This should cover all the bases in 21188b1 (Implement git clone -v),
which implemented the option to force progress reporting.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-clone.txt |    3 +++
 builtin-clone.c             |    8 ++++++--
 t/t5702-clone-options.sh    |    3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index e722e6c..f43c8b2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -102,6 +102,9 @@ objects from the source repository into a pack in the cloned repository.
 
 --verbose::
 -v::
+	Run verbosely.
+
+--progress::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if the
diff --git a/builtin-clone.c b/builtin-clone.c
index 463fbe4..58bacbd 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -44,10 +44,13 @@ static char *option_origin = NULL;
 static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbose;
+static int option_progress;
 
 static struct option builtin_clone_options[] = {
 	OPT__QUIET(&option_quiet),
 	OPT__VERBOSE(&option_verbose),
+	OPT_BOOLEAN(0, "progress", &option_progress,
+			"force progress reporting"),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
@@ -525,10 +528,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		if (option_quiet)
 			transport->verbose = -1;
-		else if (option_verbose) {
+		else if (option_verbose)
 			transport->verbose = 1;
+
+		if (option_progress)
 			transport->progress = 1;
-		}
 
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 27825f5..02cb024 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -27,7 +27,8 @@ test_expect_success 'redirected clone' '
 '
 test_expect_success 'redirected clone -v' '
 
-	git clone -v "file://$(pwd)/parent" clone-redirected-v >out 2>err &&
+	git clone --progress "file://$(pwd)/parent" clone-redirected-progress \
+		>out 2>err &&
 	test -s err
 
 '
-- 
1.6.6.278.g3f5f
