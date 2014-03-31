From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/27] t1400: Test that stdin -z update treats empty <newvalue> as zeros
Date: Mon, 31 Mar 2014 14:48:07 -0700
Message-ID: <xmqqbnwm3uqw.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:48:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk40-0004sO-0X
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbaCaVsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:48:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaCaVsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:48:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7756B79D64;
	Mon, 31 Mar 2014 17:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OgUYNjZSUloWLencXkT0cB+QTGk=; b=Efpfnz
	XhErTNCM0EqEu9VmKbDEGLkSC7Joi51ZkYjFQ81hOj1LA0hPOP8YA1ia5bV9Kr26
	AbyxX2IwF2NIchq0OjeOWO/NYgyl64DSgGVqH1uiV9tM44XPsBDIG3ZDJ44pLkvy
	XDuVqpfjV7PZit80iEnBlTqKyTyrjNnStp/Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dym0vH7hcCqUsydKbbZg31AYHWW3dn9W
	DNslRIGihdOg69ldQTqdDmU4wXZtyRSGPPzeKoiBQuVQFd6J1B650plN9YwyDKYs
	jo5/8HmcpiEG40a7aSS8MYei5hKU8tu4jnQkbWG+Az8n3oej1STwFX+RYwkuvg0/
	iDEkDq3s/4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 658CF79D63;
	Mon, 31 Mar 2014 17:48:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B290F79D61;
	Mon, 31 Mar 2014 17:48:08 -0400 (EDT)
In-Reply-To: <1395683820-17304-14-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 25F3C8F2-B91E-11E3-BE3F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245540>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is the (slightly inconsistent) status quo; make sure it doesn't
> change by accident.

Interesting.  So "oldvalue" being empty is "we do not care what it
is" (as opposed to "we know it must not exist yet" aka 0{40}), and
"newvalue" being empty is the same as "delete it" aka 0{40}.

That is unfortunate, but I agree it is a good idea to add a test for
it, so that we will notice when we decide to fix it.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t1400-update-ref.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index a2015d0..208f56e 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -730,6 +730,13 @@ test_expect_success 'stdin -z fails update with bad ref name' '
>  	grep "fatal: invalid ref format: ~a" err
>  '
>  
> +test_expect_success 'stdin -z treats empty new value as zeros' '
> +	git update-ref $a $m &&
> +	printf $F "update $a" "" "" >stdin &&
> +	git update-ref -z --stdin <stdin &&
> +	test_must_fail git rev-parse --verify -q $a
> +'
> +
>  test_expect_success 'stdin -z fails update with no new value' '
>  	printf $F "update $a" >stdin &&
>  	test_must_fail git update-ref -z --stdin <stdin 2>err &&
