From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/9] Add column layout skeleton and git-column
Date: Sun, 15 Apr 2012 22:38:09 -0700
Message-ID: <7v3984z16m.fsf@alter.siamese.dyndns.org>
References: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
 <1334314481-14470-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 07:38:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJedm-0007CJ-7q
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 07:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab2DPFiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 01:38:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab2DPFiM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 01:38:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A15AC7816;
	Mon, 16 Apr 2012 01:38:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P2+OlZf0Ywkt
	w8w7XWkky1xY9z8=; b=h9rnm7mVwWRaanbuNVF3CvH819uCQGDyW7OGKQ6ZxdST
	hc/+0jVIdkHEbn0w7i1mjzyCS3aiQmge0PgetSpXiOFoZXldYf6nf52gP5tCvbag
	iuNDOxyfgEDl5WcPDazCYCAMHZqFY1/Z9qJPy184M9VI0LEp+CW+usMKz9YgrRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jpVc54
	eKSIYNlK1V2zQztksHo5mDib4Vi3HDBLD3rvv7jWd0SFBXeaq8wnS2qmoHXV/ekH
	ORGdKAdaHtDZJsYIMHSF/3otrfCz0i562BX8nfK8q91xiIHnM1Zf0j8PRnk8G8b5
	kBeBaLjVFLAydNi7mecPDXQuI3Icr8wQbLUuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A3657815;
	Mon, 16 Apr 2012 01:38:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E925E7814; Mon, 16 Apr 2012
 01:38:10 -0400 (EDT)
In-Reply-To: <1334314481-14470-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 13 Apr
 2012 17:54:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A636C4E-8786-11E1-8F92-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195598>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static int column_config(const char *var, const char *value,
> +			 const char *key, unsigned int *colopts)
> +{
> +	if (parse_config(colopts, value))
> +		return error("invalid %s mode %s", key, value);
> +	return 0;
> +}
> +
> +int git_column_config(const char *var, const char *value,
> +		      const char *command, unsigned int *colopts)
> +{
> +	if (!strcmp(var, "column.ui"))
> +		return column_config(var, value, "column.ui", colopts);

I do not think there is anything that reads column.ui from a configurat=
ion
file (or "git -c column.ui") in this step, but later patches seem to us=
e
it from their configuration callback (e.g. git_branch_config()) and at
that point you will segfault because you ignore the case where value is
NULL.

> +	if (command) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		int ret =3D 0;
> +		strbuf_addf(&sb, "column.%s", command);
> +		if (!strcmp(var, sb.buf))
> +			ret =3D column_config(var, value, sb.buf, colopts);
> +		strbuf_release(&sb);
> +		return ret;
> +	}

This whole thing looks overly wasteful.  How about doing it this way?

	const char *it =3D skip_prefix(var, "column.");
        if (!it)
		return 0;
	if (!strcmp(it, "ui"))
		parse "ui";
	else if (!strcmp(it, command))
		parse "command";

and make the third parameter to column_config() be without the constant
prefix "column."?
