From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 14:54:06 -0800
Message-ID: <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
	<Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 23:54:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGk4S-0007yA-RF
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 23:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbXBLWyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbXBLWyM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 17:54:12 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38710 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030439AbXBLWyK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 17:54:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212225410.BJTJ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 17:54:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nmu81W00M1kojtg0000000; Mon, 12 Feb 2007 17:54:09 -0500
In-Reply-To: <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 12 Feb 2007 09:20:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39447>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Btw, how would I implement this? If I really were energetic enough to 
> implement it, I would do:
>
>  (a) Add a flag to "git-ls-files" logic to add "type information" in 
>      front.
>
>      Not only do you want this *anyway* for other reasons, but for
>      binary/text, the thing you actually care most about is "git add", and 
>      it already basically just does "take this file pattern, feed it 
>      through git-ls-files, and add those files". So you'd get it basically 
>      for free.
>
>      It is also fairly easy to add at this stage, because you can simply 
>      look for all the places that work with "info/exclude" and 
>      ".gitignore", and you know that "Ahh, I need to teach these exact 
>      places to understand about attributes". So you'd add an 
>      "add_attributes_from_file()" function etc etc.
>
>      Quite straightforward. In fact, you might be able to use the 
>      gitignore parsing *as*is*, and just teach it about more flags that 
>      just "ignore": both in "struct dir_entry" and in "struct exclude".
>
>  (b) Teach the git-update-index logic about hashing text blobs.

I agree that we can assume editors can grok files with LF
end-of-line just fine and we would not need to do the reverse
conversion on checkout paths (e.g. "read-tree -u", "checkout-index").

Textual diff generation needs to learn the CRLF-to-LF conversion
in diff_populate_filespec(); this needs to be done even when the
caller wants size_only.

Oops.

Not so fast.  What's your plan for st_size?

>  (c) Profit!
>
> It really should be fairly straightforward. I'm sure it wouldn't be 
> *entirely* trivial, but I'm also fairly sure that somebody reasonably 
> competent could do it in a couple of days (with testing) if they were just 
> sufficiently motivated to get started.
>
> Anybody?

Not me.
