From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailmap: xcalloc mailmap_info
Date: Wed, 16 Nov 2011 17:10:04 -0800
Message-ID: <7v8vnfpn9v.fsf@alter.siamese.dyndns.org>
References: <1321487473-29194-1-git-send-email-marcandre.lureau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 02:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQqUf-0007pR-L2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 02:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab1KQBKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 20:10:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab1KQBKI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 20:10:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA87E5CD9;
	Wed, 16 Nov 2011 20:10:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T/nYtQr79iUk
	Nw1ttcsybw6J5sc=; b=YCFnTCXl1GNMKZtGbTNyDUfW2g9z6z6AdQsdrG9jGEtF
	DiP4uGeny6VOmm5ad9C3ViaKmVf03uo4z0/AxTk59XMClCQq3AEwH8ynFKlmGNmu
	j4/WzTrxpP45ZxTvs+q2oNPL4Is8X5jxlkLak6pz7fqMbLI3kqLVMzpumvPwcXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hj7ey7
	opOHUTmrb1GMR3/FsgMHRdJxfrT7zsx8eYr1A0nw1ZruLIi0Yi7gUjV2QdwSAt+u
	E9yZnv1DfUJ0j1uqhC5vHYYmAA26JrNV1kpzHMdAgY/cJ0QjFyd7K/lgtIoKbcnk
	BhZBna4k6LKbmoBda2gkrZPbYV2DEShC1WQi8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC7D5CD8;
	Wed, 16 Nov 2011 20:10:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 211225CD3; Wed, 16 Nov 2011
 20:10:06 -0500 (EST)
In-Reply-To: <1321487473-29194-1-git-send-email-marcandre.lureau@gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 17 Nov 2011
 00:51:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2B7F71C-10B8-11E1-8567-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185565>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> This is to avoid reaching free of uninitialized members.
>
> With an invalid .mailmap (and perhaps in other cases), it can reach
> free(mi->name) with garbage for example.
> ---

Sign-off?

Thanks. We might want to turn xmalloc() followed by memset(,0,) for the
allocation of the mailmap entry itself in the same function, but that i=
s a
minor issue.

>  mailmap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/mailmap.c b/mailmap.c
> index 02fcfde..fbf7764 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -88,7 +88,7 @@ static void add_mapping(struct string_list *map,
>  			me->email =3D xstrdup(new_email);
>  		}
>  	} else {
> -		struct mailmap_info *mi =3D xmalloc(sizeof(struct mailmap_info));
> +		struct mailmap_info *mi =3D xcalloc(1, sizeof(struct mailmap_info)=
);
>  		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", o=
ld_email, index);
>  		if (new_name)
>  			mi->name =3D xstrdup(new_name);
