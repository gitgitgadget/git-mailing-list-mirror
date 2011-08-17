From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: decorate grafted commits with "grafted"
Date: Wed, 17 Aug 2011 11:48:43 -0700
Message-ID: <7v8vqreuwk.fsf@alter.siamese.dyndns.org>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 20:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtlAZ-0006JT-1l
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 20:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab1HQSsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 14:48:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab1HQSsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 14:48:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA6E53C7A;
	Wed, 17 Aug 2011 14:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AIDj6zPo48Ot
	Vj5dHvK3E828k0c=; b=qllbperAghMMG0iPdsHgoEEulTOWHARexord/cvcBSB+
	pkCg3gDnxRp7oeg1g2Z6paHDcrjA3sW7UL2OaUO4lOm0Kr1UkHFrzz2YMYBb2+f+
	VNqmWof4yTyR891taxbJKDbCGpAomkLzq6KF+AGjppwJTXXlbkhF9ZndB0Pj6e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TO7YVf
	qzoDG06UfnK3Z5muWZo+cOHM2e/XgCiMWuX4iKq4jSg8r4WOWgVHylmfgmF92ouV
	xMibV/C7B74ZXZ6Dd3u9HTJdZm40C2FquI1NizQrwNxyzsPFw8dOPSpNxt2E65bB
	VXmzp+DacMpbyEXr0uJeN4E+u6RpYzOV1iYlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C19743C79;
	Wed, 17 Aug 2011 14:48:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B4D43C78; Wed, 17 Aug 2011
 14:48:45 -0400 (EDT)
In-Reply-To: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 17 Aug
 2011 22:02:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89161580-C901-11E0-8B2C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179527>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -638,6 +640,9 @@ int log_tree_commit(struct rev_info *opt, struct =
commit *commit)
>  	log.parent =3D NULL;
>  	opt->loginfo =3D &log;
> =20
> +	if (!commit->parents && lookup_commit_graft(commit->object.sha1))
> +		add_name_decoration(DECORATION_GRAFTED, "grafted",
> +				    &commit->object);

I am not very enthused about this change.

We have already looked up the commit when we parsed it, and then we aga=
in
have to call lookup_commit_graft() which would yield false for most of =
the
commits?

Does this work with replacements and shallows, by the way?
