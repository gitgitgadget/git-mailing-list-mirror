From: Junio C Hamano <junkio@cox.net>
Subject: Re: index manipulation -- how?
Date: Mon, 21 Nov 2005 21:24:01 -0800
Message-ID: <7v8xvhi7bi.fsf@assigned-by-dhcp.cox.net>
References: <20051122050337.46450.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 06:26:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQdU-000191-NT
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVKVFYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKVFYE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:24:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10369 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932295AbVKVFYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 00:24:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122052245.YIJU17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 00:22:45 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051122050337.46450.qmail@web31808.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 21 Nov 2005 21:03:37 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12524>

Luben Tuikov <ltuikov@yahoo.com> writes:

> How do I reverse a _single_ "git-update-index" operation?
> Be it --add or just an update.

Reverting working tree files are "git checkout HEAD the-file"
(both index and working tree file from the head commit) or "git
checkout -- the-file" (working tree file from the index), but I
do not think there is a prepackaged way to revert only a single
index path offhand.

        git-ls-tree HEAD the-file |
        sed -e 's/^\([0-7]*\) [^ ]* \(.*\)/\1 \2/' |
        git-update-index --index-info

should work.

I think changing update-index --index-info so that you can lose
the sed in between without breaking its other usage (it reads
from git-apply --index-info, which does not say " blob " which
is what the sed is stripping out) is a worthwhile thing to do.
