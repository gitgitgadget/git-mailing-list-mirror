Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07EC05027
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCNRnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCNRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 13:43:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF635A7
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 10:43:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a2so17416608plm.4
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678815831;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l50St3JGi2L2gKBlRSZJnHQFe7ssJSGleBVnXjDTfek=;
        b=LkOH7E7gmnHuSrz+6fb5aPKxBpW2NIQpBxwlcio3ueehI+Sd/TFlnX07GI3fg67VUP
         gH6XNNue+WwBhBBpNYHV+fmD4/1/6z9SBX/BgHkke5r2VCXRqyPPAUsM9Lx2tWQBn1Ei
         G83rRTeEynVI/ra7+w7YpvmfbRL6grmDI1Rs3CR6662PURvrx1XHMH0AvjIvyVka5dx/
         1sIiqUMGecObsLa/5pUcPWnoLZv237c4bP9HsFAB2wcN+hXOIdoy/c6oT62g8/Hh2D6j
         SSf7Sm1x4nuc5eQpWTYgbWVoZ+dkKu0emwn9PxEtoY/VqMiBm+7bovxlBpsvPl3fRlVg
         palQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678815831;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l50St3JGi2L2gKBlRSZJnHQFe7ssJSGleBVnXjDTfek=;
        b=gaajJnqQCpLUS/0S3fjlLW5aXRtFSbp7GmvJjJX1tVQsD71GnJuJEi+FvrSEWITE7j
         MloU2bfPUrVN2odQVhCqJWjPmWJX4D/oYFmqXQf71Y1npm0Btft0IWzJmHT6aLd40Ikz
         1g/4kkTNoauYQjgsKnKoSqKhUgWrpldmm9PxNprlVTrGu/w6UZ5S5UsivOVunv9DgezQ
         PfCMdYMWJzVqqQohkbK4QUzTSkc0zijmQZNFF4ljDoL0KIryH2fRmNDlg7ENPUzs1mzd
         xJaDryCN2nyrwm4lXEDmglIBFHe2P0Bxr0gU5D96DNqdliyAqN/yCT97gAvp30+27Rvv
         HaNg==
X-Gm-Message-State: AO0yUKXoPrDcXlTt1cBEzcvuutixaQN273sC2igDt0Hpt6q5Iwl0/Uu0
        O+9etjWdiQr1TvXGlRai6F3XL1iUvj4=
X-Google-Smtp-Source: AK7set+dpEMAFYsZWqiDyQxTlutgIHIGQO16kU8Mdn4e+HQtd6P2zkOu88RP+mPSCpLc7zvRv7FHhg==
X-Received: by 2002:a17:902:8308:b0:1a0:4341:4cd9 with SMTP id bd8-20020a170902830800b001a043414cd9mr7636882plb.31.1678815831396;
        Tue, 14 Mar 2023 10:43:51 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b00198fb25d09bsm2017059plh.237.2023.03.14.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 10:43:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare
 repository
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
        <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
        <xmqqttynqnnj.fsf@gitster.g>
Date:   Tue, 14 Mar 2023 10:43:49 -0700
In-Reply-To: <xmqqttynqnnj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        14 Mar 2023 09:54:24 -0700")
Message-ID: <xmqqa60fqld6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Since referring to in-tree attributes is often useful with any
> command, not limited to "diff", I wonder if it is feasible to add
> support for the --attr-source=<tree> option globally, instead of
> implementing such an option piecemeal.  If your "git diff" in a bare
> repository starts honoring attributes recorded in HEAD, don't your
> users expect your "git log" and "git show" to also honor them?

Just for illustration, here is one way to do so.

The implementation goes in the opposite direction from the more
recent trend, which is why I am not making it an official patch, but
with this you can do things like:

  $ git --attr-source=e83c5163 check-attr whitespace cache.h
  cache.h: whitespace: unspecified
  $ git --attr-source=e2f6331a142^ check-attr whitespace cache.h
  cache.h: whitespace: set
  $ git --attr-source=HEAD check-attr whitespace cache.h
  cache.h: whitespace: indent,trail,space

where e83c5163 is the very first version of Git from 2005 where
.gitattributes did not exist, e2f6331a142^ is the last version
before we set whitespace to indent,trail,space, and HEAD is a more
recent version of our source tree.

In the following illustration patch, the attr-source tree object
name is kept as a string as long as possible and at the very last
minute when we call git_check_attr() for the first time we turn it
into an object id.  This is because at the very early stage when we
parse the global option we may not even know where our repository is
(hence do not have enough information to parse HEAD).  We also figure
out is_bare_repository() late in the process for the same reason.



 attr.c | 29 +++++++++++++++++++++++++++++
 attr.h |  6 ++++++
 git.c  |  3 +++
 3 files changed, 38 insertions(+)

diff --git c/attr.c w/attr.c
index 1053dfcd4b..2fd6e0eab2 100644
--- c/attr.c
+++ w/attr.c
@@ -1165,12 +1165,41 @@ static void collect_some_attrs(struct index_state *istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
+static const char *default_attr_source_tree_object_name;
+
+void set_git_attr_source(const char *tree_object_name)
+{
+	default_attr_source_tree_object_name = xstrdup(tree_object_name);
+}
+
+
+static struct object_id *default_attr_source(void)
+{
+	static struct object_id attr_source;
+
+	if (is_null_oid(&attr_source)) {
+		if (!default_attr_source_tree_object_name &&
+		    is_bare_repository())
+			default_attr_source_tree_object_name = "HEAD";
+
+		if (default_attr_source_tree_object_name &&
+		    is_null_oid(&attr_source))
+			get_oid(default_attr_source_tree_object_name, &attr_source);
+	}
+	if (is_null_oid(&attr_source))
+		return NULL;
+	return &attr_source;
+}
+
 void git_check_attr(struct index_state *istate,
 		    const struct object_id *tree_oid, const char *path,
 		    struct attr_check *check)
 {
 	int i;
 
+	if (!tree_oid)
+		tree_oid = default_attr_source();
+
 	collect_some_attrs(istate, tree_oid, path, check);
 
 	for (i = 0; i < check->nr; i++) {
diff --git c/attr.h w/attr.h
index 9884ea2bc6..a77e3713b2 100644
--- c/attr.h
+++ w/attr.h
@@ -135,6 +135,12 @@ struct git_attr;
 struct all_attrs_item;
 struct attr_stack;
 
+/*
+ * The textual object name for the tree-ish used by git_check_attr()
+ * when NULL is given to tree_oid.
+ */
+void set_git_attr_source(const char *);
+
 /*
  * Given a string, return the gitattribute object that
  * corresponds to it.
diff --git c/git.c w/git.c
index 6171fd6769..21bddc5718 100644
--- c/git.c
+++ w/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "run-command.h"
 #include "alias.h"
+#include "attr.h"
 #include "shallow.h"
 
 #define RUN_SETUP		(1<<0)
@@ -307,6 +308,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			} else {
 				exit(list_cmds(cmd));
 			}
+		} else if (skip_prefix(cmd, "--attr-source=", &cmd)) {
+			set_git_attr_source(cmd);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
