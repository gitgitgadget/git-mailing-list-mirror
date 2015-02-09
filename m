From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/24] untracked cache: load from UNTR index extension
Date: Mon, 09 Feb 2015 14:26:13 -0800
Message-ID: <xmqqmw4mwwl6.fsf@gitster.dls.corp.google.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
	<1423385748-19825-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:26:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKwmb-0008E0-8L
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 23:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760974AbbBIW0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 17:26:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755927AbbBIW0Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 17:26:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A12A837B08;
	Mon,  9 Feb 2015 17:26:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N6vV6qBd5F+E
	I2LIcIcYtv6TazU=; b=vfMrXEzrbPmGRCwgjfTy0+zUIGxzqPiy/8nkO6dbGV2x
	rpdMJPaJz+fHUQ7bUEqUVLIR4QaaU6BLfk3NdDYZGu2UUcn2d3yn4ASaiA7j1+wo
	AP8wv8oBMb2cOhUOXV01p+SBEyDKanOZVKIo9LCBvTid0YmIJ4+UFZUtkKX3j6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fIIV64
	y3MraeD5cERHTeCPqSVWUOBZmJSOLoPsR9zfkBwrw5ZVVnaY+zeaVuVlwtMRKdX9
	b4sWyBnZjAuz3N93sL+Ei1qGfAmuqxABCQsTnRzKz5dRJ8YrqxGNZQe1VKy9xEvg
	z2NT+rvWvYg1xlPr8mgrhKsDCSdpVzAADO3Pc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9804E37B07;
	Mon,  9 Feb 2015 17:26:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E69137B06;
	Mon,  9 Feb 2015 17:26:15 -0500 (EST)
In-Reply-To: <1423385748-19825-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 Feb
 2015 15:55:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8D3FA92-B0AA-11E4-90A5-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263613>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static int read_one_dir(struct untracked_cache_dir **untracked_,
> +			struct read_data *rd)
> +{
> +#define NEXT(x) \
> +	next =3D data + (x); \
> +	if (next > rd->end) \
> +		return -1;

Please do not do this, and instead write them at two places they are
used.  It is not clear to those who are reading the use sites that
this can break the control flow and return to the caller.
