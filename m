From: David Goldfarb <deg@degel.com>
Subject: RE: trouble on windows network share
Date: Mon, 6 May 2013 09:53:51 +0000
Message-ID: <8B6563E531152E4190313499F193F94214AAAB42@mbx500-u1-lo-3.exch500.msoutlookonline.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
	<1367529968647-7584800.post@n2.nabble.com>
	<87ppx8o1lj.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net>
 <87ip2wla12.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 11:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZI7K-0005KG-LI
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 11:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab3EFJxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 05:53:54 -0400
Received: from HUB500-LO-8.exch500.serverdata.net ([205.217.20.172]:36748 "EHLO
	hub500-LO-8.EXCH500.SERVERDATA.NET" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752842Ab3EFJxy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 May 2013 05:53:54 -0400
Received: from MBX500-U1-LO-3.exch500.msoutlookonline.net ([10.32.4.55]) by
 HUB500-LO-8.exch500.msoutlookonline.net ([10.32.4.73]) with mapi id
 14.03.0123.003; Mon, 6 May 2013 02:53:44 -0700
Thread-Topic: trouble on windows network share
Thread-Index: AQHOSj3+DJxfER0S7U2/adU3l4duX5j36RTQ
In-Reply-To: <87ip2wla12.fsf@linux-k42r.v.cablecom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [87.69.114.75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223434>

Looks like it works.

>From the windows machine:
    U:\foo>git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
    100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
    100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2

    U:\foo>


Double-checking that nothing was fixed or changed when I earlier committed the file from Linux, here's a second test:


    U:\foo>git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
    100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
    100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
    
    U:\foo>git status
    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       trace1
    #       trace2
    nothing added to commit but untracked files present (use "git add" to track)
    
    U:\foo>git add trace1
    
    U:\foo>git commit trace1 -m "testing"
    error: unable to find cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
    fatal: cecae5b4c87ea21aef513fcfcd5c27fe87e0536f is not a valid object
    
    U:\foo>git cat-file -p cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
    100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
    100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
    100644 blob 19102815663d23f8b75a47e7a01965dcdc96468c    test.txt
    100644 blob c9009b02950964cf1d5281125e6e2f647dd9dc16    trace1

   U:\foo>


David

-----Original Message-----
From: Thomas Rast [mailto:trast@inf.ethz.ch] 
Sent: Monday, May 06, 2013 12:42 PM
To: David Goldfarb
Cc: git@vger.kernel.org
Subject: Re: trouble on windows network share

David Goldfarb <deg@degel.com> writes:

> Git works correctly under Linux (Ubuntu 12.04; git 1.7.9.5).  I've attached the strace outputs. (Note: for reasons that are probably irrelevant, I needed to run the commands sudo'd. Shout back if this is an issue).
>
> Under Windows 7, Cygwin git 1.7.9, commit fails:
>   U:\foo>git commit -m "added foo2"
>   error: unable to find 0b89efdeef245ed6a0a7eacc5c578629a141f856
>   fatal: 0b89efdeef245ed6a0a7eacc5c578629a141f856 is not a valid 
> object
>
> For what it's worth, note that the file does exist.
>   U:\foo>ls -l .git/objects/0b
>   total 1024
>   -rwxrw-r-- 1 ???????? ???????? 74 May  5 01:15 
> 89efdeef245ed6a0a7eacc5c578629a141f856
>
> (I'm not sure why the permissions are trashed. Seems to be a Cygwin thing, or maybe my Cygwin config. The "??????" also  appears on local files, and I believe also with files on the old Buffalo drive, so I don't think it is relevant to the problem).  Just in case, here's the same dir, as seen from the Ubuntu VM:
>
>   deg@ubuntu:/mnt/users/foo$ ls -l .git/objects/0b
>   total 64
>   -rwxr-xr-x 0 root root 74 May  5 01:15 
> 89efdeef245ed6a0a7eacc5c578629a141f856
>
> Again, note that there is some user permissions lossage here. I don't know enough about Linux mount or CIFS, and apparently did the mount in a way that everything seems to appear to be stuck owned by root. (same problem I hinted at above). Hope this is not relevant to the problem.
>
> Here's how the same directory looks, when I'm ssh'd into the NAS box itself:
>
>    CentralPark:/shares/Users/foo# ls -l .git/objects/0b
>   total 64
>   -rwxrw-r-- 1 deg share 74 May  5 01:15 
> 89efdeef245ed6a0a7eacc5c578629a141f856
>
> In any event, the symptoms don't seem to be a permissions problem, so all this extra info is probably just a red herring, I hope.

Hrm.  What about what Jeff already asked of the OP (and AFAICS never got a reply)?

} If it's a race condition between the write and the subsequent read in } the same process, then it would be solved by looking at the object } later. Does "git cat-file -p 6838761d549cf76033d2e9faf5954e62839eb25d"
} work, or is the object forever inaccessible?

In your case: git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856

--
Thomas Rast
trast@{inf,student}.ethz.ch
