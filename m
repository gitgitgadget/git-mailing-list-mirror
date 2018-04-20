Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51471F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbeDTMYG (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:24:06 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34763 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMYF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:24:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id p18-v6so3327799wrm.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YInCvXx1eVl9bAPR9g9hnFiS2ZFMhWMH7Zjg/MRY2Xk=;
        b=dx9x5MPiYkvDwt+mLDEkssPUzI5om/clci5JrZ/uW7PxW4diUd6zsfchMjGBirIqVC
         B9rImnipIS932ZKiiiFFGcCMOjFXGxhjfcPxO6Eloq5KT5mec3wmXNi8tsiYhcxOObXu
         9xWVYfoUpPxQ+f0lHar7jRGi46+K87Kj9pbjN7YcyQqbmfZLLdpl7TnbUckmolgAMKfC
         ojXPTxYT3WOIwcNyYHVxQk6+OY3Q0XGISq6g1tdxwPwPJLs/uIJjUdLL1BSrY587Rkns
         c6VEUdgWQgNqsP0SiC+7uZQ5n2BS2GnQNO8BpHifELB/mAT8YHyBqnv/F3KbNMPgCMmg
         yFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YInCvXx1eVl9bAPR9g9hnFiS2ZFMhWMH7Zjg/MRY2Xk=;
        b=SjuiKnrc+NbjbPHbBKt7tYN9fFyyBuTSehVoxu9NuxfOikU2y/wEK4fbqrIdNSfrWm
         LiZv9PHCOeEUfNXUbA42lY++iqTQNeS2JPrVGSukV+C8f4iF2ERJdYOf6u0tOg1n64Dx
         0hrGqJJ5Ak1CmNGCttkLRKo6WiCymgyU2CwCeifi1MxyXSiNbuPR4cLq+is1riKGBWvR
         FC5P505ZesvCNJMSp9ICbjQyZtx/+jPoGjNLLr3lMTclduxkeAhJgHdJpZ18rrF/KfXu
         fcyvLQUnM5Yy+x8QS9VP/z5t6t31lJWJFKeynZC+Jk+T5Q9eH/Pr98l9Uv2AAL0dVyWZ
         ToNQ==
X-Gm-Message-State: ALQs6tDFKNH79DRBshE2aZPrukmLKG4FeCuagSJnd4qYSAsg2tun7icC
        iVQKl7suvY7Ny7nJUsTcZlY=
X-Google-Smtp-Source: AB8JxZpFmWT3CBmSO4zERp16PIDdyXuk9lYDQTymiAHM9yvGMNklyuItds9ECVtyROus7Gr+PJBFug==
X-Received: by 10.28.230.28 with SMTP id d28mr1891546wmh.92.1524227043838;
        Fri, 20 Apr 2018 05:24:03 -0700 (PDT)
Received: from localhost.localdomain (x4db052d6.dyn.telefonica.de. [77.176.82.214])
        by smtp.gmail.com with ESMTPSA id e202sm1537271wma.43.2018.04.20.05.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Apr 2018 05:24:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, martin.agren@gmail.com
Subject: Re: [PATCH v10 33/36] merge-recursive: fix was_tracked() to quit lying with some renamed paths
Date:   Fri, 20 Apr 2018 14:23:55 +0200
Message-Id: <20180420122355.21416-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.geecde6d7e
In-Reply-To: <20180419175823.7946-34-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-34-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In commit aacb82de3ff8 ("merge-recursive: Split was_tracked() out of
> would_lose_untracked()", 2011-08-11), was_tracked() was split out of
> would_lose_untracked() with the intent to provide a function that could
> answer whether a path was tracked in the index before the merge.  Sadly,
> it instead returned whether the path was in the working tree due to having
> been tracked in the index before the merge OR having been written there by
> unpack_trees().  The distinction is important when renames are involved,
> e.g. for a merge where:
> 
>    HEAD:  modifies path b
>    other: renames b->c
> 
> In this case, c was not tracked in the index before the merge, but would
> have been added to the index at stage 0 and written to the working tree by
> unpack_trees().  would_lose_untracked() is more interested in the
> in-working-copy-for-either-reason behavior, while all other uses of
> was_tracked() want just was-it-tracked-in-index-before-merge behavior.
> 
> Unsplit would_lose_untracked() and write a new was_tracked() function
> which answers whether a path was tracked in the index before the merge
> started.
> 
> This will also affect was_dirty(), helping it to return better results
> since it can base answers off the original index rather than an index that
> possibly only copied over some of the stat information.  However,
> was_dirty() will need an additional change that will be made in a
> subsequent patch.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

This patch causes memory corruption when the split index feature is in
use, making several tests fail.  Now, while the split index feature
sure has its own set of problems, AFAIK those are not that bad to
cause memory corruption, they "only" tend to cause transient test
failures due to a variant of the classic racy git issue [1].

Here is a test failure:

  $ GIT_TEST_SPLIT_INDEX=DareISayYes ./t3030-merge-recursive.sh
  <...>
  ok 31 - merge-recursive simple w/submodule result
  *** Error in `/home/szeder/src/git/git': free(): invalid pointer: 0x0000000001f646d0 ***
  ======= Backtrace: =========
  /lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7f84e0c5b7e5]
  /lib/x86_64-linux-gnu/libc.so.6(+0x7f72a)[0x7f84e0c6372a]
  /lib/x86_64-linux-gnu/libc.so.6(cfree+0xf7)[0x7f84e0c685e7]
  /home/szeder/src/git/git[0x5181ee]
  /home/szeder/src/git/git[0x4f1e82]
  /home/szeder/src/git/git[0x4f394b]
  /home/szeder/src/git/git[0x44a37f]
  /home/szeder/src/git/git[0x44afa9]
  /home/szeder/src/git/git[0x406640]
  /home/szeder/src/git/git[0x4070f0]
  /home/szeder/src/git/git[0x4062a7]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f84e0c04830]
  /home/szeder/src/git/git[0x4062f9]
  ======= Memory map: ========
  00400000-00616000 r-xp 00000000 08:06 2255502                            /home/szeder/src/git/git
  00815000-00816000 r--p 00215000 08:06 2255502                            /home/szeder/src/git/git
  00816000-00823000 rw-p 00216000 08:06 2255502                            /home/szeder/src/git/git
  00823000-00866000 rw-p 00000000 00:00 0 
  01f63000-01fa6000 rw-p 00000000 00:00 0                                  [heap]
  7f84e09ce000-7f84e09e4000 r-xp 00000000 08:06 921674                     /lib/x86_64-linux-gnu/libgcc_s.so.1
  7f84e09e4000-7f84e0be3000 ---p 00016000 08:06 921674                     /lib/x86_64-linux-gnu/libgcc_s.so.1
  7f84e0be3000-7f84e0be4000 rw-p 00015000 08:06 921674                     /lib/x86_64-linux-gnu/libgcc_s.so.1
  7f84e0be4000-7f84e0da4000 r-xp 00000000 08:06 917791                     /lib/x86_64-linux-gnu/libc-2.23.so
  7f84e0da4000-7f84e0fa4000 ---p 001c0000 08:06 917791                     /lib/x86_64-linux-gnu/libc-2.23.so
  7f84e0fa4000-7f84e0fa8000 r--p 001c0000 08:06 917791                     /lib/x86_64-linux-gnu/libc-2.23.so
  7f84e0fa8000-7f84e0faa000 rw-p 001c4000 08:06 917791                     /lib/x86_64-linux-gnu/libc-2.23.so
  7f84e0faa000-7f84e0fae000 rw-p 00000000 00:00 0 
  7f84e0fae000-7f84e0fb5000 r-xp 00000000 08:06 917825                     /lib/x86_64-linux-gnu/librt-2.23.so
  7f84e0fb5000-7f84e11b4000 ---p 00007000 08:06 917825                     /lib/x86_64-linux-gnu/librt-2.23.so
  7f84e11b4000-7f84e11b5000 r--p 00006000 08:06 917825                     /lib/x86_64-linux-gnu/librt-2.23.so
  7f84e11b5000-7f84e11b6000 rw-p 00007000 08:06 917825                     /lib/x86_64-linux-gnu/librt-2.23.so
  7f84e11b6000-7f84e11ce000 r-xp 00000000 08:06 917789                     /lib/x86_64-linux-gnu/libpthread-2.23.so
  7f84e11ce000-7f84e13cd000 ---p 00018000 08:06 917789                     /lib/x86_64-linux-gnu/libpthread-2.23.so
  7f84e13cd000-7f84e13ce000 r--p 00017000 08:06 917789                     /lib/x86_64-linux-gnu/libpthread-2.23.so
  7f84e13ce000-7f84e13cf000 rw-p 00018000 08:06 917789                     /lib/x86_64-linux-gnu/libpthread-2.23.so
  7f84e13cf000-7f84e13d3000 rw-p 00000000 00:00 0 
  7f84e13d3000-7f84e13ec000 r-xp 00000000 08:06 918601                     /lib/x86_64-linux-gnu/libz.so.1.2.8
  7f84e13ec000-7f84e15eb000 ---p 00019000 08:06 918601                     /lib/x86_64-linux-gnu/libz.so.1.2.8
  7f84e15eb000-7f84e15ec000 r--p 00018000 08:06 918601                     /lib/x86_64-linux-gnu/libz.so.1.2.8
  7f84e15ec000-7f84e15ed000 rw-p 00019000 08:06 918601                     /lib/x86_64-linux-gnu/libz.so.1.2.8
  7f84e15ed000-7f84e1613000 r-xp 00000000 08:06 917787                     /lib/x86_64-linux-gnu/ld-2.23.so
  7f84e1760000-7f84e17e5000 rw-p 00000000 00:00 0 
  7f84e1811000-7f84e1812000 rw-p 00000000 00:00 0 
  7f84e1812000-7f84e1813000 r--p 00025000 08:06 917787                     /lib/x86_64-linux-gnu/ld-2.23.so
  7f84e1813000-7f84e1814000 rw-p 00026000 08:06 917787                     /lib/x86_64-linux-gnu/ld-2.23.so
  7f84e1814000-7f84e1815000 rw-p 00000000 00:00 0 
  7ffff14d9000-7ffff14fa000 rw-p 00000000 00:00 0                          [stack]
  7ffff15cf000-7ffff15d2000 r--p 00000000 00:00 0                          [vvar]
  7ffff15d2000-7ffff15d4000 r-xp 00000000 00:00 0                          [vdso]
  ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
  not ok 32 - merge-recursive copy vs. rename
  #       
  #               git checkout -f copy &&
  #               git merge rename &&
  #               ( git ls-tree -r HEAD && git ls-files -s ) >actual &&
  #               (
  #                       echo "100644 blob $o0   b"
  #                       echo "100644 blob $o0   c"
  #                       echo "100644 blob $o0   d/e"
  #                       echo "100644 blob $o0   e"
  #                       echo "100644 $o0 0      b"
  #                       echo "100644 $o0 0      c"
  #                       echo "100644 $o0 0      d/e"
  #                       echo "100644 $o0 0      e"
  #               ) >expected &&
  #               test_cmp expected actual
  #       

And the gdb backtrace of that 'git merge rename' command:

  Program received signal SIGABRT, Aborted.
  0x00007ffff7403428 in __GI_raise (sig=sig@entry=6)
      at ../sysdeps/unix/sysv/linux/raise.c:54
  54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
  (gdb) bt
  #0  0x00007ffff7403428 in __GI_raise (sig=sig@entry=6)
      at ../sysdeps/unix/sysv/linux/raise.c:54
  #1  0x00007ffff740502a in __GI_abort () at abort.c:89
  #2  0x00007ffff74457ea in __libc_message (do_abort=do_abort@entry=2, 
      fmt=fmt@entry=0x7ffff755eed8 "*** Error in `%s': %s: 0x%s ***\n")
      at ../sysdeps/posix/libc_fatal.c:175
  #3  0x00007ffff744d72a in malloc_printerr (
      ar_ptr=0x7ffff7792b20 <main_arena>, ptr=<optimized out>, 
      str=0x7ffff755bcaf "free(): invalid pointer", action=<optimized out>)
      at malloc.c:5006
  #4  free_check (mem=<optimized out>, caller=<optimized out>) at hooks.c:314
  #5  0x00007ffff74525e7 in __GI___libc_free (mem=<optimized out>)
      at malloc.c:2942
  #6  0x00000000005181ee in discard_index (istate=istate@entry=0x7fffffffcc10)
      at read-cache.c:1934
  #7  0x00000000004f1e82 in merge_trees (o=o@entry=0x7fffffffc850, 
      head=<optimized out>, merge=<optimized out>, common=<optimized out>, 
      result=result@entry=0x7fffffffc7f0) at merge-recursive.c:3125
  #8  0x00000000004f394b in merge_recursive (o=o@entry=0x7fffffffc850, 
      h1=h1@entry=0x86efa0, h2=0x86f020, ca=0x0, 
      result=result@entry=0x7fffffffc840) at merge-recursive.c:3220
  #9  0x000000000044a37f in try_merge_strategy (strategy=<optimized out>, 
      strategy@entry=0x597ded "recursive", common=common@entry=0x8674c0, 
      remoteheads=remoteheads@entry=0x8673f0, head=head@entry=0x86efa0)
      at builtin/merge.c:690
  #10 0x000000000044afa9 in cmd_merge (argc=<optimized out>, 
      argv=<optimized out>, prefix=<optimized out>) at builtin/merge.c:1533
  #11 0x0000000000406640 in run_builtin (argv=<optimized out>, 
      argc=<optimized out>, p=<optimized out>) at git.c:350
  #12 handle_builtin (argc=2, argv=0x7fffffffdc30) at git.c:562
  #13 0x00000000004070f0 in run_argv (argv=0x7fffffffd9d0, argcp=0x7fffffffd9dc)
      at git.c:614
  #14 cmd_main (argc=2, argc@entry=3, argv=0x7fffffffdc30, 
      argv@entry=0x7fffffffdc28) at git.c:691
  #15 0x00000000004062a7 in main (argc=3, argv=0x7fffffffdc28)
      at common-main.c:45

