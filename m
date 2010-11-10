From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Wed, 10 Nov 2010 11:34:24 -0800
Message-ID: <7veiatht1b.fsf@alter.siamese.dyndns.org>
References: <m3eiatfbg2.fsf@localhost.localdomain>
 <1289407021-30287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, peff@peff.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 20:34:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGRW-0007Zu-46
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 20:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab0KJTeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 14:34:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab0KJTen convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 14:34:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB0253422;
	Wed, 10 Nov 2010 14:34:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Jtj72PEpS2re
	iLD8sHZ6G88tkMI=; b=rfHhelP6Pw8+PXh1QWMuDXKMEH6tJmeEjwsgJ5UI6AAe
	cRGc9HvFSnxF39DRJtc9zNjNH/DQSa07uc4UI1Z9PmFgkyrOYGkr1FCpE81zrXd0
	S4MUk5lwWFn96eY74Fxkgy9f24MD59wSAZ52oMOpXmTgQiMx6iL+GDKk2dneMCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wVaMp1
	KPjKHaDjIfQSzSdiLw63Yqll4xsxg7TZRXlTMoDHcHVv1yAiVwGHPzTpSiWgdKsL
	R4VdHpE5qun6GL8hvNMxHd/Cq/YwWICBMJsownW/3pyxB0fmu0NuIsnCbecVdl7Y
	wxSK5HH9g8NFz4C8+kw3JdAmmnvrUSBCFx4Gg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E0193416;
	Wed, 10 Nov 2010 14:34:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC7E93415; Wed, 10 Nov 2010
 14:34:30 -0500 (EST)
In-Reply-To: <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 10 Nov
 2010 23\:37\:01 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E5A8D14-ED01-11DF-A189-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161173>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  		if (namelen < 3 ||
>  		    name[2] !=3D ':' ||
> -		    name[1] < '0' || '3' < name[1])
> +		    name[1] < '0' || '3' < name[1]) {
>  			cp =3D name + 1;
> +			if (startup_info && cp[0] =3D=3D '.' &&
> +			    (cp[1] =3D=3D '/' || (cp[1] =3D=3D '.' && cp[2] =3D=3D '/')))=
 {
> +				new_path =3D prefix_path(startup_info->prefix,
> +						       strlen(startup_info->prefix),
> +						       cp);
> +				cp =3D new_path;
> +			}
> +		}

What does this new codepath do when we know where the working tree is a=
nd
we are outside of the working tree (e.g. we are looking at the index or=
 a
commit in a submodule from above the superproject)?

What should it do?
