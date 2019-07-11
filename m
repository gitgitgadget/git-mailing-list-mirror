Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3691F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGKRse (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:48:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54134 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfGKRse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:48:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so6513855wmj.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UA3lXy2X71j1pv53aEHS77wHr0WRVHNnOKpOM4lvBk=;
        b=kmy0kMyGihZuhlKdo8OcHIOSe82SzGjlhppgQ+vfueQ9IVliGQJFAKtNkVOJR/3ek6
         04S8SIeKd1+cAK3ozIA5KgkTWgRNm8NSCT54cYAFLz7GsyHiimc8A91ZnzDI8eEd7nI4
         MUm7y1IGljkEoGI7RTWdEffdHJSvesWCyNJuP3c/4Xt+9lK1HklWw4UhdLDGqoHhOo4H
         5n7s+soy64UuQLKiz2JlQ/5QItkZ3TQMPpisEXu3IerdN/Wgwl52PNuY790jjgWjYdUd
         1Ge8dWRHRxwB80FSlOUw6EtA05EiUV8S2yj2zgQlkCdr656vytAOO28k6FRxbnhlpc1Q
         wkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UA3lXy2X71j1pv53aEHS77wHr0WRVHNnOKpOM4lvBk=;
        b=WYE3vhj7sEB46U8P1BRI/Ls6AIUFpwY7my563BT4mNvjWyf5xFEuOhnXzI+ilIkx1n
         fuBRsqOjmeB7S0lHB4lWWJm2I4HlRVw+QHgJgCgGLO5JLL16YEH/tbHWCzafGYWAv+cq
         3YTwkI46S+QsKBrjAoKkDh74793dQDvAqtezifOP3wvDm/wUFCDusVPEY55Ob+2UEdx+
         XluuvRNES1WDzUQtKKpv05uBcFshf4K1ZJ5i7eVTUewSTW1byeyFBrxlvakhoWuiITHr
         zJu8J9VesBq/mwgvVn+2Tk2yA+ySYVI2m/QakrCB61PQXYLZKDstJc1LlRVmvy8mbb9f
         EDNQ==
X-Gm-Message-State: APjAAAU808C36E3nFQIyIWvylnCmHJquC2n8LAfzEtnfZbKZ8mUNfNv8
        fmnVC1jJqaJ9A8eOJ7fsw8jnvnzOyoc=
X-Google-Smtp-Source: APXvYqwJejMqoYBxVkOndKm0RpCx9XY7d5Qlef8+BMCDabaYsrynZ6P3J2FPEWjYGARTvmms1KY6Cw==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr4901400wmc.22.1562867311307;
        Thu, 11 Jul 2019 10:48:31 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id h6sm5623676wre.82.2019.07.11.10.48.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 10:48:29 -0700 (PDT)
Date:   Thu, 11 Jul 2019 18:48:28 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org
Subject: [PATCH] stash: fix handling removed files with --keep-index
Message-ID: <20190711174828.GF15477@hank.intra.tgummerer.com>
References: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Martin Nicolay wrote:
> Hi!
> 
> I don't know if this is a software or documentation bug.
> 
> man git-stash says about --keep-index:
>     If the --keep-index option is used, all changes already added to
>     the index are left intact.
> 
> If a file is deleted and this deletion is in the index a following
>     $ git stash push --keep-index
> keeps this deletion in the index but not in the working-tree.
> 
> If a file is changed and this change is in the index a following
>     $ git stash push --keep-index
> keeps this change in the index and also in the working-tree.
> 
> This is inconsistent.

Thanks for your report.  This has come up before in
https://public-inbox.org/git/1555437849815.60450@rasenplanscher.info/,
which I first thought was expected behaviour, but that was just me
misunderstanding the --keep-index option.  So I belive this is indeed
a bug.

Luckily I had some more time to actually look at this this time
around, so below is a potential fix.

This comes with a small caveat of overwriting untracked files if they
have been removed from the index, and replaced with a file that has
not been added yet.  I think that's okay as that happens in other
places as well in stash, but wanted to point it out anyway.

--- >8 ---
Subject: [PATCH] stash: fix handling removed files with --keep-index

git stash push --keep-index is supposed to keep all changes that have
been added to the index, both in the index and on disk.

Currently this doesn't behave correctly when a file is removed from
the index.  Instead of keeping it deleted on disk, --keep-index
currently restores the file.

Fix that behaviour by using 'git restore' which can faithfully restore
the index and working tree.  This also simplifies the code.

Note that this will overwrite untracked files if the untracked file
has the same name as a file that has been deleted in the index.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c  | 34 ++++++++++------------------------
 t/t3903-stash.sh |  7 +++++++
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index fde6397caa..2a58c007e1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1391,30 +1391,16 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		}
 
 		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
-			struct child_process cp_ls = CHILD_PROCESS_INIT;
-			struct child_process cp_checkout = CHILD_PROCESS_INIT;
-			struct strbuf out = STRBUF_INIT;
-
-			if (reset_tree(&info.i_tree, 0, 1)) {
-				ret = -1;
-				goto done;
-			}
-
-			cp_ls.git_cmd = 1;
-			argv_array_pushl(&cp_ls.args, "ls-files", "-z",
-					 "--modified", "--", NULL);
-
-			add_pathspecs(&cp_ls.args, ps);
-			if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
-				ret = -1;
-				goto done;
-			}
-
-			cp_checkout.git_cmd = 1;
-			argv_array_pushl(&cp_checkout.args, "checkout-index",
-					 "-z", "--force", "--stdin", NULL);
-			if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
-					 0, NULL, 0)) {
+			struct child_process cp_restore = CHILD_PROCESS_INIT;
+
+			cp_restore.git_cmd = 1;
+			argv_array_pushl(&cp_restore.args, "restore", "--source", oid_to_hex(&info.i_tree),
+					 "--staged", "--worktree", NULL);
+			if (!ps->nr)
+				argv_array_push(&cp_restore.args, ".");
+			else
+				add_pathspecs(&cp_restore.args, ps);
+			if (run_command(&cp_restore)) {
 				ret = -1;
 				goto done;
 			}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b22e671608..b8e337893f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1234,4 +1234,11 @@ test_expect_success 'stash works when user.name and user.email are not set' '
 	)
 '
 
+test_expect_success 'stash --keep-index with file deleted in index does not resurrect it on disk' '
+	test_commit to-remove to-remove &&
+	git rm to-remove &&
+	git stash --keep-index &&
+	test_path_is_missing to-remove
+'
+
 test_done
-- 
2.22.0.599.gf5cf68d754
