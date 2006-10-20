From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 10:59:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201049250.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45390168.6020502@utoronto.ca>
	<Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
	<200610201945.43957.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 19:59:42 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GayeX-00084P-Po
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 19:59:29 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GayeS-0003Sh-TE; Fri, 20 Oct 2006 18:59:24 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GayeI-0003Sb-En
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 18:59:18 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KHxAaX028332
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 10:59:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KHx9sX028046;
	Fri, 20 Oct 2006 10:59:10 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610201945.43957.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.973 required=5 tests=AWL,
	OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29513>



On Fri, 20 Oct 2006, Jakub Narebski wrote:
> 
> If I remember correctly, git decided on contents (plus filename)
> similarity based renames detection because 1), it is more generic
> as it covers (or can cover) contents moving not only wholesome rename
> of a file, and 2) because file-id based renames handling works only
> if you explicitely use SCM command to rename file, which is not the
> case of non-SCM-aware channel like for example patches (and accepting
> ordinary patches is important for Linux kernel, the project git was
> created for).

There are lots of problems with file ID's. One of the more obvious ones is 
indeed that if you arrive at the same state two different ways (eg patches 
vs "native SCM"), you end up with two fundmanetally different trees. Even 
though clearly there was no real difference.

There are other serious problems. For example, file-ID based systems 
invariably have _huge_ problems with handling two branches deleting and 
renaming things differently, and we had several issues with that during 
the BK days (ie two people would move files differently, and ending up 
with different file ID's for the same path, and merging that inevitably 
causes problems not just during the merge, but ever after, since one of 
the file ID's will then have to be "deleted" even though it might be 
active in one of the branches).

Finally, file-ID based systems fundamentally cannot handle some simple and 
interesting cases, like partial content movement. We're starting to see 
git actually being able to track file content moving between files: even 
when the files themselves didn't move (ie Junio's "git pickaxe" work could 
do things like that).

And there really aren't as many advantages to tracking renames as people 
claim. The biggest advantage of tracking renames is to avoid the trap that 
CVS fell into: being file-ID based _and_ not being able to track the file 
ID moving is clearly the worst of all worlds.

So for anybody coming from a CVS background, tracking renames explicitly 
is a _huge_ advantage, which is, I think, why some SCM people have gotten 
so hung up about them. It's just that if you don't have the file-ID 
problem in the first place (and git doesn't), then rename tracking doesn't 
actually make any sense, and only makes things much worse.

			Linus
