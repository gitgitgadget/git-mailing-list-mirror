From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Wed, 28 Oct 2015 08:48:07 -0700
Message-ID: <xmqq611rm1u0.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
	<xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
	<20151027053916.3030.8259@typhoon.lan>
	<20151027055911.4877.94179@typhoon.lan>
	<20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
	<xmqqfv0wcgzx.fsf@gitster.mtv.corp.google.com>
	<20151028070045.5031.43810@s-8d3a2f8b.on.site.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:48:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrSxT-0007pa-RL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 16:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbbJ1PsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 11:48:11 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755988AbbJ1PsK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 11:48:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC6D023C62;
	Wed, 28 Oct 2015 11:48:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qnDXb/BOnErYsGyjnLAo4x34pMQ=; b=jyDmKr
	prIzpiRzpVfofgn6p7i/eXaH0xUi7MdWBm1KImsdpEZaZKtqRezP4nP+SttNKA2E
	oXjXXxI0ULiALxzlOhBFM5j5Taq5ICoeFzrDQF+9Q+B7ckaQuuJNi55H8h/5khud
	emkD/KsbiVQFJNWe4arg4N8UJpI/qoZ4z4NNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GUazLvQbeKeXx+Vf9ESNCBE+emyhFevZ
	Edae591y3a8ZirIQDciNJ9Rzlj1aDMTfXUZ64XbxpJPMko2VGU4hiEF+dl9UHjU9
	g5MC+egA4an1uoYxGV3piaoo2VQEeA/3Oua0GI2v3ABClcJ2KYWWpkuaP4/63omu
	O0PdAYrDHdQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC5AF23C61;
	Wed, 28 Oct 2015 11:48:08 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3CD5023C5F;
	Wed, 28 Oct 2015 11:48:08 -0400 (EDT)
In-Reply-To: <20151028070045.5031.43810@s-8d3a2f8b.on.site.uni-stuttgart.de>
	(Lukas Fleischer's message of "Wed, 28 Oct 2015 08:00:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48F4EF56-7D8B-11E5-ADB5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280373>

Lukas Fleischer <lfleischer@lfos.de> writes:

> Another patch I have in my patch queue adds support for a whitelist mode
> to hideRefs. There are several ways to implement that:
>
> 1. Make transfer.hideRefs='' hide all refs (it currently does not). The

Hmph, that even sounds like a bug.  parse_hide_refs_config() does
not seem to reject ref[] whose length is zero, and ref_is_hidden()
would just check "starts_with(refname, match)" with an empty string
as "match", so I would naively have expected that to work already.

Ahh, there is "if refname[len] is at the end or slash boundary"
check after that.  You're right--you'd need to tweak that one for it
to work.

>    user can then whitelist refs explicitly using negative patterns
>    below that rule. This is how my current implementation works.

That sounds like a good way to go.

Thanks.
