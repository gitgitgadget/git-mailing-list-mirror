From: Marc Branchaud <marcnarc@xiplink.com>
Subject: RFC: Sparse checkout improvements (was: Re: question (possibly) on
 git subtree/submodules)
Date: Tue, 27 Jul 2010 10:24:13 -0400
Message-ID: <4C4EEC0D.2070105@xiplink.com>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>	<4C49C9C6.3080409@gmail.com> <loom.20100727T125434-697@post.gmane.org> <m3bp9tks6e.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex <ajb44.geo@yahoo.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 16:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odl4q-0002Zp-2u
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 16:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab0G0OYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 10:24:09 -0400
Received: from smtp152.dfw.emailsrvr.com ([67.192.241.152]:35133 "EHLO
	smtp152.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0G0OYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 10:24:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp5.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id E0CAF58480;
	Tue, 27 Jul 2010 10:24:06 -0400 (EDT)
X-Virus-Scanned: OK
Received: from [192.168.1.136] (unknown [208.85.112.101])
	(Authenticated sender: mbranchaud@xiplink.com)
	by smtp5.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPSA id C9B9E58477;
	Tue, 27 Jul 2010 10:24:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <m3bp9tks6e.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151944>

On 10-07-27 08:48 AM, Jakub Narebski wrote:
> Alex <ajb44.geo@yahoo.com> writes:
> 
>> Chris Packham <judge.packham <at> gmail.com> writes:
>>
>>> The short answer is no. Nothing git has currently will let you clone a
>>> subset of files. 
>>
>> Isn't that what 'sparse checkout' does?
>> (http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html#_sparse_checkout)
> 
> No, 'sparse checkout' is only about checkout, i.e. the working area.
> You still have all objects in repository, only part of tree (part of
> project / repository) is not checked out, not present on disk as
> files.

There's no such thing as a "sparse fetch" but you can do something like

	git clone -n git://there/foo.git
	cd foo

then

	git checkout origin/<branch> -- <paths...>

or
	git config core.sparseCheckout true
	[ Add paths to .git/info/sparse-checkout ]
	git checkout <branch>


but it's fairly inconvenient for day-to-day work.  Also, putting a
.git/info/sparse-checkout file in a public repo seems of limited use.

So IMHO the current sparse-checkout feature is pretty bare-bones and could
use some meat.  Here's some thoughts:

* What's missing is a way to define named collections of paths
("sparse-sets?") in .git/info/sparse-checkout, so that you can conveniently
checkout a particular subset of the working directory.  It would also be nice
to switch between different sparse-sets.

* It would also be good to have a way for a repo to define a default
sparse-set, so that a clone would only checkout that default.

* I also think that core.sparseCheckout should be true by default, and git
should impose no sparseness if .git/info/sparse-checkout is missing or empty.

Comments?

		M.
