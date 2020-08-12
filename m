Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E99C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0F620675
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IZpsmqrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLUql (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:46:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUqk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 16:46:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F64B6D5EB;
        Wed, 12 Aug 2020 16:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZPSCjw8jnP+h
        4lghQmaM9Mj+MqU=; b=IZpsmqrnQmtZ+kVPSQPXsqpAk0U0K1O+cYPR9n+NjzxB
        l5fJc5LxH+s/jp3OhktYPHbsGZe2xrS9CJhDBmijFydaGKsDZtR431RcS7QdiZpo
        fuDFMlxY3cLOZP6hnq3Ui4bOapSVkihCnzEpXifyitDwVBjuBR25sOBRNB1qAWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aYiXtT
        lrnFODj7CG9CjTRX1jplPsPJhyFOwDF6SK8SiaBYz6o0eDnA6Ja8q4DY0XHCo6QD
        9XKcrTVoqFvKYSqYYuhTgXvUhoDCqhIXJbePjrcXM1KR9gAPLTidBevNEoLm+WLe
        O0xClRMz7a64552gRxPYKCYdFp5/wEuoiVznc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25FB06D5EA;
        Wed, 12 Aug 2020 16:46:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A72896D5E9;
        Wed, 12 Aug 2020 16:46:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase -i: Fix possibly wrong onto hash in todo
References: <20200812183326.224782-1-detegr@rbx.email>
Date:   Wed, 12 Aug 2020 13:46:36 -0700
In-Reply-To: <20200812183326.224782-1-detegr@rbx.email> ("Antti
 =?utf-8?Q?Ker=C3=A4nen=22's?=
        message of "Wed, 12 Aug 2020 21:33:27 +0300")
Message-ID: <xmqq8sej618z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA1F585C-DCDC-11EA-9757-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antti Ker=C3=A4nen <detegr@rbx.email> writes:

> 'todo_list_write_to_file' may overwrite the static buffer, originating
> from 'find_unique_abbrev', that was used to store the short commit hash
> 'c' for "# Rebase a..b onto c" message in the todo editor. This is
> because the buffer that is returned from 'find_unique_abbrev' is valid
> until 4 more calls to `find_unique_abbrev` are made.
>
> As 'todo_list_write_to_file' calls 'find_unique_abbrev' for each rebase=
d
> commit, the hash for 'c' is overwritten if there are 4 or more commits
> in the rebase. This behavior has been broken since its introduction.
>
> Fix by storing the short onto commit hash in a different buffer that
> remains valid, before calling 'todo_list_write_to_file'.
>
> Found-by: Jussi Ker=C3=A4nen <jussike@gmail.com>
> Signed-off-by: Antti Ker=C3=A4nen <detegr@rbx.email>
> ---

Looking good.

>  sequencer.c                   | 5 +++--
>  t/t3404-rebase-interactive.sh | 6 ++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..e2007dbb8c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5178,13 +5178,14 @@ int complete_action(struct repository *r, struc=
t replay_opts *opts, unsigned fla
>  		    struct string_list *commands, unsigned autosquash,
>  		    struct todo_list *todo_list)
>  {
> -	const char *shortonto, *todo_file =3D rebase_path_todo();
> +	char shortonto[GIT_MAX_HEXSZ + 1];
> +	const char *todo_file =3D rebase_path_todo();
>  	struct todo_list new_todo =3D TODO_LIST_INIT;
>  	struct strbuf *buf =3D &todo_list->buf, buf2 =3D STRBUF_INIT;
>  	struct object_id oid =3D onto->object.oid;
>  	int res;
> =20
> -	shortonto =3D find_unique_abbrev(&oid, DEFAULT_ABBREV);
> +	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
> =20
>  	if (buf->len =3D=3D 0) {
>  		struct todo_item *item =3D append_new_todo(todo_list);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
.sh
> index 4a7d21f898..1b4fa0843e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1760,6 +1760,12 @@ test_expect_success 'correct error message for c=
ommit --amend after empty pick'
>  	test_i18ngrep "middle of a rebase -- cannot amend." err
>  '
> =20
> +test_expect_success 'todo has correct onto hash' '
> +	GIT_SEQUENCE_EDITOR=3Dcat git rebase -i no-conflict-branch~4 no-confl=
ict-branch >actual &&
> +	onto=3D$(git rev-parse --short HEAD~4) &&
> +	test_i18ngrep "^# Rebase ..* onto $onto" actual
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
