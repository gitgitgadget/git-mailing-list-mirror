From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: only accept commits from "shallow" line
Date: Tue, 08 Jan 2013 09:27:38 -0800
Message-ID: <7vfw2bfuut.fsf@alter.siamese.dyndns.org>
References: <1357644756-18205-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tscy1-0004n2-0K
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762Ab3AHR1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 12:27:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346Ab3AHR1k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2013 12:27:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 840A2A090;
	Tue,  8 Jan 2013 12:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RyuqAnK3pfow
	hb2g4AOeIr5n/y8=; b=H/inmI01WLamSaxT3jeHsJyHE+/76B5bAOsNECMmVEvo
	EA2CApm05mRNsKMh+9BXwa7Lk1YkjxEqCJF9HoC0defS7MdcxwkiKlCOtgUcE8y4
	h0+OqieLhy5vl36K4qydmn7DAKpYkWKlNZNqiR0HNvm1lLYtPmM07er/PsDs8us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YcQK5r
	UdcIZwgHZT91tMdz575xNPFyilGMVrkNkR7f6C+WN+t9hW2YpInq2Z0h5XP0vinx
	O/WX0X+In6LHwLU9YUWkwa8tsjcpJr3ltdF1nugVMFqTzZ+BmjYFWMptVEJyfKTV
	Y4Nlt30+mG2QW0xOXfzY4SPXnF8OhPiNU+bJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7802EA08F;
	Tue,  8 Jan 2013 12:27:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C84DDA08E; Tue,  8 Jan 2013
 12:27:39 -0500 (EST)
In-Reply-To: <1357644756-18205-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 8 Jan
 2013 18:32:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3B3792E-59B8-11E2-B5D9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212980>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> We only allow cuts at commits, not arbitrary objects. upload-pack wil=
l
> fail eventually in register_shallow if a non-commit is given with a
> generic error "Object %s is a %s, not a commit". Check it early and
> give a more accurate error.
>
> This should never show up in an ordinary session. It's for buggy
> clients, or when the user manually edits .git/shallow.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks. I agree with you that while this is not wrong per-se, this
will not matter in real life.

>  upload-pack.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 6142421..95d8313 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -603,6 +603,8 @@ static void receive_needs(void)
>  			object =3D parse_object(sha1);
>  			if (!object)
>  				die("did not find object for %s", line);
> +			if (object->type !=3D OBJ_COMMIT)
> +				die("invalid shallow object %s", sha1_to_hex(sha1));
>  			object->flags |=3D CLIENT_SHALLOW;
>  			add_object_array(object, NULL, &shallows);
>  			continue;
