From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 23:37:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702122332180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 23:38:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGjoo-0007eO-9z
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 23:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965438AbXBLWiD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 17:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965440AbXBLWiC
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 17:38:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:33616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965439AbXBLWiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 17:38:00 -0500
Received: (qmail invoked by alias); 12 Feb 2007 22:37:59 -0000
X-Provags-ID: V01U2FsdGVkX1/qd859ElrqTyeA9zbMs6ctHXranT3t7kqAokYIvX
	P1QQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39446>

Hi,

[I agree on the .gitignore approach; see my other mail in this thread]

On Mon, 12 Feb 2007, Linus Torvalds wrote:

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
> 
>  (c) Profit!

Not so fast.

In order for this to be _useful_, you also have to have a way to _extract_ 
the text blobs. Not only for read-tree, but _also_ for diff. It makes no 
sense at all to have this transformation one-way. For diff, you _might_ 
want to have a diff beautifier (for example the .odt thing), but read-tree 
is _really_ important.

Ciao,
Dscho
