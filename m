From: Jakub Narebski <jnareb@fuw.edu.pl>
Subject: Re: Upcoming memcached releases + rambling.
Date: 11 Feb 2008 13:50:53 +0100
Message-ID: <m33arzfyhe.fsf@localhost.localdomain>
References: <20080210094753.23234.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: memcached@lists.danga.com
X-From: memcached-bounces@lists.danga.com Mon Feb 11 13:55:56 2008
Return-path: <memcached-bounces@lists.danga.com>
Envelope-to: gcdm-memcached@m.gmane.org
Received: from mail.danga.com ([207.7.148.197])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYCP-0007vz-0r
	for gcdm-memcached@m.gmane.org; Mon, 11 Feb 2008 13:55:53 +0100
Received: from Unknown (HELO mail.danga.com) (127.0.0.1)
    by mail.danga.com (qpsmtpd/0.40) with ESMTP; Mon, 11 Feb 2008 12:55:19 +0000
X-Original-To: memcached@lists.danga.com
Delivered-To: memcached@mail.danga.com
X-Spam-Status: No, hits=-0.0 required=5.0
	tests=SPF_HELO_PASS,SPF_PASS
X-Spam-Check-By: mail.danga.com
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
	by mail.danga.com (qpsmtpd/0.40) with (AES256-SHA encrypted) ESMTPS;
	Mon, 11 Feb 2008 12:55:09 +0000
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JOYBa-00051g-8E
	for memcached@lists.danga.com; Mon, 11 Feb 2008 12:55:04 +0000
Received: from abvw19.neoplus.adsl.tpnet.pl ([83.8.220.19])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <memcached@lists.danga.com>; Mon, 11 Feb 2008 12:55:02 +0000
Received: from jnareb by abvw19.neoplus.adsl.tpnet.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <memcached@lists.danga.com>; Mon, 11 Feb 2008 12:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw19.neoplus.adsl.tpnet.pl
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Virus-Checked: Checked by ClamAV on mail.danga.com
X-BeenThere: memcached@lists.danga.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "memory cache daemon developers &amp;
	users" <memcached.lists.danga.com>
List-Unsubscribe: <http://lists.danga.com/mailman/listinfo/memcached>,
	<mailto:memcached-request@lists.danga.com?subject=unsubscribe>
List-Archive: <http://lists.danga.com/pipermail/memcached>
List-Post: <mailto:memcached@lists.danga.com>
List-Help: <mailto:memcached-request@lists.danga.com?subject=help>
List-Subscribe: <http://lists.danga.com/mailman/listinfo/memcached>,
	<mailto:memcached-request@lists.danga.com?subject=subscribe>
Sender: memcached-bounces@lists.danga.com
Errors-To: memcached-bounces@lists.danga.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73528>

"George Spelvin" <linux@horizon.com> writes:

> A few notes about git that may be causing confusion:
> 
> 1) "git pull" does more than you think, and is for developers only.
> 
>    To just follow some other work, use only "git fetch".
> 
>    "git pull" does a fetch, and then merges the fetched branch into your
>    current HEAD.  If your current HEAD is a copy of the remote branch,
>    this will be harmless, but if it's not, it will produce code changes.

Note that "git fetch" usually fetches multiple branches; with default
configuration it fetches _all_ the branches. "git pull" would merge
the one marked for merge into current branch (HEAD is current branch),
either the one marked explicitely, or the first/main branch.
 
>    "git fetch" will fetch the remote branch, and then do a "fast-forward"
>    update of the corresponding local tracking branch.  If the local
>    tracking branch is not an ancestor of the fetched branch, it will
>    abort with an error.

But you can force fetching even if branch(es) in remote repository are
not ancestors of local tracking branches, which is needed if tracked
branch is rewound, reforked or rebased. Moreover by default this check
is disabled: all fetches are "forced".

You can always go to the previous value of branch thanks to reflogs,
so it is not really less safe, and avoids some hassle.

>    So, in summary, don't use "pull" unless you want to do a merge.
>    It will suppress the merge in the obvious trivial cases (no changes
>    on one side or the other), but will happily combine things.
> 
>    (The reason that "pull" is such a prominent command is that it's what
>    Linus does all day: merges other people's development into his tree.)

BTW. with newest git "git pull" _can_ rebase instead of merge.

> 2) "git log old..new" is a special case of a very general mechanism
>    for specifying a set of commits to examine.

>    The syntax is "include1 include2 ^exclude1 ^exclude2 include3...".

>    There is one magic bit of syntax, the symmetric difference operator
>    "rev1...rev2" (note three dots).  That means all ancestors of rev1,
>    and all ancestors of rev2, but excluding all common ancestors of both.
>    It's also equivalent to an include-exclude list, but the computation
>    of the exclude set is a bit more complicated.  (It's usually just
>    one common ancestor, but there can be multiples in nasty criss-cross
>    merge cases.)

"rev1...rev2" is equivalent to "rev1 rev2 --not $(git merge-base rev1 rev2)"
which I think explains what it does.
 
> 3) "git diff old..new" uses the same syntax for a different purpose.
>    diff only works with two commits, so that's simply an alias for
>    "git diff old new".  (Whether this is a useful conveience or is too
>    misleading for the beginner has been the subject of heated discussion
>    on the git mailing list.)

By the way, "git diff rev1...rev2" also works, and shows diff between
rev2 and common ancestor of rev1 and rev2 (merge base).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
