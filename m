From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] sh-setup: make die_with_status clear GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 09:37:21 -0700
Message-ID: <7vwqpr5q9q.fsf@alter.siamese.dyndns.org>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
	<1371557670-12534-7-git-send-email-artagnon@gmail.com>
	<7vbo738na9.fsf@alter.siamese.dyndns.org>
	<CALkWK0kE1g5k=TxJCBQoHi+o7SZD5skQ2s6utxEgeuK=_C9ULg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyuV-0001Zz-39
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933090Ab3FRQh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:37:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933022Ab3FRQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:37:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B971A295C4;
	Tue, 18 Jun 2013 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EDhQpMMJGNYFyR6guzW7nAk02AQ=; b=f2lOr3
	v/FcVYCvhtmnMAHENeGHozbeoXeU+KwTsPqimAPjxJovvJ23LCtE48yIeCsIE4Q7
	Kdojlvt/u3h+tnQ8obulmM9gK/CEWY6Vwwga46U23ee2OoE9KTrG9EozgPfzHZzZ
	NzPBocJ4RtPVSj0ZNfIXh3CizO9tK5FZrep2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAK0w5bffzegi4IFckOHW+DToaUyLDpn
	9jbE3Mzts2AjBaP1KKstpTKpFkPbs8+bYI4Db06kN20kxlPSTclLSSpHx48T73NX
	q/BlmRnkzTtEyrCeomQxgjzbNJWoyMxA60akg8hFQVDw0IHcXObxBEZMxT9Q+Mgi
	0z6qQ95/dfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF4A295C3;
	Tue, 18 Jun 2013 16:37:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18500295C0;
	Tue, 18 Jun 2013 16:37:23 +0000 (UTC)
In-Reply-To: <CALkWK0kE1g5k=TxJCBQoHi+o7SZD5skQ2s6utxEgeuK=_C9ULg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 21:17:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A1A8672-D835-11E2-8C3F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228268>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Please excuse my stupidity and drop this patch.  

Heh, we always have brain-fart every once in a while.  Your
stupidity is always gladly excused ;-)

> I got mislead by your SQUASH??? patch which took care to set the
> environment variable and call checkout in a subshell.

To some, we could have done

	ENV_VAR="$ENV_VAR: some other string" command

but there were uses of "output" shell function in some instances,
and

	VAR=VAL shell_function

does not work, so that was the reason why

	(
        	VAR=VAL; export VAR
                shell_function
	)

form was used.
