From: Pavel Roskin <proski@gnu.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 01:08:32 -0400
Message-ID: <1174367312.3143.75.camel@dv>
References: <1174361424.3143.42.camel@dv>
	 <Pine.LNX.4.64.0703192148430.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:08:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWaN-00054q-D7
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934005AbXCTFIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934006AbXCTFIg
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:08:36 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:36292 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934005AbXCTFIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:08:35 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HTWYN-0000Rk-Mv
	for git@vger.kernel.org; Tue, 20 Mar 2007 01:06:35 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HTWaG-0000JK-GX; Tue, 20 Mar 2007 01:08:32 -0400
In-Reply-To: <Pine.LNX.4.64.0703192148430.6730@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.0 (2.10.0-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42709>

On Mon, 2007-03-19 at 21:54 -0700, Linus Torvalds wrote:
> 
> On Mon, 19 Mar 2007, Pavel Roskin wrote:
> > 
> > I don't know where this problem appeared, but it present in the current
> > git (1.5.1-rc1).  Empty files become invalid objects in the repository:
> 
> Hmm.. Not for me. Can you bisect when it started happening?

I was doing exactly that, and here's the result:

7efbff7531af4281487d54c1dc1401308d988e33 is first bad commit
commit 7efbff7531af4281487d54c1dc1401308d988e33
Author: Junio C Hamano <junkio@cox.net>
Date:   Mon Mar 5 00:21:37 2007 -0800

    unpack_sha1_file(): detect corrupt loose object files.
    
    We did not detect broken loose object files, either when
    underlying inflate() signalled the breakage, nor inflate()
    finished and we had garbage trailing at the end.  We do better
    now.
    
    We also make unpack_sha1_file() a static function to
    sha1_file.c, since it is not used by anybody outside.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

:100644 100644 c291163e6d2096181ddf89954d2d65953d1ba687 4b5a7541a86c488f623793fdc498d0e149c40439
 M      cache.h
:100644 100644 6d0a72ed093d353a672129f7e460d0c1015212d7 ac6b5e00b6dec913a39cc54e84829dc3fc6c782f
 M      sha1_file.c


.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 is the same 9
bytes:  30 78 9c 03 00 00 00 00 01

But it's considered corrupt by the current git.

> I wonder if this is a zlib issue. Although I seem to have libz-1.2.3 on 
> both machines, and that should be the most recent version. I don't see 
> Fedora development having anything else..

That's also 1.2.3.  I can reproduce the issue on another machine running
Fedora Core 6 i386 with all updates, also with zlib 1.2.3.

-- 
Regards,
Pavel Roskin
