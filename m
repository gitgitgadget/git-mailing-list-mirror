From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] optimize path_relative()
Date: Sat, 05 Jun 2010 11:07:19 -0700
Message-ID: <7vaar9z73c.fsf@alter.siamese.dyndns.org>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost> <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
 <20100604074442.GA5117@localhost> <20100605073728.GA19159@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jun 05 20:07:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKxmP-0003Iy-Sv
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 20:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0FESH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 14:07:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0FESH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 14:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 406A2B9B90;
	Sat,  5 Jun 2010 14:07:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hlA251vHkbrx/m0eTIZcvF323Sg=; b=Ttup6ZP7a3Q+M/8WIeGpf3M
	kjywLqjVdAGMy25pyjp66ezDg5FiepgjYeGbNA5+DQmDOS7dy7Cp2hlzw4RDIJv3
	5/xcxV2ljSe+Gb4oDX2DCoP14042mof9iZqh/RCLtA9qw9VkndcCytmhBVQZ1JMs
	/muiPQuRASBzBra/kDJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=q/lW2O9NREHMrdRpYMbRzOhL3reXYnCLjcmrJud9hwppSOpvy
	Y8dEOhgdEGRqA2K7GQ/8dUVHCnoXzaUrCMuHhLwC/xFUB2l4DHZnLBTURUCOwAuI
	mkrOhCzErF8ckjcY+4QgQ6vt995Ejk17OVeciQOM5s/5vGbmVPzq6X9SXA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0141B9B87;
	Sat,  5 Jun 2010 14:07:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34D47B9B85; Sat,  5 Jun
 2010 14:07:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31101616-70CD-11DF-8B0C-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148481>

Clemens Buchacher <drizzd@aon.at> writes:

> Avoid copying to strbuf in case a subset of the original string can
> be returned.
>
> Since the strbuf is no longer guaranteed to be updated, this
> function is different from quote_path_relative(). To avoid
> confusion, do not export it.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

The version of path_relative() after this patch looks much easier to
follow.

I noticed that there is a similar function write_name_quotedpfx() defined
in the same file, and wondered if we can do something similar to avoid the
whole allocation business.  But that would only be a microoptimize useful
for write_name_quoted_relative() and not for quote_path_relative() that
has a lot more callers, so it would probably not be worth it.

Thanks.
