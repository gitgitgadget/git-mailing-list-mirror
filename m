From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 14/25] setup.c: convert is_git_directory() to use strbuf
Date: Wed, 19 Feb 2014 12:17:32 -0800
Message-ID: <xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDaS-0004ue-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbaBSURj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:17:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820AbaBSURh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:17:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C302D6D550;
	Wed, 19 Feb 2014 15:17:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ADmmzkbht2Iw
	wYDB0pwXzmB9jKo=; b=XTLNmMpBSBLfh3hq7W2kQYD9jL4bVs+F8+1e9LVHG8sC
	NVRvQfi9rXE+kFwX46gXMRlJBUWKYG7JhAX+HmCECeLeXsgom+wNn9fTD0Nxx+38
	CZ/MLCRuptKh+QQBEb5DAnZsHIjMbcUvHgnQbyvLVW53exhBLqRLfuo/Ex9W0+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C/qm2M
	yHzraOVMmIVswQypQ5aK9UytMgYJ+6AEebb1IMvbs42D/8jP2xMlcapIxLDzrsIL
	iSVZUEDLXlb+6Si00uGEykJEREdy1oiUiW91v3w080J5pKyMasEFFEsVZUKcQbig
	juCHPiplE/oJTA1cpQCH6tiL6iy5/NfDjwFag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A75476D54F;
	Wed, 19 Feb 2014 15:17:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABFB46D54A;
	Wed, 19 Feb 2014 15:17:35 -0500 (EST)
In-Reply-To: <1392730814-19656-15-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF0C6024-99A2-11E3-B5F6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242403>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

(Only minor nits first during this round of review)

> diff --git a/strbuf.h b/strbuf.h
> index 73e80ce..aec9fdb 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -116,6 +116,10 @@ extern void strbuf_add(struct strbuf *, const vo=
id *, size_t);
>  static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
>  	strbuf_add(sb, s, strlen(s));
>  }
> +static inline void strbuf_addstr_at(struct strbuf *sb, size_t len, c=
onst char *s) {

Please have the opening "{" on its own line.

Surrounding existing functions are all offenders, but that is not an
excuse to make it worse (cleaning them up will need to be done in a
separate patch).

> +	strbuf_setlen(sb, len);
> +	strbuf_add(sb, s, strlen(s));

I am not sure addstr_at() gives us a good abstraction, or at least
the name conveys what it does well not to confuse readers.

At first after only seeing its name, I would have expected that it
would splice the given string into an existing strbuf at the
location, not chopping the existing strbuf at the location and
appending.

> +}
>  static inline void strbuf_addbuf(struct strbuf *sb, const struct str=
buf *sb2) {
>  	strbuf_grow(sb, sb2->len);
>  	strbuf_add(sb, sb2->buf, sb2->len);
