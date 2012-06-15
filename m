From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] cherry-pick ignores some arguments
Date: Fri, 15 Jun 2012 08:03:51 -0700
Message-ID: <7vaa04d3c8.fsf@alter.siamese.dyndns.org>
References: <20120614114415.39cbb64c@chalon.bertin.fr>
 <1339691389.4625.9.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:04:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfY47-0000oL-4O
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757033Ab2FOPDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 11:03:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757012Ab2FOPDy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 11:03:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8AA285B2;
	Fri, 15 Jun 2012 11:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LaBdbcWarxnm
	tyYoD1vj8DSxqcc=; b=auQB7lDemI3WQpT4w+eShx6gUQvavhVPeL8Z0o8uWBwZ
	VvEztR19GQhX1L9dbRCMlyiJwn+XOGHNp3VSde4mAEpUO0H0YXBzHkST860qIVpw
	GBVlTBmM0eLhlgPep3RlIvM+iuF4mW/G8l6jY4lQN58T0L7Fs4FGuzKaKAGmZ3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bdpeEe
	FEbp8v6dz3LUOe5Cde1aYwVxkbsfWkrRugfq4Fy8TVgwzg5wT0kw+f+Fn6p8sc1V
	Wh1pmP3+jNN2b1azl2wLnfVTbcgFFEr0gF8DFJgvuVasjVOj2j9rx8R11jRPCm5T
	it+aEVxXZPwoaMAjLxnu88h7UkQ+fIPjGyCOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFB5D85B1;
	Fri, 15 Jun 2012 11:03:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F30F85AF; Fri, 15 Jun 2012
 11:03:53 -0400 (EDT)
In-Reply-To: <1339691389.4625.9.camel@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 14 Jun 2012 18:29:49
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 525D1514-B6FB-11E1-8278-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200058>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Thu, 2012-06-14 at 11:44 +0200, Yann Dirson wrote:
>> Hello list,
>>=20
>> I just did a "git cherry-pick AAA BBB..CCC" using 1.7.10.3, and was =
surprised
>> that only the BBB..CCC range got picked - AAA was silently ignored.
>>=20
>
> There is no way to know whether this is a bug without knowing how AAA=
,
> BBB and ccc are related? From the names, can we assume that AAA is a
> (grand)parent of BBB? If that is the case, cherry-pick is behaving as
> expected.

That is correct from the "rev-list" point of view.  The request is
telling us, by having BBB on the LHS of ".."  (which is the same as
saying "^BBB"), that nothing that is an ancestor of BBB should be
used, so if AAA happens to be behind BBB, it won't be picked.

In the context of "cherry-pick", "show", and "format-patch",
however, "I want AAA and things *between* BBB and CCC" is not an
unreasonable thing to ask [*1*].  You may be trying to port the
feature implemented on your 'master' branch by commits in the
consecutive range BBB..CCC to your 'maint' branch, but the
implementation may happen to depend on an unrelated fix AAA that
also is on your 'master' branch that came before BBB.

It's just that the existing "AAA BBB..CCC" syntax is *not* a way to
ask for that semantics, as it has an established "rev-list" meaning
you explained.  Obviously you could say

	git cherry-pick AAA $(git rev-list BBB..CCC)

to get that semantics, but it is a mouthful to say.

I am OK if somebody comes up with a different syntax to allow users
to say "I have multiple range expressions. Please grab sets of
commits from them *separately*, and give me a *union* of them".

It is OK to add such a feature---it will have to be a lot more
expensive from latency point of view (i.e. such a query cannot
stream and always have to be "limited" in rev-list sense)---as long
as such a change will not hurt performance and semantics of simpler
cases.


[Footnote]

*1* I've said this a few times here, but the way "show --do-walk"
walks the history is an ugly hack that merely happens to appear to
work sometimes but is done in a wrong way.
