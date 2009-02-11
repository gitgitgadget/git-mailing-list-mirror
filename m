From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: Prevents GIT_PS1_DIRTYSTATE from
 breaking when CWD is .git
Date: Wed, 11 Feb 2009 08:56:09 -0800
Message-ID: <7vprhogbfa.fsf@gitster.siamese.dyndns.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-4-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:57:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIPA-0003Ma-IY
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbZBKQ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbZBKQ4R
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:56:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZBKQ4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:56:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8759198631;
	Wed, 11 Feb 2009 11:56:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2CCB98630; Wed,
 11 Feb 2009 11:56:10 -0500 (EST)
In-Reply-To: <1234366634-17900-4-git-send-email-ted@tedpavlic.com> (Ted
 Pavlic's message of "Wed, 11 Feb 2009 10:37:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E4EF30DA-F85C-11DD-9DD5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109444>

Ted Pavlic <ted@tedpavlic.com> writes:

> The GIT_PS1_DIRTYSTATE support uses a "git diff" to see if a "*" should
> be placed after the branch name. The "git diff" fails with an ugly error
> if the user has just changed directory into GIT_DIR.
>
> This patch uses "git rev-parse --is-inside-work-tree" to determine
> whether a "--work-tree=.." should be added to the "git diff".

Why ".."?  What prevents you from "cd .git/refs/heads"?

Your "is-inside-work-tree" might be a good change, but if you were to
spend a letter to notify the users, "Warning: You are inside GIT_DIR! This
is something unusual, proceed with caution." is a lot more important
notice to give them than "You seem to have unstaged changes" notice.

You have at least three possible states:

 * You are not in git repository at all;

 * You are somewhere in $GIT_DIR, perhaps in a bare repository, perhaps a
   repository with a work tree.

 * You are inside a work tree.

The first should be quiet, the second should say "Proceed with caution,
any 'rm -f file' or 'edit file' you do here should be to recover from
unusual repository corruptoin only; you are welcome to look but don't
touch.", and the last one is Ok to say "You have unstaged changes."
