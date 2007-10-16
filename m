From: "franky" <yinping@kooxoo.com>
Subject: RE: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 17:56:21 +0800
Message-ID: <20071016095622.CE14F7E6F@mail.kooxoo.com>
References: <8c5c35580710160142x1f699208gfc226072a27e997a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Lars Hjemli'" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjAC-0002Nz-16
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819AbXJPJ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbXJPJ40
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:56:26 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:57900 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbXJPJ4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:56:25 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id CE14F7E6F;
	Tue, 16 Oct 2007 17:56:22 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <8c5c35580710160142x1f699208gfc226072a27e997a@mail.gmail.com>
Thread-Index: AcgP0InTyXK2OVVCQJ2KZ6E+mn0hSQAA6JiA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61132>

> Well, there is always
> 
> $ git archive --remote=<repo> <revspec> <path> | tar -x
> 
> This is effectively a partial checkout of an arbitrary revision from a
> remote repo.
> 
> --
That's actually "a single command", but a little complex. And there still
are some problems with this single command

1. each time is full checkout (not incremental), so bad performance for
large bin directory
2. I can't know deployment version easily and I can't use "git-log" to see
the log and to decide which version to back to when necessary.

I just find an ugly resolution:
1. git-clone host:project.git project
Cloned project is as follows (src, bin are subdir instead of submodule)
project
    src
    bin
    .git

2. cd project && rm -rf src
3. when project.git changed, then
   git-fetch && git-checkout origin/master bin

Unfortulately, it's annoying when I run git-status which complains "deleted:
src ". And "git-log" will not show the newest log since git-checkout doesn't
update the index file

So, the alternative for the 3rd step is
	git-pull && rm src

It's so ugly!

Suggestion 1: how about adding a paths option for git-status just like
git-diff and git-log
Suggestion 2: how about changes the default paths for "git-diff", "git-log"
and so on from the "top dir with .git" to "the current dir"? So when I'm in
bin directory and run "git-log", it will only report log or diff in bin
directory.
franky
