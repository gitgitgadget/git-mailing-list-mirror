From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 28 Jun 2013 15:41:34 -0700
Message-ID: <7vvc4xluxt.fsf@alter.siamese.dyndns.org>
References: <20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130628080953.GD2232@serenity.lan>
	<7vli5up2tq.fsf@alter.siamese.dyndns.org>
	<20130628174252.GF2232@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jun 29 00:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UshMQ-00034E-Rd
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 00:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab3F1Wlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 18:41:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab3F1Wlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 18:41:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F572C5FF;
	Fri, 28 Jun 2013 22:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=progYO2H0U4tezkAx6WdeZQEFRU=; b=jWnyeH
	0okYs8sS22AxT3AuYiHKZ6dTvcLqfZNLLGgBnDKh98RHaMW1ZSNO8kxjqy7nSL4Q
	fxABNOhIlJ5t9P/qjz7C9KcZ4AVz6q4xcxaCEOu9MQEnivwzrDtRSOpORXet/o9b
	xd+WELjlRonE+NsF7FucTAU8FuP+JLPwAJAV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYQOq5hJcaLWQnEqWO0ED6Tzv80cZaT6
	ExvBb9vwiHB83cLNTAMMbFk39gka4etQJrnJzyGnL+01eOjD6N61wGqGU14/fKt/
	bQWsbHP1ipttn5Xw0VwABV4ENnF7tQZccPbSsW7QROg3Fx64SVJ1hiHu+xGcFn0N
	eZBIQOioqVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE252C5FD;
	Fri, 28 Jun 2013 22:41:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CC672C5FC;
	Fri, 28 Jun 2013 22:41:36 +0000 (UTC)
In-Reply-To: <20130628174252.GF2232@serenity.lan> (John Keeping's message of
	"Fri, 28 Jun 2013 18:42:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3B00F90-E043-11E2-BACA-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229246>

John Keeping <john@keeping.me.uk> writes:

>> Here, "git pull . branch1" is merely saying "I want to integrate
>> the work on my current branch with that of branch1" without saying
>> how that integration wants to happen.
>
> The change that I think is important is that the "bring my branch
> up-to-date" operation should force the user to choose what to do if the
> branch does not fast-forward to its upstream.  If that was spelled "git
> update" then having "git pull" perform a merge would be fine, but we
> spell this operation as "git pull" so the change needs to happen there.

I am not sure I quite get what you want to say with "git update",
and I am not sure if I necessarily want to know---I do not think we
would want to add yet another command that DWIMs for certain _I_,
that may not match newbie expectations.

> I don't think "git pull remote branch" falls into the same category as
> plain "git pull" so I'm not convinced that defaulting to merge there is
> unreasonable.  The original message about this [1] did talk about only
> "git pull" with no arguments.

If you want to limit the scope to only "git pull" (without any
command line argument), I actually do not have strong preference for
or against it either way.  Perhaps a follow-up patch to be squashed?
