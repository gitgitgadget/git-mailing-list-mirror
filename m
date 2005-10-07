From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Show original and resulting blob object info in diff output.
Date: Thu, 06 Oct 2005 22:16:14 -0700
Message-ID: <7vpsqh29gh.fsf@assigned-by-dhcp.cox.net>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
	<m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
	<m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
	<m1wtkqk89a.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060756060.31407@g5.osdl.org>
	<7vachm5a4w.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510062139560.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 07:16:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENkan-00062t-AK
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 07:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVJGFQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 01:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJGFQV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 01:16:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33507 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932122AbVJGFQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 01:16:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007051610.TMUC16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 01:16:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9798>

Linus Torvalds <torvalds@osdl.org> writes:

> IOW, why not make it shorter ans prettier and just make it be
>
> 	index 7be50413538868412a87..83660822fcbb9edac523
>
> which is basically the first 20 hex digits of each SHA1.

Makes sense.

> If you want the "applies-to" etc,...

applies-to: is for the whole tree, and I think it can go if we
do this per-blob signature thing.

The first SHA1 after applies-to: is coming from diff-tree,
noting the commit object _after_ the change.  I could filter it
while running format-patch, because it is useless from patch
application point of view.

> .... In fact, I bet 20 bits would be plenty).

So the updated proposal would be:

    diff --git a/apply.c b/apply.c
    index 7be5041..8366082 100644
    --- a/apply.c
    +++ b/apply.c
    @@ -14,6 +14,7 @@
    ...
    diff --git a/foo.sh b/bar.sh
    old mode 100644
    new mode 100755
    index 7be5041..8366082
    similarity index 86%
    rename from foo.sh
    rename to bar.sh
    --- a/foo.sh
    +++ b/bar.sh
    @@ -14,6 +14,7 @@
    ...

where the "index" line shows abbreviated SHA1 for pre- and post-
image blob, with an optional mode bit string only if there is no
mode change; otherwise we would have old/new mode line anyway.
