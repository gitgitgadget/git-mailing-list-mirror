From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 3 Feb 2007 16:31:27 -0500
Message-ID: <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com> <20070203181329.GA10192@179.242.249.10.in-addr.arpa> <7v4pq358q4.fsf@assigned-by-dhcp.cox.net> <F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com> <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSTt-000508-24
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbXBCVbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbXBCVbb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:31:31 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:33834 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXBCVbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:31:31 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 558641FFC02B;
	Sat,  3 Feb 2007 21:31:29 +0000 (UTC)
In-Reply-To: <7vabzv3qxi.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38607>


On Feb 3, 2007, at 3:51 PM, Junio C Hamano wrote:

> A filesystem that reports success on creat(path) and then does
> not return that path to later readdir() from that directory is
> broken from git's point of view.  At least that has been the
> definition so far.

I agree, it's fairly idiotic and obtuse.  By using the great Google,  
I've seen lots of other people complaining about it as well.

> I am not sure offhand the implications of the change you propose
> to make to match_one(), but it could also be the place to handle
> case-challenged filesystems.

I would simply like match_one to agree with the file system as to  
what is a match.  On OS X that would mean that both normalized forms  
of UTF-8 match.  I'm trying it as a proof-of-concept mostly to see  
what kind of effects it would have.  match_one only seems to be used  
in match_pathspec, which is only used by add and rm...  And I think  
that getting it to match the behavior of the OS would make things  
less surprising for the user.

> But even if you do that, I wonder what your plan would be to
> handle something like "git add .".  read_directory_recursive()
> asks readdir() for existing pathnames, and we expect that can be
> used as parameter to add_file_to_index and then eventually we
> can call creat() or symlink() with it, so it also needs to be
> taught to behave consistently with respect to what your updated
> match_one() does.

"git add ." works just fine, as it reads the name of the file from  
disk which is already in the form HFS+ accepts.  The only confusion  
exists when comparing data from the user to data from disk.

In any case, I don't appear to understand the proper incantations to  
bend ICU to my will, as it either doesn't change anything or breaks  
git completely.  Perhaps further attempts will help, but my lack of  
experience with the API is a serious hinderance, and I can't find any  
other way to do the normalization.

~~ Brian
