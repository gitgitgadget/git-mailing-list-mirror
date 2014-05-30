From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 14:13:05 -0700
Message-ID: <xmqqa99z7yxq.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
	<20140530015855.GG28683@sigill.intra.peff.net>
	<CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
	<20140530065737.GA13591@sigill.intra.peff.net>
	<xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
	<20140530170330.GA25443@sigill.intra.peff.net>
	<xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
	<20140530183441.GA3704@sigill.intra.peff.net>
	<xmqqmwdz809b.fsf@gitster.dls.corp.google.com>
	<20140530204853.GA9271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 23:13:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqU74-00014Q-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbaE3VNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 17:13:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65377 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaE3VNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:13:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A32C81AA7F;
	Fri, 30 May 2014 17:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lxxlr7/7efqIKKncojM9PXK+lRY=; b=nPU39l
	ipfNgm84fd/W/4L/bMnzt3PcKDUZIAE1e6hZ8Z1klDOILb7dx73Mkrck1SEGN8Ri
	nFKb0zWA2ps7iMOTDz49uakN9HjcI1La1Pw7noJ0ChYtu30/rO5lQJkuQRRM2R4s
	BRE4d+MsBIt9U8/VSIaT3fh+Ct3ksNA7qvXoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHA2pnS2aUzvG26WfxJrqkLeNm8wLP8s
	/PPcN6AoNebGuztLsx/4RPNqW4eeT01AxLOzsP9C5dHH05ZCewXbO0AS1xDAm6VK
	2l20FQ4yt8tbTl6gWkJKxIRf6W0obKjNUOwCZ6hfR+ol2VbgfFv7yPifDuEFwaqg
	8vsq+2Ee918=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DE9A1AA7E;
	Fri, 30 May 2014 17:13:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F21AA1AA79;
	Fri, 30 May 2014 17:13:06 -0400 (EDT)
In-Reply-To: <20140530204853.GA9271@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 16:48:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31F66ACE-E83F-11E3-ABC1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250485>

Jeff King <peff@peff.net> writes:

> I wonder if it would be sane to remove or quote NULs when attaching the
> buffer to commit->buffer. That would _break_ signatures, but that is a
> good thing. I do not think there is a reason to have NULs in your commit
> message unless you are doing something malicious (or using utf16, but
> that already is horribly broken).

Ahh, our messages crossed.  I do not think we are quite ready to
depart from our traditional position: the payload of a commit object
can be any bytestream, even though we do expect and encourage them
to be human readable text in a reasonable encoding.  And there is no
fundamental reason why we should forbid signing the payload that
happens to be a structured binary blob.

The user may need some way other than "log --show-signature" that
can be used to validate, because "log" itself will be useless for
such a payload with or without signature.  But I think that may be
a more or less orthogonal issue.
