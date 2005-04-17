From: David Lang <david.lang@digitalinsight.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 18:03:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504161801030.22652@qynat.qvtvafvgr.pbz>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
 <20050416233724.GP19099@pasky.ji.cz> <20050416170221.38b3e66c.pj@sgi.com>
 <20050417003325.GA15608@redhat.com> <20050416174409.59f94c26.pj@sgi.com>
 <20050417005757.GB15608@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Paul Jackson <pj@sgi.com>, pasky@ucw.cz, git@vger.kernel.org,
	mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 03:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMy9Z-0001ic-TQ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 03:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDQBE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDQBE3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:04:29 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:28409 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261230AbVDQBES
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 21:04:18 -0400
Received: from wlvims01.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 18:04:18 -0700
Received: by wlvexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <24ZZ15RZ>; Sat, 16 Apr 2005 18:04:02 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX18B3; Sat, 16 Apr 2005 18:03:59 -0700
To: Dave Jones <davej@redhat.com>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20050417005757.GB15608@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

set your umask to make things only writeable by the same user.
then create a new directory (it will fail with an error if the directory 
already exists)

now you can create files in this directory without having to worry about 
other users makeing trouble for you (they can't create symlinks in this 
directory)

David Lang

On Sat, 16 Apr 2005, Dave Jones wrote:

> Date: Sat, 16 Apr 2005 20:57:57 -0400
> From: Dave Jones <davej@redhat.com>
> To: Paul Jackson <pj@sgi.com>
> Cc: pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
> Subject: Re: fix mktemp (remove mktemp ;)
> 
> On Sat, Apr 16, 2005 at 05:44:09PM -0700, Paul Jackson wrote:
> > Dave wrote:
> > > mktemp is being used here to provide randomness in the filename,
> > > not just a uniqueness.
> >
> > Ok - useful point.
> >
> > How about:
> >
> > 	t=${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM
>
> pid is still predictable by watching ps output, $RANDOM is one of 32768
> numbers, so it's still feasable to predict the result.
> $RANDOM$RANDOM is better, and gets a little closer to mktemp strength randomness.
>
> > > all an attacker has to do is create 65535 symlinks in /usr/tmp
> > And how about if I removed the tmp files at the top:
> >
> > 	t=${TMPDIR:-/usr/tmp}/gitdiff.$$.$RANDOM
> > 	trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
> > 	rm -fr $t.?
> >
> > 	... rest of script ...
>
> Racy, though the chance of creating x thousand symlinks in such a small
> window probably makes it a non-issue.
>
> Actually.. http://www.linuxsecurity.com/content/view/115462/151/
> has some interesting bits on temp dir creation without mktemp.
> See section 3.4 onwards.
>
> 		Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
