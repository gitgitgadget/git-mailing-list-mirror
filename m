From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] nd/branch-show-rebase-bisect-state updates
Date: Tue, 19 Mar 2013 11:37:18 -0700
Message-ID: <7vhak7i6ch.fsf@alter.siamese.dyndns.org>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 19:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI1Pw-0003qA-VX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 19:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011Ab3CSShV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 14:37:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab3CSShU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 14:37:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D65FCC94;
	Tue, 19 Mar 2013 14:37:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KkGSUpNuobqf
	Tc9DW27ZVXbDQUs=; b=gBeJQ+j9SeLDIpSpkiTpOJUtT/Mhf2vjRRVsdRZUpNdQ
	NDisYg7vKcJSNC6UEybtPLOvl54P69XqlTfQ6wF4hjOri4EArHbESoNdsREOtT2B
	XaZZu+BCItc0Pz9JM34MlgA0Z5V5jUZjRsMeap06rxrfyUuR1L9fQ5n3fUVW6xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xU4FLl
	vZkuGYvvA/kjthigVaL2ljKfZNuK+4NmsD/eTCG33u0jl5UcV6VJQ3Flw/eFsTQH
	rPfUA7QSRoBmysqinWByCemOTtr4goXdayYnKHkRD7rVkciajiUHj4NM1n+TSyvd
	s2a/YjH9P/qTaXg9s9kOE0/TroC/y96ds0myo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51298CC93;
	Tue, 19 Mar 2013 14:37:20 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C402CCC91; Tue, 19 Mar 2013
 14:37:19 -0400 (EDT)
In-Reply-To: <1363174973-17597-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13 Mar
 2013 18:42:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0814E902-90C4-11E2-A689-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218548>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This round fixes the design issue of read_and_strip_branch(), makes
> use of jc/reflog-reverse-walk and performs cheaper sha-1 check on
> detached commits.

I was running "git bisect start pu jch" (jch is a branch I do not
push out everywhere that is somewhere in the middle of
"master..pu"), and then after bisection finished, saw this:

    $ git branch --with 66887099e096f0258a5ef3b1e7458748597bdffe
    * (no branch, bisecting jch)
      nd/magic-pathspecs
      pu

which is obviously bogus.  I only said "I know the tip of pu is bad
and the tip of jch is good".  If anything, I was bisecting the
breakage in 'pu', not in 'jch'.

I think the message should better say "before you started to bisect
you were on 'jch'" or something instead.
