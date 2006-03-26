From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 19:08:36 +0300
Message-ID: <20060326190836.dbe95a72.tihirvon@gmail.com>
References: <20060326014946.GB18185@pasky.or.cz>
	<7virq1sywj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 18:09:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNXo1-0005cd-H6
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 18:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWCZQId (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 11:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWCZQId
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 11:08:33 -0500
Received: from nproxy.gmail.com ([64.233.182.187]:34312 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751362AbWCZQIc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 11:08:32 -0500
Received: by nproxy.gmail.com with SMTP id o63so694650nfa
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 08:08:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ITQBVJvOqOwmBPbQ4q549soPKIB7wLf4k7cBXYDf9ihNIdT55XF2d2tdTltgipgXzO170LuLlvQQYcikjS1WQE615Uc2bQjiY4tSKBNlszcfYmkeMPFmgoUM0zhg9QJkdjTgvS8SALYEoEKwtwptADSXScYojpaIGDpV8vmsTiQ=
Received: by 10.49.6.13 with SMTP id j13mr1247714nfi;
        Sun, 26 Mar 2006 08:08:30 -0800 (PST)
Received: from garlic.home.net ( [82.128.203.117])
        by mx.gmail.com with ESMTP id q28sm21424nfc.2006.03.26.08.08.29;
        Sun, 26 Mar 2006 08:08:30 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18042>

On Sat, 25 Mar 2006 18:49:48 -0800
Junio C Hamano <junkio@cox.net> wrote:

> Looking at the evolution of rev-list.c file itself was a good
> exercise to realize that rename tracking (more specifically,
> having whatchanged to follow renames) is not such a useful
> thing (at least for me).

It would be useful for me.  I had all files organized in subdirectories,
but then noticed it was not good idea because make does not play nicely
with subdirs, so I moved all files to top level directory.

Now

    git-whatchanged -p file.c

stops at the big rename. To continue I have to do

    git-whatchanged -p -- <some-commit> <old-filename>

> Another example.  Today's tar-tree updates have one interesting
> function I think should belong to strbuf.c, and before merging
> it to the mainline, I may move that function from tar-tree.c to
> strbuf.c.  After that happens, if I run "whatchanged strbuf.c"
> to see where that function came from, I would want it to notice
> it came from tar-tree.c, although it is not a rename at all.
> Just one function moved from a file to another.

Yes in this case you can do

$ git-whatchanged strbuf.c
$ git-whatchanged tar-tree.c

but after rename...

$ git-whatchanged old-file.c
fatal: 'old-file.c': No such file or directory

$ touch old-file.c
$ git-whatchanged old-file.c

Hah, it worked!


Hmm... this works too without the touch-hack:

$ git-whatchanged file.c old-file.c

I wish I had known this before.

> What this suggests is that switching the set of paths to follow
> while traversing ancestry chain needs to depend on which part of
> the original file you are interested in.  Marking "this commit
> renames (or copies) file A to file B" is not that useful -- for
> that matter, detecting at runtime like we currently do is not
> better either.  If a file A and file B were cleaned up and
> merged into a single file C, which is in the tip of the tree,
> which one you would want whatchanged to switch following depends
> on which part of the C you were interested in.

OK, maybe following renames is not such a good idea.  But for GUIs
(gitk, qgit) following renames or even file merges (select a file to
follow by clicking it) would be big plus.

-- 
http://onion.dynserv.net/~timo/
