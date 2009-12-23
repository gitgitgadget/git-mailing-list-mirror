From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: handling merge-base failures
Date: Wed, 23 Dec 2009 20:09:36 +0000
Message-ID: <20091223200936.GA13735@dcvr.yhbt.net>
References: <931B0483-7628-488E-BB9F-C40346353149@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:09:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNXWj-0007QT-Uk
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 21:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZLWUJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 15:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbZLWUJi
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 15:09:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48294 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbZLWUJh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 15:09:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 661131F525;
	Wed, 23 Dec 2009 20:09:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <931B0483-7628-488E-BB9F-C40346353149@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135633>

Andrew Myrick <amyrick@apple.com> wrote:
> One of my projects is failing to clone because merge-base is failing
> on one of the revisions; the branch is a partial branch, so merge-base
> can't find a common ancestor with trunk.  I'd like to catch the
> exception that command_oneline should throw when merge-base fails, but
> my perl is very rusty and I'm struggling to get git-svn.perl to grok
> the Git::Error::Command class.  What is the appropriate way to import
> that class?  Or more generally, is there a better solution to handling
> this error case?

Hi Andrew,

Git::Error::Command should be imported with the rest of Git.pm

It's a special way of doing exceptions in Perl which I don't see much
point of...  Looking at git-send-email as an example, it does this:

	use Error qw(:try);
	use Git;

	try {
		# something that will throw
	} catch Git::Error::Command with {
		# error handling
	}

A more standard approach in Perl is just:

	eval {
		# something that will die
	};
	if ($@) {
		# error handling
	}

But yes, it is Perl after all and TMTOWTDI :)

-- 
Eric Wong
