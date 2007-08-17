From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do I manage this setup with git-svn and/or git remotes?
Date: Fri, 17 Aug 2007 10:56:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708171042570.30176@woody.linux-foundation.org>
References: <86y7gaxef5.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM648-0003g4-Tp
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbXHQR4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbXHQR4x
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:56:53 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58175 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757279AbXHQR4w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 13:56:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7HHuVsD027731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 17 Aug 2007 10:56:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7HHuPvb022360;
	Fri, 17 Aug 2007 10:56:25 -0700
In-Reply-To: <86y7gaxef5.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00,TW_SV
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56078>



On Fri, 17 Aug 2007, David Kastrup wrote:
> 
> Now is there any chance to set up a git structure that will me allow
> to let _git_ perform merges between the standalone dsp project and the
> part that has started off as a copy of it in a subdirectory from
> projects/great, so that I have a merge history in my git mirror?

Yes. That's what git "submodule" support is all about. You could create 
that "dsp" project as its own git project, and then include it within the 
bigger project as a submodule. Then, that "dsp" thing is really a totally 
independent git project in its own right, with git support for just 
"tying" it into the superproject.

A few words of caution:

 - while the low-level core submodule support has been around for a while
   now, the actual "porcelain" level helper stuff is new to 1.5.3 (which 
   is unreleased, so you'd have to use the current git "master" branch, of 
   course)

 - submodules are (very much by design) meant to be git projects in their
   own right, and kept separate. That very explicit separation means that 
   you will *see* it as a separate project, and you may decide that it's 
   not worth the extra setup/complexity if the "dsp" thing just isn't big 
   enough or the merge complexity just isn't worth the effort.

 - not very many people use it. The msysgit people seem to be using it,
   and Andy Parkins has been using it for a while (and seems happy), but I 
   think you basically end up having less documentation and somewhat less 
   support for it (and it doesn't get the same kind of testing that the 
   "basic" git behaviours get).

Another alternative is to do what git has long done with "gitk": you can 
maintain a separate project and just merge it directly into another git 
project, and it works fine that way, but it gets impossible to merge back 
and forth between the two projects (you can only merge one way: make all 
the major changes in the "dsp" project, and then you can just merge it 
into the project that uses it (but if you fix things in the bigger 
project, you can't merge the fixes back, you'll have to export the fixes 
as patches and do them in the "dsp" tree).

			Linus
