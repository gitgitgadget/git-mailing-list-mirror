From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Mon, 14 May 2007 10:26:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705141016370.6739@woody.linux-foundation.org>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle>
 <200705131949.38051.list-receive@mneisen.org> <20070513182405.GA13618@diana.vm.bytemark.co.uk>
 <20070513210128.GA13428@muzzle>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-2136823413-1179163567=:6739"
Cc: Karl Hasselstr?m <kha@treskal.com>,
	Martin Eisenhardt <martin.eisenhardt@mneisen.org>,
	git <git@vger.kernel.org>, Matthieu.Moy@imag.fr
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 14 19:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HneJo-0003cO-Qe
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851AbXENR03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757918AbXENR02
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:26:28 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:36136 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757882AbXENR01 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 13:26:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4EHQ801031524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 May 2007 10:26:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4EHQ6N6021783;
	Mon, 14 May 2007 10:26:06 -0700
In-Reply-To: <20070513210128.GA13428@muzzle>
X-Spam-Status: No, hits=-3.491 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.178 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47275>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-2136823413-1179163567=:6739
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT



On Sun, 13 May 2007, Eric Wong wrote:
> Karl Hasselström <kha@treskal.com> wrote:
> 
> > It might be a net win to let git-svn handle empty directories by
> > creating an empty .git-svn-empty-dir file in them, instead of
> > pretending they don't exist.
> 
> No.  This is *WAY* too ugly.

I wouldn't personally mind if somebody taught git to just track empty 
directories too.

There is no fundamental git database reason not to allow them: it's in 
fact quite easy to create an empty tree object. The problems with empty 
directories are in the *index*, and they shouldn't be insurmountable.

I never wanted empty directories for the kernel, but there is nothing 
really fundamentally wrong with them either. They do have some problems, 
which is why I don't particularly like tracking them, but if *not* 
tracking them causes more problems for people who import from SVN, I could 
easily see the balance moving towards "let people do it if they want".

In fact, I think the subproject support might have made it easier to track 
directories as empty directory entries. Pretty much every place that got 
impacted by subprojects would be where empty directory entries would be 
handled too.

In fact, one of the questions when tracking empty directories is whether 
you should track non-empty directories too. IOW, should we _always_ put 
the directory entry into the index (even when it's not empty), or should 
we do it only when somebody explicitly asks for it. I suspect the "always" 
case would is the right answer (ie a read-tree would always add a 
directory entry to the index before it starts adding the actual entries 
in the read-tree)

Anybody want to try it?

			Linus
---1463790079-2136823413-1179163567=:6739--
