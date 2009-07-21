From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2] FindBugs: don't use new String(String) in
	RefDatabase
Date: Tue, 21 Jul 2009 08:03:37 -0700
Message-ID: <20090721150337.GP11191@spearce.org>
References: <49C20D4E.5020203@gmail.com> <551f769b0907130107j51d32e4er54e125f9dc61dd80@mail.gmail.com> <20090713145308.GI11191@spearce.org> <200907211650.36831.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:04:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTGsq-00084m-Vk
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZGUPDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbZGUPDh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:03:37 -0400
Received: from george.spearce.org ([209.20.77.23]:52855 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbZGUPDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:03:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 34682381FD; Tue, 21 Jul 2009 15:03:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907211650.36831.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123660>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Shawn, any references for the ability of JIT's abilities to stack allocate in this context? For
> me learning, will commit anyway.

See [1] for example.  I read a presentation from a HotSpot engineer
at Sun a year or two ago that talked about it as a feature in the
Sun Java 6 runtime, but I can't track that down now.

Its a pretty simple concept.  Folks realized that some types,
e.g. StringBuilder, are often used only within a single stack
frame, and that escape analysis can be used to prove that the
StringBuilder instance is only visible within that stack frame.
Doing a stack allocation instead of a heap allocation would allow
the JVM to avoid creating unnecessary garbage.

Ah, according to [2] the feature is only in 6u14 and later, and is
an option you still need to enable on the command line.  But its
the direction the Sun JVM is going.  I imagine it would be on by
default in the future, various performance tests seem to indicate
its a worthwhile optimization.

[1] http://www.ibm.com/developerworks/java/library/j-jtp09275.html?ca=dgr-lnxw01JavaUrbanLegends
[2] http://java.sun.com/javase/6/webnotes/6u14.html

-- 
Shawn.
