From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual
 C++
Date: Fri, 21 Aug 2009 13:55:47 -0700
Message-ID: <7vr5v4dgz0.fsf@alter.siamese.dyndns.org>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meb9g-0007P3-QX
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbZHUU4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbZHUU4B
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:56:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbZHUU4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A73D032195;
	Fri, 21 Aug 2009 16:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=us73mYauZm51Sq/p8ltpY9iQSDU=; b=ZpnkiC
	2iuRyrwPuoktSUfmRwlLFe989KoCUKjHdnp4VzNDkaYhkoB1zUGgQEgbVP/wSFUa
	kwOTBq/RWZwyZ9heb84/Fw7bYv8k2LnsHm763/EvzmhMBAPQzzIKp9bO+t72sktQ
	r1o2B2OJVZ/jSANOitIn63JoESjGUCIsN/+FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWj4YRBRj89mbc4jkVgHG1Xo2sGh2cyE
	hpd9OpIqWt/V5Ek0gRvUh316MpOOTgTa8I443uWirr7BIegeoq23xsGyb4b4vMf2
	BnOli19bVq7yKDwFbR3FIjErVNUvsxFByiujAjgIMOd+lrCTYEy1zAABPNZJcJlt
	6aba8kz2RZg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F40E32194;
	Fri, 21 Aug 2009 16:55:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C43732193; Fri, 21 Aug 2009
 16:55:49 -0400 (EDT)
In-Reply-To: <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 (Marius Storm-Olsen's message of "Fri\, 21 Aug 2009 15\:30\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05A168F6-8E95-11DE-A670-3142836986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126752>

Marius Storm-Olsen <mstormo@gmail.com> writes:

> From: Frank Li <lznuaa@gmail.com>
>
> The Microsoft C runtime's vsnprintf function does not add NUL at
> the end of the buffer.

This contradicts the way I read the comment in compat/snprintf.c from
f4626df (Add target architecture MinGW., 2007-12-01).

As far as I can see, the correction is about the meaning of the size
parameter to the function, namely, that a broken implementation may
mistakenly think that it was told the maximum length of the meat of the
string to write, and it is allowed to append a NUL beyond the limit, when
the caller actually is telling it the size of the buffer.

So if my reading is correct, it is not about "does not add NUL at the end"
at all; it is "adds NUL beyond the end of given output buffer."
