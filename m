From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 05/17] rebase-options: implement rebase_options_load() and rebase_options_save()
Date: Sat, 12 Mar 2016 18:46:25 +0800
Message-ID: <1457779597-6918-6-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4r-0005nK-T7
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbcCLKrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:20 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36149 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcCLKrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:12 -0500
Received: by mail-pf0-f181.google.com with SMTP id u190so71815702pfb.3
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/wXtogGshPuazerYJ+AXuF6O8r/k3U5umGOQQ7scMc=;
        b=Iyanl8tqs18viW3CmwJHsmdj6duuJyOq559yy5GHe2Tbeqkzt0VxhNPVLwnr9mMmuo
         3ETY5G1hRdvblDjrNglp1rVBE55h+KBxp/ZozT9ESXXv9rP+EC3HrY00z2354HtHk5Aa
         gT/rqw4PaDB3mGoki/q4YsF7D/l3vNYoKxQntafvvl41sv2OEN4KIbo10SOkE54/zBx4
         FTUzQgo6U2+LqAftmAL+31jtSdFjlbeXLRXwL1EokRRgiJ5q4RHRMMai0U0Ms/EKx8CQ
         DKZnEObNunbwOOIKmd71Aw0vZzkvKU26limORLze2wUeZOVBL2kuZLI/rZY5wPO9MqFx
         XpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/wXtogGshPuazerYJ+AXuF6O8r/k3U5umGOQQ7scMc=;
        b=dCnOcF+tztXZjM6P45l9QPfE4PTvaUUZhEJjs5r4KOekChilfu3+NJ6/QTFHGd8ErV
         4JSe12zpBveykYtW6EHzy+Zy1SnTJYsrX89Ciof55t4fl3lHnEuzP+JZBTWG/Gsv5OBR
         fJbgN/6g7O6UEImrxRAPB6RX9Ye6sw5XBYxz3/MOpkVMgCzObE8c7XhUIMEuXYrbE7aJ
         1cD0buHvSlNn5LlD37Ec2bG4135es6PF1d9iQgfu1zOOAw5vkluOJcI7BJCa7gTJb2x3
         LlrDESeqJXzzcmyv4O59wGbUqvSekjJErG2k346oTBSwkmfH6BoNhZ1vwabLFjuLSWuC
         DBmA==
X-Gm-Message-State: AD7BkJK2EgAADY3827OPhcOoBjtSXXoI72YnJgLNcIiUy3hW8KEi+XI+6jN09xy9rXthTg==
X-Received: by 10.98.31.21 with SMTP id f21mr14529952pff.134.1457779630503;
        Sat, 12 Mar 2016 02:47:10 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:09 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288734>

These functions can be used for loading and saving common rebase options
into a state directory.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 rebase-common.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rebase-common.h |  4 ++++
 2 files changed, 73 insertions(+)

diff --git a/rebase-common.c b/rebase-common.c
index 5a49ac4..1835f08 100644
--- a/rebase-common.c
+++ b/rebase-common.c
@@ -26,3 +26,72 @@ void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src)
 	*dst = *src;
 	*src = tmp;
 }
+
+static int state_file_exists(const char *dir, const char *file)
+{
+	return file_exists(mkpath("%s/%s", dir, file));
+}
+
+static int read_state_file(struct strbuf *sb, const char *dir, const char *file)
+{
+	const char *path = mkpath("%s/%s", dir, file);
+	strbuf_reset(sb);
+	if (strbuf_read_file(sb, path, 0) >= 0)
+		return sb->len;
+	else
+		return error(_("could not read '%s'"), path);
+}
+
+int rebase_options_load(struct rebase_options *opts, const char *dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *filename;
+
+	/* opts->orig_refname */
+	if (read_state_file(&sb, dir, "head-name") < 0)
+		return -1;
+	strbuf_trim(&sb);
+	if (starts_with(sb.buf, "refs/heads/"))
+		opts->orig_refname = strbuf_detach(&sb, NULL);
+	else if (!strcmp(sb.buf, "detached HEAD"))
+		opts->orig_refname = NULL;
+	else
+		return error(_("could not parse %s"), mkpath("%s/%s", dir, "head-name"));
+
+	/* opts->onto */
+	if (read_state_file(&sb, dir, "onto") < 0)
+		return -1;
+	strbuf_trim(&sb);
+	if (get_oid_hex(sb.buf, &opts->onto) < 0)
+		return error(_("could not parse %s"), mkpath("%s/%s", dir, "onto"));
+
+	/*
+	 * We always write to orig-head, but interactive rebase used to write
+	 * to head. Fall back to reading from head to cover for the case that
+	 * the user upgraded git with an ongoing interactive rebase.
+	 */
+	filename = state_file_exists(dir, "orig-head") ? "orig-head" : "head";
+	if (read_state_file(&sb, dir, filename) < 0)
+		return -1;
+	strbuf_trim(&sb);
+	if (get_oid_hex(sb.buf, &opts->orig_head) < 0)
+		return error(_("could not parse %s"), mkpath("%s/%s", dir, filename));
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int write_state_text(const char *dir, const char *file, const char *string)
+{
+	return write_file(mkpath("%s/%s", dir, file), "%s", string);
+}
+
+void rebase_options_save(const struct rebase_options *opts, const char *dir)
+{
+	const char *head_name = opts->orig_refname;
+	if (!head_name)
+		head_name = "detached HEAD";
+	write_state_text(dir, "head-name", head_name);
+	write_state_text(dir, "onto", oid_to_hex(&opts->onto));
+	write_state_text(dir, "orig-head", oid_to_hex(&opts->orig_head));
+}
diff --git a/rebase-common.h b/rebase-common.h
index db5146a..051c056 100644
--- a/rebase-common.h
+++ b/rebase-common.h
@@ -20,4 +20,8 @@ void rebase_options_release(struct rebase_options *);
 
 void rebase_options_swap(struct rebase_options *dst, struct rebase_options *src);
 
+int rebase_options_load(struct rebase_options *, const char *dir);
+
+void rebase_options_save(const struct rebase_options *, const char *dir);
+
 #endif /* REBASE_COMMON_H */
-- 
2.7.0
