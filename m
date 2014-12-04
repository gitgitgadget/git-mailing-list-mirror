From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 03 Dec 2014 21:51:22 -0800
Message-ID: <xmqqbnnkufmt.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051911.GP6527@google.com>
	<xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
	<xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
	<20141203232951.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 06:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwPKg-0006Jy-L6
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 06:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbaLDFv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 00:51:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752822AbaLDFv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 00:51:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AB321E39F;
	Thu,  4 Dec 2014 00:51:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xxLhf+YUTIMaaeSV/iM+s8jljE8=; b=PvdmAe
	/80OKdZ5H657b7CC4K01xLEtY6GNKYZu2uIO1sPP1ywAb4uuFc/q0dEEL1+6vLrR
	yHH+Ijuyk34Ih81OCfeThkogd59zhS0mwcan1fuk2bKA32mVbCzECU/vN8hb+jwa
	9fHIZt0yp9KAMwVNVoy4Vk1HJr5fcnk9FI4Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L8SuRDYGUEPGJlEdT0Fj7ze4QNYe+sUC
	iiS1MEIVPpjMSKXmeflz9j3HyzAiRBZTokTU7/YiLjszGaAnSXVC8zUQsFK6r7ln
	GzHoBEve0LdG92ExkPm3OJm7A9uN4DROJG+i+GcJ7UT497/yGaHhwp4BSnJ51ryw
	W+scRwpa/5o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 015021E39E;
	Thu,  4 Dec 2014 00:51:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FB381E38E;
	Thu,  4 Dec 2014 00:51:23 -0500 (EST)
In-Reply-To: <20141203232951.GJ6527@google.com> (Jonathan Nieder's message of
	"Wed, 3 Dec 2014 15:29:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9443BFBA-7B79-11E4-B388-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260727>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I tried to merge the 14-patch series with obvious fix-ups after
>> dropping the rerere abortion change you sent separately and in
>> duplicate and also dropping sb/copy-fd, but I've ran out of patience
>> with this step, at least for today's integration cycle.  Should we
>> also drop jk/lock-ref-sha1-basec-return-errors topic as well?
>
> I don't mind adding it to the series....

We may want to see it done the other way around, though.  That is,
to allow the pack-refs race fix, which was reviewed and has been
cooking, graduate without having to depend on this API rewrite, so
that we may be able to merge it down even to v2.2.x maintenance
track.

Thanks.
