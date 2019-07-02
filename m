Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA23B1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfGBAyE (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 20:54:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50638 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfGBAyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 20:54:03 -0400
Received: by mail-pg1-f202.google.com with SMTP id m4so3060318pgs.17
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gb4GyAar341oN+LvmlX239POz459P8bdS2fhQFbNgwc=;
        b=XiuNHpDsW+ofYPAKF0BUXKk45WQDKNF4L51rb/5YNXBtEZXRf7Ubhqgi11pCeWwc5d
         AZ+Xg33Up533awcR2S4egEg6t51kIt/OL9pMF4UMxoI1oCWccWFJQ5uFcGEHcOSG0Fhd
         sOWpNYYRmKegqaJiOR34XHsYSy0db/zhkOiY4Z5D/xElfMFErqfpDbbHc2ei/736O9tR
         WM4zSx3JkAi9PWS5ZayebmvNPaWJocduLDh21mxmUQsj3tCP6A7aUGc+7g4RQz9YERUR
         DjXgY5Q4jNNGQPbDoJKtMMIiC4XK+spovJf4czL69fsVITb+1soI+Sr5++4+WoUM1TrT
         v5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gb4GyAar341oN+LvmlX239POz459P8bdS2fhQFbNgwc=;
        b=ZpGzgxDERT1XOpu8gTQgbtF0iKezRsdFIfLUdldRjJtkRJ6eeWgI2Vn2VNhxniUUPd
         zLiyL3TYydaMxz/77pwNcTp2bZcdmyZNieVdW0WXpACrvoJK2ciFfMjz09H+f6rRNr/n
         4kQF4TzrVO2FDWtPDtWLVcRCUuAcZ/VnQ9VaeqL0TBZl2gr5tOQzk0BqKGoTfAG4OBaT
         nMClkGSsdxXV92LOwvQEH4SkdS2P4S6x1qbrPaxXtyuBJth3G1hTEvNZYo/q5wu2vtsD
         Ag3hCqS5MzqfszLAUyOdZqfCcImBFb0+ApPLOoAJe2UJxeZk0bZiZGMV9YWzsxytceW9
         Iyvg==
X-Gm-Message-State: APjAAAXYlsODZ9KJqBgEMBwMjZN7EIjPj4VvFheIFwknelHg+YvK2LCc
        Ah663WjVrkv0kxQ2gHTfhKxy0c1NG8X54jkArudbWBweMtdbgW4ROGRVnr3qf80HQ94/b/aQIXY
        hUcDaSWkPJp+aVXnYtk8GpLY1leR24019oFkfA//FLJ0haN7KMcJ1UIPA+H6HMv/8PLAP7hrWjA
        ==
X-Google-Smtp-Source: APXvYqyv9yIN38fJke0ZapFeFGexwahhZaRIU7gxoM0sxN7Qy7m+aA+vt/qPdEX8E20PhhGJBF5bZH/ZTulrCEtfq8Q=
X-Received: by 2002:a63:593:: with SMTP id 141mr26403489pgf.78.1562028842101;
 Mon, 01 Jul 2019 17:54:02 -0700 (PDT)
Date:   Mon,  1 Jul 2019 17:53:40 -0700
Message-Id: <20190702005340.66615-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] transport-helper: enforce atomic in push_refs_with_push
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach transport-helper how to notice if skipping a ref during push would
violate atomicity on the client side. We notice that a ref would be
rejected, and choose not to send it, but don't notice that if the client
has asked for --atomic we are violating atomicity if all the other
pushes we are sending would succeed. Asking the server end to uphold
atomicity wouldn't work here as the server doesn't have any idea that we
tried to update a ref that's broken.

The added test-case is a succinct way to reproduce this issue that fails
today. The same steps work fine when we aren't using a transport-helper
to get to the upstream, i.e. when we've added a local repository as a
remote:

  git remote add ~/upstream upstream

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t5541-http-push-smart.sh | 58 ++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |  6 ++++
 transport.c                | 15 +++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ef8763e06..b57f6d480f 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,6 +177,64 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push --atomic also prevents branch creation' '
+	# Make up/master
+	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
+	git init --bare "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	up="$HTTPD_URL"/smart/atomic-branches.git &&
+	test_commit atomic1 &&
+	test_commit atomic2 &&
+	git push "$up" master &&
+	# Make master incompatible with up/master
+	git reset --hard HEAD^ &&
+	# Add a new branch
+	git branch atomic &&
+	# --atomic should roll back creation of up/atomic
+	test_must_fail git push --atomic "$up" master atomic &&
+	git ls-remote "$up" >up-remotes &&
+	test_must_fail grep atomic up-remotes
+'
+
+test_expect_success 'push --atomic shows all failed refs' '
+	# Make up/master, up/allrefs
+	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
+	git init --bare "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
+	test_commit allrefs1 &&
+	test_commit allrefs2 &&
+	git branch allrefs &&
+	git push "$up" master allrefs &&
+	# Make master and allrefs incompatible with up/master, up/allrefs
+	git checkout allrefs &&
+	git reset --hard HEAD^ &&
+	git checkout master &&
+	git reset --hard HEAD^ &&
+	# --atomic should complain about both master and allrefs
+	test_must_fail git push --atomic "$up" master allrefs >&output &&
+	grep master output &&
+	grep allrefs output
+'
+
+test_expect_success 'push --atomic indicates collateral failures' '
+	# Make up/master, up/collateral
+	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-collateral.git &&
+	git init --bare "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	up="$HTTPD_URL"/smart/atomic-collateral.git &&
+	test_commit collateral1 &&
+	test_commit collateral2 &&
+	git branch collateral &&
+	git push "$up" master collateral &&
+	# Make master incompatible with up/master
+	git reset --hard HEAD^ &&
+	# --atomic should mention collateral was OK but failed anyway
+	test_must_fail git push --atomic "$up" master collateral >&output &&
+	grep "master -> master" output &&
+	grep "collateral -> collateral" output
+'
+
 test_expect_success 'push --all can push to empty repo' '
 	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
 	git init --bare "$d" &&
diff --git a/transport-helper.c b/transport-helper.c
index c7e17ec9cb..6b05a88faf 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -853,6 +853,7 @@ static int push_refs_with_push(struct transport *transport,
 {
 	int force_all = flags & TRANSPORT_PUSH_FORCE;
 	int mirror = flags & TRANSPORT_PUSH_MIRROR;
+	int atomic = flags & TRANSPORT_PUSH_ATOMIC;
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref;
@@ -872,6 +873,11 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
+			if (atomic) {
+				string_list_clear(&cas_options, 0);
+				return 0;
+			} else
+				continue;
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport.c b/transport.c
index f1fcd2c4b0..f4d6b38f9d 100644
--- a/transport.c
+++ b/transport.c
@@ -1226,10 +1226,23 @@ int transport_push(struct repository *r,
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
 
-		if (!quiet || err)
+		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
+			for (struct ref *it = remote_refs; it; it = it->next)
+				switch (it->status) {
+				case REF_STATUS_NONE:
+				case REF_STATUS_UPTODATE:
+				case REF_STATUS_OK:
+					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
+				default:
+					continue;
+				}
+		}
+
+		if (!quiet || err) {
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					reject_reasons);
+		}
 
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
-- 
2.22.0.410.gd8fdbe21b5-goog

