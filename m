From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Fri, 29 Aug 2014 14:56:18 -0700
Message-ID: <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
References: <20140829205538.GD29456@peff.net> <20140829205809.GB7060@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 23:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNU9q-0006zf-0f
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 23:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbaH2V43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 17:56:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63210 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbaH2V43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 17:56:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74EB3361DC;
	Fri, 29 Aug 2014 17:56:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qUosOB34GgXUxC3tGAZZ+2d0Ffk=; b=vB/IW3
	cVwZ5fRuQUvfdX+Y07pRWuj9oYg9RLFiKleZ2a844u4cyxZmSqMkWca3nPRWniaE
	A5z6sXte0GWhSbXBmoNnzZimIscVSI+QbOwIynCKlzMGVH4o1LAbvEopXFidejFb
	opHYoLh5z6pI54SH13bNdLqEy57NZEG4NpIuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ooUiwXg4Alab23ZClRdCJBqWLAcQiV8K
	aiZ9C+9+Gt8d6iz+4wu+D6bSY9W29h7zG6CnNDxbLnALEPBdDHxgtJyv0Lg8p8XL
	TI2ak3iNMAjdVnir0oHLGw6wfA2qdTG/lwj3fC7eC1hqXjC7IckSC3auiEZiGMZL
	XMdazgvnQW4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6AB10361DB;
	Fri, 29 Aug 2014 17:56:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07732361D2;
	Fri, 29 Aug 2014 17:56:20 -0400 (EDT)
In-Reply-To: <20140829205809.GB7060@peff.net> (Jeff King's message of "Fri, 29
	Aug 2014 16:58:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F29C878-2FC7-11E4-8068-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256197>

Jeff King <peff@peff.net> writes:

> If a pack contains duplicates of an object, and if that
> object has any deltas pointing at it with REF_DELTA, we will
> try to resolve the deltas twice. While unusual, this is not
> strictly an error, but we currently die() with an unhelpful
> message.

Hmm, I vaguely recall Shawn declaring this as an error in the pack
stream, though.

> The duplicate base object is not our concern during the
> resolution phase, and the .idx-writing phase will decide
> whether to complain or allow it (based on whether --strict
> is set).

OK.  We still diagnose and just be more lenient without loosening
the correctness of the result, so that would be not just OK but a
very welcome change.

Will queue.  Thanks.
