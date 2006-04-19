From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 21:02:11 -0700
Message-ID: <7v8xq2ciws.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
	<7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
	<7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604181836400.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 06:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW3tR-0007jC-Ke
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 06:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDSECP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 00:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDSECP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 00:02:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45754 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750756AbWDSECO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 00:02:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419040213.QRGO20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 00:02:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604181836400.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 18:43:00 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18904>

Linus Torvalds <torvalds@osdl.org> writes:

> Actually, it's not ambiguous. Just take the named file. If you want to 
> diff it against HEAD:<named-file>, you should just say so.
>
> Now, if you _really_ want to be difficult, there's a third option: to diff 
> it against the named file as named in the index. "git diff" does have the 
> "--cached" option that would make that case unambiguous too, of course.
>
> Ie:
>
>  (a) diff against the current HEAD:
>
> 	git diff v0.99.6:git-commit-script HEAD:git-commit.sh
>
>  (b) diff against the current index contents for "git-commit.sh":
>
> 	git diff --cached v0.99.6:git-commit-script git-commit.sh
>
>  (c) diff against a random file (which may not even be in the index):
>
> 	git diff v0.99.6:git-commit-script git-commit.sh
>
> are all sensible operations, and unambiguous.

A small fry in the ointment.  What should the parts that are
output with --name-only say for such a diff?

Blob references like v0.99.6:git-commit-script are resolved by
the extended SHA1 interpreter, and all what the caller of
setup_revisions() can see and feed the diff machinery with has
are their object names.  Something like this is a possibility,
but is ugly.

        diff --git a/a2455b0... b/01c73bd...
        index a2455b0..01c73bd 100644
        --- a/a2455b0...
        +++ b/01c73bd...
        @@ -1,118 +1,509 @@
         #!/bin/sh
         #
         # Copyright (c) 2005 Linus Torvalds
        +# Copyright (c) 2006 Junio C Hamano
        +
        +USAGE='[-a] [-s] [-v] [--no-verify] [-m <message>...
        +SUBDIRECTORY_OK=Yes
        ...
