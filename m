From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] git-svn: Reduce temp file usage when dealing with non-links
Date: Mon, 11 Aug 2008 20:37:00 -0700
Message-ID: <20080812033700.GC14051@untitled>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <1218470035-13864-3-git-send-email-marcus@griep.us> <1218470035-13864-4-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Tue Aug 12 05:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSkhy-0003CU-Hv
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 05:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbYHLDhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 23:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYHLDhD
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 23:37:03 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33168 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbYHLDhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 23:37:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 10A932DC01B;
	Mon, 11 Aug 2008 20:37:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218470035-13864-4-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92065>

Marcus Griep <marcus@griep.us> wrote:
> Currently, in sub 'close_file', git-svn creates a temporary file and
> copies the contents of the blob to be written into it. This is useful
> for symlinks because svn stores symlinks in the form:
> 
> link $FILE_PATH
> 
> Git creates a blob only out of '$FILE_PATH' and uses file mode to
> indicate that the blob should be interpreted as a symlink.
> 
> As git-hash-object is invoked with --stdin-paths, a duplicate of the
> link from svn must be created that leaves off the first five bytes,
> i.e. 'link '. However, this is wholly unnecessary for normal blobs,
> though, as we already have a temp file with their contents. Copying
> the entire file gains nothing, and effectively requires a file to be
> written twice before making it into the object db.
> 
> This patch corrects that issue, holding onto the substr-like
> duplication for symlinks, but skipping it altogether for normal blobs
> by reusing the existing temp file.

Sweet optimization!  Thanks!


One thing, again, can you please make sure things don't exceed
80-columns when using 8 character-wide tabs?

I'm not sure how much it matters to the guys maintaining Git.pm, but
that's the standard for here and the Linux kernel (although it
unfortunately seems to have gotten more lax in recent years...).

Larger monitors can't help me because I use big fonts that would require
me to move my neck or eyes to see across the screen, leading to more eye
and neck strain (I have a bad neck).  I very much wish ANSI had
standardized on something even smaller, perhaps 64-char wide terminals
:)

-- 
Eric Wong
