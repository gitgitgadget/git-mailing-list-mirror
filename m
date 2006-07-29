From: linux@horizon.com
Subject: Re: git prune pig slow
Date: 29 Jul 2006 18:41:06 -0400
Message-ID: <20060729224106.12312.qmail@science.horizon.com>
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Jul 30 00:41:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6xUf-0004F8-6E
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 00:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWG2WlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWG2WlJ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 18:41:09 -0400
Received: from science.horizon.com ([192.35.100.1]:31791 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750735AbWG2WlI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 18:41:08 -0400
Received: (qmail 12313 invoked by uid 1000); 29 Jul 2006 18:41:06 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24439>

> Btw, another alternative to "git prune" is actually to do
>
>	git repack -a -d
>
> and then just delete all unpacked objects.

No, that's dangerous too.  The index file is considered part of the root
set for git-fsck-objects, but not for git-repack.

Example script:

$ git-init-db
$ cat > hello.c
#include <stdio.h>

int
main(void)
{
        puts("Hello, world!");
        return 0;
}
$ git-update-index --add hello.c
$ git-repack -a -d
Generating pack...
Done counting 0 objects.
Nothing new to pack.
$ rm .git/objects/67/159ba959e0a0cd6157bf04d5dad66af59383c2
rm: remove write-protected regular file `.git/objects/67/159ba959e0a0cd6157bf04d5dad66af59383c2'? y
$ git commit
error: invalid object 67159ba959e0a0cd6157bf04d5dad66af59383c2
fatal: git-write-tree: error building trees
