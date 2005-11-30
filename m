From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PROBE] cg-commit: show and enable editing of changes with --review
Date: Tue, 29 Nov 2005 16:30:42 -0800
Message-ID: <7vbr03564t.fsf@assigned-by-dhcp.cox.net>
References: <20051130000131.GC5365@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 01:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhFs0-00089r-8C
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 01:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVK3Aap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 19:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVK3Aao
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 19:30:44 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52450 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbVK3Aan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 19:30:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130002910.SNNM20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 19:29:10 -0500
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051130000131.GC5365@diku.dk> (Jonas Fonseca's message of "Wed,
	30 Nov 2005 01:01:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12975>

Jonas Fonseca <fonseca@diku.dk> writes:

> Show changes being commited as a patch appended to the commit message
> buffer. If the original patch is different from the patch extracted from
> the commit message file the original patch will be reverted and the edited
> patch applied before completing the commit.
>
> Due to limitations with cg-patch this can only be used when commiting
> from the project root directory. The error handling if the either the
> original patch or the edited patch does not apply is not optimal, since
> cg-patch will not report errors properly.

I do not do Porcelains, I am not a Cogito user, and I generally
do not like encouraging people who are playing an individual
developer role to commit something that has never existed in
their working tree (hence by definition never been tested),
but...

> +		echo "Updating changes to edited patch"
> +		# FIXME: Can only be run from the top level
> +		# FIXME: Is very 'fragile' error handling. We should probably
> +		# save the original patch in a local file for recovery?
> +		if ! cg-patch -R < $PATCH; then
> +			backup=$(mktemp commit-backup.XXXXXX)
> +			cp $PATCH $backup
> +			error_msg="unable to revert original patch, backup saved to $backup"

I suspect at least you should be able to use checkout-index for
the first one instead of cg-patch.
