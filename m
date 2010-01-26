From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add xmallocz()
Date: Tue, 26 Jan 2010 12:52:00 -0800
Message-ID: <7vwrz4y4gf.fsf@alter.siamese.dyndns.org>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <19295.21148.182245.516321@blake.zopyra.com>
 <7v1vhczj95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZsOf-0003pz-I5
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 21:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab0AZUwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731Ab0AZUwN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 15:52:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab0AZUwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 15:52:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1260D94265;
	Tue, 26 Jan 2010 15:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QjgZRXoZkL+bKs5YnNKTYqltbQ0=; b=oa38L/
	2plMOH4QoIEANGimdL0vWh1QyqZy5VyqtCHKRTc5wkDCiWUDp6uTqHeoKu0cDOfA
	a/mxNs3JTcCK2pAx/Bff3+iF77oZZwYCG7QQ1/VI/GSUvVLlQlFsuLUd6I9biF70
	vQhuQ2IAzqDvtkpszcu5U1gupdjQ+O5ileXMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOrix7HzEUp608lYKStcpWyqAvVYnDY/
	UpGxksB678zy8DZ3qHwu4DcKs9mgSfaeFuI/lhQalGrPOxfWVB21Lfc9WfpjcerC
	kucXwPZ/dNvYpW9pong5a1mJmuIz1X+AHUX0c5k1TB+sq7P5mlvcXSMh/oCK7y/d
	YFEaxUcV2u4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D14F194262;
	Tue, 26 Jan 2010 15:52:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC76E9425E; Tue, 26 Jan
 2010 15:52:01 -0500 (EST)
In-Reply-To: <7v1vhczj95.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 26 Jan 2010 12\:47\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA15D61C-0ABC-11DF-85B0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138075>

Junio C Hamano <gitster@pobox.com> writes:

> I'd rather see the function lose the NUL termination; if that makes the
> behaviour inconsistent with its name, perhaps it is better to rename the
> function; perhaps xmalloc1() to denote that it overallocates by one?

Actually I take that back---all the callers do benefit from the allocator
giving a buffer that is pre-terminated with NUL.

We can also lose "buf[size] = 0" from unpack_sha1_rest() patch.
