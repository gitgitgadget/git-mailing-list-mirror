Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB887C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D5C207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifXpwex/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJRvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:51:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46311 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJRvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:51:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id w4so1599054edv.13
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P9viWhQnWu0BgQ5CRfbADlrAq5dIrIvowrryXcXLOEI=;
        b=ifXpwex/Me8iYHKlFBREsDcv9v7pTMrjA9lTw/eGNN8rKxADqw84bfo1C/0gyuIIWa
         KLVHpRT6yQ9zWwaBB5KYuGTk8JqmuLD7dKrAgQQpGQBvFv5m2gd8i8w7squG5s/MjjK9
         80+zDoHtDICoWNIr0I3DGzhOMU/y/r11hcdrYSZCBBcshP0/OJEH5S8t6JvBeYsh6Xl/
         fuhUcMEtd/qL++UxrtU5qaWC7p6qdS6bzgO+E5iZcpPjvAWtpRmgOPfmkMdUQuLUYcZ6
         GIku6cuq0wealyZVfNUM5Ik5AB4duDDe9lUsQXgS/KyFE87Hn4AabXT9GdGYsZhGq6hX
         8Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P9viWhQnWu0BgQ5CRfbADlrAq5dIrIvowrryXcXLOEI=;
        b=NE7Df3IJtKd6bFksBcWYiF6rQwZ9FrC/v94hKVjUI3AKhFVykLRQVFH4BA3jHnMpsA
         mChvEHnnVT/0WDuTcI0eCzzCPF5L8+NPsep3rIKNBfKMMyMCPfXa3wp+h28FOgeAB8h/
         8uyX+lK4+9W4GhFjL2y12j+DmVHIHZtj7GxZFu4Zto5+R+t5nTtoPGn9DWCC2175SgBX
         djKJPkuhNqDYpnzt2pAQD7cW8/0hBv+kGaLwWIojTf+J8GyK8GpeMzc6prfzyolqLESA
         wKPrtMoQ/WLGm0Y/tvwT0Z3REfkNy/V7EJjMMav8XSeax+LktZFwPsxxR4/xQ7XdPwpc
         bABQ==
X-Gm-Message-State: AGi0PuYukD+Ff3IPIlSFtsDEig/lISTyx0oVhXvA6c1eEBGBMiW2I06Z
        A16jBwMlvXvn6zqurppCVHzwHa1O
X-Google-Smtp-Source: APiQypKg7mXbMRx6lsjkDQqgPIHQZttFMx/idCYJxHaL9v+DTlHfl9elekOPAj/cIggD6d+WjHKk6g==
X-Received: by 2002:a17:906:298f:: with SMTP id x15mr4967635eje.380.1586541096242;
        Fri, 10 Apr 2020 10:51:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm177551ejj.63.2020.04.10.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:51:35 -0700 (PDT)
Message-Id: <0d94eea376a65304bc31fd1841216a04b5c15709.1586541094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 17:51:32 +0000
Subject: [PATCH v2 1/3] rebase -i: mark commits that begin empty in todo
 editor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While many users who intentionally create empty commits do not want them
thrown away by a rebase, there are third-party tools that generate empty
commits that a user might not want.  In the past, users have used rebase
to get rid of such commits (a side-effect of the fact that the --apply
backend is not currently capable of keeping them).  While such users
could fire up an interactive rebase and just remove the lines
corresponding to empty commits, that might be difficult if the
third-party tool generates many of them.  Simplify this task for users
by marking such lines with a suffix of " # empty" in the todo list.

Suggested-by: Sami Boukortt <sami@boukortt.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 3 ++-
 sequencer.c                  | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..8ab0558aca2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -620,7 +620,8 @@ commits that started empty, though these are rare in practice.  It
 also drops commits that become empty and has no option for controlling
 this behavior.
 
-The merge backend keeps intentionally empty commits.  Similar to the
+The merge backend keeps intentionally empty commits (though with -i
+they are marked as empty in the todo list editor).  Similar to the
 apply backend, by default the merge backend drops commits that become
 empty unless -i/--interactive is specified (in which case it stops and
 asks the user what to do).  The merge backend also has an
diff --git a/sequencer.c b/sequencer.c
index e528225e787..ce9fd27a878 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4656,6 +4656,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			strbuf_addf(&buf, "%s %s %s", cmd_pick,
 				    oid_to_hex(&commit->object.oid),
 				    oneline.buf);
+			if (is_empty)
+				strbuf_addf(&buf, " %c empty",
+					    comment_line_char);
 
 			FLEX_ALLOC_STR(entry, string, buf.buf);
 			oidcpy(&entry->entry.oid, &commit->object.oid);
@@ -4861,6 +4864,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
+		if (is_empty)
+			strbuf_addf(out, " %c empty", comment_line_char);
 		strbuf_addch(out, '\n');
 	}
 	return 0;
-- 
gitgitgadget

