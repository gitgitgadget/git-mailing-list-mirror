From: Junio C Hamano <gitster@pobox.com>
Subject: Re: accessing oldest reflog entry with ref@{N}?
Date: Wed, 19 Jun 2013 11:48:01 -0700
Message-ID: <7vk3lqym1q.fsf@alter.siamese.dyndns.org>
References: <20130619125059.GD20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 19 20:48:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNQZ-0006bo-0a
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 20:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078Ab3FSSsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jun 2013 14:48:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965018Ab3FSSsL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 14:48:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0E429C06;
	Wed, 19 Jun 2013 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=luOVM6ohKHIE
	NMjXIb92YX0J4Z4=; b=un6y8v3VfNDixglnfSNKQzmHuLaUit7Tj/ocdguZcpj2
	gg2gbDx49hFdTnzGLSPAU/B4xqsZOAgGtyW83Xys5Mq8Df3DOGfqkoVotjFQCc6s
	gidoomhEXEHCTMuH8VMLcbWLhhJ+Hcf1SkwW0hkO+ZAfEDJ73xlehR+0kRQ7RYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dnhbWd
	nBAPYbieBFpe2YfbYVw+PmeCmYfNxBvAB9/vwGU/OxB/fOfwQj6GAB2zQoFGZF6/
	wNKYaVJiWMskp5hziYtNyIVNHtg8amv8QVyH/Qvu9Bke+0bM0h2heCztmF8XYDoO
	JNVr7GK9e55doTUqpI3Lthi2tUZsRidtcQszs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE81F29C04;
	Wed, 19 Jun 2013 18:48:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B79429C01;
	Wed, 19 Jun 2013 18:48:10 +0000 (UTC)
In-Reply-To: <20130619125059.GD20052@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Wed, 19 Jun 2013 14:50:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9D193B2-D910-11E2-8769-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228410>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> $ git log --oneline -1 master@{1}
> fatal: Log for 'master' only has 1 entries.
>
> Annoyed, I just copy-pasted the sha and got the job done.
>
> However, I wonder why it didn't worked. 'git reflog' didn't print
> master@{1} or any message for the oldest entry, but I can live withou=
t
> that.

There lies your answer, no?

Each of the log entry records "this was before, and this is after
the change".  ref@{0} reads from the "after" field of 0-th (from the
end) entry. ref@{1} reads from the "after" field of 1-st (again from
the end) entry.  ref@{N} reads from the "after" field of N-th (again
from the end) entry.

Notice that nowhere in the above sequence we read from "before" field.
