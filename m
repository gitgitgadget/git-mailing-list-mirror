Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317EF16406
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mOigOTyA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87BC81DE8C0;
	Thu, 11 Jan 2024 20:21:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lf9GoEWIGTDJ
	hztTrLIzhhqciyAsTJkX9/T4sYm35IM=; b=mOigOTyATRgi7HsgvY0PGkNM3NkO
	J712nf4neqnPuA77dd1cMi6qOgtra8dfVC4Yq/1THgqkMg83GsoDuWyx6gLSiop4
	hGZswKsohNMLZf/bmqZJz7aWR8Qg2+U91yBVqjKmjkPnfeGsutAh8JT9g6XYk9pD
	LWULOHm3eLncAsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EA6B1DE8BF;
	Thu, 11 Jan 2024 20:21:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D22DA1DE8BB;
	Thu, 11 Jan 2024 20:21:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] advice: fix an unexpected leading space
In-Reply-To: <d5fbdb05-d16a-4390-946e-22a5a7a1b56a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 11 Jan 2024 13:40:17 +0100")
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
	<4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
	<d5fbdb05-d16a-4390-946e-22a5a7a1b56a@gmail.com>
Date: Thu, 11 Jan 2024 17:21:22 -0800
Message-ID: <xmqqa5pbcpnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E65C2888-B0E8-11EE-9F28-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> [ ... ]
> diff --git a/advice.h b/advice.h
> index 0f584163f5..2affbe1426 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -49,6 +49,7 @@ struct string_list;
>         ADVICE_UPDATE_SPARSE_PATH,
>         ADVICE_WAITING_FOR_EDITOR,
>         ADVICE_SKIPPED_CHERRY_PICKS,
> +       ADVICE_WORKTREE_ADD_ORPHAN,
>  };
>
> Note the hunk header, instead of a much more expected:
>
> @@ -49,6 +49,7 @@ enum advice_type

Next time, don't include "diff" output in the proposed log message
without indenting.  It makes it hard to read and parse.

The attached is what I queued in my tree.

Thanks.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------
From: Rub=C3=A9n Justo <rjusto@gmail.com>
Subject: [PATCH] advice: fix an unexpected leading space

This space was introduced, presumably unintentionally, in b3b18d1621
(advice: revamp advise API, 2020-03-02)

I notice this space due to confuse diff outputs while doing some
changes to enum advice_type.

As a reference, a recent change we have to that enum is:

    $ git show 35f0383

    ...
    diff --git a/advice.h b/advice.h
    index 0f584163f5..2affbe1426 100644
    --- a/advice.h
    +++ b/advice.h
    @@ -49,6 +49,7 @@ struct string_list;
	    ADVICE_UPDATE_SPARSE_PATH,
	    ADVICE_WAITING_FOR_EDITOR,
	    ADVICE_SKIPPED_CHERRY_PICKS,
    +       ADVICE_WORKTREE_ADD_ORPHAN,
     };

Note the hunk header, instead of a much more expected:

    @@ -49,6 +49,7 @@ enum advice_type

Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 advice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index 9396bcdcf1..74d44d1156 100644
--- a/advice.h
+++ b/advice.h
@@ -10,7 +10,7 @@ struct string_list;
  * Add the new config variable to Documentation/config/advice.txt.
  * Call advise_if_enabled to print your advice.
  */
- enum advice_type {
+enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
--=20
2.43.0-283-ga54a84b333

