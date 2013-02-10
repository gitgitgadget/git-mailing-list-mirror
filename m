From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 18:17:32 +0700
Message-ID: <20130210111732.GA24377@lanh>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 12:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4UuQ-0001dF-2g
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 12:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab3BJLQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 06:16:56 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:36025 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab3BJLQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 06:16:48 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so2419211dad.10
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 03:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zLnmbS8IE+mIE+WaDIL29u6x3JZhxhSx4rrlvz/6bLQ=;
        b=Js8vhHFYqqrbjviGHnNhGW2KdQywl24ZUoYdr2YZ/QPnCpJMb0jrqHCjXus8u/4SIv
         Spb5/QSuFamRrjHSCBpiBL+B+gHLoFuUJzr2jUCrXqjZCSGO98bPKeAh7EAHt4MUshp6
         y62wadWr1hKUehmiabyFI0KhRzd33wky7tdsKXxiepS2s9CvXWpooMmWRsrF3ZDB4XD7
         e525yzO58OpZ/siJvt6ib8P+p6+J0VogQ0xmMeCV38W6gGgILdDDuAKequxFbZi4cxkK
         M6dYLS+ROFNEfs7qH1reJKNbaJ1poMY5RBq3owlJIkDxkCrXHnetPJ6eQSzv9i6D8Msh
         U7Ng==
X-Received: by 10.68.245.103 with SMTP id xn7mr9943541pbc.30.1360495007869;
        Sun, 10 Feb 2013 03:16:47 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id rk5sm4256498pbb.21.2013.02.10.03.16.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 03:16:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Feb 2013 18:17:32 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215900>

On Sun, Feb 10, 2013 at 12:24:58PM +0700, Duy Nguyen wrote:
> On Sun, Feb 10, 2013 at 12:10 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > Finn notes in the commit message that it offers no speedup, because
> > .gitignore files in every directory still have to be read.  I think
> > this is silly: we really should be caching .gitignore, and touching it
> > only when lstat() reports that the file has changed.
> >
> > ...
> >
> > Really, the elephant in the room right now seems to be .gitignore.
> > Until that is fixed, there is really no use of writing this inotify
> > daemon, no?  Can someone enlighten me on how exactly .gitignore files
> > are processed?
>
> .gitignore is a different issue. I think it's mainly used with
> read_directory/fill_directory to collect ignored files (or not-ignored
> files). And it's not always used (well, status and add does, but diff
> should not). I think wee need to measure how much mass lstat
> elimination gains us (especially on big repos) and how much
> .gitignore/.gitattributes caching does.

OK let's count. I start with a "standard" repository, linux-2.6. This
is the number from strace -T on "git status" (*). The first column is
accumulated time, the second the number of syscalls.

top syscalls sorted     top syscalls sorted
by acc. time            by number
----------------------------------------------
0.401906 40950 lstat    0.401906 40950 lstat
0.190484 5343 getdents	0.150055 5374 open
0.150055 5374 open	0.190484 5343 getdents
0.074843 2806 close	0.074843 2806 close
0.003216 157 read	0.003216 157 read

The following patch pretends every entry is uptodate without
lstat. With the patch, we can see refresh code is the cause of mass
lstat, as lstat disappears:

0.185347 5343 getdents  0.144173 5374 open
0.144173 5374 open	0.185347 5343 getdents
0.071844 2806 close	0.071844 2806 close
0.004918 135 brk	0.003378 157 read
0.003378 157 read	0.004918 135 brk

-- 8< --
diff --git a/read-cache.c b/read-cache.c
index 827ae55..94d8ed8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1018,6 +1018,10 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	if (ce_uptodate(ce))
 		return ce;

+#if 1
+	ce_mark_uptodate(ce);
+	return ce;
+#endif
 	/*
 	 * CE_VALID or CE_SKIP_WORKTREE means the user promised us
 	 * that the change to the work tree does not matter and told
-- 8< --

The following patch eliminates untracked search code. As we can see,
open+getdents also disappears with this patch:

0.462909 40950 lstat   0.462909 40950 lstat
0.003417 129 brk       0.003417 129 brk
0.000762 53 read       0.000762 53 read
0.000720 36 open       0.000720 36 open
0.000544 12 munmap     0.000454 33 close

So from syscalls point of view, we know what code issues most of
them. Let's see how much time we gain be these patches, which is an
approximate of the gain by inotify support. This time I measure on
gentoo-x86.git [1] because this one has really big worktree (100k
files)

        unmodified  read-cache.c  dir.c     both
real    0m0.550s    0m0.479s      0m0.287s  0m0.213s
user    0m0.305s    0m0.315s	  0m0.201s  0m0.182s
sys     0m0.240s    0m0.157s	  0m0.084s  0m0.030s

and the syscall picture on gentoo-x86.git:

1.106615 101942 lstat    1.106615 101942 lstat
0.667235 47083 getdents	 0.641604 47114 open
0.641604 47114 open	 0.667235 47083 getdents
0.286711 23573 close	 0.286711 23573 close
0.005842 350 brk	 0.005842 350 brk

We can see that shortcuting untracked code gives bigger gain than
index refresh code. So I have to agree that .gitignore may be the big
elephant in this particular case.

Bear in mind though this is Linux, where lstat is fast. On systems
with slow lstat, these timings could look very different due to the
large number of lstat calls compared to open+getdents. I really like
to see similar numbers on Windows.

read_directory/fill_directory code is mostly used by "git add" (not
with -u) and "git status", while refresh code is executed in add,
checkout, commit/status, diff, merge. So while smaller gain, reducing
lstat calls could benefit in more cases.

A relatively slow "git add" is acceptable. "git status" should be
fast. Although in my workflow, I do "git diff [--stat] [--cached]"
much more often than "git status" so relatively slow "git status" does
not hurt me much. But people may do it differently.

On speeding up read_directory with inotify support. I haven't thought
it through, but I think we could save (or get it via socket) a list of
untracked files in .git, regardless ignore status, with the help from
inotify. When this list is verified valid, read_directory could be
modified to traverse the tree using this list (plus the index) instead
of opendir+readdir. Not sure how the change might look though.


[1] http://git-exp.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary

(*) the script to produce those numbers is

-- 8< --
#!/bin/sh

export LANG=C
strace -T "$@" 2>&1 >/dev/null |
	sed 's/\(^[^(]*\)(.*<\([0-9.]*\)>$/\1 \2/' |
	awk '{
	  sec[$1]+=$2;
	  count[$1]++;
	}
	END {
	  for (i in sec)
	    printf("%f %d %s\n", sec[i], count[i], i);
	  }' >/tmp/s

sort -nr /tmp/s | head -n5
sort -nrk2 /tmp/s | head -n5
-- 8< --
