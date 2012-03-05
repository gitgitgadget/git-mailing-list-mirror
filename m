From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Mon, 05 Mar 2012 12:39:36 -0800
Message-ID: <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4eh6-0006yp-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 21:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104Ab2CEUjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 15:39:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039Ab2CEUjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 15:39:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6821172D8;
	Mon,  5 Mar 2012 15:39:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ivaKgFMLUSVC
	fLopCo3sx4sjr2o=; b=dZmgQH/ZRt+yN7boASlJhs6r5HmJCHaxiaSrvGwfmoxp
	xxIWUooucSdc0ldoEh3elrzifwjzwD7MfxNGjIebd3DRSVUy6bMjeE34E4FZQU2O
	MzMR/DAIYm2QFTOutJ71hKcCbl2qQIv8jgbSDTIsANOk5sXHrjiH62IrFgXurEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xm9x1j
	X5ByOWQtQQr+gF4+EjxsOTkIvgmggR33mbdp0za7iRWFuMxP7dkW2WSZj2n8oBc8
	EDIBiDVRdE7qGGp/6ro1G1s37z/PvDMQwJLqlr7h7Xk1fFUOA8zaGMKeNyY5yQ0l
	mBJ12fipQGW6+8gX32+DzjWQbSlbhumeSefYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF7872D7;
	Mon,  5 Mar 2012 15:39:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB42F72D5; Mon,  5 Mar 2012
 15:39:37 -0500 (EST)
In-Reply-To: <201203052039.16893.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Mon, 5 Mar 2012 20:39:15
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 535E7A9A-6703-11E1-A307-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192272>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

Swapping to: and cc: as Torsten is not the primary "guilty party" on
this one.

> t0204 tries to use a ISO-8859-1 locale and expects that characters
> outside the ISO-8859-1 code range are converted in "question marks".
>
> The gettext under Mac OS X ignores the ISO-8859-1 locale and uses
> UTF-8 anyway.
> ...
> Let the test pass when UTF-8 is returned.

This is insane.  Is passing this test *that* important to the point
that you would need to change the passing criteria, instead of
fixing the behaviour of the code being tested?

It looks like these tests prepare *.mo files based on UTF-8 *.po
files, and ask the system iconv machinery to show them in UTF-8 and
non UTF-8 locales.  And the conversion is an impossible one in this
case, as the messages won't fit in iso-8859-1.

Some platforms may be capable of noticing that and fill them with
question marks, and some others may notice the impossible request
but do something other than "question marks", and yet some others
may not even notice iso-8859-1 is requested and spit out the
original UTF-8 verbatim.

I do not see any reason to insist that their fallback behaviour must
be to fill them with question marks.  In other words, I simply do
not see the point of this test and the original "pass runs of
question" to begin with, and this patch makes things even worse.

Why not get rid of this single test that only tries to check the
output for an impossible request?

=C3=86var, am I missing something?
