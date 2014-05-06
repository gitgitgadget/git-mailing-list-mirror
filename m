From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fast-import: how to prevent incremental commit with no changes
Date: Tue, 06 May 2014 12:18:16 -0700
Message-ID: <xmqqwqdyemx3.fsf@gitster.dls.corp.google.com>
References: <20140505115320.395edd2e@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Teras <timo.teras@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 06 22:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whksj-0000Z0-2i
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbaEFTSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:18:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63517 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbaEFTSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:18:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35E001456A;
	Tue,  6 May 2014 15:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XuyEtqsmsP//GuKzYTyFq4+GaQE=; b=ajOGV4
	3nm1NRcZO1i8tygulmE87P0NvVqbggDoE47FdpMjgqMG209TW5NJA08vs3JnWrjp
	mBs7WTFqRNhnK92d3zeif8lxOAY6tPG5jq98gvh/6cAFZct0eMk7YDot75KMF0qF
	Q5yYQhZoJp7j3ktpa/zDXd6UNbhp84O3fvb0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODaSVKV/taAQaJ21zfrRKiIzeqaz6U2z
	xFksiwJT/ZmLM9lHnpqQjz7/jZha3dLOekYnq+UVX7VIAvelXMMDXG7RFJYYCm9L
	grMUFG7kN1S1u8NKXkBoaI/hM5/v5r8KBZ/gkOjaC2RkhUMVczos6mDstLgHXOPd
	VssWlnqE7IA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A21C14567;
	Tue,  6 May 2014 15:18:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFC9614562;
	Tue,  6 May 2014 15:18:17 -0400 (EDT)
In-Reply-To: <20140505115320.395edd2e@vostro> (Timo Teras's message of "Mon, 5
	May 2014 11:53:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DB82A28-D553-11E3-83B4-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248231>

Timo Teras <timo.teras@iki.fi> writes:

> I'm trying to script a setup that would periodically import a tarball
> to git with fast-import. But things do not always change, so I'd like
> fast-import to be able to not do the commit in case there is no change.
>
> That is, I'm constructing the commit with "deleteall" + importing each
> object by mark after that. Now, in case nothing changed, fast-import
> will happily create an empty commit for me.
>
> Would it be possible to add some flag that would make commit fail in
> case nothing changed?
>
> Any suggestions how to do this?

I am not sure if such a conditional logically belongs to what
fast-import does.  Would it be an option for your script to rewind
the HEAD after the import is done and it finds that the tarball did
not have anything interesting new?
