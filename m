Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C4920281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764910AbdEWTcP (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:32:15 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35834 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764901AbdEWTcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:32:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so23533562qtb.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6ootXykbqIj4Ab+cJS6OrhT69wvdMnkSRNH+BlpXuNk=;
        b=dU+Ic/IgaTeLhvZlUpOc0Sei3lcbZPRXBc4IlJ1V17nXgbZC4WdJ3HPpY24K3q40AP
         O/5bwbImJaf8lvdWU9GdalTfkmqVfKIZM3vzyJsMJ3s4wD7qLc1id3vde20FCP5KVR5k
         VtGMqWOJkXozfXS6XFlL05IkVksMrJqAc5+tP+XlRKy/J9tUpjJlxC/K7AEdd3iEixbr
         +XXwM1b2vlFA4aGrVtvEeUG8JdEl0s3gEt5cAKCTgibn32S18QBZyT7ltISX+PJHGt9G
         P8280HWfYrNTG0MNie9lLLBU5UUnBwtmFdjSTA9IUj0VTF1S3eREZfgknN7sh6hF/+Lh
         r/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6ootXykbqIj4Ab+cJS6OrhT69wvdMnkSRNH+BlpXuNk=;
        b=oJbBrUTdr7/3RP1yefaXpGI7mN2jwuiAiai+zSmVtsiEfEBgUt35ZfeesmJa3+JLBl
         0hL2L1DfgNQonCMOm+R0Fbb8vXHsYlpVmJ+z47NV0VCyXVAZvSMGB0wl0tE/VNGPVneo
         ENZa+DIacp8H+7qJd9DsSec7Flj+8iB3DryCzKCmOz3ReQQ8RxizjoZjjJkNPsdmm12G
         NZhDc/kt9vnUSSRBK8R72MK9lrCPq0tg7AAlK3HF9rvIRZ0BlXYJ9hL28x3n40aNRIHQ
         /VpdpKNBc/V1aiLo7mJ6ddrs7mWMcoB3+UjAsBbIB8dOKhZaqhc3C7QNb2o5W/z/LKsT
         KRDQ==
X-Gm-Message-State: AODbwcCQTouXOH6GYP8XUMubCukfZHgjPZzec2KFpwl+VgHjn1xGdR60
        vgMpqtMTD2IydoN9wuM=
X-Received: by 10.237.42.122 with SMTP id k55mr32565338qtf.237.1495567928339;
        Tue, 23 May 2017 12:32:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:32:07 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 4/6] dir: hide untracked contents of untracked dirs
Date:   Tue, 23 May 2017 06:09:35 -0400
Message-Id: <20170523100937.8752-5-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523100937.8752-1-sxlijin@gmail.com>
References: <20170523100937.8752-1-sxlijin@gmail.com>
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we taught read_directory_recursive() to recurse into untracked
directories in search of ignored files given DIR_SHOW_IGNORED_TOO, that
had the side effect of teaching it to collect the untracked contents of
untracked directories. It doesn't always make sense to return these,
though (we do need them for `clean -d`), so we introduce a flag
(DIR_KEEP_UNTRACKED_CONTENTS) to control whether or not read_directory()
strips dir->entries of the untracked contents of untracked dirs.

We also introduce check_contains() to check if one dir_entry corresponds
to a path which contains the path corresponding to another dir_entry.

This also fixes known breakages in t7061, since status --ignored now
searches untracked directories for ignored files.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 Documentation/technical/api-directory-listing.txt |  6 +++++
 dir.c                                             | 31 +++++++++++++++++++++++
 dir.h                                             |  3 ++-
 t/t7061-wtstatus-ignore.sh                        |  4 +--
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 7f8e78d91..6c77b4920 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -33,6 +33,12 @@ The notable options are:
 	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
 	in addition to untracked files in `entries[]`.
 
+`DIR_KEEP_UNTRACKED_CONTENTS`:::
+
+	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is set, the
+	untracked contents of untracked directories are also returned in
+	`entries[]`.
+
 `DIR_COLLECT_IGNORED`:::
 
 	Special mode for git-add. Return ignored files in `ignored[]` and
diff --git a/dir.c b/dir.c
index 68cf6e47c..ba5eadeda 100644
--- a/dir.c
+++ b/dir.c
@@ -1850,6 +1850,14 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
+/* check if *out lexically strictly contains *in */
+static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+{
+	return (out->len < in->len) &&
+		(out->name[out->len - 1] == '/') &&
+		!memcmp(out->name, in->name, out->len);
+}
+
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
@@ -2065,6 +2073,29 @@ int read_directory(struct dir_struct *dir, const char *path,
 		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_name);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
+
+	/* 
+	 * if DIR_SHOW_IGNORED_TOO, read_directory_recursive() will also pick
+	 * up untracked contents of untracked dirs; by default we discard these,
+	 * but given DIR_KEEP_UNTRACKED_CONTENTS we do not
+	 */
+	if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		     !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
+		int i, j;
+
+		/* remove from dir->entries untracked contents of untracked dirs */
+		for (i = j = 0; j < dir->nr; j++) {
+			if (i && check_contains(dir->entries[i - 1], dir->entries[j])) {
+				free(dir->entries[j]);
+				dir->entries[j] = NULL;
+			} else {
+				dir->entries[i++] = dir->entries[j];
+			}
+		}
+
+		dir->nr = i;
+	}
+
 	if (dir->untracked) {
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 		trace_printf_key(&trace_untracked_stats,
diff --git a/dir.h b/dir.h
index bf23a470a..650e54bdf 100644
--- a/dir.h
+++ b/dir.h
@@ -151,7 +151,8 @@ struct dir_struct {
 		DIR_NO_GITLINKS = 1<<3,
 		DIR_COLLECT_IGNORED = 1<<4,
 		DIR_SHOW_IGNORED_TOO = 1<<5,
-		DIR_COLLECT_KILLED_ONLY = 1<<6
+		DIR_COLLECT_KILLED_ONLY = 1<<6,
+		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 15e7592b6..fc6013ba3 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -12,7 +12,7 @@ cat >expected <<\EOF
 !! untracked/ignored
 EOF
 
-test_expect_failure 'status untracked directory with --ignored' '
+test_expect_success 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
@@ -21,7 +21,7 @@ test_expect_failure 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'same with gitignore starting with BOM' '
+test_expect_success 'same with gitignore starting with BOM' '
 	printf "\357\273\277ignored\n" >.gitignore &&
 	mkdir -p untracked &&
 	: >untracked/ignored &&
-- 
2.13.0

