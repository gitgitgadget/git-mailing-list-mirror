From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t4255: test am submodule with diff.submodule
Date: Mon, 29 Dec 2014 07:42:01 -0800
Message-ID: <xmqqiogu1n06.fsf@gitster.dls.corp.google.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
	<1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 16:42:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5cSV-0004yb-Nz
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 16:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbaL2PmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 10:42:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751866AbaL2PmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 10:42:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B29E42811D;
	Mon, 29 Dec 2014 10:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QlbKKquxwYwjGOxxZzzEGP0PZQo=; b=V6IZkZ
	22gYNYZBQPZkghSqRC4rG8xBN0/I8X1A8Blll66dPqK4W9KQ8N9xxZVAbnFjRaGZ
	dRgnmpBbpggyaNW/30gSf0pPqQmNljCehjvMhogWuqyGcBNihu2/djV6z27p4wtn
	wp9aSmHXNwtkE4FP9HvLUQP4+QiyotkmviHUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GqKPPDqNB1a2SlyqEwuqXSfFulIZ4qhc
	bnQ0YL2eSLLEZWAFkAgjzx0cjeR166W6RcEVSbh9xS9IeWy0McAPOPE/bdKq44yv
	SakbUJAWh3zFlst4MU61LuzX7EcnQfuhwmIcVhFzhalxBjBObceFZwSocCwTdpgJ
	s14xKh436CM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA0DD2811C;
	Mon, 29 Dec 2014 10:42:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 150772811A;
	Mon, 29 Dec 2014 10:42:03 -0500 (EST)
In-Reply-To: <CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 27 Dec 2014 19:37:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C23B8EC-8F71-11E4-940E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261862>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       (git am --abort || true) &&

Why (x || y)?  Is 'x' so unreliable that we do not know how should exit?
Should this be "test_must_fail git am --abort"?

>> +       (cd submodule && git rev-parse HEAD >../actual) &&

"git -C submodule rev-parse HEAD >actual" perhaps?

>> +test_expect_success 'diff.submodule unset' '
>> +       (git config --unset diff.submodule || true) &&

I think test_config and test_unconfig were invented for things like
this (same for all the other use of "git config").
