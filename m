From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 17:52:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505301748130.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <20050530221214.GA29556@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 02:48:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcuvK-0001e2-Uf
	for gcvg-git@gmane.org; Tue, 31 May 2005 02:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVEaAuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 20:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVEaAuY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 20:50:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:55467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261850AbVEaAuP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 20:50:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4V0o6jA010181
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 30 May 2005 17:50:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4V0o6od024869;
	Mon, 30 May 2005 17:50:06 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050530221214.GA29556@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 30 May 2005, Dave Jones wrote:
>
>     GIT_AUTHOR_NAME="John Doe"      \
>     GIT_AUTHOR_EMAIL="jdoe@foo.com" \
>     git-commit-tree `git-write-tree`    \
>     -p $(cat .git/HEAD )            \
>     < changelog.txt         \
>     > .git/HEAD

You _really_ want to script this.

Also, I'd seriously suggest you avoid using ".git/HEAD" _and_ writing to 
.git/HEAD in the same command. Maybe it works, maybe it doesn't.

So script it with something like

	#!/bin/sh
	export GIT_AUTHOR_NAME="$1"
	export GIT_AUTHOR_EMAIL="$2"
	tree=$(git-write-tree) || exit 1
	commit=$(git-commit-tree $tree -p HEAD) || exit 1
	echo $commit > .git/HEAD

and now you can just do

	commit-as "John Doe" "jdoe@foo.com" < changelog.txt

or something like that.

The git commands really are designed to be scripted.

		Linus
