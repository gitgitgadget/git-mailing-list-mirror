Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9FE1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeDUKeF (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:34:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:37929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeDUKeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:34:04 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkSOt-1eXkru0ui3-00cT4U; Sat, 21
 Apr 2018 12:33:57 +0200
Date:   Sat, 21 Apr 2018 12:33:41 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 07/16] sequencer: fast-forward `merge` commands, if
 possible
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <7373d7c4d416182f26a18b79a5a26f5819d31b3b.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uNHnQBPhcS+76/QceebBnWTmPrx1PcGHNZn85nvs+ntH5M5VFH3
 AsBE/MVTelOmUhfU9jbdFDLRXIoqCNoY8iNQ4/++c5SiQbgDg5jEZWPgg1G/Ucc8KV2OAHB
 m0HROUlGpoD23lU16OFf3OoUVjlIoVfJsVDwQaEaUJ/jwsRsAcAXThvvxzzISCb2F4TNISj
 nUq9r6cFu5L08UKmihKaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uRGyXrpycn4=:Pk/rDAcxCs/B03/wXt1hRn
 eBVAxBDRyQNNhBm/q3jmarEaDu/Yz92bGxL4GiLFe4RM0mKTO9/dKghP15A5GcVgQAOdTV2Pk
 ZwfvgO6X6/ED8bmoLdur+fpyQTXAJy2t+5Sm7Fc+7gIp1Xoc+XW39bznNUiMAZrDqyC3VLmxm
 3a+FXccPU8r/CaMoPtlXiFC3BhFY85cYhCgV+i+udzbg2LWE22skfQ+LF7ps/IYwe20BrhB5N
 H3MtYHkgbc/M+LqUQiwUy4GBtS4C2oWi9TAacxdeKk1dmzIS/AfYbiTHYu3O03Z/vL0RbMedR
 wunpZerO2t6EVBYh/afe/9MMJ540KGLsPwbXb7RKVaU+/s3whPzs1+aQnkeUZWDiebvAENx6B
 EZaGh5e+IK7wYYjIlv1Dch6xrzby1mEoiNVUum6/3UxaaYPwoaSavJOwSYC/qeFYlIY+xUkHW
 aTdx8EQgSyVtk7WvDAqsuobPUWqH5lu7KzfiNbMPU39ifwYwKgfip6bI3KzWLP7dMnfBAKiVS
 5p1ngMyVeY3GDTUMuUInBRvHIKol6JGwPjY+2P4eCScxi9NsWNoqDSyolATekm+6kQmkcXPKP
 6OR9/bDXU3tGpmZ8Pi2PVWMI+rUFQrFEP+olKBqQ0w7iHa1mFD5Oa1ntN+rcmaZV8OD6qJG4r
 Qp6puKgPp1bvzUXHy2bft6HO9KI5Xu6GZzvLjM5aQVzCB2ubV+D4yE94vz4ogGN3fs8TAUyxc
 ytyShZVxyjP8/opdOvOUaP+HZsIn/uoe4OpZApRndC10PTabszKVPw9vNdQJo7RL6QWy5INhW
 eE8qpXqFLTVJ/QXMlXo1jsxQX86kPR0JW/i2ezkfWM39UiC+fg=
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
index 35fcacbdf0f..5944d3a34eb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2680,7 +2680,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
 	struct merge_options o;
-	int merge_arg_len, oneline_offset, ret;
+	int merge_arg_len, oneline_offset, can_fast_forward, ret;
 	static struct lock_file lock;
 	const char *p;
 
@@ -2765,6 +2765,37 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		}
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
+		rollback_lock_file(&lock);
+		ret = fast_forward_to(&commit->object.oid,
+				      &head_commit->object.oid, 0, opts);
+		goto leave_merge;
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.17.0.windows.1.15.gaa56ade3205


