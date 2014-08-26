From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] log-tree: make name_decoration hash static
Date: Tue, 26 Aug 2014 10:40:10 -0700
Message-ID: <xmqq38cjjgjp.fsf@gitster.dls.corp.google.com>
References: <20140826102051.GA4885@peff.net> <20140826102353.GB25687@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:40:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKjL-0002Lw-VD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbaHZRkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:40:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61739 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbaHZRkX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:40:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC68E323A6;
	Tue, 26 Aug 2014 13:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6V8dSfASZDBpOdWh6bh2n3c5Fo=; b=wyopSu
	iLSjJtHJNwNd/JsYhwbatQrbNUBzEiK+OqG7en33R2aOLB4VsOkULsfTBqBu/JDg
	W0L38arRPbHa29NanN3bmFkqoFRlZ5+vd9UFIwiS6a0H6Rpn13jxkowV9WMmbOKD
	L3YQFBcPx42IjM/yljVaPrk2pwajkjK44z+UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VlZIdW7uTheyfvkl/P5XIRwveaAD8qk2
	GJ5EGyUxZfEWXBi0Y7v5guBCg5oVvBDYJOfCgFEYxQ7S1xmSgzp4u+MsO11YVdso
	iCwX1zfWkB2YJTMRU/puII+JOMHcv0FldieuXhzD8PCvwLiqTuuy66JmFY6ALZm/
	qEPUvph6KP4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A221D323A5;
	Tue, 26 Aug 2014 13:40:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5FC4732392;
	Tue, 26 Aug 2014 13:40:12 -0400 (EDT)
In-Reply-To: <20140826102353.GB25687@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 06:23:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0815C936-2D48-11E4-AB92-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255927>

Jeff King <peff@peff.net> writes:

> In the previous commit, we made add_name_decoration global
> so that adders would not have to access the hash directly.
> We now make the hash itself static so that callers _have_ to
> add through our function, making sure that all additions go
> through a single point.  To do this, we have to add one more
> accessor function: a way to lookup entries in the hash.
>
> Since the only caller doesn't actually look at the returned
> value, but rather only asks whether there is a decoration or
> not, we could provide only a boolean "has_name_decoration".
> That would allow us to make "struct name_decoration" local
> to log-tree, as well.
>
> However, it's unlikely to cause any maintainability harm
> making the actual data public, and this interface is more
> flexible if we need to look at decorations from other parts
> of the code in the future.

I didn't think we want only-bool version, but it is nice to see it
explained well.

I may have called it lookup_name_decoration() to match, though, if I
were doing this patch ;-)

Thanks.
