From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 21:10:52 -0700
Message-ID: <7v4nbwfooj.fsf@alter.siamese.dyndns.org>
References: <7vli5bllsd.fsf@alter.siamese.dyndns.org>
	<51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org>
	<51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org>
	<51E1B5DB.9080904@kdbg.org> <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
	<51E3084D.2040504@kdbg.org> <20130714203403.GE8564@google.com>
	<51E31131.3070005@kdbg.org> <20130714212800.GA11009@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uya85-0001hK-SX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3GOEK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:10:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab3GOEKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:10:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 247322A4CE;
	Mon, 15 Jul 2013 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fpdb1tZZaLYOivx54O/pbrOPbmg=; b=cpsi75
	WqvbG79t4U+RGE7wO33DTbk1s5g5hQccdvDb3uK6f2nk2LuVW89/snobi+7cinRJ
	KbqXTPfSDttk9jHx7YDlYBrHgKy50WL6uftrXT75wokEUkpAXT/ZZUkY9u97+ce9
	/EbJiRd1A0IpmT/7WeLFXRlEtwwZqFSdP5kXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=phdR/FiaTj2ydx4NtIZ7SMG6AHqLKrrz
	HFvmtfHyO8o346zN6YJibYucUP5r7Lq+pPuWtk47k2ZuZx/oWjP+zHD8B8Y5EAI1
	2r3DhP87CAp/zHdNqwdTCitFwFi1IZs3waGKA9+sxqA23ANwq1cwL/OtUncsWlme
	/GI4GzNk4wc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AAD02A4CD;
	Mon, 15 Jul 2013 04:10:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 561722A4CA;
	Mon, 15 Jul 2013 04:10:54 +0000 (UTC)
In-Reply-To: <20130714212800.GA11009@google.com> (Jonathan Nieder's message of
	"Sun, 14 Jul 2013 14:28:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B16740A-ED04-11E2-82D0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230410>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	(4) gitk @{u}@{1}..@{u}; # Is the change good?
>
> 	(5a) git pull --rebase; git push; # Yes, put my change on top of it
> 	(5b) git push --force; # No, my change is better!
>
> So far so good.  But what if yet another change is made upstream
> between step (3) and (5)?
>
> If following approach (5a), that's fine.  We notice the new
> intervening change and react accordingly, again.  There is a
> possibility of starvation, but no other harm done.
>
> In case (5b), it may be a serious problem.  I don't know about the
> intervening change until I read the "git push" output, and in the
> usual case I just won't notice.  The new lockref UI is meant to
> address this problem.  So in the new world order, in case (5b) it
> sounds like I should have instead used
>
> 	(5b') git push --allow-non-ff

t is clear you want to allow-no-ff in this case (otherwise the push
will not go through), and that is what the "--force" option meant in
the old world.  The compare-and-swap safety is to help this case by
letting you say

	git push --lockref

which is a weaker form of "--force".  We ignore "fast-forward"-ness,
like the current "--force" does, but replace it with another form of
safety "we know replacing this old value with what we are pushing is
OK---if somebody updated the ref in the meantime, then the push is
not OK, so please fail".

> Suppose I am writing a script that is meant to set the remote
> repository to a known state.  Other contributors are only using
> fast-forward updates so once my change goes in they will act
> appropriately.  I just need to get my ref update in, without being
> blocked by other ref updates.
>
> Then I will use
>
> 	(5c) git push --force
>
> which means not to use this new lockref trick that looks at my
> remote-tracking branch and instead to just force the ref update.

I am not sure I follow.  Do other contributors update this remote
repository?  They are "only using fast-forward updates", so their
updates may not lose anything we pushed, but with "--force", aren't
you losing their work on top of yours?
