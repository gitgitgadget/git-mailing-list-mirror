From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 04 Dec 2013 14:53:13 -0800
Message-ID: <xmqq38m8jkiu.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
	<xmqqa9ggl6oq.fsf@gitster.dls.corp.google.com>
	<20131204222522.GA16706@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:53:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoLJr-0003Xv-4W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab3LDWxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:53:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434Ab3LDWxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:53:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCCA5779E;
	Wed,  4 Dec 2013 17:53:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hzc3rpHe79R9gFVHB0UPBVp4yLc=; b=RiCa7L
	AonSszmTdDzeWTv0chcDzcJZcJ2ZZHmddGHu0L3wtcHaNmJihJ/xqSOJAGMFa0M4
	2r8eew/WC1ys/Z3580f+uys6MvA2hofm715KtEcEyC5ib0x41v0km91NLlOa7fsx
	GErlLtM/e5biKVd4Sej4zJycpnaF+0BlL/RDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+crWhpx/78Lf3HILpVNoknoh42R+9+n
	VwuGZjM7eITmFPs6gpZ/o73Ax8EsAQT/mfbNa009gRTragK/GfvNhbFTFOyShu22
	nPoYcZwQ38fBcaewK/6YwWj1ClGzLLBdgFNFxRYz7HvDQT8BOQmV4wKOyxZCR7vA
	TKq90eFgufg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D26D5779D;
	Wed,  4 Dec 2013 17:53:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E6105779B;
	Wed,  4 Dec 2013 17:53:16 -0500 (EST)
In-Reply-To: <20131204222522.GA16706@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 Dec 2013 17:25:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD2127B6-5D36-11E3-9E3D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238825>

Jeff King <peff@peff.net> writes:

> The rollout would be:
>
>   1. add contrib/mongoose/*
>
>   2. add test-httpd which links against mongoose, built by default in the
>      Makefile
>
>   3. convert lib-httpd/apache.conf into mongoose config as necessary
>
>   4. convert lib-httpd.sh to run test-httpd instead of LIB_HTTPD_PATH
>
>   5. delete apache.conf, LIB_HTTPD_PATH and any other apache remnants
>
>   6. default GIT_TEST_HTTPD to yes
>
> Step 3 is the part where I would anticipate trouble (i.e., finding out
> that the new server does not do everything the tests expect).

If it involves making things not tested with apache, I'd actually be
less supportive for the whole plan.  I thought the primary objective
was to encourage people who currently are _not_ running httpd tests
by making a lightweight server available out of the box, robbing an
excuse "my box does not have apache installed" from them.

As long as a server supports bog standard CGI interface, smart-http
should work the same way with any such server.  For that reason, it
should be theoretically sufficient to test with one non-apache
server (i.e. mongoose) for the purpose of making sure _our_ end of
the set-up works, but still...