Other failing tests are:

  t3030-merge-recursive.sh
  t3402-rebase-merge.sh
  t3501-revert-cherry-pick.sh
  t6022-merge-rename.sh
  t6032-merge-large-rename.sh
  t6034-merge-rename-nocruft.sh
  t6042-merge-rename-corner-cases.sh
  t6043-merge-rename-directories.sh
  t6046-merge-skip-unneeded-updates.sh
  t7003-filter-branch.sh
  t7601-merge-pull-config.sh

> diff --git a/merge-recursive.c b/merge-recursive.c
> index b32e8d817a..097de7e5a7 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c

> @@ -3081,6 +3115,15 @@ int merge_trees(struct merge_options *o,
>  	else
>  		clean = 1;
>  
> +	/* Free the extra index left from git_merge_trees() */
> +	/*
> +	 * FIXME: Need to also data allocated by setup_unpack_trees_porcelain()
> +	 * tucked away in o->unpack_opts.msgs, but the problem is that only
> +	 * half of it refers to dynamically allocated data, while the other
> +	 * half points at static strings.
> +	 */
> +	discard_index(&o->orig_index);

Removing this discard_index() call makes all those test failures go
away...  but I guess that isn't the right solution, is it.

And even with that call removed, the next patch will cause a
segmentation fault in 't6043-merge-rename-directories.sh's '72 -
9f-check: Renamed directory that only contained immediate subdirs'.


[1] Working on it: https://github.com/szeder/git split-index-racy
