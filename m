From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 12:16:17 -0700
Message-ID: <xmqqmvmn8ttq.fsf@gitster.mtv.corp.google.com>
References: <20160613195224.13398-1-lfleischer@lfos.de>
	<alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
	<alpine.LFD.2.20.1606141245490.1714@knanqh.ubzr>
	<CsLdb3qLMBok7CsLebwX38@videotron.ca>
	<alpine.LFD.2.20.1606141347310.1714@knanqh.ubzr>
	<xmqqa8inaben.fsf@gitster.mtv.corp.google.com>
	<146593150503.20857.6674861809731777501@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Nicolas Pitre" <nico@fluxnic.net>, git@vger.kernel.org,
	"Johannes Sixt" <j6t@kdbg.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:16:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCtp6-0002Gy-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 21:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbcFNTQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 15:16:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751590AbcFNTQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 15:16:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D200820DE9;
	Tue, 14 Jun 2016 15:16:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqnjtjRuww6rceajzFMlpPZSsdk=; b=VVrGbW
	RAt+obVxL+MhWuONCXsFZFgZhtIxhfxfgM/P9KjxhvmvZR0ICTDcO7KDxukESkwZ
	Nrmyn1uIngB90qAR2gwo1bI3gflDMpaikMN9/ciwhKYDVIUuoFm1M7YHnWmF+2i3
	abU8fGsqBBo84W8xyX4LNtx9XF+uX359ypan8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=won72WEVhkOwXdlsjMt0m8EjOShEPJ+0
	2UvxLQAKxVmfA0mSJ0SKPjj4c6WYXxdDFNEkDUpEn4rcnkHP3QJruefKy/HVVDSx
	XTIOfIr6IPpdLxDz4Sblcc/EMAe65ySlwyx4aEUuUojLrZyW9oJ438Ww5XJuDQ4D
	IzoVSZwEUrA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CAF5120DE8;
	Tue, 14 Jun 2016 15:16:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5736420DE7;
	Tue, 14 Jun 2016 15:16:19 -0400 (EDT)
In-Reply-To: <146593150503.20857.6674861809731777501@typhoon.lan> (Lukas
	Fleischer's message of "Tue, 14 Jun 2016 21:11:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 793F532A-3264-11E6-867C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297323>

Lukas Fleischer <lfleischer@lfos.de> writes:

> One possible solution is using strbuf and constructing the message as we
> did before. However, that still relies on fprintf() only calling write()
> once per format specifier. While that is probably true for all existing
> implementations, I don't think it is guaranteed by some standard.
> Shouldn't we always use the stderr stream when printing error messages
> instead, especially when we care about thread safety?

Or you can always write(2) to fd=2 and that is safe, too.
