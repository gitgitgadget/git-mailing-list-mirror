From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 13:48:51 -0700
Message-ID: <7vpqhzxpsc.fsf@alter.siamese.dyndns.org>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014192741.GA13029@sigill.intra.peff.net>
 <7v7h47z5i0.fsf@alter.siamese.dyndns.org>
 <20111014203438.GA15643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 22:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REogc-0003qk-8a
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 22:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab1JNUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 16:48:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34199 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab1JNUsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 16:48:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E874A75;
	Fri, 14 Oct 2011 16:48:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Esu2Q0wJD5FoWdFHR81M5EtGWY=; b=CSTMkZ
	JObWl66JbW95GkZ7tQblDhaE5mvoX5yVdqFACKEo8eBZjb2BuOJrC5x9Z7/Bhr+w
	7YHlLoVgbX+jKrzxSr2yKIHrJNBejeTFLJ1wlSHfao1VfsDFS1XRWpm3sEXUQue0
	hU+W6gq/Ojep84wEqVIxjLApLhMHZgNSLbHYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JcSQB3nzMAv6IdIXRUxmRQzzqTJSbBpt
	0CQM1oCzPmnaeViYjQ48Gbr8fOuNIvOK/p8kQYkXCUFVuWO1Qedm+NdiP2BvRCUc
	qmodcr9kH/1wTwSHuqt8v+4YPYk+qPbFsM/NwbJXYsyt3a9fo0OhCVIx4ADYL9f9
	uQHWWCT4rSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C4714A74;
	Fri, 14 Oct 2011 16:48:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CC424A73; Fri, 14 Oct 2011
 16:48:52 -0400 (EDT)
In-Reply-To: <20111014203438.GA15643@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 14 Oct 2011 16:34:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECDC41DA-F6A5-11E0-A56E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183607>

Jeff King <peff@peff.net> writes:

>> It would have been a better split to have the 1/2 patch to support both
>> informative and uninformative errors, with the default to say "access
>> denied", and 2/2 to flip the default to be more open.
>
> Isn't that what I did? It was what I meant to do, anyway...
>
> Or did you mean the options would have been better worded as:
>
>   --errors={terse,informative}
>
> or something similar?

Nothing that elaborate.

Supporting --no-* variant even when the default is already no will allow
people to prepare their daemon invocation command line beforehand to ensure
that they won't be affected to a more lenient default that may or may not
come in the future.  That's all.
