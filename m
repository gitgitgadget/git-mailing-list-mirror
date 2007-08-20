From: Steven Grimm <koreth@midwinter.com>
Subject: Re: renaming question
Date: Mon, 20 Aug 2007 08:45:21 +0800
Message-ID: <46C8E421.8000408@midwinter.com>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm>	<87vebbo0f1.fsf@mid.deneb.enyo.de>	<03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>	<85sl6fqr9n.fsf@lola.goethe.zz>	<03bd01c7e295$976a2970$0600a8c0@ze4427wm>	<85odh3qp8j.fsf@lola.goethe.zz> <87mywn8dm0.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, angray@beeb.net
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 02:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMvOZ-0006eL-RM
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 02:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbXHTApZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 20:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbXHTApY
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 20:45:24 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:59707 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752246AbXHTApY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 20:45:24 -0400
Received: (qmail 20608 invoked from network); 20 Aug 2007 00:45:23 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=e5/ZMQ9945KKxMmIY+o4DqA83gyM+AOkepP0JURFHd7kN1ieKmT+AM3L8UVzx3eX  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 20 Aug 2007 00:45:23 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <87mywn8dm0.fsf@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56160>

Florian Weimer wrote:
> Or, for more control about what gets put into patch, git-diff -M.
> (As I wrote, most of the relevant commands accept an -M switch.)
>   

The key point, and where the original writer is probably confused, is 
that in git, renames are inferred from information in the repository. 
You do not ever need to explicitly tell git about a rename. There is a 
"git mv" command which is simply a convenience command; it is equivalent to

mv a b
git add b
git rm a

When you query history with the -M flag or do merges, git will notice 
that the contents of the new file "b" are very similar to the old file 
"a" and will treat it as a rename. (The contents don't have to match 
exactly; they just have to be substantially similar.)

This is not a perfect system -- there are known cases where it fails -- 
but it has major advantages too. For example, you can unpack a 
third-party tarfile into a git repository, commit it, then unpack the 
next version's tarfile and commit that. Since you are using tar, nothing 
will have told git about files that the upstream people renamed in 
between versions, but git will detect them after the fact just as if 
you'd done "git mv".

Not only that, git can detect movement of content *within* files. Try 
moving some code from one file to another and running "git blame -M -C 
-C" on the target file; you will see git tell you that the content 
originally came from the first file. Pretty sweet. (It's not the default 
since it makes "git blame" slower.)

-Steve
