Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D159C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 23:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiKRXdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiKRXcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 18:32:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DB1F1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:19:56 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s196so6263365pgs.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+RO5ML+/s/QBbsRVfCzqjYt8RgebKOxe/YY6laoX7o=;
        b=FN4Non+QGsDrgqqnT55JTlK1Yq8Wuoe95EnsoniBx4Gr6yanDfo1ApwU5+l6aqy+Yr
         rg2nY6Iv/zITwae18ieuDdQSxNTknnvgEf/IPtyd9gMAiUVP2VnfmO9HewALXbxQgKR6
         3SUxuieZU12BkWZwurK9TH6srN+UGgTDMS3avV3BiUs96oGeg4spJq3RpNtY7l3EtCSa
         pxEiDBtl5aCrvKglBih9nfSbHVJH9FQI/rabZgFlqY8Nt1m49u3ViL8vJFstgQKTST5s
         Td5R9d77dFU+ZSCfFTH9ik4lh5eTyR+97DXBbG7CQgLkPrgbT+MFdo1Tq6VTZqZ2wOM0
         jcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+RO5ML+/s/QBbsRVfCzqjYt8RgebKOxe/YY6laoX7o=;
        b=xMi06eb45mhUtV5qg2zNhl2653N0DrpSEuaqCym7tLu5Rr5cluY4A2ssKYt9L9MyMI
         BgtGUYnVqEmDetzrnIMlmJT0Yc35TR2NWOl8CtpJlgDSIpGl+0j3UjJ7Ze3UOcD8IayL
         uoszrXjgNMFbiYDPaPfK8G/sGWLdACivr9oautNeUN84tTbbBXL69B3280+deFLide4C
         VCuiFWtA6gfDZOaCccjnNLrF9iho4mPat0skVMjar/ivLAgD1h0uQDFf37a8Ugo6sfRT
         9T/kEBCUpRSIQzwlLCIheYaDxjs6Lp3s/i9XpgbYyqyvGiWS5GCuX5kvAClXW6HoNfI3
         l8fw==
X-Gm-Message-State: ANoB5pkcqq68K08S8l6yqTj7lQbOWR9YDEsTFJa1LYV8DOVKU65E7Ejn
        KxUt2EE5o0iQZeGYkyix41A=
X-Google-Smtp-Source: AA0mqf71sIL3zNsdaiWRzwA4N6UiQ8zonGNRluDOOZ/kMF14gaL6lKXmMfoSSD/i7Y4Fgpv40AIP3Q==
X-Received: by 2002:a63:fd08:0:b0:46f:ed91:6664 with SMTP id d8-20020a63fd08000000b0046fed916664mr8446421pgh.558.1668813596238;
        Fri, 18 Nov 2022 15:19:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001869079d083sm4290452plk.90.2022.11.18.15.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:19:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
        <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
        <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
        <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
        <221114.86pmdplbs5.gmgdl@evledraar.gmail.com>
Date:   Fri, 18 Nov 2022 15:19:55 -0800
In-Reply-To: <221114.86pmdplbs5.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 14 Nov 2022 16:23:24 +0100")
Message-ID: <xmqqr0xzkfz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> IOW this bit in t/README:
>
>  - Don't use '! git cmd' when you want to make sure the git command
>    exits with failure in a controlled way by calling "die()".[...]
>
> So, before this series a test like this on Windows, with
> GIT_TEST_CMP=mingw_test_cmp:
>
> 	! test_cmp foo bar
>
> Would only succeed if "foo" and "bar" weren't identical, now it'll also
> succeed if 'git diff --no-index' happens to segfault on those inputs.

Well "! test_cmp" is wrong anyway, because it _expects_ two files
are the same and gives more detailed diagnosis when they differ by
giving "diff" output.

If you expect them to be different, "! test_cmp" would give
"detailed diagnosis" in the wrong case, i.e. the outcome is what we
expect.

So the caller must do "test_cmp !" whether the underlying
implementation of test_cmp uses "diff -u" or "diff --no-index".
