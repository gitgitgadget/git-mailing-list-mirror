From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on ia64 linux tree
Date: Wed, 27 Apr 2005 15:35:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQv7W-000677-FI
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVD0Wew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVD0Wef
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:34:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:11155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262054AbVD0WdK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 18:33:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RMX8s4022120
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 15:33:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RMX7GT014126;
	Wed, 27 Apr 2005 15:33:08 -0700
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Luck, Tony wrote:
> 
> The merge is right ... but "cg-update" leaves files that have been
> deleted lying around in the checked out tree.

Yes. I _think_ the right thing to do ends up being something like the 
update script doing

	diff-tree -r $orig $final | grep '^-'

at the end to get the list of deleted files, and just doing 'rm' on the 
result.

One problem with this is that "grep" always thinks lines end in '\n', and 
what we'd really want (from a scriptability angle) is

	diff-tree -z -r $orig $final | grep -0 '^-'

but I don't think you can tell grep to think that lines are
zero-terminated instead of terminated with \n'. But I don't see how to do
that with grep.

Another similar alternative is to use "show-files --others" before and
after the merge and seeing what files got added to the list of "files we
don't track", but that just sounds horribly hacky.

Anyway, there are clearly at least two ways of doing this, and we'll just
have to have people work on the scripts to do it right..

		Linus
