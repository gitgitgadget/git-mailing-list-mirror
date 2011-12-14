From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] merge: abort if fails to commit
Date: Wed, 14 Dec 2011 10:13:39 -0800
Message-ID: <7v4nx3qawc.fsf@alter.siamese.dyndns.org>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 19:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RatKt-0005BW-Ls
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 19:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab1LNSNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 13:13:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460Ab1LNSNm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 13:13:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E61994AE8;
	Wed, 14 Dec 2011 13:13:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=B6i0U8cg3Ztv
	e8qEDyoPbKB0tW8=; b=YjU9dsv2RH4hDQhighMRqZjmUf1DNx0ebwUiUASwagXY
	h80an27RFfws0TGjlZ8CR8z2jqkkpsOQUTHDUgQLexuytvlXFaTksQYgLAm5FbId
	MzdA8aX0JhAgHsQZhWOmV/ctvaErhxjNF9y6IqK+C/P5ONpaM1F8L0JYiJfacP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iNxr0f
	5e4WvqOXp9uf7FaFHqFmiDmnZO+CIqUyllfmENXVf2lft7sfdC9qbRvvdxXG85ok
	h3LNqX7M0c9MCcpYhs6WLT4N0W4C1IFQ6Gk2As2nME6zy6hPxyra+ND3F9f8vMsF
	pyRLXgs0dKD5FhzS+ACD9ChxCH5qKQgqpJGhc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE9304AE6;
	Wed, 14 Dec 2011 13:13:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E6AA4AE1; Wed, 14 Dec 2011
 13:13:41 -0500 (EST)
In-Reply-To: <1323871699-8839-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 14 Dec
 2011 21:08:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A3F58A8-267F-11E1-B1F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187160>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/merge.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index df4548a..e57eefa 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -913,7 +913,9 @@ static int merge_trivial(struct commit *head)
>  	parent->next->item =3D remoteheads->item;
>  	parent->next->next =3D NULL;
>  	prepare_to_commit();
> -	commit_tree(merge_msg.buf, merge_msg.len, result_tree, parent, resu=
lt_commit, NULL);
> +	if (commit_tree(merge_msg.buf, merge_msg.len,
> +			result_tree, parent, result_commit, NULL))
> +		die(_("failed to write commit object"));
>  	finish(head, result_commit, "In-index merge");
>  	drop_save();
>  	return 0;

Should we die immediately, or should we do some clean-ups after ourselv=
es
before doing so?

In any case, this is a good change that shouldn't be taken hostage to t=
he
unrelated change in patch [1/3].

Thanks.

> @@ -944,7 +946,9 @@ static int finish_automerge(struct commit *head,
>  	strbuf_addch(&merge_msg, '\n');
>  	prepare_to_commit();
>  	free_commit_list(remoteheads);
> -	commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents, res=
ult_commit, NULL);
> +	if (commit_tree(merge_msg.buf, merge_msg.len,
> +			result_tree, parents, result_commit, NULL))
> +		die(_("failed to write commit object"));
>  	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
>  	finish(head, result_commit, buf.buf);
>  	strbuf_release(&buf);
