Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B7383A5
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910933; cv=none; b=bLMMRWUT9dxdw6bpNbQS5ONVFRNX0j03xuk8GoasjbgVagfyl+9ksOvC8y/BcaqaoWQdKdUTMer5Y8vRjeb/PE/vPtOeDWS3GMHpSGvWr2NEoO+5AsWd4jsGHiV3KWnZLPahUu1ToHEgIrnsqV7ueBZIa98zUVBZdk6N/7ZCD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910933; c=relaxed/simple;
	bh=MNpy+ypChagyomLRsdi+npJq3Ep7Bjo8GZI2KUyH9nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiQ7w84FxNRUYPbIAETVOctPJ0AHv216W+0f8+EPhW6TaoRlHrdC4i5XtxZXcvXlbxdSw2E+gmiafcWCPdgiQaxV51GoOKC8QRvfHhitoQMc0bGqPCkA9PR4bebfCGDlBhNb3rs6dugBVLlEt1BBjrb1/sk0cIguxnPsOiTHrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b797a2384cso1237366d6.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 19:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910930; x=1723515730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncm/sdYszURaqAVMzwhenE9X3OpgwlmxRavUyl+v29c=;
        b=f1SjQ5JTm5FtJ3XoRjP1CczmRke2zbUVNHr24AfN8m4MUoGonG/xxr7b6aW4Auj87S
         cWDi71YzA85oAQQMjrQg15kdNORKT3F8Nym5Xagr3nlpOA2htiT9jwAq++m8eFLqvvtl
         DN7H3yCLdX1sdYdrnNO5MPb7/6c8okK4GskikBBORY4ok3jD9Px3wCL8w0kr2Xfe1bDV
         uTrsg5kfRk06MjMHAmYXLkFTnhDGsQ2Z3ZDUJD93v1S3HW36ZzyLIePPfsp2zy5Q+3NR
         o+bP1ubYf8bz3/NElrN9lWqCp9A20tEeANM7g8CY0YAbv1HFOXObc3SB7B0QJA0DT/RV
         jPOA==
X-Gm-Message-State: AOJu0YwBvp8gx5Gmlu9RES82vP70jukgAP4L1PHPuE8fEkoKeLqCG+1W
	ZKcsiyqQK9pbjcNyKTWm/cdtU3wpBxvwOQP5YDo3YYmPGBmNO3zkEfHTEXzGFQaiEbk/pgUlD+A
	EzIj4DiVIqqKTJa/2+8bOfhJIu9k=
X-Google-Smtp-Source: AGHT+IEHYqX+c1i3kakA+d/uRTMta6cmxFhXonaQ/xr36/hNuu2VQ/8PySlibVIvqPtvssa3XVXtx9ET2nFTgBoD+Vo=
X-Received: by 2002:a05:6214:c4d:b0:6bb:9b66:f262 with SMTP id
 6a1803df08f44-6bb9b66f6f1mr178107266d6.41.1722910930571; Mon, 05 Aug 2024
 19:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqttfyzd01.fsf@gitster.g>
In-Reply-To: <xmqqttfyzd01.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 Aug 2024 22:21:59 -0400
Message-ID: <CAPig+cRO=BqR1WFcni6CSxqyqvt1Ksmsyr0odmqTDKX4JdbDaA@mail.gmail.com>
Subject: Re: [PATCH] t3206: test_when_finished before dirtying operations, not after
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Many existing tests in this script perform operation(s) and then use
> test_when_finished to define how to undo the effect of the
> operation(s).
>
> This is backwards.  When your operation(s) fail before you manage to
> successfully call test_when_finished (remember, that these commands
> must be all &&-chained, so a failure of an earlier operation mean
> your test_when_finished may not be executed at all).  You must
> establish how to clean up your mess with test_when_finished before
> you create the mess to be cleaned up.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3206-range-diff.sh | 52 +++++++++++++++++++++----------------------
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> @@ -533,9 +533,9 @@ test_expect_success 'dual-coloring' '
>  for prev in topic main..topic
>  do
>         test_expect_success "format-patch --range-diff=3D$prev" '
> +               test_when_finished "rm 000?-*" &&
>                 git format-patch --cover-letter --range-diff=3D$prev \
>                         main..unmodified >actual &&
> -               test_when_finished "rm 000?-*" &&

Do we care whether the action invoked by `test_when_finished` itself
succeeds or fails? In particular, should this be using `rm -f` rather
than `rm`?

    test_when_finished "rm -f 000?-*" &&

> @@ -606,9 +606,9 @@ test_expect_success 'basic with modified format.prett=
y without "commit "' '
>  test_expect_success 'range-diff compares notes by default' '
> +       test_when_finished git notes remove topic unmodified &&
>         git notes add -m "topic note" topic &&
>         git notes add -m "unmodified note" unmodified &&
> -       test_when_finished git notes remove topic unmodified &&

Similarly, should this be using `|| :`?

    test_when_finished "git notes remove topic unmodified || :" &&
