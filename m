From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-send-pack exit with error when some refs couldn't be pushed out
Date: Tue, 13 Dec 2005 17:50:02 -0800
Message-ID: <7vbqzk5tx1.fsf@assigned-by-dhcp.cox.net>
References: <20051214004540.15040.93518.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 02:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLmU-00046J-Fd
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVLNBuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVLNBuF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:50:05 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4274 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030416AbVLNBuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 20:50:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214014912.SUYV6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 20:49:12 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051214004540.15040.93518.stgit@machine.or.cz> (Petr Baudis's
	message of "Wed, 14 Dec 2005 01:45:40 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13613>

Petr Baudis <pasky@suse.cz> writes:

> In case some refs couldn't be pushed out due to an error (mostly the
> not-a-proper-subset error), make git-send-pack exit with non-zero status
> after the push is over (that is, it still tries to push out the rest
> of the refs).

I agree this change to send-pack is a good fix (I haven't looked
at the code, but the above description describes a good fix).

However, I am not quite sure if the recent change to Cogito to
update the mirror of remote branch is a good one.  Since I am
not a Cogito user, I did not question it when I saw the change,
but I wondered what you are using the cached "remote ref is
supposed to be pointing at this commit" knowledge for.  If it is
only "pretending to have fetched the remote branch immediately
after we pushed into it before anybody else touched the same
remote branch", then it probably is benign.  But this bit
puzzles and worries me:

> ... otherwise
> it gets out of sync, which can lead even to loss of commits on the local
> side (this happenned to Jonas Fonseca - thanks for the report, BTW).

I do not remember seeing that report so I do not know how that
lossage happens with unreleased Cogito, but I suspect there is
something very fishy going on here.  I presume it happens when
the next fetch/pull from the remote is run, but if the locally
cached information can affect the next fetch/pull in such a way,
wouldn't updates by other people to the shared remote repository
branch also cause things to go out-of-sync and cause the same
breakage?
