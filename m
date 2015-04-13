From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: implement '--follow' option for `git blame`
Date: Sun, 12 Apr 2015 22:32:33 -0700
Message-ID: <xmqqiod04mq6.fsf@gitster.dls.corp.google.com>
References: <4215491428322362@web26m.yandex.ru>
	<xmqqvbh7baij.fsf@gitster.dls.corp.google.com>
	<209433431.20150410094038@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: KES <kes-kes@yandex.ua>, git@vger.kernel.org
To: Eugen Konkov <kes-kes@yandex.ru>
X-From: git-owner@vger.kernel.org Mon Apr 13 07:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhWzD-0002U1-D1
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 07:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbbDMFcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 01:32:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751107AbbDMFcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 01:32:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEAF23A391;
	Mon, 13 Apr 2015 01:32:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PBWvXj3i+G48sm0nHD/r33riWRg=; b=jVr65G
	PlHWfuNDShRWAB+Udrl2Tp2HCtqKK06NcsVTvJ/MrGGzxbUPIhMSuWawaH41vHCq
	kfRvJWXuuDkPi7mGyGAr0IFyhkrtcse+d2GPOSJp3j59GTAK29/4MJQMI1U/PR9u
	9YDVFsEqXiR31c85RKxRxYLW1muIYADwMTM8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WssL18vON/xevyGO9Qxd0bhtxIW8P+W0
	1XFOeG0KU3zn8KgC79+ZbjLdfAD4VzEtAyWFMsgNKr0+WPK3EQGfMnvRtjQaukU4
	78cpqtM5zMuBkKDXh3r0y9K0iBhEfL3bXeRts/swbF64dw0u6I5m1H/NyK1dCLKB
	ulCXPv6il8o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C81D73A390;
	Mon, 13 Apr 2015 01:32:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B67B3A38E;
	Mon, 13 Apr 2015 01:32:34 -0400 (EDT)
In-Reply-To: <209433431.20150410094038@yandex.ru> (Eugen Konkov's message of
	"Fri, 10 Apr 2015 09:40:38 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CD2FD42-E19E-11E4-A5DD-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267065>

Eugen Konkov <kes-kes@yandex.ru> writes:

> I agree with your complex example.

Note that it is a norm, not anything complex, that we do not rename
a file wholesale.

> But it will be great to guess in simple case, when in version v1.0
> only one file A which were renamed into C half year later.

So you used to have A and somebody renamed that into C in the past.
The content of C in the current version is what you used to have in
A.

What should happen if you also have A, whose contents do not have
any relation to that old A, in today's code?

What should happen if you also used to have C, whose contents do not
have any relation to that old A or current C?

What happens if you added such random guessing and you were not so
familiar with the project history to know these unrelated A's and
C's that used to exist in the past?

Current Git _consistently_ behaves, even in the presense of anything
that can lead to confusing behaviour.  When you ask

    git blame OLD -- A

it does not matter if you have an unrelated A in the revision that
you happen to have checked out in your working tree (i.e. HEAD).
The above command line talks about the old revision OLD and A talks
about the path A in that old revision.
