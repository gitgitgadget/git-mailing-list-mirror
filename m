From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] log-tree: make name_decoration hash static
Date: Tue, 26 Aug 2014 12:25:49 -0700
Message-ID: <xmqqr403hx36.fsf@gitster.dls.corp.google.com>
References: <20140826102051.GA4885@peff.net> <20140826102353.GB25687@peff.net>
	<xmqq38cjjgjp.fsf@gitster.dls.corp.google.com>
	<20140826174336.GA17101@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:26:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMMNa-0006kn-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 21:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbaHZT0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 15:26:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61721 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbaHZTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 15:25:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19B6D323D3;
	Tue, 26 Aug 2014 15:25:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zinn02ksglQVwTnMru7zbp5jZBY=; b=GxI6kv
	Kg2MJZcpaEvWx6I9z9UUyHeQIr0Lxfu7IV4j2XYh6tDoSFCKzVr/pXBaeFiN+H0z
	A/XFyGohsFXMTeRYVAfI85LjWDRLCJsqNxXUx6QRN7C0yvgfNR2LW/EQSTRsv10W
	gcv8DvSQBXZDjtFz0YjocFyjX4WqF1tJ6S8Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ASb4lh3fj9r6i3C0jJtwFp5HDD/4MJ6j
	jnlgu9L7P5XymAgPJHGbwJ4enTyPcOz/LicNQ0XXoKg2Abj1fgUonwV30o94m11K
	KUmoBL+90dYPvU+eTPDtZRdFNYvX+a8JAbfVQS9082fI0I+IcuhsMIER6yXxJ1XV
	SUyZRjS+oKY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A914323D2;
	Tue, 26 Aug 2014 15:25:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F3E1F323C8;
	Tue, 26 Aug 2014 15:25:50 -0400 (EDT)
In-Reply-To: <20140826174336.GA17101@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 13:43:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA34B406-2D56-11E4-BEF9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255935>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 26, 2014 at 10:40:10AM -0700, Junio C Hamano wrote:
>
>> I may have called it lookup_name_decoration() to match, though, if I
>> were doing this patch ;-)
>
> Hmph. I called it "get" because that was the opposite of "add" to me,
> and I was matching "add_name_decoration". Of course, in the regular
> decoration code, the add function is also "add" and its opposite is
> "lookup". So mine is gratuitously different. I do not mind if you adjust
> while applying.

I do not care too deeply either way, either ;-)  I just thought that
sharing the verb with the underlying function being wrapped would be
more consistent.

I wish we used lookup vs get more consistently, though.  One should
mean "give us if we already have one otherwise fail" while the other
should mean "give us one, or create one if there isn't yet".

Unfortunately lookup_commit() and remote_get() both do auto-vivify X-<.
