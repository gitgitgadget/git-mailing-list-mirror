From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: trouble on windows network share
Date: Mon, 6 May 2013 11:42:17 +0200
Message-ID: <87ip2wla12.fsf@linux-k42r.v.cablecom.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
	<1367529968647-7584800.post@n2.nabble.com>
	<87ppx8o1lj.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Goldfarb <deg@degel.com>
X-From: git-owner@vger.kernel.org Mon May 06 11:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZHw9-0004Ww-NU
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 11:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab3EFJmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 05:42:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:47951 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab3EFJmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 05:42:20 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 11:42:17 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 6 May 2013 11:42:17 +0200
In-Reply-To: <8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net>
	(David Goldfarb's message of "Sat, 4 May 2013 23:23:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223432>

David Goldfarb <deg@degel.com> writes:

> Git works correctly under Linux (Ubuntu 12.04; git 1.7.9.5).  I've attached the strace outputs. (Note: for reasons that are probably irrelevant, I needed to run the commands sudo'd. Shout back if this is an issue).
>
> Under Windows 7, Cygwin git 1.7.9, commit fails:
>   U:\foo>git commit -m "added foo2"
>   error: unable to find 0b89efdeef245ed6a0a7eacc5c578629a141f856
>   fatal: 0b89efdeef245ed6a0a7eacc5c578629a141f856 is not a valid object
>
> For what it's worth, note that the file does exist.
>   U:\foo>ls -l .git/objects/0b
>   total 1024
>   -rwxrw-r-- 1 ???????? ???????? 74 May  5 01:15 89efdeef245ed6a0a7eacc5c578629a141f856
>
> (I'm not sure why the permissions are trashed. Seems to be a Cygwin thing, or maybe my Cygwin config. The "??????" also  appears on local files, and I believe also with files on the old Buffalo drive, so I don't think it is relevant to the problem).  Just in case, here's the same dir, as seen from the Ubuntu VM:
>
>   deg@ubuntu:/mnt/users/foo$ ls -l .git/objects/0b
>   total 64
>   -rwxr-xr-x 0 root root 74 May  5 01:15 89efdeef245ed6a0a7eacc5c578629a141f856
>
> Again, note that there is some user permissions lossage here. I don't know enough about Linux mount or CIFS, and apparently did the mount in a way that everything seems to appear to be stuck owned by root. (same problem I hinted at above). Hope this is not relevant to the problem.
>
> Here's how the same directory looks, when I'm ssh'd into the NAS box itself:
>
>    CentralPark:/shares/Users/foo# ls -l .git/objects/0b
>   total 64
>   -rwxrw-r-- 1 deg share 74 May  5 01:15 89efdeef245ed6a0a7eacc5c578629a141f856
>
> In any event, the symptoms don't seem to be a permissions problem, so all this extra info is probably just a red herring, I hope.

Hrm.  What about what Jeff already asked of the OP (and AFAICS never got
a reply)?

} If it's a race condition between the write and the subsequent read in
} the same process, then it would be solved by looking at the object
} later. Does "git cat-file -p 6838761d549cf76033d2e9faf5954e62839eb25d"
} work, or is the object forever inaccessible?

In your case: git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
