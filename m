From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Mon, 12 Jan 2015 16:11:06 -0800
Message-ID: <xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
	<xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
	<xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
	<20150112231231.GA4023@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:11:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAp4w-00061h-H9
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 01:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbbAMALW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 19:11:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751587AbbAMALV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 19:11:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 500C32F978;
	Mon, 12 Jan 2015 19:11:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lIMJl8OMobkz/b6gSNji+ffB4dw=; b=hI70K6
	UYG5Z67Q755PszlyvKCwxZ60aGXQl6cSJWhfnd9lWSlVIIfSB1qMiVeo4Cq7r65j
	cCNty2p02WfEqo6/oFFkF87IQH1HqtljSZAENz4i2nUvGvj3aUXQMsd+r5M8RVLO
	z/V5rhjeV0u0IbRk1yBmlm9nmIXXWKXYKPaqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ub5jeGXjrG6Cm8XZC/GOwnPKOJ06MnwC
	4FumVN9IcJK4SABzUFJQySkFxPhAk6ce1eOOnW5KBsomX5zyIs8jV3P+g8A59EP9
	OLF3l56Dmzj5dlA8MY3oSCD2RAKv4WXuXDepYE/+eVFf/fs7drMBDD023/8dxHPk
	/xrdwB36/zk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46C952F977;
	Mon, 12 Jan 2015 19:11:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF8F32F96E;
	Mon, 12 Jan 2015 19:11:07 -0500 (EST)
In-Reply-To: <20150112231231.GA4023@peff.net> (Jeff King's message of "Mon, 12
	Jan 2015 18:12:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ABFAC7A8-9AB8-11E4-8DE3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262309>

Jeff King <peff@peff.net> writes:

> As an aside, I have often been tempted to have xstrdup silently
> propagate a NULL. It would have been the right thing to do here, but
> maybe there are cases where the segfault is preferable for catching a
> mistake early (otherwise you might store the NULL and then segfault much
> later).

Great minds think alike.  The sentence after "but maybe ..." was
what I had in mind as a response in anticipation that somebody might
suggest that; a separate xstrdup_or_null() might be fine, but I'd
rather not to have xstrdup() that is _too_ magical.
