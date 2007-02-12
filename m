From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:02:46 -0800
Message-ID: <7vk5yn6ktl.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
	<Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
	<7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:02:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkCB-0003fY-AS
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbXBLXCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbXBLXCs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:02:48 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35925 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030445AbXBLXCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:02:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212230247.THJP21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 18:02:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nn2m1W00Q1kojtg0000000; Mon, 12 Feb 2007 18:02:47 -0500
In-Reply-To: <7vps8f6l81.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 12 Feb 2007 14:54:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39448>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Btw, how would I implement this? If I really were energetic enough to 
>> implement it, I would do:
>> ...
>>  (b) Teach the git-update-index logic about hashing text blobs.
>
> I agree that we can assume editors can grok files with LF
> end-of-line just fine and we would not need to do the reverse
> conversion on checkout paths (e.g. "read-tree -u", "checkout-index").
>
> Textual diff generation needs to learn the CRLF-to-LF conversion
> in diff_populate_filespec(); this needs to be done even when the
> caller wants size_only.
>
> Oops.
>
> Not so fast.  What's your plan for st_size?

If I were to do this, I would say the cache should store the
size on the filesystem in stat fields.  Which means that the
object name recorded is text blob _after_ line endings are
normalized to LF, and its exploded size does not necessarily
match the cached size.

So this means that whoever does the diff_populate_filespec()
change needs to be careful, but it is not such a big deal.
