From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix calling parse_pathspec with no paths nor PATHSPEC_PREFER_* flags
Date: Tue, 22 Oct 2013 10:21:21 -0700
Message-ID: <xmqq38ntusq6.fsf@gitster.dls.corp.google.com>
References: <CALWbr2zTZzGZ9fkUonQr77Vn_dfzP57CZR1vNxNJW_touxNstQ@mail.gmail.com>
	<1382150484-13207-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 19:21:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYfeA-00053B-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 19:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab3JVRVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 13:21:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab3JVRV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 13:21:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D52D74BD44;
	Tue, 22 Oct 2013 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iptIhqvkpJx/
	nVWFYgt4wciv4nY=; b=O57JIxUlbz7ruFLYW5pb7qDuEJVUZCSMOLS+vEEsQyFn
	mINIVP77MNHmhl3r5Bh+HU3huqOtnmAnPlgrHJ8B9jTHJc9svHWI7X3ygNSnml+Q
	MTC7emY+GWKOzmarGfcLn0/n0xB9LWtvzLFfz3EmXncG1knQ/7yLx5tTLsjSfeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pk2u16
	4bx5994pVGEVyC5FRaXRBJyDt8RjbhvjvyMg7fFfAbL0qKallGrcay8vG3Ek7boa
	9KganNXinApAcnT9xTf1J0augKwo4dGZ7tSYQUGrYaAqVOGQelnkMdrO5NRews7r
	9ca6HqzD2ugcxOCLyhdvl4WkF6wcXRyxtYP1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C75734BD43;
	Tue, 22 Oct 2013 17:21:28 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2940D4BD3E;
	Tue, 22 Oct 2013 17:21:28 +0000 (UTC)
In-Reply-To: <1382150484-13207-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 19
 Oct 2013 09:41:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62BC756C-3B3E-11E3-B608-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236479>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When parse_pathspec() is called with no paths, the behavior could be
> either return no paths, or return one path that is cwd. Some commands
> do the former, some the latter. parse_pathspec() itself does not make
> either the default and requires the caller to specify either flag if
> it may run into this situation.
>
> I've grep'd through all parse_pathspec() call sites. Some pass
> neither, but those are guaranteed never pass empty path to
> parse_pathspec(). There are two call sites that may pass empty path
> and are fixed with this patch.
>
> Reported-by: Antoine Pelisse <apelisse@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

>  line-log.c | 3 ++-
>  revision.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/line-log.c b/line-log.c
> index 8b6e497..717638b 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -760,7 +760,8 @@ void line_log_init(struct rev_info *rev, const ch=
ar *prefix, struct string_list
>  			r =3D r->next;
>  		}
>  		paths[count] =3D NULL;
> -		parse_pathspec(&rev->diffopt.pathspec, 0, 0, "", paths);
> +		parse_pathspec(&rev->diffopt.pathspec, 0,
> +			       PATHSPEC_PREFER_FULL, "", paths);
>  		free(paths);
>  	}
>  }
> diff --git a/revision.c b/revision.c
> index 0173e01..dd994e9 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1372,7 +1372,8 @@ static void prepare_show_merge(struct rev_info =
*revs)
>  			i++;
>  	}
>  	free_pathspec(&revs->prune_data);
> -	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC, 0, "", prune)=
;
> +	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC,
> +		       PATHSPEC_PREFER_FULL, "", prune);
>  	revs->limited =3D 1;
>  }
