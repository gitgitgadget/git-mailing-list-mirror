From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Teach cat-file a --quiet option
Date: Sun, 22 Apr 2007 02:20:01 -0700
Message-ID: <7vd51wpxz2.fsf@assigned-by-dhcp.cox.net>
References: <20070422011447.GC2910@spearce.org>
	<7virboq1tx.fsf@assigned-by-dhcp.cox.net>
	<20070422081106.GI17480@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 11:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfYEr-0001N8-Rl
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 11:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589AbXDVJUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965626AbXDVJUF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 05:20:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63165 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965589AbXDVJUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 05:20:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422092002.IMXG1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 05:20:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q9L11W00K1kojtg0000000; Sun, 22 Apr 2007 05:20:01 -0400
In-Reply-To: <20070422081106.GI17480@spearce.org> (Shawn O. Pearce's message
	of "Sun, 22 Apr 2007 04:11:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45228>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> What's also annoying is cat-file today prints an error with -e if
> you use the "branch:path" syntax, but not if you supply the 40 byte
> hex SHA-1 of the blob in question.

I _think_ the intent of -e or any other "silently check" option
is to signal "status" with exit code, while still indicating an
error with the message.

For the particular example of "cat-file -e", whose purpose is to
accept an object name string and report if such an object exists
in the repository:

	$ git cat-file -e 45354a57ee7e3e42c7137db6c94fa968c6babe8d; echo $?
        0
	$ git cat-file -e 45354a57ee7e3e42c7137db6c94fa968c6babe8e; echo $?
        1
	$ git cat-file -e HEAD:NO-SUCH-PATH
	fatal: Not a valid object name HEAD:NO-SUCH-PATH

The input of the above two _look_ like valid object names and
they return Ok/Bad because the user is asking "is there such an
object?".

Technically speaking, with the last case, the user did not give
a correctly formatted object name (treeish colon needs to be
followed by a path that exists in the treeish to be considered a
valid object name), so it can be argued that complaining is the
right thing to do, but that is too literal to the law and I
would agree that it probably is on the wrong side of the
borderline.
