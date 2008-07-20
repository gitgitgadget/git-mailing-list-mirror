From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge -s theirs
Date: Sun, 20 Jul 2008 14:22:28 -0700
Message-ID: <7vhcak45ez.fsf@gitster.siamese.dyndns.org>
References: <20080720192130.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgNS-0006TA-Tc
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbYGTVWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYGTVWg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:22:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYGTVWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:22:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 99C38341A3;
	Sun, 20 Jul 2008 17:22:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 375ED34193; Sun, 20 Jul 2008 17:22:30 -0400 (EDT)
In-Reply-To: <20080720192130.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sun, 20 Jul 2008 19:21:30 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F844AF6E-56A1-11DD-BA10-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89235>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> This patch steals much code from "git-merge-resolve" to add "theirs"
> strategy.  Its purpose is to always fail and suggest using the preferred
> command "git reset --hard the-other-commit".
> ...
> +echo "If you wanted to say the other history is better than your history," 
> +echo "use 'git reset --hard $remotes' instead." 
> +echo "If you want to keep a record of your failure, you can create a" 
> +echo "new branch from the current HEAD before running the reset command." 
> +
> +exit 2

That is certainly cute, but I do not like it for two reasons:

 - This advertizes "theirs" as available when you ask "git merge -s whoa",
   and then the user is told "don't use this stupid, go away".  That is
   not exactly a good diplomacy to earn friends.

 - The message gives a rather long hexdecimal string in its suggestion to
   run "git reset --hard".  This is not exactly your fault, though. The
   original refname the user gave to "git-merge" is not available to your
   strategy.
