From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 08:36:26 -0700
Message-ID: <7vobdfztz9.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URlSi-0005HI-LW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934415Ab3DOPgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:36:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934152Ab3DOPg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:36:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F1ED15F27;
	Mon, 15 Apr 2013 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yhNK1JCQ2HRCz2ld3gCWN7tRqXc=; b=M50XrA
	G44JGIOqnlso0Va7fS2YOVKSQ26qJRyMV+7EmqPBUxuQSFznO72+3VsoCdvmi/9P
	qp+vpzghvN3Mk3WhC57AMpVhwByHljZNKnTu7QI5bP8iL77ffJNHynkZl6LZy4LW
	Gk+rPWY4znKMoLmouRb50AYdBtjD2ec16bNsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hj1lJYhpZ5JUlse246D3uWIYNv6tgumH
	oIW/N0gOFT5IhC78XX561nzhIb5i3wZjqTg66H4Xiyv2bVZZgxAWPtsW0RW05YaF
	TKGesmhlcfY6krJI/lImI3ZTO5B4NQHojpXGM/IJMb6TldN1XfkBwm+/JbxCHu81
	vtoaFTDaI7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72BB615F26;
	Mon, 15 Apr 2013 15:36:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C233F15F23; Mon, 15 Apr
 2013 15:36:27 +0000 (UTC)
In-Reply-To: <vpqppxvoqsc.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 15 Apr 2013 15:40:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CEF8B90-A5E2-11E2-90BC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221239>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I think you're taking it the wrong way. You seem to insist that
> autostash should be a pull feature. I think it should be a feature of
> merge and rebase, and the convenience script "git pull" should expose
> them to the user.
>
> I see no reason to prevent users running fetch and then merge or rebase
> to use the autostash feature.

I agree that is a good way to look at the problem and would lead to
a much better design of the division of labor among these three
moving parts.

> It's not about fixing the existing rebase. It's about implementing
> autostash the right way.
>
> As a user, when I run "git rebase --continue" and it tells me it's done,
> I expect the work to actually be done. This is the case today. This
> won't be the case after autostash is introduced if the user has to
> remember to run "stash pop" afterwards.

Your "rebase can do the autostash right way" idea in the other
message is a good one, I think.  The rebase proper will sequencially
either apply patches (if the user is using the "format-patch | am"
variant) or cherry-pick commits ("rebase -m").  Conceptually we can
view the WIP in the working tree as just another commit at the tip
of the original history to be rebased (modulo that it should not be
left as a commit in the resulting history, and we may need to
differentiate what was in the index and what was only in the working
tree).  Ignoring the "conflicts at stash pop time" issue for now, a
rough outline may look like:

	git-rebase --autostash

		git commit --allow-empty -m 'index part'
	        git commit --allow-empty -a -m 'working tree part'
                git rebase --onto $UPSTREAM
                git reset HEAD^
                git reset --soft HEAD^

The first "reset" is to match the index to what was "stashed" with
the first "commit" ('index part') while keeping the working tree
changes the original WIP had ('working tree part'), and the last
"reset --soft" is to move the HEAD back to the tip of the originally
committed history.
