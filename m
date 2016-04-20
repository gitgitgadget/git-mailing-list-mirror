From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 03/15] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 20 Apr 2016 14:17:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604201349590.2826@virtualbox>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com> <1461108489-29376-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 14:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asr4I-0003lJ-N9
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 14:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbcDTMRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 08:17:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:56689 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbcDTMRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 08:17:13 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0McEDD-1b8Sdo1RKB-00Jc54; Wed, 20 Apr 2016 14:17:07
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1461108489-29376-4-git-send-email-dturner@twopensource.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RER4JJvoq0UrdvqdgCh64vPpB671MzIXmAA2TBfZADTN9wgaPhj
 raFxX7/8zRU8IDt5u4Xc+oOMIwZHj24imfFRzJGz5c42OeJ1mLoI/oeNe6d8NX6YMPDtTME
 NbupQ+pPc4olPo4r8nrC0DlWF4Jr7ouBludzEOxcfrMWJAjSCnP4St03xsMpWt9TBHA9ozE
 xaSgTCjrzavOL0gMg91lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lNjGeTlTwHc=:EGGqSOeSArifeitiglwq4l
 NKrnF+3azOMpOuiabkOkpXxS8KXH3omCOo3nAdO+CJ/p31BftkVyvnFI8UPfwbK5j5breHuG/
 UtGCJdexypqEyAOwFKHn4uoSMx7+u1SUMr6brHG5Bwoa7oHRQqLeOo0aAO6hVOAo1cJZYqRh8
 CgmUGQLREYoftnRgVT9tTQ23S00XttKOmZscUKkbnQC0VXzJHQbTYJ9TTy26QrbmZCJaHBqX9
 gxo/YQhL3BtdE63WkrasMzvUhG9yiRfDdzpF67VeBlDkL7tUFiw4DzWmJb49iRLSlZ2ZF+moF
 ooLAKCL1GG+60OjAl+tJu5Dl6Q/EQsjh4LFFgBYBjF6/tMybXuZD5+99WQtj97b+C02wUMAfm
 f8BDteJ34Q/scMWIQG8Ht5UNnEOF80fBieU4RH7aT0unvzhAGaq+hdTXc+3PK9A58Sy798+wB
 rn9xS+EmRSWHucvSENvwzEaZFIT9qy2RcbmdCJds9ocPptj1WfOH8nwVZgzEimsxgUAgWdCmy
 hiAjRX0DoJrX5AuHOJFcZZQN9qgVs0NY8nsIm7HhUOzvCmQNFqpoMFV545SNRjen6b2Ax19+d
 LHYVMRUx8QVRYEPXtYR6QLhT/Cmiu/gFo1/JYLfmNjIgpGuTWX8LpKhnkJX7uwPSzs5HwclR8
 zr3jxPogkREkvIAuXGWXOpzEzmkfQ4OwsPRnuimUCxvveLFrNec0iHDv2/JmZSpLdd36joswZ
 u64KSUOl1iDtT69CiFqbjHnGcqI2BJQUtebXIm4MovraGRJ+oCPylA/umc7RaNzjhKf4SgeC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292004>

Hi Dave,

(apologies in advance if I may bring up anything that has been discussed
in earlier iterations; I simply was too busy with the rebase--helper
project to even look.)

On Tue, 19 Apr 2016, David Turner wrote:

> Shared memory is done by storing files in a per-repository temporary
> directory.  This is more portable than shm (which requires
> posix-realtime and has various quirks on OS X).  It might even work on
> Windows, although this has not been tested. The shared memory file's
> name folows the template "shm-<object>-<SHA1>" where <SHA1> is the

s/folows/follows/

And: now that it is no longer shared memory, should we not do away with
the "shm-" prefix?

> trailing SHA-1 of the index file. <object> is "index" for cached index
> files (and might later be "name-hash" for name-hash cache). If such
> shared memory exists, it contains the same index content as on
> disk. The content is already validated by the daemon and git won't
> validate it again (except comparing the trailing SHA-1s).

Excellent. I was worrying about the penalty of validating.

> We keep this daemon's logic as thin as possible. The "brain" stays in
> git. So the daemon can read and validate stuff, but that's all it's
> allowed to do. It does not add/create new information. It doesn't even
> accept direct updates from git.

I like this design. For now. Later, I really think we should add the
ability to update the index via the index-helper. I am thinking about a
method similar to watchman where a separate process (that may use the
inotify syscall on Linux, or tap into the NTFS journal on Windows) tells
the index-helper specifically which paths to look at, so that nobody ever
has to look at any files that were not modified at all.

> +	if (*new_mmap == MAP_FAILED) {
> +		*new_mmap = NULL;
> +		goto done;

Shouldn't we provide some sort of error message here?

> +	}
> +	madvise(new_mmap, size, MADV_WILLNEED);

I guess I'll need to add support for that to compat/win32mmap.c (most
likely using PrefetchVirtualMemory() when available, i.e. Windows >= 8, see
https://msdn.microsoft.com/en-us/library/windows/desktop/hh780543.aspx :-))

Likewise, I think it will be easy to use bidirectional named pipes on
Windows to accommodate for the lack of Unix domain sockets...

Ciao,
Dscho
