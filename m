Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8D21F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeG3RDc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:03:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeG3RDc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:03:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so10860782ljy.8
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuclvbRxocQQBpmm4AOFIzuvZr7hBJopcrLNjuBI1gk=;
        b=o6cvOnrdaDq2zqE2E4suWV/DFpmr3QBgJI7v2J8lc6GgEHpN0TByvNeQdV9wgS/Vmn
         PZnImVNbs83JV7Wl870+kb89ddAT7Wz6bSaFpf3mbSZ2/n3t0owK1mENBzCaNI06gmgc
         hsWCi3CB6/qZmJVXnkT1sDsHsnts3IGp8td5x7WYf7a+FE/aCktTO1bSOWtrnZB7WaDf
         f0e26To7hN/cghxSiBzoT47tG/JNNX5wphoB8LZTx4qYIPte3mlxyCfJC2NqtN1AFhRl
         p9vJN1HilS1Y5OtprIizilTxQnTHluIoJLkKwSZ61Dmh2V7i4mPL+dq0Zvwz0YcbvKlF
         4HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuclvbRxocQQBpmm4AOFIzuvZr7hBJopcrLNjuBI1gk=;
        b=YPcoojVMw/KEmA11Tx9gazM876i1RGhQKxueukvSCq3/xZbrpc0rKszLIYdCvdOnJ8
         lWnyp3GYO34KKqo+ylrK+QgLh5FZuXjf1BYcS4NF56SclVSLDNYpDMSRQC9MVvp+NSOV
         lCrS5FeuE607ZT+Gw28BoGqyFJuJyvhSlyaOKjzs9axdnocgEnq7g45pnjHjkQw3oJ5a
         8wcv7LO2oPCcQ6OJzsJGmO40ii46q8rhgzZ03RKQQj1Io3DZ5EDwR0Z97G2EQs8gOIW8
         hNyErnsvo0mYOqWNNNAg5xkF0tQadfpcbiJU5Gs1rHa86tnrMAiBcM4VBbFPmM9Id13U
         GEZQ==
X-Gm-Message-State: AOUpUlHEwS7Z+w+gQ5LTU4+1nTf0qgnRCh96kocJaZDjR/akADHOUg6E
        R2680+Yb/wkIzvuqBh0tyg4=
X-Google-Smtp-Source: AAOMgpfDtzb9mbyuRoRqreq4V2Faf0KZiZP+9icK+blPNkIpWIePoB0qqnSXHNBiV3+O0aRnLnX0TA==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr13007317lja.47.1532964481657;
        Mon, 30 Jul 2018 08:28:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r73-v6sm2115288ljb.16.2018.07.30.08.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:28:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, pawelparuzel95@gmail.com, pclouds@gmail.com,
        sandals@crustytoothpaste.net
Subject: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
Date:   Mon, 30 Jul 2018 17:27:55 +0200
Message-Id: <20180730152756.15012-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180729092759.GA14484@sigill.intra.peff.net>
References: <20180729092759.GA14484@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paths that only differ in case work fine in a case-sensitive
filesystems, but if those repos are cloned in a case-insensitive one,
you'll get problems. The first thing to notice is "git status" will
never be clean with no indication what's exactly is "dirty".

This patch helps the situation a bit by pointing out the problem at
clone time. I have not suggested any way to work around or fix this
problem. But I guess we could probably have a section in
Documentation/ dedicated to this problem and point there instead of
a long advice in this warning.

Another thing we probably should do is catch in "git checkout" too,
not just "git clone" since your linux/unix colleage colleague may
accidentally add some files that your mac/windows machine is not very
happy with. But then there's another problem, once the problem is
known, we probably should stop spamming this warning at every
checkout, but how?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5c439f1394..32738c2737 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -711,6 +711,33 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	}
 }
 
+static void find_duplicate_icase_entries(struct index_state *istate,
+					 struct string_list *dup)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+
+	for (i = 0; i < istate->cache_nr; i++)
+		string_list_append(&list, istate->cache[i]->name);
+
+	list.cmp = fspathcmp;
+	string_list_sort(&list);
+
+	for (i = 1; i < list.nr; i++) {
+		const char *cur = list.items[i].string;
+		const char *prev = list.items[i - 1].string;
+
+		if (dup->nr &&
+		    !fspathcmp(cur, dup->items[dup->nr - 1].string)) {
+			string_list_append(dup, cur);
+		} else if (!fspathcmp(cur, prev)) {
+			string_list_append(dup, prev);
+			string_list_append(dup, cur);
+		}
+	}
+	string_list_clear(&list, 0);
+}
+
 static int checkout(int submodule_progress)
 {
 	struct object_id oid;
@@ -761,6 +788,20 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
+	if (ignore_case) {
+		struct string_list dup = STRING_LIST_INIT_DUP;
+		int i;
+
+		find_duplicate_icase_entries(&the_index, &dup);
+		if (dup.nr) {
+			warning(_("the following paths in this repository only differ in case and will\n"
+				  "cause problems because you have cloned it on an case-insensitive filesytem:\n"));
+			for (i = 0; i < dup.nr; i++)
+				fprintf(stderr, "\t%s\n", dup.items[i].string);
+		}
+		string_list_clear(&dup, 0);
+	}
+
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   oid_to_hex(&oid), "1", NULL);
 
-- 
2.18.0.656.gda699b98b3

