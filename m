From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_color: fix return value for numeric color values 0-8
Date: Tue, 20 Jan 2015 16:36:05 -0800
Message-ID: <xmqqbnltynpm.fsf@gitster.dls.corp.google.com>
References: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
	<CACBZZX5s1rZ3exktbisseJSjF8-0=8ByMpBpARy6h+=iP7wEyA@mail.gmail.com>
	<20150120221447.GB18778@peff.net>
	<xmqqvbk1ypie.fsf@gitster.dls.corp.google.com>
	<20150121000352.GA12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:36:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDjHL-0000s3-3P
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 01:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbbAUAgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 19:36:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751037AbbAUAgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 19:36:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FFD83232F;
	Tue, 20 Jan 2015 19:36:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e/ieSbc8M8lCKZbEvBFqyTJT+kQ=; b=eHeAuh
	5orooxpo56qr/4ubqnGSQudmTK5788kkgdjOWIVpXygF9QE8Ht8IoXyAY6AoI5j3
	lZDlq2Kag8vUN/Mc/t5xTFZ6Rry5iEOZE9YYa9dzwdUAJqP7UWbpO+IqhbGJwc+e
	HChWj00XkR17nKzDb0WOkWGpHBPWoHvglj4uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QRKZ3o3EKtJt5y5/3jGHwJ+qch5IrAKr
	op4yW/KBDAafuRLYF8uavxxi3G+Qi08+5UYguuBeYfpowhAS1KuQvbe9oKgyWevM
	NIUtueWclrzSRQzMbeUFPhvZwAMh+pMADQCgE6Su55WGoG1hZiT2piKXBLyGwWFp
	mkD8GMOvAJ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 948393232E;
	Tue, 20 Jan 2015 19:36:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D8483232C;
	Tue, 20 Jan 2015 19:36:07 -0500 (EST)
In-Reply-To: <20150121000352.GA12543@peff.net> (Jeff King's message of "Tue,
	20 Jan 2015 19:03:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CF58F58-A105-11E4-B961-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262708>

Jeff King <peff@peff.net> writes:

>> Thanks; somebody should have caught this before we applied and
>> merged to 'master', but the process obviously did not work well.
>
> I am not too surprised. The use of numeric values for colors was
> completely undocumented, and we did not have any test coverage for it. I
> did not even know it existed until I started refactoring the function,
> and wondered what was going on (though I did try to preserve it once I
> found it).

I was specifically thinking about the failure of "eyeball test".
I often do "git am" followed by "git show -U20" to check the change
in context, which _should_ have caught the lack of return there.
