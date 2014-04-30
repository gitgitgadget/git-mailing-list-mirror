From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 30 Apr 2014 10:34:09 -0700
Message-ID: <xmqqvbtqg1ri.fsf@gitster.dls.corp.google.com>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbnvihlny.fsf@gitster.dls.corp.google.com>
	<vpqy4ymlsvy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>, d9ba@mailtor.net,
	jrnieder@gmail.com, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfYOm-0008LE-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 19:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbaD3ReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 13:34:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422723AbaD3ReN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 13:34:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6D717C8D5;
	Wed, 30 Apr 2014 13:34:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G8QExixpKEY5I1QWqjm++vPkMZA=; b=T1viZC
	TrCzPt4Yv7wAaBE7T52hoYQ4AXPfhU6fITNdUdtTXYcXAh+wY1SQeJwZgCgTBPbH
	6ps20rNrvbNwbVGVR8mfmkd7h67MDAb+OdONQ6d1nQlnaIq0VL+C31fzHqnkmXsR
	YUl/4k+LgePBQSOEY81qUVdu1t19GtW3acx80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rtAH3WuhmOuCKU9AzafZdtLttvgAqrD+
	zzn+4ASVLB4aBXMMRH6QZjFOHCahCnodF3khckTQlW0Co+MdAopNw9p5kOjkfBl5
	n+r4Et5UsFarT9m5lNQpyBZ9NDAySzmNmGw8rU13aOFjTgDqFfg7nWWoHi9tvWVV
	OdbREVQBTA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9868F7C8D4;
	Wed, 30 Apr 2014 13:34:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 834C57C8D1;
	Wed, 30 Apr 2014 13:34:10 -0400 (EDT)
In-Reply-To: <vpqy4ymlsvy.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	30 Apr 2014 17:49:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3AC33CA-D08D-11E3-9C33-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247748>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> By default, Git used to set $LESS to -FRSX if $LESS was not set by the
>>> user. The FRX flags actually make sense for Git (F and X because Git
>>> sometimes pipes short output to less, and R because Git pipes colored
>>> output). The S flag (chop long lines), on the other hand, is not related
>>> to Git and is a matter of user preference. Git should not decide for the
>>> user to change LESS's default.
>>
>> Git always pipes its output to less,
>
> Err, no, not all commands use a pager.

Yeah, what I meant to say was that when it is told to use pager
(either by an explicit "git -p" or implicitly with the lack of "git
--no-pager"), it does not count the lines shown to avoid passing
short output to the pager.  "sometimes pipes" sounded to me as if we
attempt to do so and sometimes fail to.  But again, as I said, that
is just nitpicking.

>> I am inclined to suggest queuing it for the first batch after 2.0
>> instead of directly applying to 'master', as we have past the point
>> we can expect to see reports of unexpected fallouts and fix the
>> issues in time for the final.
>
> Fine with me.
