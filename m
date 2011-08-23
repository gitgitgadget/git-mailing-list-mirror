From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] merge: remove global variable head[]
Date: Tue, 23 Aug 2011 11:46:59 -0700
Message-ID: <7vty98q82k.fsf@alter.siamese.dyndns.org>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 20:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvw0J-0004hx-W4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab1HWSrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 14:47:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596Ab1HWSrG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 14:47:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA4944F1;
	Tue, 23 Aug 2011 14:47:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yiJguzHHDVsl
	dAY9yTU7QHCPj4o=; b=j6cFWRf11P+34LgCDoCDDZqiixGrXyovHuuJ9fiQNj+k
	13ifFAW7kq3lZnLnOniPeZC1nZ9Z8kwrdJF44JuCxv1ox0OQy5/EHcETfNGufV/+
	re2OmM6xIuFytmAj+MwWqiN7T6dmhRIplRe/ZFq3DVpq3AbBKpDmDL7ipHbF5HE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AzJipn
	zpajuyCOk83uJzKaqBW1KmEY0FaS2ohAEiSS8MBI9oMFqtWrg6QU+0jvxvK9vZyG
	gEstKmtFnrkd0uHDRZwhy1Uw0u/+3YU9KZ6ZxRHYUuVBo92o8k3jfOqo56GUArBT
	vBsWlIRub+LT8RNtV+NMVeMm5NQfYEGeqMlso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79A0344F0;
	Tue, 23 Aug 2011 14:47:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4D1C44ED; Tue, 23 Aug 2011
 14:47:02 -0400 (EDT)
In-Reply-To: <1313765407-29925-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 19 Aug
 2011 21:50:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A81FC7E-CDB8-11E0-B2B5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179959>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -1012,9 +1014,11 @@ int cmd_merge(int argc, const char **argv, con=
st char *prefix)
>  {
>  	unsigned char result_tree[20];
>  	unsigned char stash[20];
> +	unsigned char head[20];
> +	struct commit *head_commit =3D NULL;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	const char *head_arg;
> -	int flag, head_invalid =3D 0, i;
> +	int flag, i;
>  	int best_cnt =3D -1, merge_was_ok =3D 0, automerge_was_ok =3D 0;
>  	struct commit_list *common =3D NULL;
>  	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
> @@ -1030,8 +1034,11 @@ int cmd_merge(int argc, const char **argv, con=
st char *prefix)
>  	branch =3D resolve_ref("HEAD", head, 0, &flag);
>  	if (branch && !prefixcmp(branch, "refs/heads/"))
>  		branch +=3D 11;
> -	if (is_null_sha1(head))
> -		head_invalid =3D 1;
> +	if (!is_null_sha1(head)) {
> +		head_commit =3D lookup_commit(head);
> +		if (!head_commit)
> +			die(_("could not parse HEAD"));
> +	}

Is this is_null_sha1() valid without first clearing head[]?

Also, would it be too much trouble and code churn to employ the same
strategy as my rewrite of your [1/4] and pass only head_commit around i=
n
the call chain?

Because this is the way to set up head_commit in the first place, this
particular resolve_ref() -> is_null_sha1() chain is unavoidable and nee=
ds
to be written carefully, but after the

    !head_commit =3D=3D=3D is_null_sha1(head) =3D=3D=3D is_initial_comm=
it

invariant is established, I suspect that it would reduce the chance of
similar mistakes in later parts of the code if it can check and use onl=
y
one argument.
