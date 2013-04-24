From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 14:23:59 -0700
Message-ID: <7vvc7baahc.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7Ae-0003hr-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028Ab3DXVYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:24:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757884Ab3DXVYC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:24:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A18D191DA;
	Wed, 24 Apr 2013 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/nbZr5qjn+O4MH9JHqQj+Hd5SfI=; b=evnJTvWO5of91hyta++Q
	hK5mfVgozDd4x1IufSU7H9QgeQ09kWRAkaJb9FooirHqM+BcQlwEsS5G2v56RvyC
	w5+0mpOWOSYIOUCd2fSW2ekl4MBzrJlLjlvORPD6FELLNRDG9dJaxu+0x1cBU4jq
	4pBxHiOAQqhFMaRfR4UYTBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qURdMDFhr9YZjNgU/GOaldOk1MHn6m0CnUhjEhezfQzse5
	MwFELFkaLG9rxs61DoZFviY07YhdCpAL80HibUGpNzlrTBOg4YyN+vi1H94Zk+uQ
	1J/OeCMsI42pC68IeZjMMUemoiUyZsIq6aWgcgIS66znm8XSEsiKjZZus0b/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2CE9191D9;
	Wed, 24 Apr 2013 21:24:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77FF7191D8;
	Wed, 24 Apr 2013 21:24:00 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47D38FE4-AD25-11E2-A492-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222325>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Sorry I wasn't clear.  A~B = $(git merge-base A B) B to diff and $(git
> merge-base A B)..B to log.
>
> Basically, I want to be able to do git log master~rebase.autostash
> (without having to rebase).

How is it different from "git log master..rebase.autostash"?

    git log A..B

is already a perfectly fine way to spell your "A~B", which is

    git log B --not $(git merge-base --all A B)

when written in longhand [*1*], no?

So I do not think your A~B helps "log".

It does not help "diff" either, because we already have A...B and we
are not going to remove it (people are used to what it means).

So I think your A~B is still a solution that is looking for a
problem.


[Footnote]

*1* You need to understand what merge-base is in order to analyse
    the equivalence of these two.  A..B asks for those that are
    reachable from B that are not reachable from A.  What does the
    other form ask, by saying "ones that can be reached from B but
    exclude the ones that are reachable from any merge base of A and
    B"?

    On the history leading to A, there are two kinds of commits:
    those that are not reachable from B and those that are.  The
    ones closer to A may not be reachable from B but if you dig the
    history starting from A and keep finding ancestors, you will
    eventually hit one that can be reached from B.  Once you hit
    such a commit, everything beyond that point are reachable from
    both A and B.  E.g.

        ---o---*---a---a---a---A
                \
                 b---b---B

    And we call that a merge base between A and B (e.g. '*').  Any
    ancestor of a merge base, e.g. 'o', is reachable from A and is
    excluded from "A..B".
