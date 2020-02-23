Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F609C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 10:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B89208C3
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 10:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk/6ANJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBWKPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:15:08 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38532 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWKPH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 05:15:07 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so3852522ywv.5
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 02:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT/T5yCIWZOcuyJFRVOF1MSij16ttYqNK1TDhGSGqY0=;
        b=Lk/6ANJF0uroyoV8kcqtSj4yAzPBxBMIXf4QMxAk1+AH8XuvKfR5nYdFhArYBPDmXS
         L68kYCyRaWZrDs4GX85A8Ba6kIkDJ97wp9eN5XPDf/6gu2DZmSiX9fD/nRQ42RMjG0Fb
         K8wzKuEEeREWBG7U3mPczseDM8HxLNxbMScsIF5KTgc+ydp3G8ErD98zPdK3Jc9ySp3e
         +kpIkse1DAixAgFvqSUjh9PjA+D27HGToLhtJXsj3vGCUiRhWKEGgI0pnE+5PwVevOB3
         vvMx1EivkvGfFYSimIPF9kQdKeE6elwtHQ3cstE+NnBVrcygeT+5ynxrbCLnKTzg+wYw
         1Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OT/T5yCIWZOcuyJFRVOF1MSij16ttYqNK1TDhGSGqY0=;
        b=b+wYTYV99pNIDGLYyfJrnVejyraUkb2YY0aDAFmfJR8BbExdJYm3WXcwhCg6fDXZec
         N+GFn90FIl7wc+WYKvHNyBPxolafLdK2EM5Zv8HrN1eZs3v2nXPpvK7l1nlkJMe20qRV
         5CUHAQZMLZcS5An8s/caMfbzbuOgBt/nQsYUChRCFonZyP7uxnn10KSzGUYprEvfyN6q
         ASJwx4hsDllOXLENT8uZPAESGsEV8faZA8A+pHBkCgEQ/7vPg3Cb0FMWjygpbU2xbHvC
         l4tUucpqabPx8X5kq2JjwFC9cok6XpTzrAMLkVDFQSfwkbt2IZisin6RJqFQjzH0M6XH
         TijA==
X-Gm-Message-State: APjAAAWRNrtG80tO3r8lD92lW/qcFdk5MaR88Oiq5Qdq2T94RYiEayvm
        IRKaQ/MbLscRS4I+m5xt/3JokNu3
X-Google-Smtp-Source: APXvYqxyekm4zZ3L8FGiVWgz3OubSpBirL+jlLMXX9uOxxHkil/4H7UpZKPqGip9nMNyTaNm7K1MSA==
X-Received: by 2002:a0d:d8cb:: with SMTP id a194mr35033263ywe.472.1582452906169;
        Sun, 23 Feb 2020 02:15:06 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id j11sm3621767ywg.37.2020.02.23.02.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 02:15:05 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] rebase: refuse to switch to branch already checked out elsewhere
Date:   Sun, 23 Feb 2020 05:14:07 -0500
Message-Id: <20200223101407.77036-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <20200223101407.77036-1-sunshine@sunshineco.com>
References: <20200220002932.5jws6qpnivlvxckw@glandium.org>
 <20200223101407.77036-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The invocation "git rebase <upstream> <branch>" switches to <branch>
before performing the rebase operation. However, unlike git-switch,
git-checkout, and git-worktree which all refuse to switch to a branch
that is already checked out in some other worktree, git-rebase switches
to <branch> unconditionally. Curb this careless behavior by making
git-rebase also refuse to switch to a branch checked out elsewhere.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/rebase.c  |  5 +++--
 t/t3400-rebase.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6154ad8fa5..41b9372c0b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1945,10 +1945,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		/* Is it a local branch? */
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", branch_name);
-		if (!read_ref(buf.buf, &options.orig_head))
+		if (!read_ref(buf.buf, &options.orig_head)) {
+			die_if_checked_out(buf.buf, 1);
 			options.head_name = xstrdup(buf.buf);
 		/* If not is it a valid ref (branch or commit)? */
-		else if (!get_oid(branch_name, &options.orig_head))
+		} else if (!get_oid(branch_name, &options.orig_head))
 			options.head_name = NULL;
 		else
 			die(_("fatal: no such branch/commit '%s'"),
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6e746dca00..9aa5268a06 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -377,4 +377,22 @@ test_expect_success 'rebase -c rebase.useBuiltin=false warning' '
 	test_must_be_empty err
 '
 
+test_expect_success 'switch to branch checked out here' '
+	git checkout master &&
+	git rebase master master
+'
+
+test_expect_success 'switch to branch not checked out' '
+	git checkout master &&
+	git branch other &&
+	git rebase master other
+'
+
+test_expect_success 'refuse to switch to branch checked out elsewhere' '
+	git checkout master &&
+	git worktree add wt &&
+	test_must_fail git -C wt rebase master master 2>err &&
+	test_i18ngrep "already checked out" err
+'
+
 test_done
-- 
2.25.1.526.gf05a752211

