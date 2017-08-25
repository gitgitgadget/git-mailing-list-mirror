Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2001F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 11:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756211AbdHYLVS (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 07:21:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755023AbdHYLVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 07:21:16 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MANGk-1dfBK33oEM-00BZsP; Fri, 25 Aug 2017 13:21:10 +0200
Subject: Re: [PATCH v4 00/16] Fix git-gc losing objects in multi worktree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <6b67875c-847c-8d5f-14bb-c3fb7004ebdc@grubix.eu>
Date:   Fri, 25 Aug 2017 13:21:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1Dl6njBX8h0GLQY12sKIFaBLa1AJ7hGyVNZbjHeFxco8L6qh5ik
 7+M9/k3CgZIAKF6fh0EgvHjW49ghJpuNQvzLRst5TZRz1lD1656m3Yim53A4KXp2vjlBR2u
 aXSmYXN2OTObqy7cuIcwbbxlC1KGSRXt8jDvfvESwRsnmXPpi+/PS7a6b4L/oMs3ZIGlgsq
 v3vApVOPHN20fdaoiImGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8CTXkk9O4fQ=:goyOfbOYQnJB6L5csTp/cW
 G8qvQhEjVFAlEUJGHoHzfK3B8X5+B3AS4m3TSBrtXY/21+IXCbrQZfu1AEgXVo/OmyIbO5RaV
 ITaNkpE6j5IYn4praA1nzqsBchGac4sKC7qL/odpUesn2wKGU6Xr13IGj4+7z491diQvOfqs6
 H1+fHZ6gupMdB/zQXP4VEg74w6Ct5C3go15IkUuA8Yo7Vc2RW9KjQL6H6QUbqdM2hT7/tdPaZ
 LuwPVa/xN44c73glTeoNB2fZzsOlvo24cGrEGIQanLWqWawWi4MYWOR75itJNHxBCnlesQfJ4
 FzUtaAUl6ewQgwj8CKp3kCBsJsZpasFYghhAC0hk1y2I2hIqFlc/T3nK8YgLJgMrbWQQrbAui
 sa8Hg3bKClI0QLTbWpVhd+d0mg32XKunga2GkwDnDiMQEm8NVfmuGBKsMfBP1qTZyU9rhJTi7
 OjxFM3rD54HKkdnDRYCCPbt7QPvnxj8LqUtlcu89OXPXd29qksssp5g5y7gCW1EaohO0EHSkp
 nw++bQjEnLlo4CZVN8vnrViU2yvijyQI1ghwEXZ6gAFV8nWtgWTMWzjpci+3FakBSCKLzWsBa
 UnR4Djeqty22sfI71i4Yy0jTP4I8IK6NefVQmGLCdPNQF+LdvtzAkxNsROJVoLrckuf+a14WJ
 3p4yE7U5faB5GIj8HDsXRnXQdvkebBIXBR1H8o0mWEDqfsn3a0BNw+X33FjSDFACxH97WZi/0
 xt9hWLixTSEEPFMiTajMjAJm8ZjJamQrGqUvW5GSTj2fC2XOLqNYdptOIMs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy venit, vidit, dixit 23.08.2017 14:36:
> "git gc" when used in multiple worktrees ignore some per-worktree
> references: object references in the index, HEAD and reflog. This
> series fixes it by making the revision walker include these from all
> worktrees by default (and the series is basically split in three parts
> in the same order). There's a couple more cleanups in refs.c. Luckily
> it does not conflict with anything in 'pu'.
> 
> Compared to v3 [1], the largest change is supporting multi worktree in
> the reflog iterator. The merge iterator is now used (Micheal was right
> all along).
> 
> [1] https://public-inbox.org/git/20170419110145.5086-1-pclouds@gmail.com/
> 
> Nguyễn Thái Ngọc Duy (16):
>   revision.h: new flag in struct rev_info wrt. worktree-related refs
>   refs.c: use is_dir_sep() in resolve_gitlink_ref()
>   revision.c: refactor add_index_objects_to_pending()
>   revision.c: --indexed-objects add objects from all worktrees
>   refs.c: refactor get_submodule_ref_store(), share common free block
>   refs: move submodule slash stripping code to get_submodule_ref_store
>   refs: add refs_head_ref()
>   revision.c: use refs_for_each*() instead of for_each_*_submodule()
>   refs.c: move for_each_remote_ref_submodule() to submodule.c
>   refs: remove dead for_each_*_submodule()
>   revision.c: --all adds HEAD from all worktrees
>   files-backend: make reflog iterator go through per-worktree reflog
>   revision.c: --reflog add HEAD reflog from all worktrees
>   rev-list: expose and document --single-worktree
>   refs.c: remove fallback-to-main-store code get_submodule_ref_store()
>   refs.c: reindent get_submodule_ref_store()

I probably won't be able to review this (many commits without commit
message), but I'm happy to see progress on the "--all" and prune front
(and will test). I suggest we think about the UI exposure a bit when it
comes to including all heads or naming options, though:

* HEAD is "the current head"
* refs/heads is where all local branch heads are

* --branches is the rev-list/log option for refs/heads/*
* --all is the rev-list/log option for refs/* plus HEAD
* HEAD is the rev-list/log argument for HEAD

* --heads is the show-ref option limiting to refs/heads/*
* --head is the show-ref option which adds HEAD

* refs/heads is the for-each-ref-pattern for refs/heads/*
* HEAD is not the for-each-ref-pattern for HEAD
[I'll suggest a patch to change the latter, shortly.]

I would hope that the result of this series and other efforts will be:

* consistent way to specify "all local branch heads"
* consistent way to specify "the head" aka HEAD
* consistent way to specify "all linked worktree heads"
[* maybe something for submodules...]

This may require changing the misnamed show-ref option, but also
thinking twice before changing the meaning of "--all" for the
rev-list/log family: it's easy to say "--all --linked" or "--all
--heads" to get everything plus all linked worktree heads when "--all"
== "--branches --tags HEAD", but it's more cumbersome with a changed
--all that is "really everything". I gues my suggestion would be:

--all as it is now (refs/* plus HEAD)

--head alternative way to say HEAD (as it is now for show-ref)

--heads HEAD for all linked worktrees (incompatible change for show-ref)

And all of them should work the same for the rev-list/log family as well
as for-each-ref/show-ref.

I thinking that changing show-ref (porcelain, not quite as commonly
used) should do the least harm compared to all other options.

Michael
