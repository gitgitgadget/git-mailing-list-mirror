From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 23:20:59 +0200
Message-ID: <46896C3B.1050406@jaeger.mine.nu>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:21:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5TKb-00051L-8X
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbXGBVVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbXGBVVG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:21:06 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:41027 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755482AbXGBVVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 17:21:05 -0400
Received: (qmail 11137 invoked from network); 2 Jul 2007 21:21:03 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 2 Jul 2007 21:21:03 -0000
Received: (qmail 24040 invoked from network); 2 Jul 2007 21:20:59 -0000
Received: from unknown (HELO ?10.0.21.1?) (10.0.21.1)
  by elvis-jaeger.mine.nu with SMTP; 2 Jul 2007 21:20:59 -0000
User-Agent: Icedove 1.5.0.12 (X11/20070607)
In-Reply-To: <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51408>

Yann Dirson wrote:
> On Mon, Jul 02, 2007 at 10:23:00PM +0200, Christian Jaeger wrote:
>   
>> I don't per se require undo actions. I just don't understand why git-rm
>> refuses to remove the file from the index, even if I didn't commit it.
>>     
>
> I'd say it does so, so you won't loose any uncommitted changes without
> knowing it - and "git add -f" is available when you have checked that
> you indeed want to discard that data.
>   

I'm really realising that

git-rm $file # where $file *has* been committed previously

does remove *and* unlink the file. (cg-rm does unlink only with the -f
flag, as said.)

So there's no -f flag in normal git-rm usage. It thus has a different
meaning, namely "force the operation pair of removing from index and
unlinking", not "force this operation also onto the checked out files"
as is the case with cogito.

So I now understand better why they invented the -f flag to git-rm for
the case you're mentioning above and why the hint doesn't warn about
it's danger, since git-rm is always dangerous. (Ok, as is "rm" without
the "-i"; I just found it normal that cogito behaved like my "-i" setup.)

Regarding the issue of "lost files" because they have been created,
added, and removed again before committing: as far as I remember this
has never happened to me with cogito. I commit often, so if I add a file
or a few, in most cases I commit just this fact (that they have been
added), before doing more fancy stuff. I'm maybe used to thinking in
database terms, work that isn't committed is lost. So if I create a file
and add it, in my brain the "attention, uncommitted work" flag is on,
and it usually doesn't happen that I later erroneously think the work
has been committed when in fact it isn't. (I can always check with a
quick cg-status (which shows the files as "A", which makes them stand
out better than in the git-status output)).

Just before writing this mail I had a case where I wanted to remove a
file from versioning control, but keep it on disk (I used git-rm and
that's how I learned that it really also unlinks the local file without
asking(*)). Note that this has not been an undo action; the file has
been committed previously.

(* thanks to git-reset I could get it back of course)

>
> That is, "git rm" will only ever remove the file without asking, when
> it is safe do so, in that you can retrieve your file from history. 

(Well it's not safe if you want to remove the file *from the index* and
naively mis-use the -f flag as suggested by the hint.)

>  Or
> do you think of another way, in which more safety would be needed ?
>   

I think we have just two different points in our view where we think
safety matters.

Regarding the man pages: yes the git-rm man page is fine, and it's nice
to see the manuals are improving. As noted I came from cogito, and
didn't expect git to behave so different with the same named (but
different purpose) options, so I didn't read the man pages (I've been in
irc and asked there, where someone suggested to bring this to the list;
I'm too tired today to think further about it and will try to read more
docs and hope I'll get to understand the git philosophies more).

Christian.
