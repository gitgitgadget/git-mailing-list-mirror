From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Strangely broken git repo
Date: Mon, 10 Oct 2005 07:54:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510100742070.14597@g5.osdl.org>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
 <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
 <4349ED5D.6020703@catalyst.net.nz> <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	Nick Hengeveld <nickh@reactrix.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 17:00:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOz47-0000lo-C5
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 16:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVJJOyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 10:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJJOyw
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 10:54:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750831AbVJJOyv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 10:54:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9AEsX4s017707
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 07:54:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9AEsVMS017542;
	Mon, 10 Oct 2005 07:54:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9890>



On Mon, 10 Oct 2005, Junio C Hamano wrote:
> 
> Hmph.  Interesting.  I just tried.
> 
> $ curl 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID**'
> 
> gives an error page "404 Not Found", while
> 
> $ wget -O - -o /dev/null 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID**'
> 
> works fine and gives 2ddfec0dfd0cffd4892af9aaf48ee29c40c7ada3
> back.  So we do need to fix things up somewhat in our scripts as
> well.

It seems to be the space. Doing

  $ curl 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED%20**INVALID**'

works ok (ie %20 instead of ' ').

As far as I can tell, we should probably _also_ quote any curl-specific 
stuff. As far as I can tell from the manual, if the tag were to have 
special characters like '[' and '{', curl might confuse them with being 
range specifiers.

		Linus
