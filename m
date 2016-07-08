Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF75C2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 16:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbcGHQcz (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 12:32:55 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35900 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbcGHQcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 12:32:53 -0400
Received: by mail-lf0-f51.google.com with SMTP id q132so30872776lfe.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 09:32:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jjflOVFz6oJGBIQwwlA+LrCw83MZ4Ab/CCPWTxsmEV8=;
        b=Hyvl0GdSf4G9EjDL48Q3pFdljtYsMjTHbIuacNdo2XiWzxRYm1+3LzwkwsuC+tQe0C
         p0BVVokVnlYDRPbx33KtAMO0USUVqeqY4yaVjk584YyJLOV9lv4F0poRASY/4s+tyequ
         q9zRhGSTqo8qGxD2E9VeK0LqrPWF6vPBTPUiAJ9H4ohr3BgK1+INRFUZ+sS36vrBksLZ
         Zb1laW9+2nJxsg4XAHSmsJnIMSIKaFeeq7VPhOHEanrb6G0QDWmoFuvp363aD78yMNWp
         LdAZOij0fO4RM1DUYUMaouY4+wdCsFjDju1HjazFTqkgoI/BGh21JCpsf7xumWlU0tiU
         h8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjflOVFz6oJGBIQwwlA+LrCw83MZ4Ab/CCPWTxsmEV8=;
        b=HCtVpnYcrBgPQ7vCwW7A8kDGV107Vq0PzerNNXUE+Zgm/8hPoGyUJkMDxkXmgJe3Sf
         CBUbozcZXxzZIFOyn5/xJxRpZZKxlqzqmOOGAw3UdDduRaZ25VdeLqlllzajqTty3t14
         mb5nmjkJaQJiKfqGYVO4dsXvEif2KcJtk+b9eoTd+INj+SvC7clFUR6MA7HdoCw7icxt
         Ud6bf7n1ZMTVHAok2UB4tBwW4rWZZl9rj6mzO3aCOZcqAFJHJsxMnU58EZC7yxeO61wo
         nkhdAjg0iMl6hCTtuzv+0H+rEFBdUIYvOZP4+aTUr4uSDLXINGQ66O4W7YXB2AxIdVkH
         5mkA==
X-Gm-Message-State: ALyK8tKFlu3wx8TK5SdLdDl1ka+qnedFjOUAtH4CFOs6b+Z3xhEzjGDehGMBQqVQ+xDICw==
X-Received: by 10.25.216.106 with SMTP id p103mr1494256lfg.226.1467995571133;
        Fri, 08 Jul 2016 09:32:51 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id l11sm8544913lfl.23.2016.07.08.09.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 09:32:42 -0700 (PDT)
Date:	Fri, 8 Jul 2016 18:32:40 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Ben Peart <peartben@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
Message-ID: <20160708163240.GA20978@duynguyen>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-11-git-send-email-novalis@novalis.org>
 <loom.20160630T192750-125@post.gmane.org>
 <CACsJy8DjYLQCBRc9CzFSWNqkVnhbAfnxd1mnQh4oEfJwKjPd1A@mail.gmail.com>
 <loom.20160701T013515-311@post.gmane.org>
 <CACsJy8DvZgj0w8z8LdeuY8HdTTcEu7ABPyFi_wnmEZOGsoMkDQ@mail.gmail.com>
 <loom.20160706T170547-355@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20160706T170547-355@post.gmane.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 06, 2016 at 04:54:00PM +0000, Ben Peart wrote:
> Duy Nguyen <pclouds <at> gmail.com> writes:
>
> >
> > First step would be enabling that because besides directory
> > traversing, this code does a lot of string processing that's hopefully
> > eliminated by untracked cache extension. I cut git-status' time in
> > half with it. The side effect though, is that it creates a new flow of
> > stat(), one per directory. It would be great if you could do some
> > measurements with untracked cache on Windows and see if we get similar
> > gain.
>
> These numbers were captured with core.fscache and core.untrackedcache
> both set to true in the belief that it would produce the best
> performance.

So I guessed it wrong :-) I thought untracked cache was still not popular.

> If that is incorrect, I'm happy to capture numbers with other
> options set.

It's not incorrect. But if you are happy to provide numbers, I'm happy
to read them and provide my opinions.

> If you drill the next step down into the call tree, the bulk of the cost
> of read_directory is coming from mingw_stat (85.6%).  These numbers are
> inclusive in that they reflect the of the function plus any of its
> callees.

If I remember it correctly, fscache changes mingw_stat() to
FindFirst.. and FindNext... basically read the whole directory up. The
assumption is, if you stat(a/b) you probably want to stat(a/c) and
stat(a/d) soon too. And stat() on Windows is slower in that case
(which is a real case, index refresh).

Untracked cache does not follow this pattern, it stat() all
directories an no files (ok, _some_ files, like .gitignore), which is
not what fscache is optimized for. It would be good if you can get
some numbers with untracked cache but _without_ fscache.

You should kill the lstat() stream from index refresh though because
it may interfere. Doing that is as simple as this. This could provide
some good base line for measuring read_directory().

diff --git a/read-cache.c b/read-cache.c
index db27766..1cef379 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1079,7 +1079,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	 * that the change to the work tree does not matter and told
 	 * us not to worry.
 	 */
