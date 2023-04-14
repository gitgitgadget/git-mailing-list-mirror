Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67CC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNVOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNVOd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:14:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2055A6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:14:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r184so4325776ybc.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681506871; x=1684098871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xY8BsHyUfbus95CMBdLo5X8XyY9z34A1cF3hARG8A+o=;
        b=Fo18Maypb9dz3PoQ1ppm1Zb19RAQgM9p9FJbXoPt1Yas1GmVF3MNq8SAHwnmj44Hau
         nCIDRV3XujLu68FUmEL3+udUPgBkAZePvCtTKhe4eY84FNecmz/fg0WiGHOPgXYjb5L6
         iwJWZB9BhZyeS4U4czYtMqUP7HSOGE5owbsfiOwUcWCfebzwpzUQhPgQ149nS8HFnMQ5
         RhG1gLvnuucKpNBPTCxwl56TywrUYt0igkpy8RrwxPZ6K8btSsXFnYz9iKdv9MnufFkC
         MeZWIEdXkIGQvxkbitp7Pa89iwo3DIshjXjDR1VzNqKVC8Om/9XicbmRDL0PsrHDcriU
         /vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506871; x=1684098871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY8BsHyUfbus95CMBdLo5X8XyY9z34A1cF3hARG8A+o=;
        b=Li7gN96hGoEIshleoX8FuoeC9W3B2t39xJXXrZ8VsZ0BU75kKNzI6UvErSqBKREq5w
         IlsuYbKTIdBviF0eLNB90ldlaW8rumoBZRpmSRMeu1zz2IqbYeGMDi/+E35FW06Fz4Vt
         b+EMhLbBK6kCgUdKAEHsBsSmXr4MEpCDjMRAVt27XpMK+4JCAdKkCKGOTCVL5d0J28SI
         aSTBGQ1VA4xeFi+A5AtyMiAMs4J4N+8wSFGMruCZxZxZTYo/nTELbmogytgYdmD105S+
         yLc5lqBI52yf3Sq/34aHkQbKNtnCijFCCUmuGVoHHzo9Hv+MGTScH9MbqVz2EmEgv09d
         A8Aw==
X-Gm-Message-State: AAQBX9c1QYKLA087sp5X9tJBMXXhmjKyXOZcID8ka3zpmnowYXbLHSCe
        a034tYQBQbdhWgtrlSKcBZiZ+g==
X-Google-Smtp-Source: AKy350YC/SgASy5HQ/uOsoQdCsJ6KxurazCA8Vb7Pi9yNDSZlVfI2KYZZ1PaJUk6N2Qa5J4BvkW/Gg==
X-Received: by 2002:a25:73c6:0:b0:b0f:dde5:e389 with SMTP id o189-20020a2573c6000000b00b0fdde5e389mr6824583ybc.41.1681506871511;
        Fri, 14 Apr 2023 14:14:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b1-20020a259201000000b00b922881eac6sm101940ybo.20.2023.04.14.14.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 14:14:31 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:14:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/5] revisions.txt: document more special refs
Message-ID: <ZDnCMegeiw0kT5oj@nand.local>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
 <ebcf2426-db40-e967-9db5-532869cac8ff@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebcf2426-db40-e967-9db5-532869cac8ff@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 12:49:16PM -0700, Victoria Dye wrote:
> To help with that, you could create visual separation in the rendered doc by
> adding a '+' between each special ref description; converting them into a
> bullet pointed list would also work, I think.

In case you're looking for another option, you could convert these into
a description list, which would be consistent with the outer-most list
in this document.

I had to refresh myself on how the spacing and continuations work in
ASCIIdoc, but I think the following (which applies on top of this patch)
is right:

--- 8< ---
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 98b8f89bc8..b34f981622 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -30,7 +30,7 @@ characters and to avoid word splitting.
   explicitly say 'heads/master' to tell Git which one you mean.
   When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
-
++
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
     `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
@@ -44,26 +44,34 @@ characters and to avoid word splitting.
   . otherwise, 'refs/remotes/<refname>' if it exists;

   . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
+
 +
-`HEAD` names the commit on which you based the changes in the working tree.
-`FETCH_HEAD` records the branch which you fetched from a remote repository
-with your last `git fetch` invocation.
-`ORIG_HEAD` is created by commands that move your `HEAD` in a drastic
-way (`git am`, `git merge`, `git rebase`, `git reset`),
-to record the position of the `HEAD` before their operation, so that
-you can easily change the tip of the branch back to the state before you ran
-them.
-`MERGE_HEAD` records the commit(s) which you are merging into your branch
-when you run `git merge`.
-`REBASE_HEAD`, during a rebase, records the commit at which the
-operation is currently stopped, either because of conflicts or an `edit`
-command in an interactive rebase.
-`REVERT_HEAD` records the commit which you are reverting when you
-run `git revert`.
-`CHERRY_PICK_HEAD` records the commit which you are cherry-picking
-when you run `git cherry-pick`.
-`BISECT_HEAD` records the current commit to be tested when you
-run `git bisect --no-checkout`.
+  `HEAD`:::
+    names the commit on which you based the changes in the working tree.
+  `FETCH_HEAD`:::
+    records the branch which you fetched from a remote repository with
+    your last `git fetch` invocation.
+  `ORIG_HEAD`:::
+    is created by commands that move your `HEAD` in a drastic way (`git
+    am`, `git merge`, `git rebase`, `git reset`), to record the position
+    of the `HEAD` before their operation, so that you can easily change
+    the tip of the branch back to the state before you ran them.
+  `MERGE_HEAD`:::
+    records the commit(s) which you are merging into your branch when you
+    run `git merge`.
+  `REBASE_HEAD`:::
+    during a rebase, records the commit at which the operation is
+    currently stopped, either because of conflicts or an `edit` command in
+    an interactive rebase.
+  `REVERT_HEAD`:::
+    records the commit which you are reverting when you run `git revert`.
+  `CHERRY_PICK_HEAD`:::
+    records the commit which you are cherry-picking when you run `git
+    cherry-pick`.
+  `BISECT_HEAD`:::
+    records the current commit to be tested when you run `git bisect
+    --no-checkout`.
+
 +
 Note that any of the 'refs/*' cases above may come either from
 the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
--- >8 ---

Thanks,
Taylor
