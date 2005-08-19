From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Questions on 'cvs migration guide''
Date: Fri, 19 Aug 2005 08:18:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508190812490.3412@g5.osdl.org>
References: <46a038f9050818201717f9ed93@mail.gmail.com> 
 <Pine.LNX.4.58.0508182130050.3412@g5.osdl.org> <46a038f9050818225865deb7ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 17:18:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E68dM-0007Y0-MJ
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 17:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVHSPSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVHSPSM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 11:18:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbVHSPSL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 11:18:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7JFI8jA017523
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 Aug 2005 08:18:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7JFI7BG020161;
	Fri, 19 Aug 2005 08:18:08 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050818225865deb7ee@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 19 Aug 2005, Martin Langhoff wrote:
> 
> I'm keen on keeping my 'merge & publish' step in a single repo that
> has all the 'team' branches. The person running this repo will
> probably actually code in separate repos, and merge in there too.

I would suggest against a person owning a "merge and publish". Instead, 
just have a public repo that everybody involved to can push to - _they_ 
will need to merge before they push (since a push won't accept a unrelated 
parent), but that way anybody can export their changes at any time, 
exactly like with a central CVS repository.

> Right now I'm switching 'heads' (I'm getting used to cogito's use of
> 'branch' for 'remote head') using this quick'n'dirty bit of shell:

No, just do

	git checkout <headname>

> but I want to prevent the action if the checkout is 'dirty'. Is there
> any way to check whether cg-diff thinks anything has changed?

If you use "git checkout" to switch branches, it will do that testing for 
you. You can still _force_ a head switch with "git checkout -f".

Oh, and if a file was dirty that is the same in both heads, the 
"dirtyness" follows you into the new head. If that isn't what you want, 
then you need to add some logic like

	if [ "$(git-diff-files)" != "" ]; then
		echo "Current branch not clean" >&2
		exit 1
	fi
	git checkout "$@"

or something.

		Linus
