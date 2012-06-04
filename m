From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -f --autosquash
Date: Mon, 04 Jun 2012 13:05:35 -0700
Message-ID: <7vlik2sv00.fsf@alter.siamese.dyndns.org>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
 <1336820755.3002.11.camel@centaur.lab.cmartin.tk>
 <7vipfyiuv6.fsf@alter.siamese.dyndns.org>
 <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com>
 <7vobpap1gb.fsf@alter.siamese.dyndns.org>
 <CABURp0p+NbYbiEO3n1iwP4jH63CjqvE6zhk6pHFjGU7+N0=vXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Kitchen <kitchen.andy@gmail.com>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:05:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdX8-0004Em-58
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430Ab2FDUFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:05:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab2FDUFl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:05:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE118886;
	Mon,  4 Jun 2012 16:05:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m91m8mz4G9w2RaQBrhvjUJnyxZk=; b=nniarC
	QfkN4IfA671qd3+vUVBuOdp8sLbBkKyg+gxTdNyk+Cm6dMjUbaUWqhqKJylkC8wi
	J2RwrFEvSl/fu/nYX0UVQKGZpeCE21bK/4eE2xINuM1nHNg3NVwKFaaVQVOicRfu
	c1FSbxyzPL8cheIZKW+cOzdZPtQkq+yYtHv5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LdvZ6Ck/vzyBegK8NQUPegiqLZfN10Si
	ZBCtwdvFZoovt6UUEC6haWtQvoYyg8lb9s6omSF5JqdJB1EmV+0pJ4jwnyRl+zfG
	BgpGe6npV70ZEh0XA01nv+6YnzDv42AB9v+T38R6fvkvi6v0QAuWEZOjOGMe2uto
	H1puFW4YUuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269B78885;
	Mon,  4 Jun 2012 16:05:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB2B8880; Mon,  4 Jun 2012
 16:05:39 -0400 (EDT)
In-Reply-To: <CABURp0p+NbYbiEO3n1iwP4jH63CjqvE6zhk6pHFjGU7+N0=vXA@mail.gmail.com> (Phil
 Hord's message of "Mon, 4 Jun 2012 15:44:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7BFEF96-AE80-11E1-A743-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199175>

Phil Hord <phil.hord@gmail.com> writes:

> ...  That both are
> required seems to me to be an embarrassing, historical implementation
> detail.

I do not know if we are discussing the same thing.

There is nothing historical in that "--interactive" is the word used
to tell the command that the user wants to replay commits in an
order that is different from the order they were found in the
original commit DAG.  If you want to tweak the order, you use
"interactive". If you don't, you don't.

There indeed is implementation detail to worry about. The "-p" mode
that is *not* about letting the user modify the order of replayed
commits internally does use the same machinery as interactive, but
that is hidden from the end user (the "implied" value in
$interactive_rebase in git-rebase.sh makes this difference).

But this case is not about replaying the commit without reordering.

If you are proposing to rename "--interactive" to "--reorder" or
something, with a solid migration plan to keep the current users
happy, and possibly are proposing to add non-interactive autosquash
implementation outside git-rebase--interactive.sh, the issue would
entirely be different, but I somehow do not sense that is the
direction in which you are trying to go.
