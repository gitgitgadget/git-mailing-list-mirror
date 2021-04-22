Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A82C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A1B61417
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhDVPbE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Apr 2021 11:31:04 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36746 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhDVPbE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:31:04 -0400
Received: by mail-ej1-f42.google.com with SMTP id r9so69426461ejj.3
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HRgCWDzKyUPLCtNcRjThs68KgLjGQAR3U5yRHk4xl44=;
        b=NR2vBNhoCm87ZVz5ewlmrbPuwkqbPdVMYcWBVICCkemm1atI+zPPeEU13g3tP933GH
         1VRPrHLAjX4MuWsztE+c+l4u1nXEk04W5ZL+tMpcvqfGgHIqKClDP7VoTa5cUFskPXuw
         2tRFDQB3E7R7Vf9wqdAO/D4VDgNq6lHz1ddMDoOAFjJCSbddHVcAv8f7RRIYGAavJigP
         9+uWFhatcQH25VFJpl9En+O17SRG3LwCfY8TtTNSB19NceK1N3Xk12Td1QV/mtGvwZ47
         GG77JTvxL0mx7BVw6+4bTt6nHowhjLICtzdXDIPiVNuWOtUNHU5XjNEXtVYtGBvVItjc
         6JAA==
X-Gm-Message-State: AOAM533G5VWReLHLRQJEelyTkRMqce7xYA8BicsSuIqZGXOrVDIm6BzW
        22bON+Fxkdqf9Aj6r++a7N/QCr6zjHzwlt3DiNE=
X-Google-Smtp-Source: ABdhPJxDQbKOrLbjQcem+EHSBMT8x6yEha39MGYSd8l7CX0O8kkUizab6Nddspi/u8WzXlBnWSMPOsuxMe1/U7tLGEA=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr4079123ejd.168.1619105426950;
 Thu, 22 Apr 2021 08:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <YIAAzJTG1UitiWyu@danh.dev> <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com> <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
 <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
 <xmqq5z0fxlgn.fsf@gitster.g> <YIF+0BZGwpMMI1pf@danh.dev> <87pmym1huk.fsf@evledraar.gmail.com>
In-Reply-To: <87pmym1huk.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Apr 2021 11:30:15 -0400
Message-ID: <CAPig+cR7wvPRrWiTS+_AFSSWqHvnSP0oK-joOo9_Pa4+nWR0qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 11:04 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Apr 22 2021, Đoàn Trần Công Danh wrote:
> > Hm, I'm not sure how would we implement such mode:
> >
> > * Will we run such command in a subprocess and and pipe to "wc -l"
> >   directly to avoid a temporary file, but we will lose the exit code
> >   of running command in process?
>
> Just use a tempfile.

That's what I had in mind when I suggested the function. The function
would remove the tempfile if the check succeeded.

> Here's an implementation that works, sans the fancy opts parsing etc. I
> just use -1 for "don't care". You can see "test_commit" etc. for how to
> do that.
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -817,6 +817,24 @@ test_line_count () {
> +test_line_count_command () {
> +       local op=$1
> +       local ocnt=$2
> +       local ecnt=$3
> +       shift 3
> +       "$@" 2>cnt.err >cnt.out
> +       local exit_code=$?
> +       if test "$ocnt" -gt -1
> +       then
> +               test_line_count "$op" "$ocnt" cnt.out
> +       fi &&
> +       if test "$ecnt" -gt -1
> +       then
> +               test_line_count "$op" "$ecnt" cnt.err
> +       fi &&
> +       return "$exit_code"
> +}

It's not clear why you manually catch the exit code of the command
being run but then use &&-chain for the other parts.

An important reason I suggested creating a function was because the
function could clean up after itself thus freeing the test author from
worrying about adjusting counts in later tests (or later in the same
test). So, just before this function returns, I'd expect to see:

    rm -f cnt.out cnt.err &&
