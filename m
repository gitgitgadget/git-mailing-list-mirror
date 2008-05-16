From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Fri, 16 May 2008 08:54:21 +0200
Message-ID: <482D2F9D.4080809@viscovery.net>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com> <alpine.DEB.1.00.0805160012310.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 08:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwtqr-00077U-CN
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 08:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbYEPGy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 02:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYEPGy1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 02:54:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41181 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYEPGy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 02:54:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jwtpd-0004Hq-GT; Fri, 16 May 2008 08:54:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2907A6C4; Fri, 16 May 2008 08:54:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0805160012310.30431@racer>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82259>

Johannes Schindelin schrieb:
> +'GIT_CEILING_DIRECTORIES'::
> +	If set (to a colon delimited list of absolute directories), Git
> +	will refuse to look for the .git/ directory further when hitting
> +	one of those directories (otherwise it would traverse the parent
> +	directories until hitting the root directory).

Hmm.

Looking at the current implementation, this should be written as:

	If set to a colon delimited list of absolute directories,
	and the current directory is in or below one of them, then
	these are the top-most directories in which Git will look for
	a .git/ directory (otherwise it would traverse the parent
	directories until hitting the root directory).

But from David's initial commit message:

For example, I use git in an environment where homedirs are automounted
and "ls /home/nonexistent" takes about 9 seconds.  Setting
GIT_CEILING_DIRS="/home" allows "git help -a" (for bash completion) and
"git symbolic-ref" (for my shell prompt) to run in a reasonable time.

This implementation it will still look for a non-existing /home/.git, and,
hence, should take a long time to complete.

David, does this really meet your needs?

-- Hannes
