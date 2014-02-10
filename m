From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Ignore trailing spaces in .gitignore
Date: Sun, 09 Feb 2014 20:07:07 -0800
Message-ID: <7vd2iv8vbo.fsf@alter.siamese.dyndns.org>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 05:06:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCi8z-0006yZ-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 05:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbaBJEGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Feb 2014 23:06:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbaBJEGo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 23:06:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5076B6CF;
	Sun,  9 Feb 2014 23:06:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nFpbLUsDEX7T
	/AQKVtFn1RS/iEQ=; b=qBsedzFhs9B7cuAcl44Jn2fchZ6r5guAToImaKMtpR7f
	dGR/z6XX/mcV04osCMYWWK/ScWeQNSjY54jSG6HCUhWOgqR/VGZQuJkTbz2iBYAW
	Mml6Yx0nL2czD6WQrl6AVpYlbsoIWoC8MFhY5QQJMBuGrqh7rAfAjNqjoknwsjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nq9jNS
	AH334UExHrwdg93jKKZGSF62WQOjiKZySgSlMDWiXbnQU4VQjhvYO/UTdHXF1Jw3
	qpBze105kYGq50CNSoGrtlvYo4pXo6CQF97UbgWKEED07tstcXdfGMN0tDsB+kkO
	2T44M56yl6cwlq0JiLSY2271WODJGlPzmL+WY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CD146B6CE;
	Sun,  9 Feb 2014 23:06:38 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A4866B6CC;
	Sun,  9 Feb 2014 23:06:37 -0500 (EST)
In-Reply-To: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 8 Feb
 2014 15:10:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: BC803EFA-9208-11E3-8C02-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241899>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Trailing spaces are invisible in most standard editors (*). "git diff=
"
> does show trailing spaces by default. But that does not help newly
> written .gitignore files. And trailing spaces are the source of
> frustration when writing .gitignore.
>
> So let's ignore them. Nobody sane would put a trailing space in file
> names. But we could be careful and do it in two steps: warn first,
> then ignore trailing spaces. Another option is merge two patches in
> one and be done with it.
>
> People can still quote trailing spaces, which will not be ignored (an=
d
> much more visible). Quoting comes with a cost of doing fnmatch(). But

Hmph, sorry but I fail to see why we need to incur cost for
fnmatch().  We read and parse the file and keep them as internal
strings, so your unquoting (and complaining the unquoted trailng
spaces) can be done at the parse time, while keeping the trailing
spaces the user explicitly told us to keep by quoting in the
internal string that we eventually feed fnmatch() with _after_
unquoting, no?

Puzzled...
