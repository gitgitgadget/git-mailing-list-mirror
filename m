From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] receive-pack: request for packv4 if it's the preferred version
Date: Thu, 17 Oct 2013 10:26:21 -0700
Message-ID: <xmqqzjq724hu.fsf@gitster.dls.corp.google.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
	<1380162409-18224-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 19:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWrLB-0003Sf-KM
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 19:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074Ab3JQR00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Oct 2013 13:26:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757365Ab3JQR0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 13:26:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 471394B300;
	Thu, 17 Oct 2013 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rzp8prwWvP0b
	dhAV+3d19VLBkY0=; b=DxGX0czO6Wsjq39EadqUtwF488BEkpEKzImTlKYE/Q+A
	bT3pdA2088yA/FgPiDwkrL6W/dhfBEHdRY1XYJFGZYZiHBm1Lynl/ekqvk/n2m+Y
	xT0Eab9RWRJABolfyD3ZyFS0a0+dYQ8a4woHOLnF71voY/2bbiFwS8rl6SXjzhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JjCfWO
	sTgWGLKwO9UrHaAk7/ZRzu43BLWW4ziMGtohYJjbZmbckMavdNVrr9cvFFDiFyn0
	3olIFar5FJIdvpoKWdo2CyHNbVJAUK2s8KqeeSrxLDbpohE0B3Mca/OjEUExiQpd
	6lzZ0XS++I1xydbGp4GiEgu8MlrDn2dwMhU/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F864B2FE;
	Thu, 17 Oct 2013 17:26:24 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FF5B4B2F8;
	Thu, 17 Oct 2013 17:26:23 +0000 (UTC)
In-Reply-To: <1380162409-18224-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 26
 Sep 2013 09:26:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3ECB50BA-3751-11E3-9DE2-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236301>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is the only plumbing command that is controlled by
> core.preferredPackVersion so far.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/technical/protocol-capabilities.txt | 4 ++++
>  builtin/receive-pack.c                            | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docu=
mentation/technical/protocol-capabilities.txt
> index be09792..32153cd 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -226,4 +226,8 @@ this capability, the server may send a pack versi=
on 4. The server can
>  choose to send pack version 2 even if the client accepts this
>  capability.
> =20
> +The receive-pack server advertises this capability if it wants to
> +receive the pack in format version 4 and the client should send in
> +this format.

Technically, "if it can and if it wants to receive" is more correct,
as a v4 capable receiving end can choose to pretend it does not
understand v4 by not sending this capability. Also a v4 incapable
receiver would not advertise it even if it _wants_ to receive.  So
in practice, we see this header only from a receiver that wants to
receive v4, which makes the above statement accurate in a twisted
way.

There needs a bit more explanation on the "should" part, especially
because this is very unusual and unlike all the other capabilities,
which are offered as more freedom of choices without preference on
the advertising side.  Rationale (i.e. reduce load on the receiving
end) and ramifications of non-compliance (e.g. the receiver may
choose to fail the push when its load is too high) are good things
to guide third-party implementors to do the right thing.

>  This capability does not include multi-base tree support.
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e3eb5fc..288b0bc 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -130,10 +130,11 @@ static void show_ref(const char *path, const un=
signed char *sha1)
>  	if (sent_capabilities)
>  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
>  	else
> -		packet_write(1, "%s %s%c%s%s agent=3D%s\n",
> +		packet_write(1, "%s %s%c%s%s%s agent=3D%s\n",
>  			     sha1_to_hex(sha1), path, 0,
>  			     " report-status delete-refs side-band-64k quiet",
>  			     prefer_ofs_delta ? " ofs-delta" : "",
> +			     core_default_pack_version =3D=3D 4 ? " packv4" : "",
>  			     git_user_agent_sanitized());
>  	sent_capabilities =3D 1;
>  }
