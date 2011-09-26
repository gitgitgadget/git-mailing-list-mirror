From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Mon, 26 Sep 2011 16:49:31 -0700
Message-ID: <7voby6zwxg.fsf@alter.siamese.dyndns.org>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
 <20110925094822.GA1702@myhost>
 <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
 <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Kvb-0002h2-9Q
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab1IZXtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:49:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab1IZXte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:49:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A874B5602;
	Mon, 26 Sep 2011 19:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HP5hu3ceJ1woo3n6dKD3xYasEro=; b=c4Lrb0
	HJJN7aR0uE/68twizswNXmwHAow/0lgDZ13sJJo55cE4uS4PoSc3gugSra+1IcOs
	z3oFtNUYHwnJXjrn4SQ/ygTt3aT1AQaSrkYLofPpk7SHrD8syEqoJvBYNwmXsTRn
	46qmrNsZ/qDot1tiGUcnvHpeQRTKmJLLIAQDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUmPFfwPSs645yXItLWG3PP4okjffT+y
	6jqwYaFUPMH9B56b1KTyCYrYgqp5aTUfb05xM7+HQNMD6t+GxqL8rrfbvMsVdE6q
	kTay7tqA6j9Tl+NdVSEK435swIQHi5qovBkNp+YmxEwQw5QhG6n8Cap8M/ki9eN0
	lr1HxrDwr8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1145601;
	Mon, 26 Sep 2011 19:49:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 323AB55FC; Mon, 26 Sep 2011
 19:49:33 -0400 (EDT)
In-Reply-To: <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com> (Sitaram
 Chamarty's message of "Tue, 27 Sep 2011 05:14:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EFEFD2E-E89A-11E0-962C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182194>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>> In that case (if "non-existent-ref" was indeed non-existent, and not just
>> pointing at a dangling commit), I would say the post anything hook should
>> not be called for that ref. These hooks of course need to run if there
>> are _other_ refs that were updated, though, to handle these _other_ refs,
>> but I do not think they should be told about the no-op.
>
> Question is what happens if none of them existed.  It's a difference
> between not calling the hook at all, versus calling it with no
> arguments/empty stdin (as the case may be) -- which would you do?

In case it was unclear, I was trying to say the hooks should not run with
empty input.
