Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC2A1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 15:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfJGPwS (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 11:52:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43695 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGPwS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 11:52:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so7049434plj.10
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhOfunFqDctGPTdIk7/WwCV4jReQTBGtLZtWSrry+uc=;
        b=TwlYuUOJz2IHTVP63pr+I2Qg9I4hE/dii5J9YGs1lV2uiaaup8e18bAHTBCkax1Nqh
         v7Q+5o03/uTNqoi/ySmdc6/XmDxhSLuk1ZfJNwv+QGL6zFWX8MnZ/wb3MqIYY/VDJ1AS
         XKipi38GQB4S/iWNmFUmOFcwp9j5C4ZU7CgMJDMLChNVlbU1P4c6zYRX3bNBFs1vITuH
         RcF6rsvBbH/yCifKnxZuGWBnbwAiw5ZMTJd1L/Y5Jeh7LkQ85eO8mA7vHc2EGHXZBZ2e
         AP4hG+N4i1CsEBiav9WryD1k0kh+5s84kre9YoLlbaGmgQT94yr+WQFpvQg5/ek1WOCa
         riLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhOfunFqDctGPTdIk7/WwCV4jReQTBGtLZtWSrry+uc=;
        b=W3eUQc8apVV6bIKFFBgqBUvVWTTG1KjgCqNvCHXD6M5Ft8xo7zGW0wBGj/pZURggWK
         +zWTOGAwChvALSVl88Vpj7VVmvAgx0Rkok1xqi9zFzuA6Gn3M5UbCUmRdGk2oOeKu1oW
         KM4igRUiZCbUDAioiWAFaKihjIjRe9baAIpfyWii2q08ggMsGXXLxlqORrux58t+yXoX
         qhidiiVxZ2WgnT7HKun+RH7IigAdUd/OiwGbLFmD03/zbe04dOWRstWJJe1Ofdc1vN1f
         etSYBLBcBshOrcA8uusnqMHdGqqlFUpAZqJl3wCx0Z/5MUvZKP9U4CpO0IW3TzqdM7TU
         miVQ==
X-Gm-Message-State: APjAAAUcVE9uLCWTKJ79PVMZhH+6Eakf5ZcgZjajvJrCcOkpqNt/6CzU
        g0LS8xNzWzr9YvFH1DhYSP8=
X-Google-Smtp-Source: APXvYqyl/J9lfnx1aXAI/BUpf5ojyDLNHiBs7M1hfjvcVjX4GQW7x7/CN2pps5xX3avjtYbLkGH9dA==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr31177896plc.41.1570463537245;
        Mon, 07 Oct 2019 08:52:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h70sm12948123pgc.48.2019.10.07.08.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 08:52:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: fix the fix to the diff3 common ancestor label
Date:   Mon,  7 Oct 2019 08:52:11 -0700
Message-Id: <20191007155211.23067-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.26.gfc82117b87
In-Reply-To: <xmqq7e5h46an.fsf@gitster-ct.c.googlers.com>
References: <xmqq7e5h46an.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 208e69a4ebce ("merge-recursive: fix the diff3 common ancestor
label for virtual commits", 2019-09-30) which was a fix to commit
743474cbfa8b ("merge-recursive: provide a better label for diff3 common
ancestor", 2019-08-17), the label for the common ancestor was changed
from always being

         "merged common ancestors"

to instead be based on the number of merge bases and whether the merge
base was a real commit or a virtual one:

    >=2: "merged common ancestors"
      1, via merge_recursive_generic: "constructed merge base"
      1, otherwise: <abbreviated commit hash>
      0: "<empty tree>"

The handling for "constructed merge base" worked by allowing
opt->ancestor to be set in merge_recursive_generic(), so we payed
attention to the setting of that variable in merge_recursive_internal().
Now, for the outer merge, the code flow was simply the following:

	ancestor_name = "merged merge bases"
	loop over merge_bases: merge_recursive_internal()

The first merge base not needing recursion would determine its own
ancestor_name however necessary and thus run

	ancestor_name = $SOMETHING
	empty loop over merge_bases...
	opt->ancestor = ancestor_name
        merge_trees_internal()

Now, the next set of merge_bases that would need to be merged after this
particular merge had completed would note that opt->ancestor has been
set to something (to a local ancestor_name variable that has since been
popped off the stack), and thus it would run:

	... else if (opt->ancestor) {
		ancestor_name = opt->ancestor;  /* OOPS! */
        loop over merge_bases: merge_recursive_internal()
        opt->ancestor = ancestor_name
        merge_trees_internal()

This resulted in garbage strings being printed for the virtual merge
bases, which was visible in git.git by just merging commit b744c3af07
into commit 6d8cb22a4f.  There are two ways to fix this: set
opt->ancestor to NULL after using it to avoid re-use, or add a
!opt->priv->call_depth check to the if block for using a pre-defined
opt->ancestor.  Apply both fixes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e12d91f48a..2653ba9a50 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3550,7 +3550,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 		merged_merge_bases = make_virtual_commit(opt->repo, tree,
 							 "ancestor");
 		ancestor_name = "empty tree";
-	} else if (opt->ancestor) {
+	} else if (opt->ancestor && !opt->priv->call_depth) {
 		ancestor_name = opt->ancestor;
 	} else if (merge_bases) {
 		ancestor_name = "merged common ancestors";
@@ -3600,6 +3600,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 							  merged_merge_bases),
 				     &result_tree);
 	strbuf_release(&merge_base_abbrev);
+	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
-- 
2.23.0.26.gfc82117b87

