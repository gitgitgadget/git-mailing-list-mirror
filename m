From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement "git stash branch <newbranch> <stash>"
Date: Wed, 02 Jul 2008 21:12:04 -0700
Message-ID: <7v63rn61yj.fsf@gitster.siamese.dyndns.org>
References: <20080702195947.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0807021447200.9925@racer>
 <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org>
 <20080702195401.GA17214@toroid.org>
 <7vprpw80bw.fsf@gitster.siamese.dyndns.org>
 <20080703022316.GA25433@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7h-0002yW-FG
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbYGCG7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbYGCG5r
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYGCEMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 00:12:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81C85B961;
	Thu,  3 Jul 2008 00:12:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B8045B95F; Thu,  3 Jul 2008 00:12:11 -0400 (EDT)
In-Reply-To: <20080703022316.GA25433@toroid.org> (Abhijit Menon-Sen's message
 of "Thu, 3 Jul 2008 07:53:16 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38CD012A-48B6-11DD-A54C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87249>

Abhijit Menon-Sen <ams@toroid.org> writes:

> +branch <branchname> [<stash>]::
> +
> +	Creates and checks out a new branch named `<branchname>` starting from
> +	the commit at which the `<stash>` was originally created, applies the
> +	changes recorded in `<stash>` to the new working tree, and drops the
> +	`<stash>` if that completes successfully. When no `<stash>` is given,
> +	applies the latest one.
> ++
> +This is useful if the branch on which you ran `git stash save` has
> +changed enough that `git stash apply` fails due to conflicts. Since
> +the stash is applied on top of the commit that was HEAD at the time
> +`git stash` was run, it restores the originally stashed state with
> +no conflicts.

Perhaps we would want to replay the stash always with --index for this
application.  By definition this will be conflict-free both in the index
and in the working tree.

I've also toyed with an idea to make <branchname> optional, and detach the
HEAD if <branchname> is not given.  It would be a useful mode of operation
but one problem is that it is _not_ an operation that should be called
"branch" anymore.
