From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Mon, 24 Jun 2013 10:21:58 -0700
Message-ID: <7vwqpja0g9.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-5-git-send-email-gitster@pobox.com>
	<CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
	<7v7ghkdl2p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:22:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrASu-0008Vf-HE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab3FXRWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:22:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab3FXRWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:22:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45F462B734;
	Mon, 24 Jun 2013 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lZ3DeNRri3vX6IT6YUjQysFpoyg=; b=wOpEpG
	eetYmPAvJ8wD39vshg8RzpX/Ft/IdvBuc0bQGP6PeR/etxaNRAiPf6w+47JOseja
	+PHflpDyKQTpa/TP5pl7B6h2zPzNQgOLuLUPxApNadY9TjjT7mVKV9y1PrT7aTTB
	KxyvHxq3tYpnGFka+dqhD9JfNsS4uCEVllacQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X8god9qT14CQFT2SIttpGsJEqXYo6gmD
	nep3RCefDNnPyf8i8GqNBjk81qtGTvasP3FPpzXoqMej2sDzb44taVFKqFMGMqYg
	rLSMDRB9w4GR0lgldp7l6W0hNpeiEnksB6+gPFRCvm0ywcuZ+pKKxWUKXg24F0NK
	ToZTdBL085Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05DB62B733;
	Mon, 24 Jun 2013 17:22:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48E7F2B730;
	Mon, 24 Jun 2013 17:22:00 +0000 (UTC)
In-Reply-To: <7v7ghkdl2p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 00:28:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94513DEC-DCF2-11E2-B973-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228879>

Junio C Hamano <gitster@pobox.com> writes:

> Johan Herland <johan@herland.net> writes:
>
>>> +       git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
>>
>> Isn't  ${3:-repo1} a bashism?
>
> I do not think so.  But now I looked at it again, I think I would
> use ${3-repo1} form in this case myself.  No caller passes an empty
> string to the third place.

Actually, because the caller blindly does this:

    # $3 = [optional] repo to check for actual output (repo1 by default)
    test_push_success () {
            git -c push.default="$1" push &&
            check_pushed_commit HEAD "$2" "$3"
    }

where it should be doing something like this:

            check_pushed_commit HEAD "$2" ${3+"$3"}

if it wants $3 to be "optional", ${3:-repo1} is needed here to work
it around.

So I'll leave it as-is for now.
