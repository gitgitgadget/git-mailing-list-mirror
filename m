From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: Simplify calculation of GIT_DIR
Date: Thu, 8 Mar 2012 00:51:03 +0000
Message-ID: <20120308005103.GA27398@dcvr.yhbt.net>
References: <1330804397-43062-1-git-send-email-barry.wardell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Barry Wardell <barry.wardell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 01:51:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5RZs-0002L5-7L
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 01:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014Ab2CHAvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 19:51:07 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44252 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab2CHAvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 19:51:04 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C93F1F862;
	Thu,  8 Mar 2012 00:51:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1330804397-43062-1-git-send-email-barry.wardell@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192511>

Barry Wardell <barry.wardell@gmail.com> wrote:
> -my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
> -$ENV{GIT_DIR} ||= '.git';

<snip>

>  unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {

<snip>

> +	git_cmd_try {
> +		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
> +	} "Unable to find .git directory\n";
> +
> +	chdir $toplevel or die "Unable to chdir to '$toplevel'\n";
>  	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
>  }

It looks like some places in "git svn (init|clone|multi-init)" rely on
GIT_DIR being set.  I noticed the first test of t9100-git-svn-basic.sh
failing (causing everything else in that test to fail) with your patch.

Can you fix those use cases (and ensure tests pass)?  Thanks.
