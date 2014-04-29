From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tagging  a branch as "not fitted for branching" ?
Date: Tue, 29 Apr 2014 10:43:24 -0700
Message-ID: <xmqqeh0gkp4z.fsf@gitster.dls.corp.google.com>
References: <535E4507.2070805@gmail.com>
	<xmqqoazlm3ji.fsf@gitster.dls.corp.google.com>
	<535F56A2.9020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:43:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfC47-0004rz-BU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933911AbaD2Rnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Apr 2014 13:43:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbaD2Rna convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 13:43:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B95681BAA;
	Tue, 29 Apr 2014 13:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d6UAdE3YJY/n
	U1bISu+I61095Rk=; b=eOHz4kmX9DBCAEszN3fjspf2S2oMu3NRlhmRoCJ074jn
	zcySTl0MgX5nX9hERJyr/mT361/pP7E1HY/QtEMXEDgLoRvG6SSh3Xwwhjkoqi1G
	s4LLBmIS+tx69i+ZcW25ThhlddoYWO8OVlHr/+UAdqyOj2M/hebCgtvJTLgmjnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hiNSYr
	EQlSghljVeSytbDOGMOf7oPN/9oGT3JPPuURF5/bhehRjz2D41Y1P3191t7oj+GM
	c7tFDjl3s0CIWz2QzHc1PBNzEeyFveRW2KibHMNT6H/5zXV0hjrLcdzVBRthbhiT
	KHk9wgqVaGZJLGkPQ0IlRBapv5CcExDzPzqIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1AD681BA9;
	Tue, 29 Apr 2014 13:43:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D225381BA4;
	Tue, 29 Apr 2014 13:43:26 -0400 (EDT)
In-Reply-To: <535F56A2.9020900@gmail.com> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 Avila"'s message of
	"Tue, 29 Apr 2014 09:37:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C4D2E6A2-CFC5-11E3-9DB8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247596>

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> .... In your daily management of the pu
> branch for git, do you have to use the -f flag a lot?

During the day I prepare and validate all the branches I am going to
publish, and at the end of the day, I run "git push" (no options)
with something like this in my .git/config:

        [remote "origin"]
                url =3D k.org:/pub/scm/git/git.git
		fetch =3D +refs/heads/*:refs/remotes/origin/*
                push =3D heads/master
                push =3D heads/next
                push =3D +heads/pu
                push =3D heads/maint

I may be on any branch (not one of these four branches) when I need
to run "git push" before I ran out of the office to catch my bus, so
these explicit "which branches are to be pushed" configuration that
does not change what is pushed based on the current branch is
perfect match for *my* workflow.  I know 'pu' is always forced, so a
single "+" in front of only that one would allow me to rely on the
fast-forward safety for other branches to stop me from rewinding
them.

I could be also using the --force-with-lease support to validate
that the current value of 'pu' matches what I expect with versions
of Git post 1.8.5, but I happen to be the only person who publishes
there, so there is no need for an extra safety.

If it were not for +heads/pu thing, I could even have relied on the
"matching" mode, because these four branches are the only ones I
have there, and most of the local branches I have do not have any
reason to be on that remote repository.

I should caution that the use of "matching" mode or the explicit
"remote.*.push" specifications are not suitable for non-maintainer
workflows, though.  As most of the people are non-maintainers, we
are switching the default to upcoming Git 2.0 release.
