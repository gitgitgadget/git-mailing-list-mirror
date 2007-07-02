From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 22:23:00 +0200
Message-ID: <46895EA4.5040803@jaeger.mine.nu>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 22:23:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5SQO-0001b3-2b
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 22:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbXGBUXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 16:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbXGBUXF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 16:23:05 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:38245 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752758AbXGBUXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 16:23:04 -0400
Received: (qmail 4056 invoked from network); 2 Jul 2007 20:23:01 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 2 Jul 2007 20:23:01 -0000
Received: (qmail 18503 invoked from network); 2 Jul 2007 20:23:01 -0000
Received: from unknown (HELO ?10.0.21.1?) (10.0.21.1)
  by elvis-jaeger.mine.nu with SMTP; 2 Jul 2007 20:23:01 -0000
User-Agent: Icedove 1.5.0.12 (X11/20070607)
In-Reply-To: <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51400>

Yann Dirson wrote:
> On Mon, Jul 02, 2007 at 08:09:37PM +0200, Christian Jaeger wrote:
>   
>> Why so complicated? Why not just make git-rm without options behave like
>> cg-rm? (Or at the very least, I'd change the hint to say "try -f --cached".)
>>     
>
> It is probably a matter of taste.  Personally, I am really upset by
> this behaviour that cvs, cogito, stgit and others share, which forces
> me to issue 2 commands to really delete a file from version control
> and from the filesystem.
>   

It doesn't force you to issue 2 commands: the -f option to cg-rm unlinks
the file for you. So you only have to type an additional "-f".

Yes it's probably (partly) a matter of taste: in my bash startup files I
have mv aliased to mv -i and rm to rm -i, so that it asks me whether I'm
sure to delete or overwrite a file. If I know in advance that I'm sure,
I just type "rm -f $file", which then expands to "rm -i -f $file" where
the -f overrides the -i. cg-rm -f just fits very well into this scheme
(the only difference being that "cg-rm $file" doesn't explicitely ask me
whether I also want the file to be unlinked). (BTW note that usually for
removing a file I use a "trash" (or shorter alias "tra") command, which
moves it to a trash can instead of deleting; so I use "tra $file" by
default, and only for big files or when I'm sure I immediately want to
delete them, I use rm, and then if the paths are clear I add the -f
flag, if not (like globbing involved), I don't add the -f and thus am
asked for confirmation.)

If I could alias the git-rm command so that the default action is the
reverse of git-add and adding an -f flag removes it from disk, that
would be fine for me.

> Do you really need to undo an add more often than you need to remove a
> file from version-control ?  It may be worth, however, to make things
> easier.  Maybe "git add --undo foo" would be a solution ?

This doesn't sound very intuitive to me (and I couldn't fix it with an
alias).

I don't per se require undo actions. I just don't understand why git-rm
refuses to remove the file from the index, even if I didn't commit it.
The index is just an intermediate record of the changes in my
understandings, and the rm action would also be intermediate until it's
being committed. And a non-committed action being deleted shouldn't need
a special confirmation from me, especially not one which is consisting
of a combination of two flags (of which one is a destructive one).

Christian.
