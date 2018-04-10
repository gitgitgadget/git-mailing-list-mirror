Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFA21F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeDJMaB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:33535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbeDJM37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:59 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lm34j-1eWolt46dN-00ZhZ2; Tue, 10 Apr 2018 14:29:53 +0200
Date:   Tue, 10 Apr 2018 14:29:52 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 06/15] sequencer: fast-forward `merge` commands, if
 possible
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <4e0d0ea09c7b6173fd52b71ebc41753691aa0a66.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4MG4yQjnIh2I8WUA8WJTOMNw4OPqr8MzagouAOCrqZ04tWVQ5qM
 O+kuf6yB6c1hr+34XPxfkxxtXmSWmY13jwXMOgQeC+HtGO+wpOTUSjWHJiljBvA8vctGuuQ
 Xk0pK4q2Ah7hnhTLM8PtqRxh9ggpr9ixKj46+qjDe5lTNEFh+h2YZv8uFWUISrpLtASa1Hx
 CBAYgNiNAEQZP25olaSgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sHJDx3rxjjo=:97HNcY+BJiBAd5/dAEsP2B
 omavE7MSGQJYi6sOBJEYVKe9nmn6YCYWp4YJo9m0B5ZmirRCjl3BWoGu6nynYRH11700Glq3i
 wPkOA98j+n6d5PNnYCxopbkovXYktLWRQRzVgE1BPG1T0rSdVFS+eQD/tgbODgV30HNsrFiPa
 aVUxB7ZzWALJ8cVsXOcKCeWWoltlu1YO7/PoQNJtDE3QFuM/q9NnlZLcMcyZJRMqrsE9PJl4H
 /wOGn34PJ4VamnqA+bTekGUJlGUytxAtYq2kAIuhuCtmley2ABnyVK49Y2Yu1yvULkXYoQ2BV
 iS1tvoiL4DSxJMSQ/iVwqvPTibBO4YINUDsHru0QwC9aIybyyrKi6n6ivlsGCdlfbdoMP1WYD
 dkA6CcO2fNPaRI4EGWe1ut2sEBXVm3/tRqW7yTJCPZXwQauQpvBQ25n9UmLzl28gEdUMQeqjV
 9p8BRqM995rOQT3ypsgbtHUKtyZOw8Y7xfhU5oBg1YGMBUCZ+RcTcvbOHpPlFBH6zuz/jiF8I
 ux+zb3pKi2X/f2o0tVSSTCGHwf/7yMVaZwwnoAz6uEpgXd1d/tbZnhwD5t05h4wAay+qygpna
 +HHXHrrFOVPpYxJVU5Sm5Y61s5ghTjpv7XaThDJBNwFVaA9PTpVETvcGjk21GDs/aPBstdn54
 WKsIBQr6Q5f8Ocrm2gyn26pNQExNMKzhHl38HpRHz2alKNGG4NRYfwg4M6zJH5Fv20KEC7wQG
 vIEbCv1JYUWH22Xa+zhfB9XD+WIbKsnTB/KAwITDod0JNja08JVWxNZg/RQ0eIAwb4oYJcLET
 cv9d+PUe9u+S0fnVBiJd06b0ryCC/ud4sYEN5fR9xWFxREolbg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to rebase a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 1b5f1441102..fb362fafaa7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2665,7 +2665,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
 	struct merge_options o;
-	int merge_arg_len, oneline_offset, ret;
+	int merge_arg_len, oneline_offset, can_fast_forward, ret;
 	static struct lock_file lock;
 	const char *p;
 
@@ -2750,6 +2750,37 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * If HEAD is not identical to the first parent of the original merge
+	 * commit, we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
+	/*
+	 * If the merge head is different from the original one, we cannot
+	 * fast-forward.
+	 */
+	if (can_fast_forward) {
+		struct commit_list *second_parent = commit->parents->next;
+
+		if (second_parent && !second_parent->next &&
+		    oidcmp(&merge_commit->object.oid,
+			   &second_parent->item->object.oid))
+			can_fast_forward = 0;
+	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return fast_forward_to(&commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.17.0.windows.1.4.g7e4058d72e3


