Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F4DC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 01:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D80764D79
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 01:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBOBgU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Feb 2021 20:36:20 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:38268 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBOBgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 20:36:19 -0500
Received: by mail-ej1-f45.google.com with SMTP id bl23so8704378ejb.5
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 17:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NtH6RqNFqqm5guo+i4GmweNWHPrcOVS13F9rE4v/tPQ=;
        b=h7Lbth4ZE0X8PLinEOc5cm9bG4xlRl8xUn5udp85JwPtz3n4TEGCsvdGN1m3RWA/Ha
         99ZibyKEefPoV3Bkf+V5SYpz7cAzYFmNjY77ZRzOG74YCiq6QxZB0V4YGgKR0Nyujz3p
         20zIBfWj9tjbVg60a5EgejEPtJfznVNqtFjoP5FmmBsbxNigy5hqcpM1ArUTXjd2LOQs
         m9UdTGtZfSTQo75esi7w0unE7MJTPoY1G8HsjUzG8ah8vbLRiKAUB5uXqu1BNsj8/9m4
         WCqD8xi7gi6hrHU/PWe1PFCSJHUpgNDXsq6gHk51ugpj9GKamSsunPVM055OIhdF5abO
         Ujxw==
X-Gm-Message-State: AOAM533PfwxEhtitwXMUaHxUu1MmE6RTFWEJkNxTKN1KVyegKuUJSVoj
        HW8YzKe5o8+L1WV0r5sx9msiO+VBLhip594DEW4=
X-Google-Smtp-Source: ABdhPJyE2x6ZWLb/9/E4PqbF/zeKYQvvdTRRpaFi5r5Aw0jP2udQTFHmBtT6Y2W29QgffHP6E1mrB7h8guvY6FsGJ58=
X-Received: by 2002:a17:906:c286:: with SMTP id r6mr3827874ejz.202.1613352937804;
 Sun, 14 Feb 2021 17:35:37 -0800 (PST)
MIME-Version: 1.0
References: <87tuqebj6m.fsf@evledraar.gmail.com> <20210215005236.11313-8-avarab@gmail.com>
In-Reply-To: <20210215005236.11313-8-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Feb 2021 20:35:26 -0500
Message-ID: <CAPig+cSo-a12aUo-Xwo=7nECpXTsWv+nsoh6DnfUQGk4TZeqyw@mail.gmail.com>
Subject: Re: [PATCH 07/20] userdiff tests: match full hunk headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 14, 2021 at 7:56 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> Let's bring back coverage for that by adding corresponding *.ctx
> files, this has the added advantage that we're doing a "test_cmp", so
> when we have failures it's just a non-zero exit code from "grep",
> we'll actually have something meaningful in the "-v" output.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> @@ -81,11 +81,12 @@ test_expect_success 'setup hunk header tests' '
> +for i in $(git ls-files -- ':!*.ctx')
>  do
>         test_expect_success "hunk header: $i" "
> +               git diff -U1 $i >diff &&
> +               sed -n -e 's/^.*@@\( \|$\)//p' <diff >ctx &&
> +               test_cmp $i.ctx ctx
>         "
>  done

If I'm reading this correctly, you're simply stripping off all the
leading `@@ blah @@` stuff...

> diff --git a/t/t4018/README b/t/t4018/README
> @@ -1,15 +1,15 @@
> +The text that must appear in the hunk header must contains the word
> +"RIGHT" by convention. The "LANG-whatever.ctx" file contains what we
> +expect to appear in the hunk header. We munged the start of the line
> +to "@@ [...] @@" for ease of not having to hardcode the line numbers
> +and offsets.

...which makes me wonder what this "munging to `@@ [...] @@`" is about.

Is this documentation update wrong or am I misunderstanding?
