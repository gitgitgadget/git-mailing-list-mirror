From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Regression: git-svn clone failure
Date: Tue, 22 Dec 2009 13:38:29 -0800
Message-ID: <7vbphqzo2y.fsf@alter.siamese.dyndns.org>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com>
 <20091222192115.GA10313@dcvr.yhbt.net>
 <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com>
 <1261516416.23944.44.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Myrick <amyrick@apple.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNCRO-00026v-GK
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 22:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbZLVVin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 16:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbZLVVin
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 16:38:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZLVVim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 16:38:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C80058A658;
	Tue, 22 Dec 2009 16:38:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b8zCArokiIsGvCu6hitDl4yS96w=; b=K2E49t
	/NUupAEPvfwlMiMyrleLqaHDmS7tjfuFQtINQ9Un1zCWxFzK9REnKamXY8MNPGjH
	H6chEICJbaRWxuKwcy1hBWZCtPz0sWBvcDtOx6D4AnpfVqVuLbFtzAic0s0LsQlW
	jcN71s7ZuTNkvNLjJ4T9Dx5Kwjcz9AiUBb2QU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EisCN2mwCOR3aONcc0eX9Ha/Su8na944
	QGaQ7Lf98wKPeUPVhpujNm01oXufoBvaYs5ttdbzn8WIJKKQDakalEBKA5CGq00o
	tDocLXeHU9GWcP6oZiawfudWVwujw63Ab9g5pnjcNi8oa/4kTQ41FaI3IB+uOq6Z
	LlJc6x60UvE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F318A654;
	Tue, 22 Dec 2009 16:38:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CAA18A652; Tue, 22 Dec
 2009 16:38:30 -0500 (EST)
In-Reply-To: <1261516416.23944.44.camel@denix> (Sam Vilain's message of
 "Wed\, 23 Dec 2009 10\:13\:36 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BCD169A-EF42-11DE-862C-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135600>

Sam Vilain <sam@vilain.net> writes:

> With git, merge parent relationships imply (conceptually, anyway) that
> all of the changes reachable from that branch are included in the
> commit.  If someone is doing cherry-picking, then they are specifically
> excluding some commits, so adding a merge parent to that branch isn't
> right.  This is what the warning is saying.  It's happening every commit
> because that section of code doesn't know whether a mergeinfo record is
> new or not.
> ...
> Subject: [PATCH] git-svn: consider 90% of a branch cherry picked to be a merge
>
> Be slightly fuzzy when deciding if a branch is a merge or a cherry pick; in
> some instances this might indicate intentionally skipping changes as not
> required, as if they had performed a real merge and then skipped those
> files.
>
> Signed-off-by: Sam Vilain <sam@vilain.net>

If I were _using_ git-svn (or any other tool), I would rather be forced to
see overlapping changes from both branches to sort out the conflict myself
when I merge such a cherry-picked history, rather than an automated but
unreliable operation that drops changes randomly, still records that
everything from the branch is now merged, and reports "everything is
peachy".

That sounds horrible, as you cannot trust your merges anymore.  I hope I
am mis-interpreting what you wrote above.
