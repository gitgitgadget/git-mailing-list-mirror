Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312C6C433E1
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9A622258
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKlyXkWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgFUFVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFUFVd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 01:21:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555FEC061794
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so1012744wrn.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tWAkzOfRxeIqJsNcY8oRzXMnT5hdn69xa1MZAS1QIPQ=;
        b=LKlyXkWOiduB2iyN7brCZDRUrHYs9eBhuU3KUZtk4erLoNa9ojhgYzRiS+ikwFcznw
         Vm/LCq6rXa4DgRECLb0XlzfLJUzz464EV+OOnMfLNMR6om3XGr9jKqPfLbRlPOIjhK90
         huWGbryMkwSHP3g/ezN0tiBQvVdkvG3EN9ewKwMwUloX8bu25ZmyupBsyyvJskXSIsPe
         WoH59yVPhbMEimHhCQu6RNnIF7O08kjbXrFX4ylFd8GwSDHm+5Tnn1jFp2y7LolRRSU1
         3VuLztRFe1UGcLUdXwNuetBLeMGn7F4GX67QQDZlGLzScjc3iku4agm6aP/oMvAj+L9J
         Fe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tWAkzOfRxeIqJsNcY8oRzXMnT5hdn69xa1MZAS1QIPQ=;
        b=FOXXmn6A40TLAxSxT+ecy+G8NbUsJi9wzZhrY73ZLd+io1tQqMOFG9UwNcvt2khzdt
         Apx7gHgTE+bAwUuO4LEycL9ax9D6ecGH9JQXcnrw4YpgCn1r/74dpkRKWOUYxFu1QheT
         YdYm4RssBkC4fcFN89EGMTX9Rq8Kft+671fb1XLw27AWPd+lEZjxTp0YB/afaJKvy9tt
         F2TdU1ZZX71Vr2p1t236sIca1TDwHHuAnUdHzaL5NO+x+U9QLdUCPvhYyK/MKIGYNCtv
         oqaRndhVD3N2ycJgXeW+9lc3LBK7LmiP0adKBasZtiZvclX6x4cladjICKSKz/Uub0gK
         aJVw==
X-Gm-Message-State: AOAM531QuCEjvQd6GPg0pvwzDe/qjs2q4uDnTROIS08MJO2Z6vWtkeA6
        vu2YsSX8bRPY20CgBiTSbOttAg/1
X-Google-Smtp-Source: ABdhPJzuRYgDsPF+I6r2Of3bcpdge6Jh1PeLpto2bHPVgtLuQ/abwSVQlRZ6mTCfxYFwuIABef/ing==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr12376345wro.317.1592716891888;
        Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm12795516wrp.45.2020.06.20.22.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
Message-Id: <d99202f8e1443f517b16811b7d2ba2593898e9d0.1592716887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
References: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
        <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Jun 2020 05:21:27 +0000
Subject: [PATCH v3 3/3] git-prompt: include sparsity state as well
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

git-prompt includes the current branch, a bunch of single character
mini-state displayers, and some much longer in-progress state
notifications.  The current branch is always shown.  The single
character mini-state displayers are all off by default (they are not
self explanatory) but each has an environment variable for turning it
on.  The in-progress state notifications provide no configuration
options for turning them off, and can be up to 15 characters long (e.g.
"|REBASE (12/18)" or "|CHERRY-PICKING").

The single character mini-state tends to be used for things like "Do you
have any stashes in refs/stash?" or "Are you ahead or behind of
upstream?".  These are things which users can take advantage of but do
not affect most normal git operations.  The in-progress states, by
contrast, suggest the user needs to interact differently and may also
prevent some normal operations from succeeding (e.g. git switch may show
an error instead of switching branches).

Sparsity is like the in-progress states in that it suggests a
fundamental different interaction with the repository (many of the files
from the repository are not present in your working copy!).  A few
commits ago added sparsity information to wt_longstatus_print_state(),
grouping it with other in-progress state displays.  We do similarly here
with the prompt and show the extra state, by default, with an extra
    |SPARSE
This state can be present simultaneously with the in-progress states, in
which case it will appear before the other states; for example,
    (branchname|SPARSE|REBASE 6/10)

The reason for showing the "|SPARSE" substring before other states is to
emphasize those other states.  Sparsity is probably not going to change
much within a repository, while temporary operations will.  So we want
the state changes related to temporary operations to be listed last, to
make them appear closer to where the user types and make them more
likely to be noticed.

The fact that sparsity isn't just cached metadata or additional
information is what leads us to show it more similarly to the
in-progress states, but the fact that sparsity is not transient like the
in-progress states might cause some users to want an abbreviated
notification of sparsity state or perhaps even be able to turn it off.
Allow GIT_PS1_COMPRESSSPARSESTATE to be set to request that it be
shortened to a single character ('?'), and GIT_PS1_OMITSPARSESTATE to be
set to request that sparsity state be omitted from the prompt entirely.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 179b96e4936..e6cd5464e5c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -74,6 +74,11 @@
 # revert, cherry-pick, or bisect, the prompt will include information
 # related to the operation, often in the form "|<OPERATION-NAME>".
 #
+# When the repository has a sparse-checkout, a notification of the form
+# "|SPARSE" will be included in the prompt.  This can be shortened to a
+# single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
+# by setting GIT_PS1_OMITSPARSESTATE.
+#
 # By default, __git_ps1 will compare HEAD to your SVN upstream if it can
 # find one, or @{upstream} otherwise.  Once you have set
 # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
@@ -425,6 +430,13 @@ __git_ps1 ()
 		return $exit
 	fi
 
+	local sparse=""
+	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
+	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
+	   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
+		sparse="|SPARSE"
+	fi
+
 	local r=""
 	local b=""
 	local step=""
@@ -496,6 +508,7 @@ __git_ps1 ()
 	local i=""
 	local s=""
 	local u=""
+	local h=""
 	local c=""
 	local p=""
 
@@ -528,6 +541,11 @@ __git_ps1 ()
 			u="%${ZSH_VERSION+%}"
 		fi
 
+		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
+		   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
+			h="?"
+		fi
+
 		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
 			__git_ps1_show_upstream
 		fi
@@ -546,8 +564,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	local f="$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}$r$p"
+	local f="$h$w$i$s$u"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
gitgitgadget
