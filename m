From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Mon, 18 Mar 2013 11:40:12 -0700
Message-ID: <7v38vso8kz.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
 <20130318073229.GA5551@sigill.intra.peff.net>
 <7vtxo8ody3.fsf@alter.siamese.dyndns.org>
 <20130318164950.GA14844@sigill.intra.peff.net>
 <7vli9kocuc.fsf@alter.siamese.dyndns.org>
 <20130318171949.GB15924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 19:40:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHezF-0001Ej-8d
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 19:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab3CRSkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 14:40:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317Ab3CRSkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 14:40:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA9BABDC;
	Mon, 18 Mar 2013 14:40:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eq3LNTVWtF3/XzUyjkR2kqLlTCA=; b=Zhe8J0
	qkwio/h1exO1790IUVAA/x/mXbnBz0XB3GekFH8eXEpnmHiAHFuMnRMAJmkA2YTU
	uKI+Lx4W2RXrOZDqVPPueh9Au9RYFZj3ReGb0vB0kKlbUCaRVg1UpOqkSdqAnk5E
	SRokBGC/+Yo8epJ8yjsexUxbrtzx6DLdnYZ2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQKkzMB30QXz4oQwQxluh7eP0SZecuSO
	MTvJgXBgKtBOpXMdtiBSqdbXEMsJCXsW4Fb5JixZQw+6o3OQ6oRyur65YgktItaG
	ZXn6PvVgXwA77QfYIzx2hMNG1syRJTEnEgLx1VNyqdtYCs1hS8yaNjOypId6ZhYM
	nYHABR9kIrc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80D8DABDB;
	Mon, 18 Mar 2013 14:40:14 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA24AABD6; Mon, 18 Mar 2013
 14:40:13 -0400 (EDT)
In-Reply-To: <20130318171949.GB15924@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Mar 2013 13:19:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 456F7606-8FFB-11E2-A950-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218437>

Jeff King <peff@peff.net> writes:

> I do not see anything obviously wrong in it, though I did not walk
> through all of the ofs calculation to look for any clever speedups.
> However, I think it is clear from the other timings and Ingo's thread
> that glibc 2.11's memcmp does not perform very well on many short reads.
> And sha1_entry_pos will do memcmps even smaller than 20 bytes.
>
> What happens if you do this?

The overall trend is the same.

[without GIT_USE_LOOKUP]
real    0m40.044s
real    0m40.054s
real    0m40.072s
real    0m40.097s
real    0m40.159s

[with GIT_USE_LOOKUP]
real    0m40.257s
real    0m40.281s
real    0m40.311s
real    0m40.366s
real    0m40.407s

I suspect that after the first few rounds the range shrinks small
enough that the difference between a simple "mi = (hi + lo)/2" and
convoluted ofs computation becomes dominant.  Perhaps we should only
do N-R for the initial midpoint selection and then fall back to a
stupid binary search?
