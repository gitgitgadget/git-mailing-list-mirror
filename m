From: Junio Hamano <junio@twinsun.com>
Subject: (unknown)
Date: Sat, 23 Jul 2005 02:10:51 -0700 (PDT)
Message-ID: <7vek9phorr.fsf@totally-fudged-out-message-id>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:11:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwG2J-0007iU-6G
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 11:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVGWJLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVGWJLE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 05:11:04 -0400
Received: from alcor.twinsun.com ([198.147.65.9]:21623 "EHLO alcor.twinsun.com")
	by vger.kernel.org with ESMTP id S261309AbVGWJLC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 05:11:02 -0400
Received: from sic.twinsun.com ([192.54.239.17])
	by alcor.twinsun.com (8.12.9/8.12.9) with ESMTP id j6N9Aq3x012104;
	Sat, 23 Jul 2005 02:10:52 -0700 (PDT)
Received: from pete.twinsun.com (pete.twinsun.com [192.54.239.43])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j6N9AqY11990;
	Sat, 23 Jul 2005 02:10:52 -0700 (PDT)
Received: from sic.twinsun.com ([192.54.239.17])
 by pete.twinsun.com (SMSSMTP 4.1.0.19) with SMTP id M2005072302105126160
 ; Sat, 23 Jul 2005 02:10:51 -0700
Received: from arte (arte.twinsun.com [192.54.239.5])
	by sic.twinsun.com (8.11.7p1+Sun/8.11.7) with SMTP id j6N9ApY11986;
	Sat, 23 Jul 2005 02:10:51 -0700 (PDT)
Received: by arte (sSMTP sendmail emulation); Sat, 23 Jul 2005 02:10:51 -0700
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>From nobody Sat Jul 23 02:08:27 2005
To: Ryan Anderson <ryan@michonline.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Add git-find-new-files to spot files added to the tree,
 but not the repository
Bcc: junkio@cox.net
References: <20050723074219.GB3255@mythryan2.michonline.com>
From: Junio C Hamano <junio@twinsun.com>
Date: Sat, 23 Jul 2005 02:10:51 -0700
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Ryan Anderson <ryan@michonline.com> writes:

> Add git-find-new-files to find files that are in the tree, but
> not checked into the repository.

You _ought_ to be able to just say:

 $ git-ls-files --others --exclude-from=<exclude pattern file>

and be done with it.  Also please see the thread about Cogito
and StGIT's use of .gitignore and .git/exclude files.

The current implementation of "git-ls-files" exclude mechanism
may have rooms for improvements; the last time I checked, it
only did the matching of patterns against filename without
leading directories).  The world will be a better place if
somebody extends it, instead of working around its limitation.

I may be tempted to doing it myself, but I'm in the middle of
something else, so ...

> +#	find . -name .git -type d -prune -o -type f -print \
> +#		| grep -v -e .tree1 -e .tree2 \
> +#		| sed -e "s/^\.\///" \
> +#		| sort >.tree1
> +#	git-ls-files | grep -v -e .tree1 -e .tree2 \
> +#		| sort >.tree2
> +#	diff -u .tree1 .tree2

It does not matter since the above is just an example and I
think you should be able to just use "ls-files --others", but
just FYI, you could have written "comm -23 .tree1 .tree2" above
instead of "diff -u".
