From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 21:40:51 -0700
Message-ID: <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 06:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RICNB-000461-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 06:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab1JXEky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 00:40:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1JXEky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 00:40:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BCA05D15;
	Mon, 24 Oct 2011 00:40:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5fs+CzNe6LqxQ04bMcyhkx4cbrk=; b=fDaN7e
	vSu90gIaUqoEjBYz4bkQzbwJY/I2ju5EhHENvSr88iI9yP6CYx8PZIn0HVimhnaI
	ffd4aXpxvUlyRnGjhPZc9gLt6mntOd0d4MYoE3aIjeFW6IwE07Ip2T+ccnVyEPhR
	dVhk3QXFe8w802Jpfmawl6BWSIhGSVm0AQ+LU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wV9WQt2CMUvHfKFMGLGnrSR4BmBJ/sZP
	Upt9QygXQejD1ZK0wxZ0wKtmVY9mOmETtj1z7lABzX6vfn/xJKRfTZ5EQE2oyHAz
	lAjL9o6VfADABheD4RDr45ax3nNd6XCf6zBbsewaI5skhErenIszey5fmbM++XOi
	4c2nXsp4x+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A705D14;
	Mon, 24 Oct 2011 00:40:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 809B35D13; Mon, 24 Oct 2011
 00:40:52 -0400 (EDT)
In-Reply-To: <7v39ej5uqb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 23 Oct 2011 13:16:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AA2B842-FDFA-11E0-BAE9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184150>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But as Duy mentions, we have an encoding header. Shouldn't we treat it
>> like binary goo until we do reencode_log_message, and _then_ we can
>> break it into lines?
>
> That's sensible. If we go that route, I think the "one allocation of
> separate struct commit_buffer pointed from a pointer field in struct
> commit to replace the current member 'buffer'" is a reasonable thing
> to do.

Having given that "sensible" comment, I am not convinced if this is worth
it. We are talking about what is left in the ephemeral COMMIT_EDITMSG by
the chosen editor, but are there really editors that can _only_ write in
UTF-16 and not in UTF-8, and is it worth bending backwards to add support
such an editor?
