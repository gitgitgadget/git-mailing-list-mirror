From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Sun, 11 May 2014 15:56:22 -0700
Organization: Twitter
Message-ID: <1399848982.11843.161.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
	 <1399747109.11843.137.camel@stross>
	 <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 00:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjcfY-0007Dl-4V
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 00:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbaEKW42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 18:56:28 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51914 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaEKW41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 18:56:27 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so7064667pab.10
        for <git@vger.kernel.org>; Sun, 11 May 2014 15:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=LYvApLR3Nd+0mvosbsbE4R6eueAvg/Tdw3pnegEwTlQ=;
        b=I3FdIka2li2E0LdnQpXqNZCd2T+/6izh4yyOt3z+vEtDwxtNFYvHv7cK7ZbrPQP6Vh
         e8ow/5+Qwi6T53hYpaXbQs8eQFYHq1C0o1xeceXFY+8gIoIlJCq91WT6KtSIO/nSn7qN
         I+yJt8lw6KXhW92NwNrB2qHuZdBVcuuwHsQs0zzOvp8G9JK9Rt0YncWwypOIcNQM5ffu
         eW4HHP88TOjgF4WhMG/TrC/zULCbDVkCtBG5Psa4owcyy7ne/fdI3A78kDYV9XjOubL7
         X1d4fe42TIT4CLttjlDYHk8AMjgVOCxV4762LnwhZZu3baQZ1tVICkaVUGwDWEC6g/Hz
         ceug==
X-Gm-Message-State: ALoCoQn21XciKaAfMTpgIg4h3tEQIcEJnuB74MwYcJDn+40ndSA806zlD/VP2/D+8LSf0FHpaxz2
X-Received: by 10.67.13.134 with SMTP id ey6mr48562697pad.44.1399848986830;
        Sun, 11 May 2014 15:56:26 -0700 (PDT)
Received: from [192.168.0.2] (65-102-19-155.ptld.qwest.net. [65.102.19.155])
        by mx.google.com with ESMTPSA id sv10sm19304024pbc.74.2014.05.11.15.56.24
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 11 May 2014 15:56:25 -0700 (PDT)
In-Reply-To: <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248682>

On Sun, 2014-05-11 at 07:21 +0700, Duy Nguyen wrote:
> On Sun, May 11, 2014 at 1:38 AM, David Turner <dturner@twopensource.com> wrote:
> >> I got "warning: Watchman watch error: Got bad JSON from watchman
> >> get-sockname: '[' or '{' expected near end of file". Any ideas what I
> >> did wrong? I'm using watchman.git and libwatchman.git. check-0.9.11
> >> and jansson-2.4 were installed by system (gentoo).
> >
> > What do you get from watchman get-sockname on the command-line?  Do the
> > watchman tests pass?
> 
> Found the problem. "watchman" binary is not in $PATH but popen() did
> not complain (or it did but your "2>/dev/null" in watchman_connect
> suppressed it). 

I should probably not be using popen, since it doesn't offer good error
reporting.  I'll try to fix that in the next few days.

> BTW you need to update the array size of "expressions"
> in test_watchman_misc().

Thanks, fixed.

> So without watchman I got
> 
>    299.871ms read_index_from:1538 if (verify_hdr(hdr, mmap_size) < 0) go
>    498.205ms cmd_status:1300 refresh_index(&the_index, REFRESH_QUIE
>    796.050ms wt_status_collect:622 wt_status_collect_untracked(s)
> 
> and with watchman ("git status" ran several times to make sure it's cached)
> 
>    301.950ms read_index_from:1538 if (verify_hdr(hdr, mmap_size) < 0) go
>     34.918ms  read_fs_cache:347 if (verify_hdr(hdr, mmap_size) < 0) go
>   1564.096ms  watchman_load_fs_cache:628 update_fs_cache(istate, result);
>    161.930ms cmd_status:1300 refresh_index(&the_index, REFRESH_QUIE
>    251.614ms wt_status_collect:622 wt_status_collect_untracked(s)
> 
> Given the total time of "git status" without watchman is 1.9s,,
> update_fs_cache() nearly matches that number alone. All that is spent
> in the exclude update code in the function, but if you do
> last_excluding_matching() anyway, why cache it?

My numbers are different (for my test repository):

---
    30.031ms read_index:1386 r = read_index_from(istate, get_index_
    71.625ms cmd_status:1302 refresh_index(&the_index, REFRESH_QUIE
   259.712ms wt_status_collect:622 wt_status_collect_untracked(s)
----
    41.110ms read_index:1386 r = read_index_from(istate, get_index_
     9.294ms read_fs_cache:347 if (verify_hdr(hdr, mmap_size) < 0) go
     0.173ms watchman_load_fs_cache:628 update_fs_cache(istate, result)
    41.901ms read_index:1386 r = read_index_from(istate, get_index_
    18.355ms cmd_status:1302 refresh_index(&the_index, REFRESH_QUIE
    50.911ms wt_status_collect:622 wt_status_collect_untracked(s)
---

I think something must be going wrong with update_fs_cache on your
machine.  I have a few hypotheses:

1. Maybe watchman isn't fully started up when you run your tests.
2. Maybe there is a bug.

update_fs_cache should only have to update based on what it has learned
from watchman.  So if no .gitignore has been changed, it should not have
to do very much work.

I could take the fe_excluded check and move it above the
last_exclude_matching check in fs_cache_is_excluded; it causes t7300 to
fail when run under watchman but presumably that's fixable

> I think we're paying lookup cost in refresh_index(). I forced CE_VALID
> bit on as an experiment and refresh_index() went down to 33ms.

Yes, it is possible to use Watchman to set CE_VALID as well, and I
should probably do that.  It's a bit more complicated (at least, I
recall running into problems), but probably doable.

> A bit surprised about wt_status_collect_untracked number. I verified
> that last_excluding_matching() still runs (on the same number of
> entries like in no-watchman case). Replacing fs_cache_open() in
> add_excludes_from_file_to_list() to plain open() does not change the
> number, so we probably won't need that (unless your worktree is filled
> with .gitignore, which I doubt it's a norm). 

My test repo has a couple hundred of them.  Maybe that's unusual?  A
repo with a lot of projects will tend to have lots of gitignore files,
because each project will want to maintain them independently.
