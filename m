From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Wed, 16 Feb 2011 11:07:29 -0800
Message-ID: <7vei77kdce.fsf@alter.siamese.dyndns.org>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
 <AANLkTinsvfXjVhJfLDeZ+g4skev6bBmJgByyxXW7eO39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpmjA-00011b-5C
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab1BPTHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 14:07:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab1BPTHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 14:07:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B33F93205;
	Wed, 16 Feb 2011 14:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yk2922L4Y3kS
	LWXNP2XtFalBRDY=; b=MwGSmo+eRF0fZDit4eGDVwAZhRIL7FGDXQFP10dIev4K
	bgKfjonyfHpeu3nysL6uaRWWTLaarLsTgFNcz+s1zPTfWbNEaBE6nwclQ+1b7UWS
	X25hFiJcj902Y07FY9yVizE45EJrQ02RxdbHcQItpwrDq514ii0vc4Lck4tSfEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eTsv9Y
	HP03WDgMtPBseW2ux1Mhgk+sZE8EWANI4V5FsrnSm+DuDfqHGmS0IuuP21SZztHf
	6d9nUNscCRrbEbcha+nYW6tVQtdxmPxi7zHiiB6wIC0fnPt77Irr7ifajNs1FPvZ
	FumOPpNrdUWYetd9i9sjHBp1hw/wka1Hq89r8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 724D13204;
	Wed, 16 Feb 2011 14:08:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCBF13202; Wed, 16 Feb 2011
 14:08:38 -0500 (EST)
In-Reply-To: <AANLkTinsvfXjVhJfLDeZ+g4skev6bBmJgByyxXW7eO39@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Wed\, 16 Feb 2011 14\:22\:04
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D39010E-3A00-11E0-9C82-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166988>

Santi B=C3=A9jar <santi@agolina.net> writes:

>> +    oldremoteref=3D$(git merge-base $curr_branch $oldremoteref $(gi=
t
>> rev-list -g $remoteref 2>/dev/null))

Yuck; the entire set of commits that appear in reflog can be quite long=
=2E
What will happen when this exceeds the shell command line limit or when
you get E2BIG from execve(2)?
