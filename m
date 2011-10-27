From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pack-objects: rewrite
 add_descendants_to_write_order() iteratively
Date: Thu, 27 Oct 2011 15:13:49 -0700
Message-ID: <7vty6uxeua.fsf@alter.siamese.dyndns.org>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
 <1318915284-6361-4-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 00:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJYCz-0004aJ-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 00:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab1J0WNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 18:13:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab1J0WNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 18:13:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 722016413;
	Thu, 27 Oct 2011 18:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gL2cGt4CpQMDqBR8tJhkU1HHODQ=; b=U5L7is
	lhrq5vImOLhQ4irHs+BI2Yxo9zIHpDeXvlvjjUE9rE00L8DMqz0ukX/w87tmsZKQ
	7NcyF7bAHC8Dc/G3Dd/RUudmXLdHCL87bjVPOFk8C9hfq0cd02YqJErx64LYatj6
	sXA1il7nZbcCgHTc6npKT8L/H4P1BmzdLUf00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=poOPcBWTHNVBuQKiL+7ppdPviImHXhKr
	BtZieSx5bgfWJrRc3xruVtUIm/evKxJhVMTNgalBCoElpLmwzFQ/WsE1UtwQEb0X
	FAI5MzFlE/q1BXHacPnzKpQgxcz5utBsPyyydql5bF7LO/NQXcCnq3WjsfUOm03a
	cVbyh11QAPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B816412;
	Thu, 27 Oct 2011 18:13:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0017F6411; Thu, 27 Oct 2011
 18:13:50 -0400 (EDT)
In-Reply-To: <1318915284-6361-4-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Tue, 18 Oct 2011 00:21:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F32EE4B4-00E8-11E1-B644-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184323>

Dan McGee <dpmcgee@gmail.com> writes:

> This removes the need to call this function recursively, shinking the
> code size slightly and netting a small performance increase.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Tricky.

As long as this is done after compute_write_order() populates
delta_sibling vs delta link in a consistent way, the new logic should
produce exactly the same result as the original code.

Thanks.
