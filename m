Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784CACCA485
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiGRTbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiGRTai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:30:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3332063
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:29:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e28so21074110lfj.4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpkUtQk1xEkj3G+MEIZpRBPtyA33xsYOscoZ+rTnmUw=;
        b=ZKDcLWv1Q2OvFFaj8tOQ6rQgKLO9qmUH7tQjbBDK8ccYGU6faUMZtS9/9PgTEhIhw9
         qvkV+lUnBUnMfOk2tmISS2UeJ5mp1XkOAqCE6B1mYda0VNujUcJIj3A4yH8N1saro9eR
         RkIBSeMnaYVkYh1ODVCaILKXzLd914r1OacEHE0GTVXnUQgXLgGkc34E4DGQ9fGCVfIp
         62gmqJEdpi1SVQwiFIP/T4A4t1oS86MhNclAKDTnWUFZwdnwt1QGshF+7QgvIv72hcXJ
         ie7DYGcq1AnN4ihBmBYI7SMvbfAvOLGl+s5zlySIiDBNqWXbgStKut2zpsnb41u/PXWx
         WnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpkUtQk1xEkj3G+MEIZpRBPtyA33xsYOscoZ+rTnmUw=;
        b=X750tqu1PNhZrSXEJROjnCDFcnXE7CDEzvJuWuMLGe4kNfifOitdwXFgbeu9PEBKaw
         eML8RPsZdV5MJIske3OqTESnwXroKaHpodiwDKPTfwmvKsnF7/6qwGgd6EdN1OBGUgjw
         rYaqs/0wb4GjTXmKrunw3MymFBcDKE8LS7wU4FHOUvVNbi8E5jLX6CZIktUDY5VI6vCa
         +Z7X7o1Egm8C+0j317fTcEBmM1w87oVPT9bp5SoBI8sLKxEYqsXIXpINB+Q7kr+EFtsC
         7axasvt8Z7GBac1OilA+tdt4Sf4UEouLDWAqP0RuOWxbpMETTp3qFAhoVboXlt+eYIit
         SLfA==
X-Gm-Message-State: AJIora9zZEPth7G55sw38mzUejmz2q0XJ43lJvvjex+BcJ0ksGWiu9hK
        1thzD+cy7LiDkuTTwcxijBLKq4eakChGdPKnYbtXkEIhhYE=
X-Google-Smtp-Source: AGRyM1sVvuJZkQg8vofPzBmqLIoGnv1Y8Legh9LKxbHVBR6LSJBi20YdVhh1+sdOP5qKOKJEUPfejy1uCpknatvYnH0=
X-Received: by 2002:a05:6512:230c:b0:489:ca4e:ba2a with SMTP id
 o12-20020a056512230c00b00489ca4eba2amr14803978lfu.561.1658172583129; Mon, 18
 Jul 2022 12:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzYYQ1EOmbUvafQvzJUNW8kojLuD+BbakxU09JSm=niHA@mail.gmail.com>
 <89310a11-b8cd-b643-5d46-c6d273f66b49@github.com>
In-Reply-To: <89310a11-b8cd-b643-5d46-c6d273f66b49@github.com>
From:   Dian Xu <dianxudev@gmail.com>
Date:   Mon, 18 Jul 2022 15:29:32 -0400
Message-ID: <CAKSRnEyrc1ZzeShYNOHumMjnkB0MWHaZTRd6n7SrRACT=eAiYA@mail.gmail.com>
Subject: Re: 'git sparse-checkout add' hangs if local repo is using
 alternative objects store
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

Thank you for your reply. Please see my reply inline:

On Thu, Jul 14, 2022 at 11:06 PM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 7/12/2022 9:58 AM, Dian Xu wrote:
>
> > Reproduction steps:
> >     1. Local repo setup:
> >         git init
> >         git remote add origin <repo_url>
> >         echo <alternative_objects_store> >! .git/objects/info/alternates
>
> Is this alternative object store on the local disk? Or is it
> across a network connection?


The alternate object store I used is across network connection.


>
> >         git config --unset-all remote.origin.fetch
> >         git config --unset-all remote.origin.tagopt
> >         git config --add remote.origin.tagopt --no-tags
> >         git config --add remote.origin.fetch
> > +refs/heads/main:refs/remotes/origin/main
> >         git config core.sparsecheckout true
> >         git config core.sparsecheckoutcone true
> >         git fetch
>
> This is interesting that you are fetching without having
> any existing refs, only the alternate store. Are you using
> something like the core.alternateRefsCommand config option?
>
> Otherwise, I would expect this "git fetch" to act as if it
> was a normal clone (unless of course the alternate already
> has the current tip of 'main'). Maybe fetch negotiation helps
> find some common commits that exist in the alternate, but the
> client is useless in that discovery without refs.


