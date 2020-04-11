Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D807C2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EAB2078E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 02:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy9ufmqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDKCoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:44:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45482 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgDKCoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 22:44:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id v5so4203609wrp.12
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P9viWhQnWu0BgQ5CRfbADlrAq5dIrIvowrryXcXLOEI=;
        b=Wy9ufmqoeNZVRpqu4xkVhULO1YcQ7SsNT+4dgUe9/lQLgulsgSdNxXgySo+X1IKFAr
         zWPmN3yY4fWwPX/tKkVD2VXdP3U2HQ6oNUKP2MwSI1HT9h9V+gWTn1JP7QT7qIFgekJz
         YQSgBJ38oKTgoNa97mFJGm4cOX68MD20+0Fa2+0v4dx6G5xNOqkuwxz/7wqKmM9fxVPJ
         U5m6be4PQwXDqdAsI7cSMKcksCcarF1vfmcEm5WKqUOzZTlUGvzRJWypvS4qLxGyiyMm
         +uMTSXR3JqvqeOPruBiJMiMZv9zDL6tnCkWQLT/Xo1baRVmZTdy2r1EIYlqqnjdstRAI
         Kjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P9viWhQnWu0BgQ5CRfbADlrAq5dIrIvowrryXcXLOEI=;
        b=GfGmaxcDwNi3tSlt39q1qEQxnQyBPnh9az7pv6PafeRVvn4IQBjl1ok8JCJDe9QgGQ
         qZLy0zwXdpJnJUpj8CUVH2a9xKZRZxCQtSG8ukEHyt7d62Pq56dJeoAhR1cq2MiH/NQN
         xutJcOwubgVKnYb86/APqMHPRnTTUDoaT2ub/J9M9okcyojFszQu+67EM4U35mLDVYHW
         mJlKdc+Pka43AvsTHP2v/c7lY52Uhc4N17pN+LdiOzKuJ2RB9eRYEMKMsV6wsuZ9tF8O
         ZvhFEWSaFYiGo4uMBrnxORqGSsRM9TexeVRV8v9FSN6vgJHb6ZtJ+ztVrLP6szx58wSM
         edTQ==
X-Gm-Message-State: AGi0PuaEiPMmHVqs70K1f2ng/S/NXBAqNrgfN5vLQFWHCIgCI1dwAlb2
        Dnhif3Pk5+0izbTpze2yx40O9ct6
X-Google-Smtp-Source: APiQypJALGPbF+m/fnsZ2iwRKeVp5sV3XMpZU0c8QMh0a0EtIU7JNXGhoNlEHnQEKr/jJRBA7eg7rA==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr7410630wrn.365.1586573070059;
        Fri, 10 Apr 2020 19:44:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e23sm5466785wra.43.2020.04.10.19.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 19:44:29 -0700 (PDT)
Message-Id: <0d94eea376a65304bc31fd1841216a04b5c15709.1586573067.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
References: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 02:44:24 +0000
Subject: [PATCH v3 1/4] rebase -i: mark commits that begin empty in todo
 editor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com, Elijah Newren <newren@gmail.com>,
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

