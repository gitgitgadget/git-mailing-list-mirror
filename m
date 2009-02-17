From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH v2] filter-branch -d: Export GIT_DIR earlier
Date: Tue, 17 Feb 2009 18:59:59 +0100
Message-ID: <20090217175959.GA3564@lars.home.noschinski.de>
References: <20090217083146.GA7338@lars.home.noschinski.de> <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:01:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUGI-0001Ij-MV
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbZBQSAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZBQSAG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:00:06 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:53052 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZBQSAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:00:04 -0500
Received: from [87.78.91.107] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZUEi-00060k-W9; Tue, 17 Feb 2009 19:00:01 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZUEi-000152-0L; Tue, 17 Feb 2009 19:00:00 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110426>

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [09-02-17 16:08]:
>On Tue, 17 Feb 2009, Lars Noschinski wrote:
>> The improved error handling catches a bug in filter-branch when using
>> -d pointing to a path outside any git repository:
>> 
>> $ mkdir foo
>> $ cd foo
>> $ git init
>> $ touch bar
>> $ git add bar
>> $ git commit -m bar
>> $ cd ..
>> $ git clone --bare foo
>> $ cd foo.git
>> $ git filter-branch -d /tmp/filter master
>> fatal: Not a git repository (or any of the parent directories): .git
>
>This could be written as
>
>	$ cd .git
>	$ git filter-branch -d /tmp/bla master

Does not work, as we get another (slightly misleading) error message:

/tmp/foo/.git$ git filter-branch -d /tmp/bar master
fatal: This operation must be run in a work tree
Cannot rewrite branch(es) with a dirty working directory.

But we do not need a bare repository at all to demonstrate this bug, so
we can skip even the 'cd .git'.

>Funny, git am -3 reports:
>
>	Did you hand edit your patch?
>	It does not apply to blobs recorded in its index.
>	Cannot fall back to three-way merge.

Hm, for some reason, format=flowed was enabled. I wonder, that it has
not bitten me earlier.

>We try to avoid cd'ing back, by using constructs like this:
>
>	(cd drepo &&
>	 ...
>	) &&

Ok, can do.

>After those two (maybe three) changes and your SOB: ACK.
>
>BTW the reason I wanted to test this thing is that I suspected that you 
>meant test_commit instead of make_commit.  But then, I realized that there 
>exists a make_commit in t7003... which shares the shortcoming of our 
>previous implementation of test_commit in that it adds ambiguities on 
>case-insensitive filesystems.

Yeah, I used make_commit to stay consistent with the rest of the file.
I'll change it to test_commit. I think as it does not bite us, it would
be unnecessary code churn to remove the remaining usage of make_commit?

>So I _had_ to look who introduced make_commit:
>
>	$ git blame -L '/make_commit/,/}/' t/t7003*
>
>Making a fool out of yourself -- priceless.

:)

  - Lars.
