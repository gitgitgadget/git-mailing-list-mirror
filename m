From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v10 1/2] git-pull.c: introduce git_pull_config()
Date: Mon, 21 Mar 2016 23:48:02 +0530
Message-ID: <1458584283-23816-2-git-send-email-mehul.jain2029@gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Cc: gitster@pobox.com, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:19:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai4Pr-0006QX-VS
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 19:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbcCUSSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 14:18:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35669 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbcCUSSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 14:18:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id u190so31462630pfb.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOzhp7z27V2oPUvwpROMiOwhCRKX4ZQWYu99ryG5VHs=;
        b=hsWC45e9CY7uhMbZZRw90+62Q8FJE6wpqnoumau+AKD5FZS3QkmuFTZMWDFO+Ah9GR
         iOwtI5uvDpy0VDWdSr5Lwk8kNRxjEhujSCrp5lxDS5W1yw5gxQkkD9G6mnZ+ug5UX11F
         OjigcfKKXRwC4DXiO0qVQ76rZlkv9cW8OcFLjcHFUAJbBroEbWi892Aoo173Rhk3yq2G
         gZX3JZE4EB3VTb9gpt53GeOXzh3XySyb4ppwLb8b9Sow550Cn6XQTFwlNWCrdZgvKuev
         cQUQUgLXMDz1VWGjxG5A4j5X2VAy2td9XJyLye9dl0gfWkBW0G0upexk+1EPvcXsvaBu
         J34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOzhp7z27V2oPUvwpROMiOwhCRKX4ZQWYu99ryG5VHs=;
        b=eOmpjhpNGgQ5pQZFH13wG4zDOQxv4PvO9MimNaSLNKREHLdpnD9/KXycICG3v3pgYJ
         sqn4yalufxt8xz2IzNsldt1NterbU3dPBcma2qhiFSS4nuzmVN0PSud03Hx0nAeMVQsH
         TECrbi710i5EZ/NhqkWRr4G9gnRYdgz4uVISzeNAf7kpzvZ4CdwntMk5AMe6u54cIg0r
         3CI33JIdG+mfH6tQuGCfBXbzQ/Sxhn3UrmLiyh8l0dlUEZ/9pqazvhM9bDNXIIYPhoUK
         jL9N9N6Ym1ZYzdXIzMVyaSpkMXrqvbgYFbYr8axMDXX3IlnxAcImru/DG1OCGVVVodCm
         edMQ==
X-Gm-Message-State: AD7BkJJ0y+wGVUdlkCW0FS4+nNm5AgzD+fVsFAMPf4qAeZTTP4l3T+E6OYasqdsucV6awQ==
X-Received: by 10.98.64.132 with SMTP id f4mr33872988pfd.146.1458584334069;
        Mon, 21 Mar 2016 11:18:54 -0700 (PDT)
Received: from localhost.localdomain ([1.39.36.202])
        by smtp.gmail.com with ESMTPSA id ud8sm42378768pac.11.2016.03.21.11.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 11:18:53 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289435>

git-pull makes a seperate call to git_config_get_bool() to read the value
of "rebase.autostash". This can be reduced as a call to git_config() is
already there in the code.

Introduce a callback function git_pull_config() to read "rebase.autostash"
along with other variables.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 builtin/pull.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..c21897d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int config_autostash;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
@@ -306,6 +307,18 @@ static enum rebase_type config_get_rebase(void)
 }
 
 /**
+ * Read config variables.
+ */
+static int git_pull_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "rebase.autostash")) {
+		config_autostash = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
+/**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
 static int has_unstaged_changes(const char *prefix)
@@ -823,7 +836,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase();
 
-	git_config(git_default_config, NULL);
+	git_config(git_pull_config, NULL);
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("Pull");
@@ -835,12 +848,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
+		int autostash = config_autostash;
 
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
 		if (!autostash)
 			die_on_unclean_work_tree(prefix);
 
-- 
2.7.1.340.g69eb491.dirty