I am not sure I understand your statement fully here:
    - All these config setup here is to let 'git fetch' only fetches
e.g. 'refs/heads/main', nothing else
    - The HEAD of the AOS (alternate object store) is indeed at refs/heads/main
    - I can remove all these 4 specific refs config settings (now
fetching all refs instead), and the issue can still be reproduced


>
> >     2. Sparse checkout <dir1>:
> >         git sparse-checkout set <dir1>
> >         git checkout -b tmp1 origin/main
> >
> >     3. Add another <dir2> via sparse-checkout, which hangs:
> >         git sparse-checkout add <dir2>
> >             09:39:11.169116 read-cache.c:2451       performance:
> > 6.326754679 s:  read cache .git/index
>
> Could you re-run this with GIT_TRACE2_PERF=1 so we can see
> even more details about how this works?


Please see the output with GIT_TRACE2_PERF at the end of the email,
which hung at:
    15:17:28.216829 cache-tree.c:477             | d0 | main
          | region_enter | r1  | 85.183554 |           | cache_tree
| ..label:update


>
> > Repo and dir info:
> >     <repo_url> is a large repo, containing large number of directories
> > and 2 million files;
> >     Local repo is using <alternative_objects_store>, which is working
> > by verifying: git count-objects -vH;
> >     <dir1> used here is one level deep, <dir2> used here is 5 level deep
> >
> > Observations:
> >     1. Even 'sparse-checkout add' hangs, scm code from <dir2> was
> > actually downloaded pretty fast
>
> I'm interested to learn what you mean by "downloaded" here.


After the 'git sparse-checkout add' hung, I ctr-C then cd to inspect
the source code, they are on disk


>
> >     2. If waited out 'sparse-checkout add', git seems start to
> > download large number of objects from alternative objects store into
> > local .git/objects
>
> Hm. Adding the objects into .git/objects is strange. It should
> recognize that the objects are in the alternate and not write
> them to the local repo (this is independent of the sparse-checkout
> builtin).


Yep, seems like git is downloading objects from AOS to local, which is
a main concern. We choose to use AOS to save space/time in the first
place.


>
> Thanks,
> -Stolee

Please let me know if you need more details.

Thanks,

Dian Xu
Mathworks, Inc
1 Lakeside Campus Drive, Natick, MA 01760
508-647-3583

----------GIT_TRACE2_PERF----------

% git sparse-checkout add matlab/config
15:16:03.038943 common-main.c:49             | d0 | main
      | version      |     |           |           |              |
2.37.0
15:16:03.038997 common-main.c:50             | d0 | main
      | start        |     |  0.005727 |           |              |
git sparse-checkout add matlab/config
15:16:03.039144 compat/linux/procinfo.c:170  | d0 | main
      | cmd_ancestry |     |           |           |              |
ancestry:[tcsh mate-terminal mate-panel mate-session lightdm lightdm
systemd]
15:16:03.044327 repository.c:136             | d0 | main
      | def_repo     | r1  |           |           |              |
worktree:/mathworks/devel/sandbox/dianxu/workspaces/tmp_git/cone
15:16:03.045148 git.c:461                    | d0 | main
      | cmd_name     |     |           |           |              |
sparse-checkout (sparse-checkout)
15:16:03.045589 read-cache.c:2447            | d0 | main
      | region_enter | r1  |  0.012321 |           | index        |
label:do_read_index .git/index
15:16:07.665184 cache-tree.c:628             | d0 | main
      | region_enter | r1  |  4.631908 |           | cache_tree   |
..label:read
15:16:07.821302 cache-tree.c:630             | d0 | main
      | region_leave | r1  |  4.788028 |  0.156120 | cache_tree   |
..label:read
15:16:07.834318 read-cache.c:2393            | d0 | main
      | data         | r1  |  4.801047 |  4.788726 | index        |
..read/version:3
15:16:07.834364 read-cache.c:2395            | d0 | main
      | data         | r1  |  4.801097 |  4.788776 | index        |
..read/cache_nr:2314721
15:16:07.834375 read-cache.c:2451       performance: 4.788756364 s:
read cache .git/index
15:16:07.834379 read-cache.c:2452            | d0 | main
      | region_leave | r1  |  4.801112 |  4.788791 | index        |
label:do_read_index .git/index
15:16:07.950067 progress.c:268               | d0 | main
      | region_enter | r1  |  4.916794 |           | progress     |
