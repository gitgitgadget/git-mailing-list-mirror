Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CA320281
	for <e@80x24.org>; Wed, 27 Sep 2017 02:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968026AbdI0CDD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 22:03:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32777 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966927AbdI0CDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 22:03:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id i130so7797443pgc.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 19:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=wTsInArHAt11zRfSnBQojZvijDYeYxLsgCFkdpwOO6U=;
        b=C6UYytvIuPoVP4XQ6EgCRzDewVUDZx4LYHt1ussB8x4reOWoUxmbqYtXkxc6rf5yIk
         6FkFOWVX2mR2Mlz/P4QefrEgfHap9BQ0debM4t7vZ4oZFsHwAZX55cPGLlQTUUrFwkce
         1zKAtNBFFqeix8z6eO3eaERnDBY3AWHG2tPj5lhqH8OGiGpI0u80F4ih8VqmF09+FEGn
         HiIyEgdp1BqglzKcNOtbnRFhDIFsErbpcD6YTZiv7FGEc7JCcCKTd3MnFs6bVmdvr+yO
         iYXvbbnNm18an61cz+XFKAuLG4oeuDpxADTuw+b/enyPFWVuVTdJ9IJ8ke825J0r5+zb
         w0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=wTsInArHAt11zRfSnBQojZvijDYeYxLsgCFkdpwOO6U=;
        b=AdajqPaGBCZwRNTxRZ7cwix8aRqsuJKCQsqMb6UYv8v5SUV+4y8TtDBLIRDvRZzyFp
         seCtfygLutanIp6POrRuF4XY0ancshe9vf6RrYBhO0RbefZ2VyjCYVgSNXpNXjIO/RBn
         j8J7iYo60B0Vhl4eY1MtmAI0ztHjDVU7Kv3ex+uAZRtvPftTa03BwC3PtlbXl6ThMBUW
         FnWuaWMSDkERqdI875g6J48fWTFlr3s+QFsksad0dAWNMv1/hVAC3fe4ZoMEwz5ut9XQ
         mBD5YZB8u754Oc/8XcDQoLy70SbKetYcByJT+l9zmKhvAA7XNXIclqkokvtJ3kY9RrOG
         KQEQ==
X-Gm-Message-State: AHPjjUgKXehJXaHyfd2C+FlgcBY2dt0Ves4il70dnPxspQ/Ro2oR2Ead
        TFyBhIWg5QDze4U6gm/FRj4=
X-Google-Smtp-Source: AOwi7QA19rHbw6pwNFE0ELje6wCjXfM9/YcPLM08S/qhQP1whWeiJACsxRENu9xuY3DNhNYB2c8+VQ==
X-Received: by 10.159.194.132 with SMTP id y4mr12350863pln.85.1506477780657;
        Tue, 26 Sep 2017 19:03:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id p20sm19520786pfl.124.2017.09.26.19.02.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 19:02:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 4/3] branch: fix "copy" to never touch HEAD
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
        <20170705231454.15666-1-avarab@gmail.com>
        <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com>
        <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com>
        <874lrpw34z.fsf@evledraar.booking.com>
Date:   Wed, 27 Sep 2017 11:02:58 +0900
Message-ID: <xmqqvak47val.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I do think however that we also need to update the docs, the relevant
> origin/master...gitster/sd/branch-copy diff is currently:
>
>     +The `-c` and `-C` options have the exact same semantics as `-m` and
>     +`-M`, except instead of the branch being renamed it along with its
>     +config and reflog will be copied to a new name.
>
> Suggestions welcome, but I think that should probably be changed to
> something like the following as part of this patch:
>
>     The `-c` and `-C` options have the exact same semantics as `-m` and
>     `-M`, except instead of the branch being renamed it along with its
>     config and reflog will be copied to a new name. Furthermore, unlike
>     its `-m` and `-M` cousins the `-c` and `-C` options will never move
>     the HEAD, whereas the move option will do so if the source branch is
>     the currently checked-out branch.

I do not think anybody even _imagines_ copy to move HEAD, and do not
think "unlike -m, it doesn't touch HEAD" a worthwhile thing to say.

It is '-m' whose behaviour may look strange wrt HEAD, so _that_ may
be worth mentioning, though.

I suspect that your reaction probably comes from being too married
to the idea that HEAD has a string that is the same as the refname
of the current branch.  But that is a mere implementation detail.
Users would think that HEAD points at the current branch and does
not even care how that pointing is implemented.

Conceptually, you can consider that each branch has its own
identity, separate from various traits it has, like what its
upstream branch is, what commit it points at, what its reflog says,
and (most notably) what its name is.

Then you can think of "branch -m old new" to be (1) finding the
instance of branch that currently has name 'old' and (2) updating
only one of its trait, namely, its name, without changing anything
else.  Creating a new instance of a branch by copying an existing
one, on the other hand, would then be the matter of (1) finding the
instance of branch with name 'old' and (2) creating another instance
of branch with the same traits as the original, modulo its name is
set to 'new'.

A necessary wrinkle for "branch -m" that falls out of the above
world model is that HEAD needs to be adjusted in order to keep
pointing at the same (renamed) instance of branch that now has an
updated name, if HEAD happened to be pointing at the instance of the
branch whose name trait has been updated.

So, from that point of view, I'd prefer to do something like the
attached patch instead.  I notice that "branch -m" does not mention
configuration variables carried over to the new branch, but I do not
necessarily think we want to exhaustively enumerate what traits are
carried over here, so perhaps it is OK as is.

 Documentation/git-branch.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index fe029ac6fc..d425e3acd4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -63,11 +63,13 @@ With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
 renaming. If <newbranch> exists, -M must be used to force the rename
-to happen.
+to happen.  If you rename a branch that is currently checked out,
+`HEAD` is adjusted so that the branch (whose name is now
+<newbranch>) stays to be the current branch.
 
-The `-c` and `-C` options have the exact same semantics as `-m` and
-`-M`, except instead of the branch being renamed it along with its
-config and reflog will be copied to a new name.
+With a `-c` or`-C` option, a new branch <newbranch> is created by
+copying the traits like the reflog contents and `branch.*.*`
+configuration from an existing <oldbranch>.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
