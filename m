From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Tue, 01 Dec 2009 09:49:01 -0800
Message-ID: <7vzl62zisy.fsf@alter.siamese.dyndns.org>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>
 <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>
 <1254510286-23155-1-git-send-email-nmiell@gmail.com>
 <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com>
 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
 <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Dec 01 18:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWqw-0004Ih-Hw
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbZLARtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 12:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbZLARtS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:49:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbZLARtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 12:49:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17057A3752;
	Tue,  1 Dec 2009 12:49:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xrvdl2GxKyZI
	TQ9/ED3+v+Fj+zQ=; b=jadckC+iMnY0H5crjtFNa+JE5mfVColW8KT01K4WUKEX
	OpUIl/bCyCSK6+2llyy0H+fXytFycE4manfKlAfHBZhymaL7CYR/FFRtQrDfkN4Q
	rmVvWD7ODpUzoQD8eBJRGMGeYG+jQjjEL1ihaPxWY4lBjsRT1YZXRWojjl/lu5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Vndj3G
	8Ea6lcTCSro637TANj5ZhCz1FBiyHreKu+XlQnYw2+hWvJXpkiCRivYYa7GtRwU5
	tM4muW1Ukc6gNXBKfL8grENgYBdNuu70Go6rJSx1OHv/X4HPlPhG9e09OuxzjDXY
	XxHgNOELD8kIhjyNUiLKImWNFdgOy14MXWct0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 899C5A3740;
	Tue,  1 Dec 2009 12:49:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33280A3733; Tue,  1 Dec 2009
 12:49:02 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
 ("Martin =?utf-8?Q?Storsj=C3=B6=22's?= message of "Tue\, 1 Dec 2009
 12\:33\:39 +0200 \(EET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6F36498-DEA1-11DE-9397-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134237>

Martin Storsj=C3=B6 <martin@martin.st> writes:

> As long as the current rpc read buffer is the first one, we're able t=
o
> rewind without need for additional buffering.

=2E.. and if the current buffer isn't the first one, what do we do?

> +#ifndef NO_CURL_IOCTL
> +curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
> +{
> +	struct rpc_state *rpc =3D clientp;
> +
> +	switch (cmd) {
> +	case CURLIOCMD_NOP:
> +		return CURLIOE_OK;
> +
> +	case CURLIOCMD_RESTARTREAD:
> +		if (rpc->initial_buffer) {
> +			rpc->pos =3D 0;
> +			return CURLIOE_OK;
> +		}
> +		fprintf(stderr, "Unable to rewind rpc post data - try increasing h=
ttp.postBuffer\n");
> +		return CURLIOE_FAILRESTART;
> +
> +	default:
> +		return CURLIOE_UNKNOWNCMD;
> +	}
> +}
> +#endif

What will this result in?  A failed request, then the user increases
http.postBuffer, and re-runs the entire command?  I am not suggesting t=
he
code should do it differently (e.g.  retry with a larger buffer without
having the user to help it).  At least not yet.  That is why my first
question above was "what do we do?" and not "what should we do?".

I am primarily interested in _documenting_ the expected user experience=
 in
the failure case, so that people can notice the message, run "git grep"=
 to
find the above line and then run "git blame" to find the commit to read
its log message to understand what is going on.
