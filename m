From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/10] user-manual: move howto/make-dist.txt into user
 manual
Date: Mon, 14 May 2007 10:44:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705141043080.6739@woody.linux-foundation.org>
References: <11791560893572-git-send-email-> <1179156089759-git-send-email->
 <11791560893022-git-send-email-> <11791560891179-git-send-email->
 <1179156089470-git-send-email-> <11791560892667-git-send-email->
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon May 14 19:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnebr-0008Fz-Oo
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXENRpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 13:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756422AbXENRpE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:45:04 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:41227 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755289AbXENRpC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 13:45:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4EHiR9e032304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 May 2007 10:44:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4EHiQ7W022153;
	Mon, 14 May 2007 10:44:26 -0700
In-Reply-To: <11791560892667-git-send-email->
X-Spam-Status: No, hits=-3.491 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.178 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47277>



On Mon, 14 May 2007, J. Bruce Fields wrote:
>
> +where release-script is a shell script that looks like:
> +
> +-------------------------------------------------
> +#!/bin/sh
> +stable="$1"
> +last="$2"
> +new="$3"
> +echo "# git-tag v$new"
> +echo "git-tar-tree v$new linux-$new | gzip -9 > ../linux-$new.tar.gz"
> +echo "git-diff-tree -p v$stable v$new | gzip -9 > ../patch-$new.gz"
> +echo "git-rev-list --pretty v$new ^v$last > ../ChangeLog-$new"
> +echo "git-rev-list --pretty=short v$new ^v$last | git-shortlog > ../ShortLog"
> +echo "git-diff-tree -p v$last v$new | git-apply --stat > ../diffstat-$new"

Actually, these days it looks more like

	#!/bin/sh
	stable="$1"
	last="$2"
	new="$3"
	echo "# git tag v$new"
	echo "git archive --prefix=linux-$new/ v$new | gzip -9 > ../linux-$new.tar.gz"
	echo "git diff v$stable v$new | gzip -9 > ../patch-$new.gz"
	echo "git log --no-merges v$new ^v$last > ../ChangeLog-$new"
	echo "git shortlog --no-merges v$new ^v$last > ../ShortLog"
	echo "git diff --stat --summary -M v$last v$new > ../diffstat-$new"

ie I'm using more modern versions of the git tools ;)

		Linus