-	if (!ignore_skip_worktree && ce_skip_worktree(ce)) {
+	if (1 || !ignore_skip_worktree && ce_skip_worktree(ce)) {
 		ce_mark_uptodate(ce);
 		return ce;
 	}


> If you look at the overall cost of functions exclusively (ie that only
> include the cost of the function and not it's children),
> kernelbase!CreateFileW, kernelbase!CloseHandle, and
> kernebase!GetFileInformationByHandle dominate (84.9% of the time).
> These functions form the basis of the stat emulation on Windows although
> the fscache certainly has an impact on what is happening here as well.

Yeah.. I'm hoping to see something different without fscache. But
probably not much.

> > > Given there were no dirty files, Watchman would have made a huge
> > > improvement in the overall time but index helper would have had
> > > relatively little impact.  We've noticed this same pattern in all our
> > > repos which is what is driving our interest in the Watchman model and
> > > also shows why index-helper is of less interest.
> >
> > Assuming that untracked cache cuts git-status time by half on Windows
> > as well, then index read time now takes a bigger percentage, 8%, where
> > it starts to make sense to optimize it.
> >
> > On a quiet repository, having watchman does not help so much because
> > we already reduce the significant number of filesystem-related system
> > calls. Yes there is lstat() and eliminating it may gain some more
> > (with watchman) and it matters on a repo with lots of directories. You
> > probably can just take these lstat out (I can help point out where)
> > and see how much the gain is.
>
> I don't understand why Watchman won't provide a _significant_ improvement
> here.  My understanding is that it will minimize the stat calls to those
> files that may have changed as well as limiting the untracked cache to
> only scanning those directories that may have changes in them.  In this
> particular scenario, _no_ files have changed so Watchman would return
> an empty set thus eliminating virtually the stat calls and directory
> enumerations.  I'd expect this to result in a >90% savings.  Am I
> missing something?

If stat() calls consume most of the time by read_directory() then yes
watchman provides significant improvement. I was writing that thinking
you did not enable untracked cache. It's a big leap with and without
untracked cache. Watchman's performance gain is smaller in comparison
to that (again I can be really wrong when it comes to Windows stuff).


> > > While the current design hides watchman behind index-helper, if we were
> > > to change that model so they were independent, we would be interested
> > > in doing it in such a way that provided some abstraction so that it
> > > could be replaced with another file watching daemon.
> >
> > Frankly I'm not that interested in replacing another file watching
> > daemon. My first attempt at this problem was "file-watcher" which was
> > tied to Linux inotify system only and it would make sense to make it
> > replaceable. But watchman supports OS X, Linux, FreeBSD and Windows
> > now, not just Linux only as before, why another abstraction layer? You
> > could even replace "watchman.exe" binary. As long as you produce the
> > same json data, your new daemon should still work.
>
> This is a simplification it would be nice to make as we have other code
> already running that can report on all the changes happening.  It would
> enable us to remove the additional complexity of the Watchman daemon.
> I'm sure we can make it work either way by emulating the Watchman
> interface and output.

In the spririt of scratching own itches, please feel free to suggest
some changes to split the watchman interface out of index-helper. It
feels like a burden to me, but I am just a contributor like you.

>
> > Tying index caching daemon and file watching daemon (let's avoid
> > "watchman" for now) gives us a bonus. Because both git and the caching
> > daemon know that they read the same index, we could answer the
> > question "what files are dirty?" with "file number 1, 5, 9 in the
> > index" instead of sending full paths and git has to make some more
> > lookups to identify them. In this series we send it as a compressed
> > bit map. Probably not a big deal in terms of real performance, but it
> > feels nice to do lookups less.
>
> Today, Watchman returns a list of files and directories and then creates
> the compressed bitmap that index-helper uses.  The work of looking those
> entries up in the index and then creating the bitmap still has to happen
> so I suspect you are correct that it doesn't make much of a real
> performance difference.  It's just moving where that lookup and bitmap
> creation happens.

We could do the lookups in background, before git requests it, so the
cost would be hidden. But yeah, numbers decide whether this is an evil
micro-optimization or not.


> I'm in the process of prototyping this, and currently skip much of the
> process of iterating through the list of changed files, looking up the
> entry in the index, creating the bitmap, passing that bitmap through the
> WAMA section to index-helper reading the WAMA section in git and then
> looping through the bitmap to set the CE_WATCHMAN_DIRTY bit on the
> corresponding index entries and updating the untracked cache.
>
> Instead, I iterate through the list of changed files, look up the entry
> in the index and directly set the dirty bit all within read-cache.c.
> At this point, it's <100 lines of code.  I'll keep fleshing this out
> and get some perf numbers once it's working.

Great!

> > The second reason is because watchman daemon alone does not provide
> > enough information to reduce untracked cache's lstat() as much as
> > possible. The current approach in this series is a naive one, which
> > works for some cases, but not optimal (I'll get to that). We need a
> > separate long-running daemon to maintain extra info to reduce lstat().
> > Because our target is watchman, it does not make sense to add yet
> > another daemon besides index-helper to do this.
> >
> > OK the optimal lstat() reduction thing. Right now, if any file in a
> > directory is updated, the directory is invalidated in untracked cache
> > and we need to traverse it to collect excluded files again. But it
> > does not have to be that way. We don't care if any file is _updated_
> > because it will not change untracked cache output. We care about what
> > files are _added_ or _deleted_. New files will need to be classified
> > as either tracked, untracked or ignored. Deleted files may invalid
> > either three file lists. Watchman cannot answer "what files are added
> > or deleted since the point X in time" and I agree that it's not
> > watchman's job (watchman issue 65). So we have to maintain some more
> > info by ourselves, e.g. the list of files at any requested "clock".
> > With that we can compare the file lists of two "clock"s and tell git
> > what files are added or deleted.
>
> This sounds like a nice optimization but right now I'm focused on how we
> can scope the cost of status to be limited to the files and directories
> that may have changes.  With large repos, this is a small subset of the
> overall repo and will hopefully be enough to make the performance
> reasonable.

The use case in my mind is building stuff where .o files are put in
the same place as source files, and such a build would touch everything.
I certainly am not familar with what most real large repos look like
and how they are used. So I may be wrong.
--
Duy
