From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/3] bisect: rewrite `check_term_format` shell function in C
Date: Fri, 13 May 2016 11:01:10 -0700
Message-ID: <xmqq60uhalcp.fsf@gitster.mtv.corp.google.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-3-git-send-email-pranit.bauva@gmail.com>
	<xmqq37pmdhtk.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPP+w4BOU+jKSRqGLBx-1f9JtZCq5bj-kkg4-Yw_omeswg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 20:01:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1HOz-0001Ke-0a
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbcEMSBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:01:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751312AbcEMSBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 14:01:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE3511A3E0;
	Fri, 13 May 2016 14:01:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WrRBvf219DaE6eWqRQU8fYyXktw=; b=ceT+ST
	veX0X2ewTmAoR/H4lsGVHhpzs7b8F53NrPHKTeVnQfMLBNtSDQBZuSvFOqi7CvuB
	FfINGyUUPFCSc04QTPlWzhVr308+lCqSRoix6WRdVtS3ZmpinZYOFRKpOsHmleCM
	jQJAFryxVwQylC03nqgAKBaGnpyrgjH/n8SGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xbnb+mM6Gyt/+QCK5k/lLv0/Y19S8k3a
	2uJe+F3zDyHKGwyj2VbpPqfHlJ5iegXazK9aTaHlcdoy3vrDwgpFiDrhPNHOCIQV
	Q5RMn5sTNB57K4HSrkw2qq3kDVld1BvbYwK79EGByY2K5yNZleo3cv9ePKjB4eCc
	36FXcidXRRg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E40BC1A3DF;
	Fri, 13 May 2016 14:01:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 437ED1A3DE;
	Fri, 13 May 2016 14:01:12 -0400 (EDT)
In-Reply-To: <CAFZEwPP+w4BOU+jKSRqGLBx-1f9JtZCq5bj-kkg4-Yw_omeswg@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 13 May 2016 12:29:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADA3F650-1934-11E6-BACC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294551>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Not just that, it would also be fundamentally more correct as there is
> a difference between " !strcmp("good") " and " strcmp("bad") ".

Not really.  As long as you are in tight control of the callers,
because we'd never call $2 with anything other than good and bad in
the original, there is no deep fundmental difference between them.

It is just "test bad != $2" makes it more clear that we are checking
if $2 is not 'bad', but strcmp(orig_term, "bad") doesn't do so as
strongly as that.

> Will do this change in a separate patch after the dust settles.

Thanks.
