From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] convert: Use the enum constant SAFE_CRLF_FALSE.
Date: Thu, 01 Apr 2010 12:53:42 -0700
Message-ID: <7vaatnosop.fsf@alter.siamese.dyndns.org>
References: <cover.1269860022.git.grubba@grubba.org>
 <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
 <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
 <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 21:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxQSj-0006uh-6H
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 21:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431Ab0DATxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 15:53:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab0DATxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 15:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD5ABA76D7;
	Thu,  1 Apr 2010 15:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Wms1G3vbk4N
	0SCVfPGY0A5bP10=; b=joh1kQ9d+3vdngrRq/YOLpWdkw+WIcl+IEJHC7g3DmS0
	WRsi0ajeRmAewDy27JXcve+A63+Xb1R4OLxCqHeAbUZmrB/JphxxFp3nXoW//ogP
	D5cZYh8f093eLDfJ3K8IIG7GaF8VjQ8o9PXbU3cjuiNkCoO4/u5B0l6F5MzukY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j6gmdv
	XDh8dS5+dlj43wju0aZtVLEZoj/kVznX+UuhN0B66g3J80jb2kBFebvNZdXDSh6C
	njOK7RsLgnUzcfbqqrDTUBdpNN+SNf8FP9VV5IV1Lw8W9izcxxEiDm22c/l18UcH
	W0Wtxx3ujLuvYbUQVY2TEOqzq2H2nUv1MK8D4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7E8A76D5;
	Thu,  1 Apr 2010 15:53:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0799EA76D2; Thu,  1 Apr
 2010 15:53:43 -0400 (EDT)
In-Reply-To: <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
 ("Henrik =?utf-8?Q?Grubbstr=C3=B6m=22's?= message of "Mon\, 29 Mar 2010
 13\:28\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 48A9D704-3DC8-11DF-86B6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143743>

"Henrik Grubbstr=C3=B6m (Grubba)"  <grubba@grubba.org> writes:

> A few places used plain zeros as the last argument to convert_to_git,
> instead of the corresponding enum constant.

I have a feeling that you are fixing a wrong problem.

If anything, I personally think that the original that passes 0 makes i=
t
easier to read the callers, and I suspect that the primary reason why i=
t
is so is because SAFE_CRLF_FALSE is grossly misnamed.  X_FALSE makes th=
e
reader wonder "perhaps I can change it to X_TRUE and make something
interesting happen?" but there of course is no SAFE_CRLF_TRUE.

Look at the callee that _ought_ to use the enum constant but doesn't:

    static void check_safe_crlf(const char *path, int action,
                                struct text_stat *stats, enum safe_crlf=
 checksafe)
    {
            if (!checksafe)
                    return;
    ...

The "checksafe" is used to specify "what should be done if it turns out=
 to
be unsafe after inspection", and passing 0 is "won't do anything, so th=
ere
is no point to even check".  Both callers and the callee _know_ that 0
means "don't bother", and thus this callee doesn't bother.

If the constant were renamed from SAFE_CRLF_FALSE to something a bit mo=
re
sensible (perhaps SAFE_CRLF_NOWARN?  SAFE_CRLF_NOOP?), then it might ma=
ke
sense to replace these 0 with symbolic constants and argue that such a
change makes the code easier to read.
