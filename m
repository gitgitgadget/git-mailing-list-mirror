From: Junio C Hamano <junkio@cox.net>
Subject: Re: Prepare "git-merge-tree" for future work
Date: Fri, 30 Jun 2006 13:52:27 -0700
Message-ID: <7vbqsagyd0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606281054470.3782@g5.osdl.org>
	<Pine.LNX.4.64.0606281401540.12404@g5.osdl.org>
	<7vejx7mmaj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606291925230.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 22:52:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwPyc-0001i3-MV
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 22:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWF3Uwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 16:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWF3Uwa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 16:52:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64236 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932294AbWF3Uw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 16:52:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630205228.VWYP554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 16:52:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606291925230.12404@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 29 Jun 2006 19:32:22 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23018>

Linus Torvalds <torvalds@osdl.org> writes:

> In contrast, the ones to diff_filespec I've never really used, and I did 
> not want to compare blob objects, I very much wanted to compare in-memory 
> buffers (_and_ potentially blobs).
>
> So if you can show an easy example of how to populate a set of filespec 
> pairs (not with blobs - with in-memory generated data) and insert them 
> onto the lists, that would be good.

Ah, I see.  Your origin() function always returns a in-core
buffer from an existing blob (or NULL if it is a new file) but
result() returns either an existing blob resulting from the
tree-level merge, or a 3-way content merge result that does not
have an existing blob, and it is not obvious how to express the
latter as a filespec (all other cases you can stuff the blob
object name in the sha1[] member and if you choose to do the
read_sha1_file() yourself store the result in data member or you
can let diff_populate_filespec() read the data when diff
machinery needs it).

I think a filespec that has 0{40} sha1, with data already
populated and should_free/should_munmap members both set to
false might work for the in-memory data but I haven't tried.

I'd take the hint, and I will (eventually) take a look at it
if nobody beats me to it, but most likely not now, sorry.
