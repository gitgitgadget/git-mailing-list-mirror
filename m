From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Wed, 28 May 2014 12:35:37 -0700
Message-ID: <xmqqegzdd7cm.fsf@gitster.dls.corp.google.com>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
	<20140525053223.5329.28002.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed May 28 21:35:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpjdb-00064v-GB
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 21:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaE1Tfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 15:35:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56727 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaE1Tfn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 15:35:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF90A1BBA2;
	Wed, 28 May 2014 15:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jzmCLoKUZ/UXYSIQeCqh1CPyUYw=; b=GCA9Ws
	e8ptThO0TZjV2GhEv6NT2nE605zG2JiDNtkSTqd8AyAReTINhiu82SOgpbXgD1e7
	hdIfASVvX46PwMWGiIb6IoVZzGQgBvPC6E3RuFiLD+cR73QFuVNU6Y0rOX/dghdk
	z16X81vF7HZk+3E12YlJiufvmhf+Jq8AMYzkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5VL3p11lRjirK30D0i/Fy9iiUID936p
	H+c3uCrpf6HonMZWrl2MaCP7bMd1i4eL6ESIyV0awT6L/N6chjQ1QrcsZdkR4T/+
	HIUh/qtA8a1PHSxE/fxwm1PSjGAHlkpxE1Yxl17vmXPVR+S3cMUsZhE+NhS3upB/
	HJ0GFCBmvZ0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3C761BBA1;
	Wed, 28 May 2014 15:35:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 611DB1BBA0;
	Wed, 28 May 2014 15:35:39 -0400 (EDT)
In-Reply-To: <20140525053223.5329.28002.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 25 May 2014 07:32:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3FBD4A0C-E69F-11E3-ACDB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250321>

Christian Couder <chriscool@tuxfamily.org> writes:

> +The trailers are recognized in the input message using the following
> +rules:
> +
> +* only lines that contains a ':' (colon) are considered trailers,
> +
> +* the trailer lines must all be next to each other,
> +
> +* after them it's only possible to have some lines that contain only
> +  spaces, and then a patch; the patch part is recognized using the
> +  fact that its first line starts with '---' (three minus signs),
> +
> +* before them there must be at least one line with only spaces.

While I agree with Michael on the other thread that we should limit
the syntax and start with ':' only, if you really want to allow
random syntax like "Bug #12345" and "Acked-by= Peff", for which you
have demonstrations in the tests in the other patch, the above rule
should be updated to also allow prefix matches to possible set of
keys defined by the user, so that an existing line that is produced
by your tool, e.g. "Acked-by= Peff", can be picked up as matching
with some token having a key "Acked-by= ".  Otherwise, the input
side of your tool is inconsistent with the output side of your own
tool, and that will make the flexiblity of the output side useless.
