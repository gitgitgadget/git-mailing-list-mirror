From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score for rename detection
Date: Thu, 28 Jun 2007 23:34:47 -0700
Message-ID: <7vwsxngtfc.fsf@assigned-by-dhcp.pobox.com>
References: <7vtzssog5i.fsf@assigned-by-dhcp.pobox.com>
	<20070628060416.GA13162@midwinter.com>
	<20070628061821.GM32223@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 08:34:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4A4B-0004Bg-2W
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbXF2Get (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbXF2Get
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:34:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34477 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbXF2Ges (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:34:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629063448.CLLL1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 02:34:48 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HJan1X0061kojtg0000000; Fri, 29 Jun 2007 02:34:47 -0400
In-Reply-To: <20070628061821.GM32223@spearce.org> (Shawn O. Pearce's message
	of "Thu, 28 Jun 2007 02:18:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51151>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Actually even better if you can also run the in/out filter things.
> I'm thinking of say an XML file that has had whitespace formatting
> changes, but whose XSD and processors ignore unnecessary whitespace.
> Be nice if the rename detection actually was able to canonicalize
> both files before detecting the rename, assuming both files had a
> canonicalizer input filter defined that does that...

This certainly is tempting, but I suspect that should be left to
later rounds.  I suspect that it would introduce a concept of
two different kinds of diffs, one to be mechanically processed
(i.e. use in merge with "git-merge-recursive", and apply with
"git-am"), and another to be inspected by humans to understand.
It often may be useful to munge the input for the latter case,
even though the output from comparing munged input files may not
be readily usable for mechanical application.

Which is not a bad thing per-se, but needs to be done carefully.

A replacement set for Steven to comment on follows.

  [PATCH 1/4] diffcore_count_changes: pass diffcore_filespec
  [PATCH 2/4] diffcore_filespec: add is_binary
  [PATCH 3/4] diffcore-delta.c: update the comment on the algorithm.
  [PATCH 4/4] diffcore-delta.c: Ignore CR in CRLF for text files
