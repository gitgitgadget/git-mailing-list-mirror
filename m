From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] commit: turn commit.ignoreIntentToAdd to true by
 default
Date: Mon, 06 Feb 2012 12:03:08 -0800
Message-ID: <7v8vkf7mrn.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUme-00009S-5h
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab2BFUDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 15:03:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab2BFUDO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 15:03:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5BC6A55;
	Mon,  6 Feb 2012 15:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8OEKqGXHBjs9
	ByXpiSI+EZ8QwfQ=; b=LuEkrJOX6yG7bTmdoh0v+9zx6hedSRmeVszk7PagJyBb
	DiM7PnNTioXYKK4banquQS1xKyBzqHWQqKzA45tuPJzdDKmj5v0ApLuIsRqpwYPA
	76ARdIG3EoOS9tOJcCkwCjwlvNPdpFbFImu7TS2MWc0N0EXYU79acMU67IPHDjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NPr2L+
	PfOnlKzuHiVVWrbvIzNDTBqiU3EoKWqtv8B1p4RCXgX2DiDNXes+jEoayqxe56nA
	vP0KGt9PsnL+A852e4xrTkRjzdkRBpHRDE1Uyj4nARMrkH3pluHWTKRwx8ieAB/G
	JVdofPAY/Jb2yEn/I1uM2UvRoP9K+G4VBSNAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 445956A54;
	Mon,  6 Feb 2012 15:03:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1EFF6A53; Mon,  6 Feb 2012
 15:03:12 -0500 (EST)
In-Reply-To: <1328525855-2547-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 17:57:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 996128BA-50FD-11E1-9179-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190092>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> -		if (!set_commit_ignoreintenttoadd) {

Now no warning() is associated with testing of this flag, which means t=
hat
people who didn't get around to read the doc and react to the warnings =
in
the earlier releases will get _nothing_ when the real change hits them?

That sounds strangely bad.  What am I missing?

> +		if (!(cache_tree_flags & WRITE_TREE_IGNORE_INTENT_TO_ADD)) {
>  			int i;
>  			for (i =3D 0; i < active_nr; i++)
>  				if (active_cache[i]->ce_flags & CE_INTENT_TO_ADD)
>  					break;
>  			if (i < active_nr)
>  				warning(_("You are committing as-is with intent-to-add entries a=
s the result of\n"
> -					  "\"git add -N\". Git currently forbids this case. This will c=
hange in\n"
> -					  "1.8.0 where intent-to-add entries are simply ignored when co=
mmitting\n"
> -					  "as-is. Please look up document and set commit.ignoreIntentTo=
Add\n"
> -					  "properly to stop this warning."));
> +					  "\"git add -N\". Git currently forbids this case. But this is=
 deprecated\n"
> +					  "support for this behavior will be dropped in FIXME.\n"
> +					  "Please look up document and set commit.ignoreIntentToAdd to =
true\n"
> +					  "or remove it."));

As this is marked with FIXME ;-)

At this point in the deprecation cycle, "currently forbids this case." =
is
not true at all. "You asked me to punt when you forgot to tell me the
final contents for i-t-a entries, so I am honoring your wish" is what i=
s
happening here.  Perhaps...

	Git currently allows you to set commit.ignoreIntentToAdd to false
        to remind you about the paths you may have forgotten to add the
        real contents to before committing, but this support will be
        removed in future versions of Git.  Set commit.ignoreIntentToAd=
d
        to `false` or remove the variable, and get used to the new
        behaviour, to squelch this message.
