From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rm: do not set a variable twice without intermediate reading.
Date: Tue, 23 Jul 2013 12:01:33 -0700
Message-ID: <7vzjtd6qya.fsf@alter.siamese.dyndns.org>
References: <1374571162-22881-1-git-send-email-stefanbeller@googlemail.com>
	<7v4nbl86us.fsf@alter.siamese.dyndns.org>
	<51EECFBB.3050406@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 21:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1hqA-0000ao-68
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 21:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab3GWTBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 15:01:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756829Ab3GWTBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 15:01:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB6C33033;
	Tue, 23 Jul 2013 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4teEa3KjFstSTRx9A33tyJ69xY=; b=tiCwwz
	njrdxW5Il3WVtpW0Y6/8ud2kXFPsfBRH5NhslRPLIaUOV+HzCtvrdkK2KJHLHkaP
	f81/sRmGQ+Y+v7PlxLfR1g+zDTdFzQ+rhx1q5Un1PfaB2Otl2fheQe5qS2K64Wtp
	AcTXjkVGW+QCFzjbt+RQ5aE2JnVDmVNNop7fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hSiHcedE+HH835cuvXlIh5GWV06NCgrI
	PNUUYmqlcPt9BK5qD1IpBYcd+HHr2BGHDecuVqKeRYh0UjN9lIkjqPCwWNxsNBkc
	eaB/tpjMzivxNnIJZym/lF+4olCJiJqjNcL19J0TzDtPWibohXkfa0QteV3V9mzE
	Bx/sqJWHZ3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF64D33032;
	Tue, 23 Jul 2013 19:01:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FAEB3302F;
	Tue, 23 Jul 2013 19:01:35 +0000 (UTC)
In-Reply-To: <51EECFBB.3050406@googlemail.com> (Stefan Beller's message of
	"Tue, 23 Jul 2013 20:47:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B9D0826-F3CA-11E2-B1A1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231051>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 07/23/2013 08:32 PM, Junio C Hamano wrote:
>> Interesting. This is ancient and dates back to 7612a1ef (git-rm:
>> honor -n flag., 2006-06-08).
> Originally it comes from d9b814cc97 (by Linus), which introduced:
> +	seen = NULL;
> +	if (pathspec) {
> +		for (i = 0; pathspec[i] ; i++)
> +			/* nothing */;
> +		seen = xmalloc(i);
> +		memset(seen, 0, i);
> +	}
>
> Then in 7612a1efdb0c the second seen assignment was made unconditional.

That is why I blamed the bug to 7612a1ef.  Before that, without pathspec,
directory traversal function were told not to report which ones were
seen and which ones were not by passing seen=NULL.
