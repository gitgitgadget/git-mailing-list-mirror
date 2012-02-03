From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 13/13] tag: add --column
Date: Fri, 03 Feb 2012 15:30:25 -0800
Message-ID: <7vhaz7lcku.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:30:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSaO-0000uN-L7
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab2BCXa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:30:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312Ab2BCXa1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:30:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DE36F66;
	Fri,  3 Feb 2012 18:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9V7nkce6F2hK
	jBV1D7ZiC21r7/4=; b=MsMPEVidlL8dqnoEez+f7GNBTSlqGepSh+dzS6JbZYE7
	kiMA2KrKtWeC7DveAG2MdNicHyLnqeiAv/7sJU8DTCbEOWYphRN39D6/MSPDxtj5
	b9GY792VxKqxkjh83yT1+Jr1+ekG/ht7HsNgaAUAam4JcFEzcuFMpJTVLh6ehK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pBkMFt
	rBzd3AAWGC1dr5TFVuFYE1Phm6AK1BFShpgPS3IeD6GaY5pXP41ZKq5UxpbXLmCv
	Dbirs89rH+NhWG21LLe8RK7LrAz2D07Ty5/cVbtneq9xpbxy3EVcXvIMVCYdtVTH
	V86V2VPix77fym52eWnRqrKbJdQ/B06KpvTJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4F36F65;
	Fri,  3 Feb 2012 18:30:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E66C86F64; Fri,  3 Feb 2012
 18:30:26 -0500 (EST)
In-Reply-To: <1328276078-27955-14-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D786DE4-4EBF-11E1-AF71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189830>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -421,6 +428,8 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  	};
> =20
>  	git_config(git_tag_config, NULL);
> +	if (!colopts)
> +		colopts =3D git_colopts;
> =20
>  	memset(&opt, 0, sizeof(opt));
> =20
> @@ -441,9 +450,19 @@ int cmd_tag(int argc, const char **argv, const c=
har *prefix)
> =20
>  	if (list + delete + verify > 1)
>  		usage_with_options(git_tag_usage, options);
> -	if (list)
> -		return list_tags(argv, lines =3D=3D -1 ? 0 : lines,
> -				 with_commit);
> +	if (list) {
> +		int ret;
> +		if (lines =3D=3D -1) {
> +			struct column_options copts;
> +			memset(&copts, 0, sizeof(copts));
> +			copts.padding =3D 2;
> +			run_column_filter(colopts, &copts);
> +		}
> +		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
> +		if (lines =3D=3D -1)
> +			stop_column_filter();
> +		return ret;
> +	}
>  	if (lines !=3D -1)
>  		die(_("-n option is only allowed with -l."));
>  	if (with_commit)

The patch is surprisingly small, which is a good sign.  The same commen=
t
to the silent suppression "branch -v --column" applies here to "tag -n"=
=2E
