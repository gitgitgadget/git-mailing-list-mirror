Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98839211B4
	for <e@80x24.org>; Tue,  4 Dec 2018 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLDWmq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 17:42:46 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36107 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 17:42:46 -0500
Received: by mail-qk1-f201.google.com with SMTP id h68so18417275qke.3
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BWitzYN19xdtZiBhNuBpTvVnU4rFTJBe+3yzSx+f/Ko=;
        b=CXzCcpb5B4F81nOm+b135skJXaNecTiW67k3IpiTymp3BQCsWxi/Z3aGkEk23Y1g1K
         w8hiH4o57PoVyo8LKSnylFO8nKMM+f10cUGkJxbJ36zlD5tX4YLBrq0WNIQQ86yAp95y
         5lLtByLP1MV71BuLHYWPG5PJbzst++fW+Jcjif/KSp82iYAPz9EouwxIDbHlDnZTT5KF
         YDyPNg0sSmMBuxSw/7hQQi64vEzE6qzFEiPdXvhkuTl6T4YKqKZDgWUe8TjcWtpkIHCS
         75JkyXpt8bbuqp2tC2oICRQuHhYevEY8vuZdCgjc2XfsJVoPiVW8GqIK8lpXtDQoX7fm
         /ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BWitzYN19xdtZiBhNuBpTvVnU4rFTJBe+3yzSx+f/Ko=;
        b=adyVhrRTauH8IOo1tt9IQVPCT84GGWohFIV3qTUTwnSPyqox+sgnsiFV1/EDz7hOG+
         EH2sbsldPAysor5uvNaM1GmpAlu6fzbWAsvtvEKmLcqIFwVo9XP4Iamz9zvYpU3RCnpF
         OSrsGK7Jd5qxetRwj/+MzQKi/dn8X1WiTkQqqhEUiul1C6d55C9joQF8uymEFuqtZGRx
         5W5TdOdDlYzvSH4UfLMCx+kU2vvRvOigOlO2F2F9IRexwST1n6t7OivOVIALCh0XrrKo
         O9NAzt2XuzJ4Uc7VRSXqyNt0J+W1NHE+a9QEi2b38CVevRZ676vtXiYLes+K6JbgNfEt
         wnFA==
X-Gm-Message-State: AA+aEWZ+sKRJtyvyXIHWs2cBOLwCpeEHuIyecNjNeB3+s1XLEyRIw1au
        P52qQ4zJrhzEkmRTnPljBoYPoe+NSM7ABJNKih1lH0aM5dsESXdl0pS19RD6EOt53qLlCYXbx0H
        fvmmkCwdxdTh2m9W42DeGgadtGpZxq7e6AIRpvzX/oxigcm1PI5Cs835NJdRSRfrUbnHMg+8YX1
        x5
X-Google-Smtp-Source: AFSGD/UzEd+cauxIUqODdnoHEBHzHlsczEb05XNkG13CYqLMVlSXVggTrJaKED0ymyLOqHfKe/eRsmjB2IfWNDT7Y4bE
X-Received: by 2002:a0c:9199:: with SMTP id n25mr17009852qvn.49.1543963365094;
 Tue, 04 Dec 2018 14:42:45 -0800 (PST)
Date:   Tue,  4 Dec 2018 14:42:38 -0800
Message-Id: <20181204224238.50966-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH on sb/more-repo-in-api] revision: use commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching into a repository, a connectivity check is first made by
check_exist_and_connected() in builtin/fetch.c that runs:

  git rev-list --objects --stdin --not --all --quiet <(list of objects)

If the client repository has many refs, this command can be slow,
regardless of the nature of the server repository or what is being
fetched. A profiler reveals that most of the time is spent in
setup_revisions() (approx. 60/63), and of the time spent in
setup_revisions(), most of it is spent in parse_object() (approx.
49/60). This is because setup_revisions() parses the target of every ref
(from "--all"), and parse_object() reads the buffer of the object.

Reading the buffer is unnecessary if the repository has a commit graph
and if the ref points to a commit (which is typically the case). This
patch uses the commit graph wherever possible; on my computer, when I
run the above command with a list of 1 object on a many-ref repository,
I get a speedup from 1.8s to 1.0s.

Another way to accomplish this effect would be to modify parse_object()
to use the commit graph if possible; however, I did not want to change
parse_object()'s current behavior of always checking the object
signature of the returned object.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on sb/more-repo-in-api because I'm using the repo_parse_commit()
function.

A colleague noticed this issue when handling a mirror clone.

Looking at the bigger picture, the speed of the connectivity check
during a fetch might be further improved by passing only the negotiation
tips (obtained through --negotiation-tip) instead of "--all". This patch
just handles the low-hanging fruit first.
---
 revision.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index b5108b75ab..e7da2c57ab 100644
--- a/revision.c
+++ b/revision.c
@@ -212,7 +212,20 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(revs->repo, oid);
+	/*
+	 * If the repository has commit graphs, repo_parse_commit() avoids
+	 * reading the object buffer, so use it whenever possible.
+	 */
+	if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
+		struct commit *c = lookup_commit(revs->repo, oid);
+		if (!repo_parse_commit(revs->repo, c))
+			object = (struct object *) c;
+		else
+			object = NULL;
+	} else {
+		object = parse_object(revs->repo, oid);
+	}
+
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
-- 
2.19.0.271.gfe8321ec05.dirty

