Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F7C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 22:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiL0WdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiL0WdG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 17:33:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8A1007
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 14:33:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so15150194pjb.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NF1fwHPEh/OC+ItZ4BJCem58YY5IeB3GPNSzVHbkHg=;
        b=asKWp/Q2SXpZCWzUB9XRQ1HiK/JbR4bPdTSIeixwXjER3k49cRJTxSlbKuVIiu6osl
         3GOLrM4PQJDTVK7UuYgTcR20fVK0WwSpBT1HunAfndi52EmkjPfgrYhfpilRlnIceckG
         OjW0CP9wQ397LI6mir8xZTj7eYzhMaIW5h3Oz4m7AwgE8LfeIQ8jVfkaycZob+ZTOIk+
         OnYQ3Fkv/qGW7Lj3EV2VZ7PS1ESySJT90VhXj1nputQAUgH7tIksmKgn0E1ewDAY9msH
         COkvNHrRkaq0vuJvg1EYuIVzv2UNtHRO9lIiRpLWRRD862c3qk2iB2zl41Mkst5GdNhi
         O5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NF1fwHPEh/OC+ItZ4BJCem58YY5IeB3GPNSzVHbkHg=;
        b=5zvm1MGn9OHMkoH8fF5X+kQ1VmKUh1RLr+wa3QZ+K5gw8v5MVpoQpCI202zjkhP6C7
         vetjRFKCZo6Su7Ead1/g+LavgGEDnvUIyjuoclVkBjT8ao8etGJmCUIlJ5c+kHg9eHEE
         OvcKi7CsvpmJh5SzbDkJGtcUnp+be6EGZrHf9HtFDtahcldp+3ZP/wTznGKlZ7jJ0xld
         quenW0XAH+C9lq9/VpxvglIlEEbhqaz9A5u8jnHsFSLcoyZc91xX2tFGHgWDJJKR980I
         Z1GQQl/GMtZT8sRjFSfSN/7QBhjUR1KXQyLJjCJuoj4AiPa0Jml2lZrAt7EP1oeSlx8y
         pJ9Q==
X-Gm-Message-State: AFqh2kp1AXTsW+xao8znlQ9iStrXMdly/itUJVoGVv8hzBGsLnhgCLcV
        +/AEW4IbjICbH3pI0v12aFM=
X-Google-Smtp-Source: AMrXdXsKRsNcW0k+Du6/NqlsGLgHv8RA3q+JwlSuLWG9O9W507pjS6MhqSN8YuQeRXttRc84Yd6EAA==
X-Received: by 2002:a17:90a:4005:b0:223:aa36:9580 with SMTP id u5-20020a17090a400500b00223aa369580mr26131822pjc.25.1672180385038;
        Tue, 27 Dec 2022 14:33:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a16-20020a17090a6d9000b00223fa0148b8sm10804421pjk.41.2022.12.27.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 14:33:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH] cmake: don't invoke msgfmt with --statistics
References: <patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com>
        <45d8d9fc-ca68-5902-0aa7-70034f8383ff@dunelm.org.uk>
        <xmqqcz8e29d5.fsf@gitster.g>
        <221227.86tu1huevt.gmgdl@evledraar.gmail.com>
Date:   Wed, 28 Dec 2022 07:33:04 +0900
In-Reply-To: <221227.86tu1huevt.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Dec 2022 14:51:17 +0100")
Message-ID: <xmqq1qoktr33.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think the only justification that's needed here (and which should
> short-circuit any questions about what someone using cmake may or may
> not like) is the one given in my 2f12b31b746 (Makefile: don't invoke
> msgfmt with --statistics, 2021-12-17).
>
> I.e. this was something I added as part of the initial i18n support, but
> I had no good reason for using --statistics other than ad-hoc eyeballing
> the output at the time.
>
> The CMake recipe then just copy/pasted whatever it found in the
> Makefile, and the two then drifted apart.
>
> So, in general with those sorts of changes I think it's sufficient to
> say that we're not bringing them in line again, unless there's some
> reason to suppose that the cmake version has since come to rely on the
> divergence for some reason.
>
> Which, in this case is clearly not the case, as we're just spewing this
> output to the user's terminal.

OK, let's hear from Windows folks about that.  I do not care either
way myself (after all it is just extra lines in the output), but for
a topic that was once merged to 'next' that later turned out to be
unwanted (instead of simply being a buggy implementation of the
right idea), I'd like to hear from those who have been depending on
whatever the current behaviour is.

Thanks.


