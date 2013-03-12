From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Updating not actual branch
Date: Tue, 12 Mar 2013 09:03:24 -0700
Message-ID: <7v620w8v1v.fsf@alter.siamese.dyndns.org>
References: <006501ce1f24$94636a30$bd2a3e90$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jan =?utf-8?Q?Pe=C5=A1ta?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Tue Mar 12 17:04:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRgB-0004yM-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 17:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702Ab3CLQD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 12:03:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932336Ab3CLQD2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Mar 2013 12:03:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F7F0BB62;
	Tue, 12 Mar 2013 12:03:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BViBDMgJuUB4
	eu4dSe4vZ8OA7LA=; b=kgkCc6JJZsrjDXTUxzGG8pl6Q/Wyv6k9SplJ+XMlUAdg
	VdisjRPwCqT5hQGhyaqbmITtzp9z5W5LjOox+gB2QkQdofgEvKYWqRACxUdv9ZUx
	2SgOk2+8KtCBtISv9I/PeeFGFbGyBmgFlLmKdPb11vaIuPmx7S98jZ6BDOId2tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RegXCQ
	rNhipgiZ/BR9/oj6j8rbjPRSOHpyh2MJl3uWjEvwdvb0U0GGQ/vDB+cJ+fElanEa
	ZpNPgbzcFqCrA2nkD35mFpeAwHG2IWamen6gLjC+RF33Wa3+4nNwLpylT3WNzqSV
	z2QmTMcc/jyf3DrDhXBmtfa15/YjGNRoX94ZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648DFBB60;
	Tue, 12 Mar 2013 12:03:27 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97429BB5F; Tue, 12 Mar 2013
 12:03:26 -0400 (EDT)
In-Reply-To: <006501ce1f24$94636a30$bd2a3e90$@certicon.cz> ("Jan
 =?utf-8?Q?Pe=C5=A1ta=22's?= message of "Tue, 12 Mar 2013 14:22:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FC88668-8B2E-11E2-800C-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217971>

Jan Pe=C5=A1ta <jan.pesta@certicon.cz> writes:

> I have following situation:
>
> A - B - C - I - J                       master
>                \ - D - E - F               feature 1
>                                  \ G - H     feature 2 (working copy)
>
> I would like tu update whole tree with latest changes in master
>
> A - B - C - I - J                                              master
>                            \ - D* - E* - F*                  feature =
1
>                                                    \ G* - H*     feat=
ure 2
> (working copy)
>
>
> Is there some way how to do it without swithing to each branch and up=
date
> them manually?

With these asterisks I would assume that you are rebasing feature #n
on top of updated master.  As rebasing requires you to have a
working tree, so that you can resolve potential conflicts between
your work and work done on the updated upstream, you fundamentally
would need to check out the branch you work on.

In the case you depicted where feature-1 is a complete subset of
feature-2, you are rebasing both of them, and you do not end up in
a nasty conflict, you could start from this state:

    A---B---C master
             \
              D---E---F feature-1
                       \
                        G---H feature-2

update the master from the upstream:

    $ git checkout master ; git pull

    A---B---C---I---J master
             \
              D---E---F feature-1
                       \
                        G---H feature-2

rebase feature-2 on top of the updated master:

    $ git rebase master feature-2

                                G'--H' feature-2
                               /
                      D'--E'--F'
                     /
    A---B---C---I---J master
             \
              D---E---F feature-1
                       \
                        G---H

and finally repoint feature-1 to its updated version:

    $ git branch -f feature-1 F'

                                G'--H' feature-2
                               /
                      D'--E'--F' feature-1
                     /
    A---B---C---I---J master
             \
              D---E---F
                       \
                        G---H

Depending on the interaction between commits C..J and C..F, your
rebasing of feature-2 may end up not losing any of D', E' or F'.
Imagine the case where J was committed on the upstream by applying
the same patch as the original E; E' will become redundant and the
result of your "git rebase master feature-2" may look like this
instead:

                            G'--H' feature-2
                           /
                      D'--F'
                     /
    A---B---C---I---J master
             \
              D---E---F feature-1
                       \
                        G---H

Or J could remove something E depends on, in which case you may have
to add it back with a new commit X when you rebase feature-2, like
so:

                                    G'--H' feature-2
                                   /
                      D'--X---E'--F'
                     /
    A---B---C---I---J master
             \
              D---E---F feature-1
                       \
                        G---H

Because you cannot mechanically decide where the tip of updated
feature-1 has to be, you would need to use your brain to decide
where to repoint the tip of feature-1 in the last step.
