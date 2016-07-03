Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF92202F4
	for <e@80x24.org>; Sun,  3 Jul 2016 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcGCM2v (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 08:28:51 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35060 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbcGCM2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 08:28:50 -0400
Received: by mail-io0-f169.google.com with SMTP id f30so133853910ioj.2
        for <git@vger.kernel.org>; Sun, 03 Jul 2016 05:28:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aJhYyaew5EmbyBOgbvQwR1xNCpyJNUjeKAOXSRmcDM8=;
        b=NC3qS0mrPwlWku88aTEsjcc6Y6cK/k53NpyuryLzer8Rw0pM1P474GwItzTfYmV2wF
         f3pYuIsipAA+h0aFUvB4T9TbQJ9Aw92+eC77jvuRmSfGppWWqvcBeMMBJ2BIiltbRSy7
         m9rqOlbgK9QcyBw074yI8YmIpC7PL5t4n+iQfhEDHD1u2F9LszhUHjYlSmICI7EtPCRe
         VGCAA8ElvWoEmWFw/vvJnseiAQcwha9HH9/ZidForh7zWFGiPyLzpBqhyFR3aX9TVsSB
         SDpIAYucPVzjM/EdB/lf9tytdvM311qMwmDROrdMXvcmOE/plP10IkbRq09e/Xrtt5e8
         UqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aJhYyaew5EmbyBOgbvQwR1xNCpyJNUjeKAOXSRmcDM8=;
        b=PdusmyaNN5gsCVwixbyNAlnGLD2Or6kzrOO4VNfUmDiBKV9zWXVof0JptRBxhK2fzl
         VAwgTcqMQuh9b5nqDDPTmMmjoK88QGu4Y6bemZ3KYBLQI9V2HBU/wo0OQ+XTFNqdabZG
         DePHAubHzKX1HR3CPdTWHSNf6HtnFelM5zwgJxIb2KNIliqxRLUPgof9JERuOWOvfyu9
         EqhoxXAKnfSiIv2C80VTx9WmEN72EdCips/OfTAZnzln7zO8HZHHN34Re+G7gRqWaB0S
         7l0i/ylOecrAOKAY9VT/P+bGt+0cnwIhyvmCBJghHN0Y0o+lNSMlJEslbZmBW/TlNkXu
         01SQ==
X-Gm-Message-State: ALyK8tLIvTLfoIJVtnqGEactRnkJs8RyKXn5ZJkNYiod1kN5JIZVIcanJD+Sth1z8zFwyPabh4e5wZfbsE0adw==
X-Received: by 10.107.22.6 with SMTP id 6mr5144447iow.128.1467548929574; Sun,
 03 Jul 2016 05:28:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 3 Jul 2016 05:28:20 -0700 (PDT)
In-Reply-To: <loom.20160701T013515-311@post.gmane.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-11-git-send-email-novalis@novalis.org> <loom.20160630T192750-125@post.gmane.org>
 <CACsJy8DjYLQCBRc9CzFSWNqkVnhbAfnxd1mnQh4oEfJwKjPd1A@mail.gmail.com> <loom.20160701T013515-311@post.gmane.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 3 Jul 2016 14:28:20 +0200
Message-ID: <CACsJy8DvZgj0w8z8LdeuY8HdTTcEu7ABPyFi_wnmEZOGsoMkDQ@mail.gmail.com>
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
To:	Ben Peart <peartben@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 1:54 AM, Ben Peart <peartben@gmail.com> wrote:
> I've found (at least on Windows) that as the repo size gets larger, the
> time to read the index becomes a much smaller percentage of the overall
> time.  I just captured some perf traces of git status on a large repo we
> have.  Of that, 92.5% was spent in git!read_directory and only 4.0% was
> spent in git!read_index.  Of that 4%, 2.6% was git!glk_SHA1_Update.

OK.. Windows. I don't have Windows numbers, but "git!read_directory"
(is that read_directory() in "git" process?) does not do a lot of
stat'ing. Although I agree that it dominates git-status. I recorded
some numbers in nd/untracked-cache topic (see 9e59724 (update-index:
manually enable or disable untracked cache - 2015-03-08)).

First step would be enabling that because besides directory
traversing, this code does a lot of string processing that's hopefully
eliminated by untracked cache extension. I cut git-status' time in
half with it. The side effect though, is that it creates a new flow of
stat(), one per directory. It would be great if you could do some
measurements with untracked cache on Windows and see if we get similar
gain.

> Given there were no dirty files, Watchman would have made a huge
> improvement in the overall time but index helper would have had
> relatively little impact.  We've noticed this same pattern in all our
> repos which is what is driving our interest in the Watchman model and
> also shows why index-helper is of less interest.

Assuming that untracked cache cuts git-status time by half on Windows
as well, then index read time now takes a bigger percentage, 8%, where
it starts to make sense to optimize it.

On a quiet repository, having watchman does not help so much because
we already reduce the significant number of filesystem-related system
calls. Yes there is lstat() and eliminating it may gain some more
(with watchman) and it matters on a repo with lots of directories. You
probably can just take these lstat out (I can help point out where)
and see how much the gain is.

Assuming (blindly again) that removing lstat helps like 10% of
read_index(), we would need to profile untracked cache code and see
where what we can do next. There are still a lot of directory
traversing there (except that it traverses the cache instead of
filesystem) and maybe we can do something. But I haven't gotten that
far.

> While the current design hides watchman behind index-helper, if we were
> to change that model so they were independent, we would be interested
> in doing it in such a way that provided some abstraction so that it
> could be replaced with another file watching daemon.

Frankly I'm not that interested in replacing another file watching
daemon. My first attempt at this problem was "file-watcher" which was
tied to Linux inotify system only and it would make sense to make it
replaceable. But watchman supports OS X, Linux, FreeBSD and Windows
now, not just Linux only as before, why another abstraction layer? You
could even replace "watchman.exe" binary. As long as you produce the
same json data, your new daemon should still work.

Tying index caching daemon and file watching daemon (let's avoid
"watchman" for now) gives us a bonus. Because both git and the caching
daemon know that they read the same index, we could answer the
question "what files are dirty?" with "file number 1, 5, 9 in the
index" instead of sending full paths and git has to make some more
lookups to identify them. In this series we send it as a compressed
bit map. Probably not a big deal in terms of real performance, but it
feels nice to do lookups less.

The second reason is because watchman daemon alone does not provide
enough information to reduce untracked cache's lstat() as much as
possible. The current approach in this series is a naive one, which
works for some cases, but not optimal (I'll get to that). We need a
separate long-running daemon to maintain extra info to reduce lstat().
Because our target is watchman, it does not make sense to add yet
another daemon besides index-helper to do this.

OK the optimal lstat() reduction thing. Right now, if any file in a
directory is updated, the directory is invalidated in untracked cache
and we need to traverse it to collect excluded files again. But it
does not have to be that way. We don't care if any file is _updated_
because it will not change untracked cache output. We care about what
files are _added_ or _deleted_. New files will need to be classified
as either tracked, untracked or ignored. Deleted files may invalid
either three file lists. Watchman cannot answer "what files are added
or deleted since the point X in time" and I agree that it's not
watchman's job (watchman issue 65). So we have to maintain some more
info by ourselves, e.g. the list of files at any requested "clock".
With that we can compare the file lists of two "clock"s and tell git
what files are added or deleted.
-- 
Duy
