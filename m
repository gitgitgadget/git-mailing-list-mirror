From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Finding all commits which modify a file
Date: Mon, 23 Jan 2012 17:40:21 -0800
Message-ID: <7vipk16fp6.fsf@alter.siamese.dyndns.org>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com>
 <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
 <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Groothuis <ngroot@lo-cal.org>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 02:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpVN8-0003oL-0P
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 02:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab2AXBkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 20:40:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327Ab2AXBkY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 20:40:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 888117229;
	Mon, 23 Jan 2012 20:40:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eTUZImawi+dE
	H8T0/YOj9Ge/Qc4=; b=KB1nPrQRm1cocQb/KnZEsIQZFpl8CjIpow+iY8LaQcdx
	IG4U4/PwVBSNxEpvrQ4XFRls4Plew5YgFq6a8BJSFyKdgzdA8vUrf3eLo0/U0vSY
	CDGJzqWM6jb2dzTTW13/41OvI6JZ1koi7X8RlYtxq1y7YbIO+eQjz/45vmGgT6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B2HXHc
	NYW8TOnkTxcvEqwf20PnYPMEXoRUYtl6bZbmtmqHvUBLHOjjJhBpuYhtNjGguvga
	79tncdvc0VZKlRtzWIkqDYDQ0jwxFu8plDNMU3Sbga8CiwTPfGnXLILGJRfUcj0w
	ewR8/alRgmPO+xRRQfh5Ff1q7u/aMEiuqq7D8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACA17228;
	Mon, 23 Jan 2012 20:40:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06A417224; Mon, 23 Jan 2012
 20:40:22 -0500 (EST)
In-Reply-To: <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Tue, 24 Jan 2012 01:58:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61C1619E-462C-11E1-8BA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189035>

Santi B=C3=A9jar <santi@agolina.net> writes:

> diff --git a/revision.c b/revision.c
> index 064e351..db97250 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -492,7 +492,7 @@ static void try_to_simplify_commit(struct rev_inf=
o
> *revs, struct commit *commit)
>                 }
>                 die("bad tree compare for commit %s",
> sha1_to_hex(commit->object.sha1));
>         }
> -       if (tree_changed && !tree_same)
> +       if ((tree_changed && !tree_same) || (!revs->simplify_history
> && tree_changed))

Is that the same as saying this?

	if (!(tree_same && revs->simplify_history) && tree_changed)
		return;

Which reads: unless we find a parent that matches the result and we are
simplifying the history, a child different from at least one parent is
worth showing.

Which makes sort of sense at the conceptual level, but I am not sure if=
 it
is practically useful (the same issue with --full-history that makes
complex history almost unreadable).
