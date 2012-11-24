From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Option to revert order of parents in merge commit
Date: Fri, 23 Nov 2012 18:58:49 -0800
Message-ID: <7vfw3zzoye.fsf@alter.siamese.dyndns.org>
References: <20121123083550.GA702@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sat Nov 24 04:08:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc66L-0004ZE-PG
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab2KXC6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 21:58:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881Ab2KXC6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 21:58:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AC1AAB1C;
	Fri, 23 Nov 2012 21:58:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fpvjy0krAmCaQGvroMe48rESmpQ=; b=uTG4ql
	apdIIDk3wp3/7OqPfJy3s4SL//K+F6QCyeesluhpp1eXVM2vI7zsgWnTX8RP6CWl
	CeCePQjmXOIBY18PDJ6Czb16Ryr2ncAyrhTj0YzZZbT982yEQtCt9a5LMZfl9BOG
	BzjepBTFOONWdG83SIYtPpLKeQcXrvsRU5kc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=grI0dPsxsBzuAffZvJgytUOqUlRlKcdC
	4ZEiOq8yPYcPZUDhoC5AACFgK8gLaILZE3x4n/+F8VI7wYzQD40XbLCcco6qLNQZ
	IHMYHiKzDtYTs4m9u1OO1nh6c8wKML7ZGQ3u7XcgA75VDtpqLuZcgYxhKbeuTWNr
	9kf6kMwayl8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76BB0AB1B;
	Fri, 23 Nov 2012 21:58:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2F70AB17; Fri, 23 Nov 2012
 21:58:50 -0500 (EST)
In-Reply-To: <20121123083550.GA702@camk.edu.pl> (Kacper Kornet's message of
 "Fri, 23 Nov 2012 09:35:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFCB5C06-35E2-11E2-ADE9-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210282>

Kacper Kornet <draenog@pld-linux.org> writes:

> The following patch is an attempt to implement this idea.

I think "revert" is a wrong word (implying you have already done
something and you are trying to defeat the effect of that old
something), and you meant to say "reverse" (i.e. the opposite of
normal) or something.

I am unsure about the usefulness of this, though.

After completing a topic on branch A, you would merge it to your own
copy of the integration branch (e.g. 'master') and try to push,
which may be rejected due to non-fast-forwardness:

    $ git checkout master
    $ git merge A
    $ git push

At that point, if you _care_ about the merge parent order, you could
do this (still on 'master'):

    $ git fetch origin
    $ git reset --hard origin/master
    $ git merge A
    $ test test test
    $ git push

With --reverse-parents, it would become:

    $ git pull --reverse-parents
    $ test test test
    $ git push

which certainly is shorter and looks simpler.  The workflow however
would encourage people to work directly on the master branch, which
is a bit of downside.

Is there any interaction between this "pull --reverse-parents"
change and possible conflict resolution when the command stops and
asks the user for help?  For example, whom should "--ours" and "-X
ours" refer to?  Us, or the upstream?
