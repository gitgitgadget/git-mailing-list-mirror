From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Thu, 6 Oct 2005 07:59:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510060756060.31407@g5.osdl.org>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org> <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510050725510.31407@g5.osdl.org> <7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
 <m1mzln9zi1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
 <m1y8575i9y.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
 <m1wtkqk89a.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 17:03:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENXDl-0003KF-R8
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 16:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVJFO7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVJFO7m
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 10:59:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751060AbVJFO7m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 10:59:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j96Exb4s019091
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Oct 2005 07:59:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j96Exa4n004212;
	Thu, 6 Oct 2005 07:59:37 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1wtkqk89a.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9773>



On Thu, 6 Oct 2005, Eric W. Biederman wrote:
> 
> After thinking about it I don't think you need to look through the
> history to use it for a merge3 operation.   As I recall merge3 only
> looks at the base and the two derived versions of the file.  If we
> have the sha1 of the original in the git repository I think all we
> need to compute is the diff between that sha1 the current version
> file.  And then apply the merge3 algorithm to combine the two sets of
> changes.

Ahh, that I can definitely agree with. In fact, it makes perfect sense.

However, it assumes that everybody is a git user, which isn't actually 
true. Also, I'm wondering whether the advantages outweigh the 
disadvantages: it would make the diff uglier. We'd have to add that SHA1 
there somewhere (either on the "diff" line itself, or as anothe rextended 
git line like the "rename from/to" lines - a "original <sha1>" line).

		Linus
