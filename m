From: David Goldfarb <deg@degel.com>
Subject: RE: trouble on windows network share
Date: Wed, 8 May 2013 09:37:57 +0000
Message-ID: <8B6563E531152E4190313499F193F94214AB8CED@mbx500-u1-lo-3.exch500.msoutlookonline.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
	<1367529968647-7584800.post@n2.nabble.com>
	<87ppx8o1lj.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net>
 <87ip2wla12.fsf@linux-k42r.v.cablecom.net>
 <871B6C10EBEFE342A772D1159D1320853F65E5B6@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 08 11:38:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua0p5-0000lI-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 11:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab3EHJiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 05:38:01 -0400
Received: from hub500-lo-2.exch500.serverdata.net ([205.217.20.184]:41101 "EHLO
	hub500-lo-2.exch500.serverdata.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439Ab3EHJh7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 May 2013 05:37:59 -0400
Received: from MBX500-U1-LO-3.exch500.msoutlookonline.net ([10.32.4.55]) by
 HUB500-LO-2.exch500.msoutlookonline.net ([10.32.4.33]) with mapi id
 14.03.0123.003; Wed, 8 May 2013 02:37:49 -0700
Thread-Topic: trouble on windows network share
Thread-Index: AQHOSj3+DJxfER0S7U2/adU3l4duX5j4lwwAgAJtFzA=
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853F65E5B6@umechphj.easf.csd.disa.mil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [87.69.114.75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223651>

Here's one more data point. It suggests that the problem is due to either Cygwin or possibly Git 1.7.9.


My Ubuntu box is actually a VM, hosted by my windows box in VMWare Player.

So, I tried using the VMWare shared folder feature, to mount the Windows U: drive (which is physically on the WD NAS box) as /mnt/hgfs/Host-U on Ubuntu.
Then, I tried linux on the Ubuntu box, fully expecting it to fail as it trampolined through Windows connection to the NAS box).

But, it worked fine.

So, at this point, it became likely that the problem is tied to the different version of Git that I have on the two machines:
- On Ubuntu, git version 1.7.10.4
- On Windows, Cygwin's git version 1.7.9 (which appears to be the latest version for Cygwin).

So, I installed Git on Windows from http://git-scm.com/download/win. Git version 1.8.1.msysgit.1

Triumph: Git on windows works with this git but, on the same file and repo, fails with Cygwin git.

So, either something relevant changed in Git 1.7.10, or (more likely) this is a Cygwin issue.


Jason, are you also using Cygwin git?  Are you also using a WD NAS?

David

-----Original Message-----
From: Pyeron, Jason J CTR (US) [mailto:jason.j.pyeron.ctr@mail.mil] 
Sent: Monday, May 06, 2013 4:11 PM
To: Thomas Rast; David Goldfarb
Cc: git@vger.kernel.org
Subject: RE: trouble on windows network share

> -----Original Message-----
> From: Thomas Rast
> Sent: Monday, May 06, 2013 5:42 AM
> 
> David Goldfarb <deg@degel.com> writes:
> 
> > Git works correctly under Linux (Ubuntu 12.04; git 1.7.9.5).  I've
> attached the strace outputs. (Note: for reasons that are probably
> irrelevant, I needed to run the commands sudo'd. Shout back if this is
> an issue).
> >
> > Under Windows 7, Cygwin git 1.7.9, commit fails:
> >   U:\foo>git commit -m "added foo2"
> >   error: unable to find 0b89efdeef245ed6a0a7eacc5c578629a141f856
> >   fatal: 0b89efdeef245ed6a0a7eacc5c578629a141f856 is not a valid
> object
> >
> > For what it's worth, note that the file does exist.
> >   U:\foo>ls -l .git/objects/0b
> >   total 1024
> >   -rwxrw-r-- 1 ???????? ???????? 74 May  5 01:15
> 89efdeef245ed6a0a7eacc5c578629a141f856
> >
> > (I'm not sure why the permissions are trashed. Seems to be a Cygwin
> thing, or maybe my Cygwin config. The "??????" also  appears on local
> files, and I believe also with files on the old Buffalo drive, so I
> don't think it is relevant to the problem).  Just in case, here's the
> same dir, as seen from the Ubuntu VM:
> >
> >   deg@ubuntu:/mnt/users/foo$ ls -l .git/objects/0b
> >   total 64
> >   -rwxr-xr-x 0 root root 74 May  5 01:15
> 89efdeef245ed6a0a7eacc5c578629a141f856
> >
> > Again, note that there is some user permissions lossage here. I don't
> know enough about Linux mount or CIFS, and apparently did the mount in
> a way that everything seems to appear to be stuck owned by root. (same
> problem I hinted at above). Hope this is not relevant to the problem.
> >
> > Here's how the same directory looks, when I'm ssh'd into the NAS box
> itself:
> >
> >    CentralPark:/shares/Users/foo# ls -l .git/objects/0b
> >   total 64
> >   -rwxrw-r-- 1 deg share 74 May  5 01:15
> 89efdeef245ed6a0a7eacc5c578629a141f856
> >
> > In any event, the symptoms don't seem to be a permissions problem, so
> all this extra info is probably just a red herring, I hope.
> 
> Hrm.  What about what Jeff already asked of the OP (and AFAICS never
> got
> a reply)?

If referring to me, then yes but it was too big for the list.

> 
> } If it's a race condition between the write and the subsequent read in
> } the same process, then it would be solved by looking at the object
> } later. Does "git cat-file -p
> 6838761d549cf76033d2e9faf5954e62839eb25d"
> } work, or is the object forever inaccessible?
> 
> In your case: git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
