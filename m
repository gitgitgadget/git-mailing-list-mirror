From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Thu, 09 May 2013 23:37:27 -0700
Message-ID: <7vzjw349y0.fsf@alter.siamese.dyndns.org>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McClure <matthewlmcclure@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 10 08:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uagxd-0007Ff-R3
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 08:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab3EJGhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 02:37:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab3EJGha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 02:37:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8441E1953A;
	Fri, 10 May 2013 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gOK6XUDX/S5BxobhiTi/lnRXBqo=; b=u0gcir
	ScPrg07Lu3EVZDwKtb6iNwnnGhdi02S8i4KJzF7rzXoDCIu9KwZ8menBYBAYxI2f
	79YquGM3FpjaWIVBqYxkUOCjRPbM+QQrMsmjMI8/qKpoL6JO5tGsUO5qgUqzZ+E2
	8E11RDlUxq7MrllCTJzyaSz3woOd40ALJKCkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M6oLLrMVPMVfnQFPd0wt32/2m6Sb1fTM
	yMzIVLhM/+TfwaeBRQxImMaR9/mNy/L88HHoSFf4+vmY7VsAgEr7bA44RmT2PrSi
	lxmMqVWNINSGHFcKvjYX9CnC+zfPD2aXz+9QsCcgBabLvLXb3ITnWnbbPikciHMC
	g16ozVGxEug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7692D19539;
	Fri, 10 May 2013 06:37:29 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E703F19538;
	Fri, 10 May 2013 06:37:28 +0000 (UTC)
In-Reply-To: <518C8EAC.6000106@viscovery.net> (Johannes Sixt's message of
	"Fri, 10 May 2013 08:07:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15CEA100-B93C-11E2-BB25-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223817>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/8/2013 18:16, schrieb Matt McClure:
>> That begs a follow-up question. It sounds as though Git will typically 
>> delete unreachable objects. My team often shares links like 
>> https://git.example.com/foo.git/log/d59051721bb0a3758f7c6ea0452bac122a377645?hp=0055e0959cd13780494fe33832bae9bcf91e4a90
>>
>> . If I later rebase the branch containing those commits and d590517
>> becomes unreachable, do I risk that link breaking when Git deletes 
>> d590517?
>
> Yes.
>
> When we explain 'rebase', we usually say "you make the life hard for
> people who build on (published) history that you later rebase". But you
> inconvenience not only people who build their own history on top of your
> outdated history, but also those who operate with (web) links into that
> history.
>
>> What's a good strategy for avoiding breaking those links?
>
> Do not rebase published history.

All true, but I think we could do a bit "better", although I am
still on the fence if what I am going to suggest in this message is
truly "better".

Let me idly speculate and think aloud, "what if".

Imagine that a user runs "git rebase" on a history leading to commit
X to create an alternate, improved history that leads to commit Y.
What if we teach "git rebase" to record, perhaps by default, an
"ours" merge on top of Y that takes the tree state of Y but has X as
its second parent, and "git log" and its family to ignore such an
artificial "ours" merge that records a tree that is identical to one
of its parents, again perhaps by default?  "git log" works more or
less in such a way already, but we might want to teach other modes
like --full-history and --simplify-merges to ignore "ours" to hide
such an artificial merge by default, with an audit option to
unignore them.

The history transfer will not break, as there is a true ancestry
that preserves the superseded history leading to X, while in the
daily use and inspection of the history, such a superseded history
will not bother the user by default.  When the user really wants to
see it (e.g. following a stale gitweb link, or with "git log $X"),
such a superseded side history is still there.

Private history rewriting lets us pretend to be perfect, which is a
major plus in the distributed workflow Git gives us, and such a mode
of operation will defeat that in a big way, which might turn out to
be a major downside, of course.

Also, rebases and filter branches that are done in order to excise
unwanted objects from the history (committed a password in a file,
anybody?) need a way to turn it off.
