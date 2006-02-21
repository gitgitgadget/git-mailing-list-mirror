From: Sam Vilain <sam@vilain.net>
Subject: Re: rewriting pathnames in history
Date: Wed, 22 Feb 2006 09:54:54 +1300
Message-ID: <43FB7E1E.6070605@vilain.net>
References: <20060221075342.GA13814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 21:55:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBeXS-0003L1-3n
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 21:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbWBUUzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 15:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWBUUzK
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 15:55:10 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:21668 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932716AbWBUUzI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 15:55:08 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 27B6654EA; Wed, 22 Feb 2006 09:55:03 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id E56CC454B;
	Wed, 22 Feb 2006 09:54:55 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Jeff King <peff@peff.net>
In-Reply-To: <20060221075342.GA13814@coredump.intra.peff.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16549>

Jeff King wrote:
> I recently ran into an interesting situation with git. I created a
> repository that consisted of several directories (and files in them).
> Later, after many commits, I realized I would prefer each directory have
> its own git repository. That is, given a repo with the files:
>   foo/bar
>   baz/bleep
> I wanted two repos, "foo" containing the file "bar" and "baz" containing
> the file "bleep".

Nice work, but I think you should be able to get it *really* fast, much 
faster than that.

Instead of replaying a checked out copy, just go through the commit 
history, and when the treeID for that subdirectory has changed, then 
that directory has a new revision.  So, make a new commit object with 
that as the treeid.  in other words, you'll be constructing a very 
lightweight branch, but with its tree IDs all corresponding to 
sub-directory treeids on the combined branch.  The history ripple script 
that was posted the other day probably has most of the pieces you need. 
  Once this is done, you can just clone that branch to "get it out".

Sam.
