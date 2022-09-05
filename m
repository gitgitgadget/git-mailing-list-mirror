Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E78CECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 20:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiIEUrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEUrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 16:47:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDC34F6B0
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 13:46:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13016053pjh.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=sAAD9KIBlIcb5+4IJ9tVvNXoQPjCS3RsneaxXmuzJuE=;
        b=b0vU3TZyA6t1iCqvZwkCbBBsDvuVpVxn0f5Sfbw7ZJsbXqjoXC7f6nno/pqhHjtOpI
         N4BXrMJ7pG1Wa3bTYmgN73PBtmZ6NuCwsvLjVvUoyfRJmvQNkm1gMeYue8VAyh/wEb9d
         RGz7aebq7J5V2smkQWTpOjfCX14Ecc54WzcQW14nzWdPFBmHC4coIZFINlVgqeCePlOE
         VnF8GiAboXiBM5V8x8aGAhIlZF0N77a9R+U1PZd/yqTAh3vspWqh37TeVQkqTbse7d/w
         Y+0YN5RRF6Gy6MZXPbfG3BlnFpKyA+LlRl8QHPiyE97+kkn7qF/mbtcpbvNGZ8HaGJuw
         hnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sAAD9KIBlIcb5+4IJ9tVvNXoQPjCS3RsneaxXmuzJuE=;
        b=XWdVQ867fJNE7uZISh7laePQnC0dD8WiaH3VxRUhXdNCU+vWqCUtx+LHBQ2Xhzma5w
         hhx0sFMUIbPV3z4wB6vrc93w1fbbpxWZulIFjYYT+FpXGDMj4CdKqiZXGvJBsFqGLcM3
         Je9mp2YZ+4oaEQ6wG7tiN0vqY6Netyn6fHGh7nDV+s3EnXczSEf15HdI4Fo7zNTBijJN
         vlp9Z2hMksWlGdCc8Vu92wP7vSx5cGkPV4rEFmNGOySWFThNceEzLVLbjjnZHlG810CO
         VPAIGSYjMHMKJjMdZytf55SDUjrgFmZ6MPcHZNp6G5qRbnkta9upOdKgccyoxF5OTX0j
         RKwQ==
X-Gm-Message-State: ACgBeo3AbtiesQh4WdgMwmggbQyftbPGhQJKkesWWk3hW1B2swHDnDTb
        uAERCKtSpLPJUmLq954ME7Y=
X-Google-Smtp-Source: AA6agR6Vb072fGjEQc3P1sDH1J+qHT1tySv24IaVCzTYJZUHcuz95hJieO401Q6efQK8y3V6bcWJUQ==
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id pf11-20020a17090b1d8b00b0020053675ecdmr8771817pjb.165.1662410818697;
        Mon, 05 Sep 2022 13:46:58 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b00174ea015ee2sm7967691plh.38.2022.09.05.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:46:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 1/2] diff.c: When appropriate, use utf8_strwidth(),
 part1
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220903053931.15611-1-tboegi@web.de>
Date:   Mon, 05 Sep 2022 13:46:57 -0700
In-Reply-To: <20220903053931.15611-1-tboegi@web.de> (tboegi@web.de's message
        of "Sat, 3 Sep 2022 07:39:31 +0200")
Message-ID: <xmqqv8q1zgzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
> Subject: Re: [PATCH v4 1/2] diff.c: When appropriate, use utf8_strwidth(), part1

Given 2/2 does not share a similar title, "part1" sounds somewhat
strange.  In any case, 'when appropriate,' is probalby best unsaid,
as it is almost a given.  We won't deliberately use something that
is not appropriate on purpose anyway.  Even if we =were to keep that
word, downcase "When".


> When unicode filenames (encoded in UTF-8) are used, the visible width
> on the screen is not the same as strlen(filename).
>
> For example, `git log --stat` may produce an output like this:
>
> [snip the header]
>
>  Arger.txt  | 1 +
>  Ärger.txt | 1 +
>  2 files changed, 2 insertions(+)
>
> A side note: the original report was about cyrillic filenames.
> After some investigations it turned out that
> a) This is not a problem with "ambiguous characters" in unicode
> b) The same problem exists for all unicode code points (so we
>   can use Latin based Umlauts for demonstrations below)
>
> The 'Ä' takes the same space on the screen as the 'A'.
> But needs one more byte in memory, so the the `git log --stat` output
> for "Arger.txt" (!) gets mis-aligned:
> The maximum length is derived from "Ärger.txt", 10 bytes in memory,
> 9 positions on the screen. That is why "Arger.txt" gets one extra ' '
> for aligment, it needs 9 bytes in memory.
> If there was a file "Ö", it would be correctly aligned by chance,
> but "Öhö" would not.
>
> The solution is of course, to use utf8_strwidth() instead of strlen()
> when dealing with the width on screen.
>
> Side note 1:
> Needed changes for this fix are split into 2 commits:
> This commit only changes strlen() into utf8_strwidth() in diff.c:
> The next commit will add tests and further needed changes.

I am not sure if it makes sense to split them into two.  It is hard
for us to demonistrate the need for this step if it does not come
with its own test.

> Side note 2:
> Junio C Hamano suspects that there is probably more work to be done,
> in a separate commit:
> Code in diff.c::pprint_rename() that "abbreviates" overly long pathnames
> and "transforms" renames lines like
> "a/b/c -> a/B/c" into the shorter
> "a/{b->B}/c" form, and IIRC this is all byte based.

I already said that I suspect {b->B} conversion is OK, so the side
note is probably more noise than being useful.
>
> Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 974626a621..b5df464de5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2620,7 +2620,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  			continue;
>  		}
>  		fill_print_name(file);
> -		len = strlen(file->print_name);
> +		len = utf8_strwidth(file->print_name);
>  		if (max_len < len)
>  			max_len = len;
>
> @@ -2743,7 +2743,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		 * "scale" the filename
>  		 */
>  		len = name_width;
> -		name_len = strlen(name);
> +		name_len = utf8_strwidth(name);
>  		if (name_width < name_len) {
>  			char *slash;
>  			prefix = "...";
> --
> 2.34.0
