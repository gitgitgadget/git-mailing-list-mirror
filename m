From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] read_directory(), core.ignorecase and pathspec
Date: Thu, 12 May 2011 09:04:47 -0700
Message-ID: <7vwrhvdhwg.fsf@alter.siamese.dyndns.org>
References: <BANLkTimqJvLoWGxMzeSs9n7LrrLaE-azwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:05:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKYNq-0003DV-O4
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 18:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820Ab1ELQEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 12:04:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768Ab1ELQEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 12:04:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96F694903;
	Thu, 12 May 2011 12:06:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GUmj60O9SIj2i8RU6OHvMf0LOjI=; b=kW/7SH
	99QCtkm9OVzJ1sAeW1Y9P+0jNyQJHr0K0i2RcpgijAfCooM741e7LyOGKdfm7axe
	+jbRrJma2FHLI+nMlf1rM+BTUZSlbGSQMQICdX9wCmcB4TmrO3SP0CeKHPz4AJTS
	PY9bTw19uNKRQcAfFbksnM0JeK/LZQj3KQDGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qDaw6aIw0vpA0Gx1Bq1hCQvU2AwfEspR
	vT88P/if2KuxlYcbp7HF2jnYvgRXxMgoaZCa+Ofd2OexPfIkozKKid5Vw/AyqNCZ
	UqBxIddTQekc5rT0TpqRZB57Y0fzEQIRLb9R/rl4f6dG/wVRznP2INBHPkxc/TWh
	AqFnlUN594c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73D4C4901;
	Thu, 12 May 2011 12:06:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B88B48FE; Thu, 12 May 2011
 12:06:54 -0400 (EDT)
In-Reply-To: <BANLkTimqJvLoWGxMzeSs9n7LrrLaE-azwQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 12 May 2011 20:24:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCA4A8FC-7CB1-11E0-81C0-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173478>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I was looking at how read_directory() uses pathspec, and it seems that
> simplify_away(), the function that cuts out directories early if
> they're definitely outside given pathspec, does exact match (ie.
> memcmp) regardless core.ignorecase. This means "git add -- '*.c'" may
> not work as expected when core.ignorecase is on.

I don't think for '*.c' it would make any difference, but it is very
plausible that 'frotz/*.c' will cull 'Frotz/anything' as "never going to
match".

> The whole simplifying thing in read_directory() will eventually be
> replaced with real pathspec matching as we put more magic in pathspec.

That should be done not "as" but "before". Get the foundation right before
going fancier.
