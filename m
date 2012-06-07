From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] exclude: reuse last basename comparison
Date: Thu, 07 Jun 2012 11:40:57 -0700
Message-ID: <7vd35bge2u.fsf@alter.siamese.dyndns.org>
References: <1339055617-23028-1-git-send-email-pclouds@gmail.com>
 <1339055617-23028-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Schdp-00049o-TK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 20:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662Ab2FGSlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 14:41:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab2FGSlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 14:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938628CD4;
	Thu,  7 Jun 2012 14:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GPRE5Dfhrmr6
	nN0DdIfWFtG18RY=; b=TSHZ1EODuhwVP2hPZ3oZSYxGhnGyZSqBThN0VYhchLoq
	g+wFLYH5SW2VPpC4PXrYwLbH/He0LWaKE5UTIdC3CwskPeyAo/lxEV87GLw6Rz/T
	zNmnwKshQn9Yp/WYZh3Y/GV00eDoMs7nRoBiKG+F2fDmRtwvBze9SofmfQxt4Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M9RTFx
	mmtAthHN/fEWNNj2GG7Tc6LOjNhHG0B3BFpyY99F3GPDZUz55d9JPGW1ElGCBjZy
	flGpnNcEfvFQI6c2b/ayUl2LH5+lbJKADwfezQwrhiYJ4GkIHbyR9BZdjAZHbDdo
	EyoMmMykGH/GxyRnUsxY6/E4l8JNZVXOy1+zc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B4568CD3;
	Thu,  7 Jun 2012 14:40:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21ECA8CD2; Thu,  7 Jun 2012
 14:40:59 -0400 (EDT)
In-Reply-To: <1339055617-23028-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 7 Jun
 2012 14:53:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5316906A-B0D0-11E1-8F57-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199435>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/dir.c b/dir.c
> index 94fe9f8..2964076 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -511,6 +511,7 @@ int excluded_from_list(const char *pathname,
>  		       struct exclude_list *el)
>  {
>  	int i;
> +	int last_basecmp =3D el->nr, basecmp_result;

Gcc complains that basecmp_result may be used without initialized in
this function.
