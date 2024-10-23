Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECE1E2824
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714578; cv=none; b=kU2TyGpykuWOJrgNDEedOY7F3h+dhZNtJeb+pxxlSETEIvfSioJ0zLv1qMtMrzYpcL3j2gVKVXsKZZ8XkTzNOx+8b9OjqG1EgHqh2vjKcFnHga8pLB5djbx+0asuNac8Zoy0XJTrvwH9ApEXAvzKo0KeW6NgcDSnGSdg/Ltm3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714578; c=relaxed/simple;
	bh=FNJdbDcwe6sXRErTUOvJmtAJzVWzC+YoGDddTBdWJYM=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=Tz01oQzgpwtkoISvVq4/9hKul9ef8VXtxv7c/zLiKiXSie0hVBz8lt6V/+1snmPNOLiYU5HKd+C+BOFb6Thc9wsp3sbqwqYrzq0Q26obt27PKHkc5OS2n5ZT94Pzgkj5o3RGfUIT1f9jxAlJfR6QdvTVvCABJnVmZ6cv/6NuVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bTwgFSpN; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bTwgFSpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=LoPF3pN5Io+/IcY1eyj+fbrUgCORYmpHLmHBY8zbMNk=;
 b=bTwgFSpNTX/0e25nupN3kOLm0oeVxTyLOTbO0s6mwIQW3U6TSLH5PwzcSgpWdiod/TaBRv1wriv8
   73BwS/Z/QXY37UrpJkAPtZQzzdO8pt15ZYSlZEUvOrGMy1gF9oSht84MgFf7rWlEF+XfoOMt4SV5
   25/7/hYE9qoiOP0zeUHNMbiViOCOWafpHVue0eKv/1wwKBuwU3mFsQcbVtd0l31uA6fkxjDVdQDx
   p2vQFT5gSqXs5Q4Vf9GKqwdGKAgBSfgzKbYpAo1ZNOjw50HDj0xUd9zfsjV+Jlw1g/lB1pUxx/RR
   zsQjy+Qb3oMdI2vkEk3MdDgYenwbgfmeLRdBEw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00MWASAXXT20@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 20:16:09 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>,	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
	Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH] notes: add prepend command
Date: Wed, 23 Oct 2024 22:14:24 +0200
Message-id: <20241023201430.986389-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHxVhgT40vmMneorwtbNskryHhsUvCLZftk3h6pVCWanQNRX98yPKGZOrF/i73v
 sB6q645GudB+v8GRwsyK9F+XggPHZWY/6KfEeq8PYkOSPTsje32eVoYc7k23oWvl
 Ifa6sFO4B8UrowFSYigk+GgqcsuNTgy7XJCSS9R7WCEekmuAHW/sSUsqanxIZaS4
 2oIqmydf3UjN3QHskQuJ7lRSjTjfSQ1WwcWO8SICoz2oMvr5BbgtmAY7pen7J3JX
 Exvd1h33C9qmQPDXRzoiHkRZqFm8WVQo/s3S5SlVbBBHe4IKdaXSoIILo7we4G/C
 77PMhfAlWvL3hiyITmfUQ/q6cf+2jlT+3PBFznYgfQmXyZlkwXvbYScy83QHiHlX
 aiGod//UkCFkBSmjI9lsURRBhG7QohyLRtUdS+xt8Ax5Pl80aQDkb2J2o5YrENXT
 gWvjyHNCFJt1D0OKOKr2ShcbAf/x1P5cd6LLTLmYaWXl0YwrWDPFWu7q

When a note is detailing commit history, it makes sense to keep the
latest change on top, but unlike adding things at the bottom with
"git notes append" this can only be done manually. Add a

    git notes prepend

command, which works exactly like the append command, except that it
inserts the text before the current contents of the note instead of
after.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    RFC v1: Cf.
        https://lore.kernel.org/git/20241023153736.257733-1-bence@ferdinandy.com/T/#m5b6644827590c2518089ab84f936a970c4e9be0f
    
        For that particular series I've used
        git rev-list HEAD~8..HEAD | xargs -i git notes append {} -m "v12: no change"
        for a quick-start on updating notes, when only 1 note needed to be
        really edited with meaningful content, and for some of the patches
        you now need to scroll a bit to actually find that "no change" text,
        instead of seeing it right at the top.

 builtin/notes.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 8c26e45526..cf158cab1c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -35,6 +35,7 @@ static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
 	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] prepend [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes-ref>] show [<object>]"),
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
@@ -644,7 +645,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int append_edit(int argc, const char **argv, const char *prefix)
+
+static int append_prepend_edit(int argc, const char **argv, const char *prefix, int prepend)
 {
 	int allow_empty = 0;
 	const char *object_ref;
@@ -716,11 +718,18 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 		if (!prev_buf)
 			die(_("unable to read %s"), oid_to_hex(note));
-		if (size)
-			strbuf_add(&buf, prev_buf, size);
-		if (d.buf.len && size)
-			append_separator(&buf);
-		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
+		if (prepend) {
+			if (d.buf.len && size)
+				append_separator(&buf);
+			if (size)
+				strbuf_add(&buf, prev_buf, size);
+		} else {
+			if (size)
+				strbuf_add(&buf, prev_buf, size);
+			if (d.buf.len && size)
+				append_separator(&buf);
+		}
+		strbuf_insert(&d.buf, prepend ? d.buf.len : 0, buf.buf, buf.len);
 
 		free(prev_buf);
 		strbuf_release(&buf);
@@ -745,6 +754,16 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int prepend_edit(int argc, const char **argv, const char *prefix)
+{
+	return append_prepend_edit(argc, argv, prefix, 1);
+}
+
+static int append_edit(int argc, const char **argv, const char *prefix)
+{
+	return append_prepend_edit(argc, argv, prefix, 0);
+}
+
 static int show(int argc, const char **argv, const char *prefix)
 {
 	const char *object_ref;
@@ -1116,6 +1135,7 @@ int cmd_notes(int argc,
 		OPT_SUBCOMMAND("add", &fn, add),
 		OPT_SUBCOMMAND("copy", &fn, copy),
 		OPT_SUBCOMMAND("append", &fn, append_edit),
+		OPT_SUBCOMMAND("prepend", &fn, prepend_edit),
 		OPT_SUBCOMMAND("edit", &fn, append_edit),
 		OPT_SUBCOMMAND("show", &fn, show),
 		OPT_SUBCOMMAND("merge", &fn, merge),
-- 
2.47.0.119.g5b706304f7.dirty

