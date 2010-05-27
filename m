From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Checking out on a different+partial directory
Date: Thu, 27 May 2010 01:10:12 -0400
Message-ID: <m3d3wikk0b.fsf@winooski.ccs.neu.edu>
References: <19441.8259.634019.348195@winooski.ccs.neu.edu>
	<20100522054852.GB29118@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 07:10:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHVMU-0006nA-VV
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 07:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435Ab0E0FKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 01:10:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:58842 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367Ab0E0FKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 01:10:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OHVMK-0006k3-C6
	for git@vger.kernel.org; Thu, 27 May 2010 07:10:20 +0200
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:10:20 +0200
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:10:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:A4TgG1kflHm6s6JqBXywd0KZe7E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147828>

Jeff King <peff@peff.net> writes:

> On Mon, May 17, 2010 at 06:53:55AM -0400, Eli Barzilay wrote:
>
>> Say that I have a repository at /some/dir, and a tree that contains
>> most of its files at /another/dir (the second is a build directory,
>> made with `git archive', so some files removed due to export-ignore
>> attributes and some built files are present).
>> 
>> Is there a convenient way to make /some/dir usable as a repository?
>
> Did you mean /another/dir? /some/dir is already a repository as per your
> description above

Yes, sorry for the confusion...


> (is it a bare repository or a regular one?).

It's a regular one.


>> Two things that I tried are
>> 
>>   git --work-tree=/another/dir reset --hard master
>> 
>> which one time, but then failed with "fatal: unable to read tree...",
>> and another is
>
> I would have thought that worked, assuming you were in /some/dir. And
> oddly, _some_ stuff works. I tried:
>
> [...]
>
> So there is clearly a bug. I'll investigate.

Thanks!


>>   cp -a /some/dir/.git /another/dir
>>   cd /another/dir
>>   git reset --hard master
>> 
>> which looks like it can suffer from the same problem.
>
> That should work, too.

Heh, I just assumed that I'm doing something similarly wrong in both
cases...  In any case, I finally settled on doing things the other
way: grab all of the files that were created by the built tree and add
them to the repository directory (that is -- get stuff from
/another/dir into /some/dir).  It's a little less convenient for me,
so I'll probably switch back to the above, given that it should work.


>> (It would be especially nice if there's a way to have only
>> different files touched in /another/dir.)
>
> Only different files will be rewritten, but git will have to read all of
> the files to determine their sha1 (usually it avoids this by checking
> stat info, but obviously your exported files will not match the stat
> info in the /another/dir's index).

Yes, I expected this cost...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
