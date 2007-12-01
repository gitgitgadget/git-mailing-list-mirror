From: Al Boldi <a1426z@gawab.com>
Subject: Re: git guidance
Date: Sat, 1 Dec 2007 09:50:15 +0300
Message-ID: <200712010950.15628.a1426z@gawab.com>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <alpine.LFD.0.9999.0711290810170.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyMCn-00014w-Nl
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXLAGvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbXLAGvj
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:51:39 -0500
Received: from [212.12.190.32] ([212.12.190.32]:45563 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750838AbXLAGvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:51:38 -0500
Received: from localhost ([10.0.0.111])
	by raad.intranet (8.8.7/8.8.7) with ESMTP id JAA12174;
	Sat, 1 Dec 2007 09:49:49 +0300
User-Agent: KMail/1.5
In-Reply-To: <alpine.LFD.0.9999.0711290810170.8458@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66705>

Jing Xue wrote:
> Quoting Al Boldi <a1426z@gawab.com>:
> > Sure, browsing is the easy part, but Version Control starts when things
> > become writable.
>
> But how is that supposed to work?  What happens when you make some
> changes to a file and save it?  Do you want the "git file system" to
> commit it right aways or wait until you to issue a "commit" command?
> The first behavior would obviously be wrong, and the second would make
> the "file system" not operationally transparent anyways. Right?

Not sure what you mean by operationally transparent?  It would be transparent 
for the updating client,  and the rest of the git-users would need to wait 
for the commit from the updating client; which is ok, as this transparency 
is not meant to change the server-side git-update semantic.

Linus Torvalds wrote:
> On Thu, 29 Nov 2007, Jing Xue wrote:
> > By the way, the only SCM I have worked with that tries to mount its
> > repository (or a view on top of it) as a file system is ClearCase with
> > its dynamic views. And, between the buggy file system implementation,
> > the intrusion on workflow, and the lack of scalability, at least in
> > the organization I worked for, it turned out to be a horrible,
> > horrible, horrible idea.

Judging an idea, based on a flawed implementation, doesn't prove that the 
idea itself is flawed.

And...
> Doing a read-only mount setup tends to be pretty easy, but it's largely
> pointless except for specialty uses. Ie it's obviously not useful for
> actual *development*, but it can be useful for some other cases.
>
> For example, a read-only revctrl filesystem can be a _very_ useful thing
> for test-farms, where you may have hundreds of clients that run tests on
> possibly different versions at the same time. In situations like that, the
> read-only mount can actually often be done as a user-space NFS server on
> some machine.
>
> The advantage is that you don't need to export close to infinite amounts
> of versions from a "real" filesystem, or make the clients have their own
> copies. And if you do it as a user-space NFS server (or samba, for that
> matter), it's even portable, unlike many other approaches. The read-only
> part also makes 99% of all the complexity go away, and it turns out to be
> a fairly easy exercise to do.
>
> So I don't think the filesystem approach is _wrong_ per se. But yes, doing
> it read-write is almost invariably a big mistake. On operatign systems
> that support a "union mount" approach, it's likely much better to have a
> read-only revctl thing, and then over-mount a regular filesystem on top of
> it.

You could probably do that, or you could instead use cp -al.  Both would 
require some hacks to allow some basic version control.

> Trying to make it read-write from the revctl engine standpoint is almost
> certainly totally insane.

Sure, you wouldn't want to change the git-engine update semantics, as that 
sits on the server and handles all users.  But what the git model is 
currently missing is a client manager.  Right now, this is being worked 
around by replicating the git tree on the client, which still doesn't 
provide the required transparency.

IOW, git currently only implements the server-side use-case, but fails to 
deliver on the client-side.  By introducing a git-client manager that 
handles the transparency needs of a single user, it should be possible to 
clearly isolate update semantics for both the client and the server, each 
handling their specific use-case.


Thanks!

--
Al
