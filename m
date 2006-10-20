From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 21:14:38 +0200
Message-ID: <200610202114.39223.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 21:14:53 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GazpT-0000Mi-2V
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 21:14:51 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GazpS-0000Iz-D5; Fri, 20 Oct 2006 20:14:50 +0100
Received: from ug-out-1314.google.com ([66.249.92.169])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GazpJ-0000Ig-1c
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 20:14:45 +0100
Received: by ug-out-1314.google.com with SMTP id p35so730464ugc
	for <bazaar-ng@lists.canonical.com>;
	Fri, 20 Oct 2006 12:14:40 -0700 (PDT)
Received: by 10.66.222.9 with SMTP id u9mr2496985ugg;
	Fri, 20 Oct 2006 12:14:39 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id o1sm507347uge.2006.10.20.12.14.38;
	Fri, 20 Oct 2006 12:14:39 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29526>

Jan Hudec wrote:

> Let's consider following scenario:
> 
> (where A$ means working in branch A, B$ means working in branch B and
>  VCT stands for version control tool of choice)
[...]
> At this point, I expect the tree to look like this:
> A$ ls -R
> .:
> data/
> data:
> hello.txt
> A$ cat data/hello.txt
> Hello World!
[...]
> Oh, and there is one more complicated case, that I also require to work
> and that works in Bzr, but did not work in Arch:
> 
> ...let's start with the tree at the end of previous example...
> 
> A$ VCT mv data greetings
> A$ VCT commit -m "Renamed the data directory to greetings"
> B$ echo "Goodbye World!" > data/goodbye.txt
> B$ VCT add data/goodbye.txt
> B$ VCT commit -m "Added goodbye message."
> A$ VCT merge B

(slightly corrected example).

A$ git branch B
A$ git mv data greetings
A$ git commit -a -m "Renamed the data directory to greetings"
A$ git checkout B
B$ echo 'Goodbye World!' > data/goodbye.txt
B$ git add data/goodbye.txt
B$ git commit -a -m "Added goodbye message."
B$ git checkout A
A$ git pull . B
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 4a8a1a7941f214c6173786b583830b4f74a67c1f
Merging: 
96738390ba0b4de5b234059081701badc1c86693 Renamed the data directory to greetings 
4a8a1a7941f214c6173786b583830b4f74a67c1f Added goodbye message. 
found 1 common ancestor(s): 
7cfd8edd06b7cb016856737d8fd98d5d096955b5 Merge branch 'B' into A 

Merge made by recursive.
 data/goodbye.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 data/goodbye.txt

> And now I expect to have tree looking like this:
> 
> A$ ls -R
> .:
> greetings/
> greetings:
> hello.txt
> goodbye.txt

So git _fails_ (your expectations) in this case:
A$ ls -R
.:
data  greetings

./data:
goodbye.txt

./greetings:
hello.txt
