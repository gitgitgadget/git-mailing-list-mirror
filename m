From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Mon, 02 Jul 2012 16:50:20 -0700
Message-ID: <7v1uktyb7n.fsf@alter.siamese.dyndns.org>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlqNw-0003x3-UD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 01:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab2GBXuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 19:50:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab2GBXuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 19:50:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23BD79F68;
	Mon,  2 Jul 2012 19:50:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gBZMcXrrBv5qm8/kpmzrO7nm98I=; b=MThJy+
	YJnuyXNUEqBnxLd0z/FW0LiC4aDqqDhXu/tcj0NvVEuycEFdnPIRWnLhh9RQeBwM
	RkpzhLzH6/skgWY8aqQzCV7chrM5mky5oKtuJBVcZhyqmvgT2pBLrV6YjIAVFx30
	NGgOQp5cZxvN7ou4KRKXWCmi4fza/qDvoKHhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MFC6iaSGQLkUcQs7dvrRXCMK3s8gaIN3
	mcpsRHJEBR9nvJbIKeMWFeFm190zNMhP4e268/D64fLKn4l3/qDuFfI74oXXXhdh
	FA00fi6B+YlO59cyDm6FlDakeV4xB2TOf8aq6q6TBq/6mfeGHiDuuR6Vsim69gPU
	i9Ktb/jnMF8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF309F67;
	Mon,  2 Jul 2012 19:50:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A14F19F66; Mon,  2 Jul 2012
 19:50:21 -0400 (EDT)
In-Reply-To: <m2vci5n5r5.fsf@igel.home> (Andreas Schwab's message of "Tue, 03
 Jul 2012 00:43:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF8A5FC8-C4A0-11E1-9CFA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200890>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Jeff King <peff@peff.net> writes:
>
>> It's very odd for pread to report ENOENT (since it is always operating
>> on an already-opened file descriptor).
>
> It doesn't, but gettext will clobber errno:
>
> 		n = pread(pack_fd, inbuf, n, from);
> 		if (n < 0)
> 			die_errno(_("cannot pread pack file"));
>
> There is nothing that saves errno.  This isn't limited to i18n though,
> any function call in the arguments may potentially clobber errno.

Argh...
