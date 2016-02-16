From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/4] git remote improvements
Date: Tue, 16 Feb 2016 10:47:48 +0100
Message-ID: <1455616072-20838-1-git-send-email-t.gummerer@gmail.com>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Cc: sunshine@sunshineco.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:47:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcEO-0005h8-Q6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbcBPJrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:47:35 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33925 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcBPJrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:47:31 -0500
Received: by mail-wm0-f42.google.com with SMTP id b205so101265255wmb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lr9nRkVMGmYBgbXojZawRuCEJeU5kis5yHi3QwSb3Mw=;
        b=Ct8mHQ/MrUYzzucMHeUZ6c3PIHvQX69IGvXq8uTS+Y0e0gUyhrvDkxWEHtnKguvncR
         ZC8UXGD8OLxTVY8+ts17huS18sknD7jALhQQMOQgVd12WIhhEdhM/MjN1j71Bzm26E9z
         XXg7Mt6oVn+7N8r8b0yHqYHLg3QAWQ1SeaaR96UIF8MC/E5DynMA6QzqdrPjy3miNqRw
         sfjJa8sB8nRNN40veBD+cPoNaD3DORBLZ4MUxK5r4GANz7PR+b8mwFsGUTe49EAAIJRS
         EitF2l8joReVxPjPKf0MtPnWAHsJEwiFhDlT+N2f9J439jpdlIfWbsXXWMw1hoKrhTgm
         XQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lr9nRkVMGmYBgbXojZawRuCEJeU5kis5yHi3QwSb3Mw=;
        b=BuXb0Rys3g5AcOCLSdGheSgaD6Vqggyr3KZKRE3ULsBtbqPZZZoVMWFeKuWOTVQmYw
         pqY+938tLDn9Pr3j7MUSGora6AbUGELdzELGPgbtHALBikRPNsqyGe041pMyEz5NpOWn
         w5laV3hSEMZfu3SOxzFTSBRmWdlRVbrqhdd7CKIBiloXNlyJ2TfXl8KP2XotbKO/VBLJ
         zbz3p88FnHqgu0LJKlhKZn9/EHXw32K3NLXmR5OJdV6FLVTdef95hLeqAtuHx8s25Nz1
         1PPuT5LjHSLETNou14Gr+GX0YD/9tIzCBky0otMX+TeDU0vI9bVIl9Gf58tyHSc90mfa
         i4mA==
X-Gm-Message-State: AG10YOR0ZeullFqPMpDjIxWBpk2qFKY68XpJQt6UukzOKmXckhfh2N7Mqob6s/Dt3dtJqg==
X-Received: by 10.194.184.112 with SMTP id et16mr21273515wjc.75.1455616050601;
        Tue, 16 Feb 2016 01:47:30 -0800 (PST)
Received: from localhost (host161-107-dynamic.2-87-r.retail.telecomitalia.it. [87.2.107.161])
        by smtp.gmail.com with ESMTPSA id h132sm19689304wmf.9.2016.02.16.01.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 01:47:29 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286331>

Previous rounds are at $gmane/286214 and $gmane/286278.  Thanks to
Peff and Eric for the reviews on the previous round.

This version changes two checks in [1/4], and uses test_config in the
tests instead of calling git config directly.

Interdiff below:

diff --git a/remote.c b/remote.c
index d10ae00..f001681 100644
--- a/remote.c
+++ b/remote.c
@@ -358,17 +358,17 @@ static int handle_config(const char *key, const char *value, void *cb)
 		return 0;
 
 	/* Handle remote.* variables */
-	if (!strcmp(subkey, "pushdefault"))
+	if (!name && !strcmp(subkey, "pushdefault"))
 		return git_config_string(&pushremote_name, key, value);
 
+	if (!name)
+		return 0;
 	/* Handle remote.<name>.* variables */
-	if (*(name ? name : subkey) == '/') {
+	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
-			name ? name : subkey);
+			name);
 		return 0;
 	}
-	if (!name)
-		return 0;
 	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
 	if (!strcmp(subkey, "mirror"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 142ae62..94079a0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -158,18 +158,15 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 '
 
 test_expect_success 'add existing foreign_vcs remote' '
-	git config --add remote.foo.vcs "bar" &&
-	test_when_finished git remote rm foo &&
+	test_config remote.foo.vcs bar &&
 	echo "fatal: remote foo already exists." >expect &&
 	test_must_fail git remote add foo bar 2>actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'add existing foreign_vcs remote' '
-	git config --add remote.foo.vcs "bar" &&
-	git config --add remote.bar.vcs "bar" &&
-	test_when_finished git remote rm foo &&
-	test_when_finished git remote rm bar &&
+	test_config remote.foo.vcs bar &&
+	test_config remote.bar.vcs bar &&
 	echo "fatal: remote bar already exists." >expect &&
 	test_must_fail git remote rename foo bar 2>actual &&
 	test_i18ncmp expect actual


Thomas Gummerer (4):
  remote: use parse_config_key
  remote: simplify remote_is_configured()
  remote: actually check if remote exits
  remote: use remote_is_configured() for add and rename

 builtin/fetch.c   |  5 ++--
 builtin/remote.c  | 23 +++++++---------
 remote.c          | 82 +++++++++++++++++++++++--------------------------------
 remote.h          |  3 +-
 t/t5505-remote.sh | 33 ++++++++++++++++++++++
 5 files changed, 81 insertions(+), 65 deletions(-)

-- 
2.7.1.410.g6faf27b