label:Updating index flags
15:16:07.950130 unpack-trees.c:1671          | d0 | main
      | region_enter | r1  |  4.916863 |           | unpack_trees |
..label:clear_ce_flags(0x00000000,0x02000000)
15:16:08.083835 unpack-trees.c:1678          | d0 | main
      | region_leave | r1  |  5.050562 |  0.133699 | unpack_trees |
..label:clear_ce_flags(0x00000000,0x02000000)
15:16:08.083902 progress.c:339               | d0 | main
      | data         | r1  |  5.050634 |  0.133840 | progress     |
..total_objects:2314721
15:16:08.083910 progress.c:346               | d0 | main
      | region_leave | r1  |  5.050643 |  0.133849 | progress     |
label:Updating index flags
15:16:08.161023 progress.c:268               | d0 | main
      | region_enter | r1  |  5.127750 |           | progress     |
label:Updating files
Updating files: 100% (21877/21877), done.
15:17:11.071782 progress.c:339               | d0 | main
      | data         | r1  | 68.038510 | 62.910760 | progress     |
..total_objects:21877
15:17:11.071825 progress.c:346               | d0 | main
      | region_leave | r1  | 68.038557 | 62.910807 | progress     |
label:Updating files
15:17:11.071859 progress.c:268               | d0 | main
      | region_enter | r1  | 68.038591 |           | progress     |
label:Filtering content
15:17:11.071911 progress.c:339               | d0 | main
      | data         | r1  | 68.038643 |  0.000052 | progress     |
..total_objects:0
15:17:11.071930 progress.c:346               | d0 | main
      | region_leave | r1  | 68.038662 |  0.000071 | progress     |
label:Filtering content
15:17:11.071960 unpack-trees.c:496      performance: 62.934445487 s:
check_updates
15:17:11.071974 unpack-trees.c:2062     performance: 63.187061820 s:
update_sparsity
15:17:11.071998 read-cache.c:3179            | d0 | main
      | region_enter | r1  | 68.038728 |           | index        |
label:do_write_index
/mathworks/devel/sandbox/dianxu/workspaces/tmp_git/cone/.git/index.lock
15:17:12.387925 cache-tree.c:532             | d0 | main
      | region_enter | r1  | 69.354652 |           | cache_tree   |
..label:write
15:17:12.426139 cache-tree.c:534             | d0 | main
      | region_leave | r1  | 69.392868 |  0.038216 | cache_tree   |
..label:write
15:17:16.696737 read-cache.c:3135       performance: 5.624723676 s:
write index, changed mask = 2
15:17:16.696828 read-cache.c:3141            | d0 | main
      | data         | r1  | 73.663556 |  5.624828 | index        |
..write/version:3
15:17:16.696897 read-cache.c:3143            | d0 | main
      | data         | r1  | 73.663629 |  5.624901 | index        |
..write/cache_nr:2314721
15:17:16.696953 read-cache.c:3182            | d0 | main
      | region_leave | r1  | 73.663682 |  5.624954 | index        |
label:do_write_index
/mathworks/devel/sandbox/dianxu/workspaces/tmp_git/cone/.git/index.lock
15:17:17.089520 sparse-index.c:209           | d0 | main
      | region_enter | r1  | 74.056246 |           | index        |
label:convert_to_sparse
15:17:17.146799 cache-tree.c:477             | d0 | main
      | region_enter | r1  | 74.113525 |           | cache_tree   |
..label:update
15:17:24.864900 cache-tree.c:482             | d0 | main
      | region_leave | r1  | 81.831626 |  7.718101 | cache_tree   |
..label:update
15:17:24.864975 cache-tree.c:483        performance: 7.718183242 s:
cache_tree_update
15:17:24.864989 sparse-index.c:223           | d0 | main
      | region_leave | r1  | 81.831721 |  7.775475 | index        |
label:convert_to_sparse
15:17:24.911366 cache-tree.c:477             | d0 | main
      | region_enter | r1  | 81.878090 |           | cache_tree   |
label:update
15:17:25.890481 cache-tree.c:482             | d0 | main
      | region_leave | r1  | 82.857209 |  0.979119 | cache_tree   |
label:update
15:17:25.890528 cache-tree.c:483        performance: 0.979171895 s:
cache_tree_update
15:17:25.890536 sparse-index.c:340           | d0 | main
      | region_enter | r1  | 82.857269 |           | index        |
label:ensure_full_index
15:17:28.216829 cache-tree.c:477             | d0 | main
      | region_enter | r1  | 85.183554 |           | cache_tree   |
..label:update
