From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone tag shallow
Date: Mon, 18 Feb 2013 01:22:56 -0800
Message-ID: <7vliamascv.fsf@alter.siamese.dyndns.org>
References: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
 <CACsJy8Dso-g7foyJhpY20DNrY11PA8ZZUmP6JXxsiJ_Ggbt_KA@mail.gmail.com>
 <CAByu6UWO=kUOvJ_YcPG9bo+XVZ5hSxRQpyEaUMcVxa=sXt_EMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:23:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7MwY-0001dd-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab3BRJXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:23:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813Ab3BRJW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:22:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 558EE96FB;
	Mon, 18 Feb 2013 04:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DDWQKYKHz67Dqxvb+yiIiWVNRbs=; b=rVqVT5
	nYscYGYW8nGsLLsU14ddM2lajRuLZGM/fZGV8xrIXNdrID2PDMwoo2Dx+vIJ9Afd
	6xGjhv6XgfnjEgSSLbAlqCZrL6qBoGqYTVXziWaM8HUJnvKbrEe+uvXltp7EdljS
	O+6hiK2rof7h4ikvIKjTlAFFjLlYL35SY7Ojs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeJdYtGHFg06Qb6JKKnYv/Uu7WmVmn4W
	qqPWdMFhRsQ1e4bhJ13ZoAhqJStL61Y/Ayihe2gbzuPhT7Boyxj2pKYxvoNmHvqr
	uPHFF9tAK2FBiMEf5k1CT02f6oUgu0sNlXma1hrz1PKI+DdkGF3ADmUzky8mG9ul
	aN9DzZ+xn2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A50D96FA;
	Mon, 18 Feb 2013 04:22:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF95B96F9; Mon, 18 Feb 2013
 04:22:57 -0500 (EST)
In-Reply-To: <CAByu6UWO=kUOvJ_YcPG9bo+XVZ5hSxRQpyEaUMcVxa=sXt_EMw@mail.gmail.com>
 (Thibault Kruse's message of "Mon, 18 Feb 2013 09:26:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C86EDF02-79AC-11E2-9960-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216450>

Thibault Kruse <tibokruse@googlemail.com> writes:

> Whenever a command description involves "<branch>" this can, depending
> on the command, refer to
> 1) a name that, when prepended with "refs/heads/", is a valid ref,
> 2) a name that, when prepended with "refs/heads/" or "refs/tags", is a
> valid ref,
> 3) a name that, when prepended with "refs/[heads|tags]/", or unique in
> "refs/remotes/*/" is a valid ref
>
> Now in the docu I don't see a nice distinction between 1), 2) and 3).
> I could work on a patch if someone
> tells me how to clearly distinguish those cases.

It is _very_ true that we do not give strict distinction in many
cases in the SYNOPSIS section.

It is clear that (1) should use <branch> or even <branch-name>.
"git checkout master" and "git checkout head/master" mean very
different things.  The former is the "git checkout <branch-name>"
case---checkout the named branch and prepare to grow the history of
that branch.  The latter is "git checkout <committish>"---detach the
HEAD at that commit, and even when the committish was named using
the name of an existing branch (e.g. "master^0" or "heads/master"),
prevent future commits made in that state from affecting the branch.

I am not sure why you meant to treat (2) and (3) differently,
though.  Care to elaborate?

And there is (4) that is not in your list.

A name that is not a local branch name (i.e. no refs/heads/$name)
and that there is only one ref that matches refs/remotes/*/$name,
such a name is special-cased in "git checkout $name".  But I do not
know it is worth giving a name to such a narrow concept that is only
used for a single hacky special case.  Whatever word you invent and
call such a name (perhaps "remote branch name"?), you would need to
repeat the first three lines of this paragraph in the description to
define that word anyway.

Outside "git checkout", we historically deliberately stayed loose in
an attempt to help beginners by avoiding <committish> or <ref>, when
most people are expected to feed branch names to the command and
used <branch>.  I am not sure if it is a good idea to break such a
white lie just to be technically more correct in the first place.
It needs to be done with care to avoid making the resulting text
harder to approach for beginners.
