From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] status: show more info than "currently not on any
 branch"
Date: Wed, 06 Mar 2013 11:16:54 -0800
Message-ID: <7vzjygpcd5.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 20:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDJqA-0000pb-E9
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 20:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab3CFTRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 14:17:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab3CFTQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 14:16:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A43C1B58D;
	Wed,  6 Mar 2013 14:16:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=omnMI1Z5VZw9
	gAQ/0MUOvvjL0CM=; b=pc92Qj6Y6OltDZ/X+eiKsYyxnHqnnXIbfOSp590cvCwI
	lFouduiKA9ecfWtmS3pw+AoRg9rpP8SFyCwcUugRCCYRDoTGYE+R7jAamz////WC
	Xt9AO8Q/BiEMTdHMK17qcj8m3bgFsicRCFKM0grISBkCs3Y1DvKGflXNEDyklIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q4SV3b
	Zhjyz/4tZs5RHfleqVJtP8X7WbuLgpd5hDaVoFgl2PEWXQN1npGuj2Tr26XVUPjt
	uq4qaHKwBWY1L4qKiwCnoZpQGMQBnNcIKF/qXqdAjGwI9EvaorggSUg2g4uuqoeS
	AC1Nrl+fqoOWE2oIw1niPWDGKzeWsauZ0D9qo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B0BB58C;
	Wed,  6 Mar 2013 14:16:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F101AB57D; Wed,  6 Mar 2013
 14:16:57 -0500 (EST)
In-Reply-To: <1362572482-20570-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 6 Mar
 2013 19:21:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A383DA0-8692-11E2-85B8-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217538>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static void wt_status_get_detached_from(struct wt_status_state *stat=
e)
> +{
> +	struct grab_1st_switch_cbdata cb;
> +	struct commit *commit;
> +	unsigned char sha1[20];
> +	char *ref =3D NULL;
> +
> +	strbuf_init(&cb.buf, 0);
> +	if (for_each_recent_reflog_ent("HEAD", grab_1st_switch, 4096, &cb))
> +		for_each_reflog_ent("HEAD", grab_1st_switch, &cb);
> +	if (!cb.buf.len)
> +		return;

Is this correct?  What if the recent entries (i.e. the tail 4k) of
the HEAD reflog did not have *any* checkout?  Your callback never
returns non-zero, so as long as the HEAD reflog is sufficiently
long, for_each_recent_reflog_ent() will return 0 to signal success,
and you do not dig deeper by retrying the full reflog for HEAD,
missing the checkout that exists before the final 4k, no?

It should be more like this, I would think:

	for_each_recent_reflog_ent();
        if (!found)
        	for_each_reflog_ent();
	if (!found)
        	return;

Using cb.buf.len as the "found" marker may be correct, but I found
it a bit subtle to my taste, without explanation.  Adding an
explicit bit to "struct grab_1st_switch_cbdata" would be cleaner and
more resistant to future changes, I think.

> +
> +	if (dwim_ref(cb.buf.buf, cb.buf.len, sha1, &ref) =3D=3D 1 &&
> +	    (commit =3D lookup_commit_reference_gently(sha1, 1)) !=3D NULL =
&&
> +	    !hashcmp(cb.nsha1, commit->object.sha1)) {

That feels unnecessarily expensive.  Why not hashcmp before checking
the type of the object to reject the case where the ref moved since
the last checkout early?

=46or that matter, does this even need to check the type of the object
that currently sits at the ref?  Isn't it sufficient to reject this
case by seeing if sha1 is the same as cb.nsha1?
