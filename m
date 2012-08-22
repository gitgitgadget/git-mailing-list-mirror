From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support generate poison .mo files for testing
Date: Wed, 22 Aug 2012 04:13:31 -0700
Message-ID: <7vboi3b2n8.fsf@alter.siamese.dyndns.org>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org>
 <1345613246-4053-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 13:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T48sX-0007wx-Lv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 13:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab2HVLNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 07:13:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098Ab2HVLNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 07:13:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DDE77D06;
	Wed, 22 Aug 2012 07:13:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v7iCEiV8ho5L
	v6/h5+zee5WzZsc=; b=dhLmXLVltZ4NDqULPxxLXlTiAt3erOv+N2T44NxhZM6o
	7x9yPIXMdBPwNLE0ep9AaQMRvnIjw8SrYd4yJdxcrXhCh7Rqn6tdnb3bsfOVK6tx
	7QAhH+j3iHO9oic6K277iJeeZoiswqDE6N+DKgqdJcZ/kDPg4ByJqp/AuaxuZgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=phv0gM
	QVy9Dw7hYgwmBJY8pJqlF7fNpEfot9b8GEBY6xV5m9vwgFElrhgP4pVpGLpef3wQ
	HulU9ScXvfX9Zr36xUWXDdNIIIzY7yYmsQPIF3ri24+Ub244ue1FzIhBNbBg/LmE
	zIHv3Uy4GIqTP3biZvl8xU3w1/6U2pHoZZMaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BF6B7D05;
	Wed, 22 Aug 2012 07:13:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B252C7D03; Wed, 22 Aug 2012
 07:13:32 -0400 (EDT)
In-Reply-To: <1345613246-4053-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 22 Aug
 2012 12:27:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68C62668-EC4A-11E1-9165-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204011>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> test-poisongen does a similar job to gettext poison feature except
> that it does it at build time. Gibberish .mo files are generated for
> all supported langauges and put in po/build/poison-locale. Target
> "poison-locale" is for this.

What is the significance of this locale being "Gibberish"?
Currently, for any string, we give "### gettext poison ###" or
something but the only thing we care about in the poison mode is
that it is different from the message id, no?  I was wondering if
these phony translations can be something simple like "Add QQ at the
beginning of the message id string" and still can catch mistakenly
marked messages that come from the plumbing layer, or something.

As you have already written a printf skipper that looks fairly
conservative, perhaps I shouldn't be worried too much about it, but
we seem to be spending considerable effort on the "poison", and it
makes me wonder (even though no better alternative comes to mind) if
we could do better.  The reason we do "poison" (be it the current
one or locale based one) in the first place is so that we want to
make sure messages from the plumbing are not marked for i18n, and we
do so by running our test under the "poison" mode that produces
output different from the in-code text that are marked for i18n,
which somehow feels quite a roundabout way of doing so.

> User can run the test with these .mo files by setting POISON_LOCALE
> while running the test suite. User must also set LANG/LC_* correctly
> (and the system is supposed to support that locale).

>  OK let me redo step one. test-poisongen requires libgettextpo. I'm
>  not sure if this library if gnu specific. We may need another flag
>  for it instead of NO_GETTEXT. We don't need a fake language code wit=
h
>  this approach.
	=09
OK.

>  Makefile         |  19 ++++++++
>  t/test-lib.sh    |  10 +++-
>  test-poisongen.c | 139 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  wrap-for-bin.sh  |   6 ++-
>  4 files changed, 171 insertions(+), 3 deletions(-)
>  mode change 100644 =3D> 100755 t/test-lib.sh
>  create mode 100644 test-poisongen.c
>  mode change 100644 =3D> 100755 wrap-for-bin.sh

Thanks.  I suspect two mode changes weren't intentional?

> +static void translate(const char *msg, struct strbuf *buf)
> +{
> +	const char *end =3D msg + strlen(msg);
> +	const char *text =3D "* GETTEXT POISON *";
> +	int text_len =3D strlen(text);
> +	int t =3D 0;
> +
> +	strbuf_reset(buf);
> +	/* preserve \n and printf format specifiers because msgfmt
> +	   barfs otherwise. */
> +	while (msg < end) {
> +		/* printf specifiers and shell variables, it's a quite
> +		   relax check */
> +		if ((*msg =3D=3D '%' || *msg =3D=3D '$') && msg+1 < end) {
> +			strbuf_addch(buf, *msg++);
> +			do
> +			       strbuf_addch(buf, *msg);
> +			while (msg < end && !isspace(*msg++));
> +		} else if (*msg =3D=3D '\n') {
> +			/* we only need to preserve trailing newlines, doing
> +			   more does not really harm */
> +			strbuf_addch(buf, '\n');
> +			msg++;
> +		} else {
> +			strbuf_addch(buf, text[t]);
> +			t =3D (t + 1) % text_len;
> +			msg++;
> +		}
> +	}
> +}
