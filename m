From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] diff: add a 'path' meta header for non-renames and non-copies
Date: Mon,  3 May 2010 08:27:52 +0200
Message-ID: <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Eli Collins <eli@cloudera.com>
X-From: git-owner@vger.kernel.org Mon May 03 08:28:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8p8n-0005Um-NO
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 08:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810Ab0ECG2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 02:28:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52677 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab0ECG2V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 02:28:21 -0400
Received: by fxm10 with SMTP id 10so1804206fxm.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uFxD1gCye+m5NqJymiTCla03N2JPpeNzLDgZ/lYhb04=;
        b=BNzWzlOfPmr+GLM2zP52jlJs//unQS2ZjYLXClztk9KKQv9uuvG1Hkq9EJk4IYS1h8
         rfs3tGysV+daXeaSoqgGPt1DZarIDw9UnpGs9E6XDk0Fh5HIlfVYnRHh6DEs6UKNpLwJ
         Jx+5uQ0bo3gLv9UT5VhtEO8CLXkofKYET6IQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=reBBXEeFmyAsXYVocLHhX3HMn+U/UEY756PfmgdSg25YQPTQIsWZXXmAWOZw+OfUfR
         eWzhDz+Ov9GRvrJeViln4dSfXT/6YLxDQlzMisI0ma8p8qUD3JwGj5lTbIWI2g/gn1HD
         pgZPhykymamFNZqOauyIa+m03U2Swja3viEqw=
Received: by 10.223.21.22 with SMTP id h22mr3097829fab.106.1272868099822;
        Sun, 02 May 2010 23:28:19 -0700 (PDT)
Received: from localhost ([92.116.147.145])
        by mx.google.com with ESMTPS id d13sm8144456fka.2.2010.05.02.23.28.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 23:28:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc2.620.g49a9d
In-Reply-To: <1272852221-14927-1-git-send-email-eli@cloudera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146215>

Hi Eli, 

I like to have a path without any prefix in the diff header, too, but also like
to see the diff mnemonic prefix (see diff.mnemonicprefix config). For some
diffs there is such path, which is in the extended header of the diff for
copies and renames. So I wrote the appended patch wich adds also an extended
header for non-copies and non-renames which shows the path without any prefix.


Regards,
Bert

--- 8< ---

From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] diff: add a 'path' meta header for non-renames and non-copies

This way you have always a path without any diff mnemonic prefix.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Documentation/config.txt              |    4 ++++
 Documentation/diff-generate-patch.txt |    4 ++++
 diff.c                                |   12 ++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..652365e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -807,6 +807,10 @@ diff.mnemonicprefix::
 `git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
+diff.path::
+	Always add a 'path <path>' extended header into the diff output,
+	for non-copies and non-renames.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the 'git diff' option '-l'.
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 8f9a241..67ba78f 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -30,6 +30,7 @@ the file that rename/copy produces, respectively.
        new mode <mode>
        deleted file mode <mode>
        new file mode <mode>
+       path <path>
        copy from <path>
        copy to <path>
        rename from <path>
@@ -38,6 +39,9 @@ the file that rename/copy produces, respectively.
        dissimilarity index <number>
        index <hash>..<hash> <mode>
 
+    The 'path' header will only show up, if the diff.path configure option
+    is set.
+
 3.  TAB, LF, double quote and backslash characters in pathnames
     are represented as `\t`, `\n`, `\"` and `\\`, respectively.
     If there is need for such substitution then the whole
diff --git a/diff.c b/diff.c
index d0ecbc3..fa33b9c 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@ static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
+static int diff_path;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -104,6 +105,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
+	if (!strcmp(var, "diff.path")) {
+		diff_path = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_diff_basic_config(var, value, cb);
 }
@@ -2351,8 +2356,11 @@ static void fill_metainfo(struct strbuf *msg,
 		}
 		/* fallthru */
 	default:
-		/* nothing */
-		;
+		if (diff_path) {
+			strbuf_addstr(msg, "path ");
+			quote_c_style(name, msg, NULL, 0);
+			strbuf_addch(msg, '\n');
+		}
 	}
 	if (one && two && hashcmp(one->sha1, two->sha1)) {
 		int abbrev = DIFF_OPT_TST(o, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
-- 
tg: (ddd02b7..) bw/always-print-a-path-meta-header (depends on: master)
