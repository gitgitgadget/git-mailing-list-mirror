From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 11:57:07 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
 <20090106072253.GA9920@coredump.intra.peff.net>
 <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com>
 <20090106080300.GA10079@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 12:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKAa5-00018g-K7
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 12:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbZAFL5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 06:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZAFL5R
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 06:57:17 -0500
Received: from main.gmane.org ([80.91.229.2]:39781 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbZAFL5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 06:57:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKAYd-0003k8-Sv
	for git@vger.kernel.org; Tue, 06 Jan 2009 11:57:15 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 11:57:15 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 11:57:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104679>

On 2009-01-06, Jeff King <peff@peff.net> wrote:
> If you are going to have multiple users sharing a repository, generally
> they should be in the same group and the core.sharedrepository config
> option should be set (see "git help config", or the "shared" option to
> git-init).
>
> I've never used that personally, though. I have always just used POSIX
> ACLs, with a default ACL on each directory giving access to everyone.
> E.g. (off the top of my head):
>
>   for user in user1 user2 user3; do
>     setfacl -R -m u:$user:rwX -m d:u:$user:rwX /path/to/repo
>   done

If you're not worried about the finer-grained access control
that acl(5) gives you, just do what "git init
--shared=group" does:

    git config core.sharedrepository 1 # as mentioned above
    chmod g+ws .git

Now set the group to something (I use "gitpushers" ;-)

    chgrp -R gitpushers .git

amd make sure all your users are part of that group.

Works fine for small teams...
