Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F21BC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 03:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ECF2071A
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 03:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKZDQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:16:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51052 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfKZDQI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 22:16:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so1554707wmh.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 19:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkgYUdr3y1I4b80RRDLYhHrLsuI1thnNy82X4aeAYPQ=;
        b=OxHnKgkDJ2qsQNFt7EGq/mUJnZpjAoJgZNP7SHcXts6n+UmGCtD5lsw9CLq+RBVrVB
         M/zgGHS+V3Vhz6xkw3K54Q42I+/QXCUi4mEPB2hh6CVZGSMIwTQ7LfGhj8UK3AJKwxlI
         TrcKOOWh47+45CXyANJA6wyT5ChXHxz7aFZ9haoMCbo/rhJG7RLneqbwH+CXTSYq+qcn
         6rqb62QODRZL/Lk6wAufviYPC5MEx6eBmfZ2n3mITWZK1l4v8CNqE3YjZQFYT8w+Zu/u
         W5IswqfLyhmTY5abOdFvZK7Tjw3MGn/TSCLegn2uqSygOm4nRsoOoV5TbBYeL2ABQ5bq
         hIyA==
X-Gm-Message-State: APjAAAW9mu2G9/R0ShL6usV5wF0nXAIj6Gy30LbED8KFskoPrpTtFF9m
        0PSjk8xceEV7VmUZhJ5ggmH2o4w9n8MXUgevXDc=
X-Google-Smtp-Source: APXvYqyT0Qgpb4HDuYJ8ciDeLgaD4Td2B3vl4vKepQKxSx+0f0zdm7eJxTYjlzSjtcA0Wk4HoMkZ4iJyvrUpsf39EVo=
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr1811188wma.120.1574738166178;
 Mon, 25 Nov 2019 19:16:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574449072.git.liu.denton@gmail.com> <cover.1574731022.git.liu.denton@gmail.com>
 <a747fbd08b46f394c4dc1e9f9b8399d13d294273.1574731022.git.liu.denton@gmail.com>
In-Reply-To: <a747fbd08b46f394c4dc1e9f9b8399d13d294273.1574731022.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Nov 2019 22:15:55 -0500
Message-ID: <CAPig+cRDVndrWajFzZDShyo2cV2MechUF1bZFqkRTk87moN3rA@mail.gmail.com>
Subject: Re: [PATCH v4 26/27] t7700: make references to SHA-1 generic
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 8:22 PM Denton Liu <liu.denton@gmail.com> wrote:
> Make the test more hash-agnostic by renaming variables from "sha1" to
> "oid" (case-insensitively). Also, replace the regex, `[0-9a-f]\{40\}`
> with `$OID_REGEX`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> @@ -6,31 +6,31 @@ test_description='git repack works correctly'
>  commit_and_pack () {
>         test_commit "$@" 1>&2 &&
> -       SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
> -       echo pack-${SHA1}.pack
> +       OID=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
> +       echo pack-${OID}.pack
>  }

Meh. OID stands for "object ID". However, in this context, SHA1 is a
computed hash value -- a checksum -- not the ID of an object. So,
calling this an OID is confusing (IMHO). By the way, the uppercase
"SHA1" gives the impression that this value is global to the script,
but it is, in fact, used only in this function, so it would be clearer
to downcase the entire name, implying by convention that it is a local
variable. Taking both observations into consideration, a better name
might be "packid".

> -# we expect $packsha1 and $objsha1 to be defined
> +# we expect $packoid and $objoid to be defined

Likewise. By using "oid" in these names, you're calling these values
"pack object ID" and "object object ID", respectively, which doesn't
make much sense. Perhaps "packid" and simply "oid" would be better
names.

Same comment applies to remaining changes in this patch.

> @@ -124,7 +124,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
>  test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
>         rm -f alt_objects/pack/*.keep &&
>         mv .git/objects/pack/* alt_objects/pack/ &&
> -       csha1=$(git rev-parse HEAD^{commit}) &&
> +       coid=$(git rev-parse HEAD^{commit}) &&

This is indeed an object ID, so replacing literal "sha1" with "oid" makes sense.
