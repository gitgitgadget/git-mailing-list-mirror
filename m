From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git stash list' vs. non-default 'log.date' setting
Date: Mon, 09 Aug 2010 08:02:49 -0700
Message-ID: <7vbp9b96cm.fsf@alter.siamese.dyndns.org>
References: <20100809104056.GJ4612@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 09 17:03:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTtF-0005v3-4O
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 17:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab0HIPDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 11:03:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968Ab0HIPDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 11:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3638CCC649;
	Mon,  9 Aug 2010 11:03:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UEf2aKhwm1hl
	ZbZuW5vUgzTPcAM=; b=ApMXoxXEvENx6LfnenSKBtZZs/KRImXWnWpHWyWarYVj
	8vCglk8iTIr0lAfrEkZEa/ztUOwpPCXxQk5heZyRuRFYfmkdSjZYG64CJoz3ScSZ
	9InMrS4lWDdMf7TfvcXmrCyiQeFIL+VqhJGjRYrrwC60cCONVi9OI/WU2e0bd34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RY9UVc
	HVLPPzoM6ccSWqlP3X9ct0/XP9a7n64rZDEORU+Psad0EcSwHX9PenyiK6VMfqBI
	6T9Qkua11ixKg23m4+AlMg7pDDcynYO1+4R76KGwUm1hAFpO6BIV+Zzu8b7+pv4X
	vVF3m+TRJZlp5vMHhYOtKBfNYtPE3OxKF4ZRE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9916CC648;
	Mon,  9 Aug 2010 11:02:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F621CC640; Mon,  9 Aug
 2010 11:02:51 -0400 (EDT)
In-Reply-To: <20100809104056.GJ4612@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Mon\, 9 Aug 2010 12\:40\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 321C9C8C-A3C7-11DF-B4BB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152974>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Fortunately, fixing 2) is a no-brainer:

I don't think it is a "no-brainer" to "fix" it, even though it may be s=
o
to hack it around.  Having to give "--date=3Ddefault" to "git log -g" t=
o
cause it to show reflog entries in non-date format sounds like a terrib=
le
UI bug to me.  I'd expect

    $ git log -g --date=3Ddefault

to give you the logs in the default date format, overriding log.date, a=
nd
perhaps either of these

    $ git log -g --no-date
    $ git log -g --date=3Dno
    $ git log -g --numbered

to countermand log.date and force it to show numbered entries.

I _think_ "git log -g" uses a hacky heuristics to choose between date/n=
umber
based on how you give the stating ref.  I personally do not like this d=
wim
very much, but it seems to be stable and established by now, so it may =
be
a good thing to use here instead:

    $ git log -g refs/stash@{0}
    $ git log -g refs/stash@{now}
