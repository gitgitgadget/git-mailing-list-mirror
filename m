From: Steven Grimm <koreth@midwinter.com>
Subject: Re: blame follows renames, but log doesn't
Date: Tue, 19 Jun 2007 02:54:55 -0700
Message-ID: <4677A7EF.500@midwinter.com>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com> <20070619071916.GC9177@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0aQO-0004xI-R3
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 11:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbXFSJy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbXFSJy7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 05:54:59 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:50894
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752764AbXFSJy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 05:54:58 -0400
Received: (qmail 2127 invoked from network); 19 Jun 2007 09:54:58 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=dMLzSDaqIlGs0wG/cyVAMABqjY/m2OJ00XWbfTRxHe3DrfXR+v9Nt2VRUbUx5ANb  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 19 Jun 2007 09:54:58 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <20070619071916.GC9177@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50465>

Theodore Tso wrote:
> Actually, the bigger missing gap is merges.  Suppose in the
> development branch, you rename a whole bunch of files.  (For example,
> foo_super.c got moved to foo/super.c, foo_inode.c got moved to
> foo/inode.c, etc.)
>
> Now suppose there are fixes made in the stable branch, in the original
> foo_super.c and foo_inode.c files.  Ideally you would want to be able
> to pull those changes into the development branch, where the files
> have new names, and have the changes be applied to foo/super.c and
> foo/inode.c in the development branch.
>   

I believe git handles this case already, actually. I've seen this work 
just fine many times.

What git doesn't handle, but BitKeeper does, is applying directory 
renames to newly created files. I rename the "lib" directory to "util", 
you create a new file lib/strings.c and update lib/Makefile to compile 
it. I pull from you. Under BitKeeper, I will get util/strings.c and the 
change will be applied to my util/Makefile. git will create a brand-new 
"lib" directory containing nothing but the new file, but since the 
Makefile existed before, it will (correctly) apply your change to my 
util/Makefile, which will then break my build because it will refer to a 
file that doesn't exist in the Makefile's directory.

This has bitten me a few times in real life, e.g. in cases where I'm 
importing a third-party source tarfile and reorganizing it a little to 
fit it into my local build system. Every time they add a new source 
file, I have to go manually clean up after it rather than just merging 
the vendor branch into mine like I can do when they don't add anything. 
It is not frequent enough to be a major hassle for me but it sure is 
annoying when it happens (especially since sometimes the build *doesn't* 
break and it takes a while to notice a newly created file isn't where it 
should be.)

-Steve
