Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF812C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 12:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiANMJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiANMJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 07:09:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F5C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:09:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 30so34302514edv.3
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2/njUzgCRJy2qyftH1v84qhPoq7USJ8hX91PUPdtXNU=;
        b=TsSBNAfhBM+uMk90cZOClxVwDKl5HVQRXD2n1QFvHkgEnvPmfNwIeIvfACG+p/ZImW
         XxnhlYhR8VfX5jUTKCvttv281klyrMm2wBhfRPZi8oORntZJhHF/GYXLurXxI/8UtnRL
         h7R8pDmpfitwYCrtwmz31P/SRuVUn0QUD4q3LYZ/WpFehrptFR4yiBwii4+ftGrFypNA
         2UBjW/a5ZQWZNt1s2CwN7Dc5lydmx3twvgv9de7Edzg8FWXM6dnvEiureoVc/U/CP7gD
         dswqSEhcgYaOZV12bKdgHfcKx2O5r0fUw7v6voFIFZ5AiKT8GjndIgb4s9v0Ehf99wUv
         FZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2/njUzgCRJy2qyftH1v84qhPoq7USJ8hX91PUPdtXNU=;
        b=7zwiD++hAgcEImbFbRJ8FUlxUCDUAE2eBidj9MfOWUsoF4WwRGtPL8qn1L1oidERvk
         HgZozecN0EVOPbo5itkFpqKEUGXvxxNSlg4yUb7CejB7ur9/e0vRr4pVz3q9MJfQT+xz
         mIAbEQZDsYUvheAz01/4ZrJSOkEixHjmL+CIsRy4IAix4CacANhYoRwYNX88nn/ntqvR
         SZilKeJ4I3RmKGHGSLcVlmD7QG73oPs8sbKCU8a4vtF8VUekuJWzKGc+znqxcf5ge3w4
         Bah2A6qpf+U1qsoQXzFvXypmGXvmQDv67+E9CsFw6GRbAuvqcsWW96EUcfvjNZet0CgD
         /OWw==
X-Gm-Message-State: AOAM532gdxjlBtjBUx96D8lX1DIRIUXBjqGawGyQ9eahX4DbTbyOfeEm
        7BhvUmmyqKFYutEjV2Ol0KersFG5+OQ=
X-Google-Smtp-Source: ABdhPJzRmoB+cL5uU9lvS5v/l2OPkTka4oEENnCnmncTwF5G4l1aWkYuMlQUw6BsTdCoMc/zThyiNA==
X-Received: by 2002:a17:906:7944:: with SMTP id l4mr7217918ejo.598.1642162145408;
        Fri, 14 Jan 2022 04:09:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id di18sm1777976ejc.56.2022.01.14.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:09:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8LOC-0015Ps-4T;
        Fri, 14 Jan 2022 13:09:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 1/6] object-name tests: add tests for ambiguous
 object blind spots
Date:   Fri, 14 Jan 2022 13:07:53 +0100
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
 <patch-v7-1.6-28c01b7f8a5-20220111T130811Z-avarab@gmail.com>
 <xmqq8rvjgszp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rvjgszp.fsf@gitster.g>
Message-ID: <220114.861r1att7j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +test_cmp_failed_rev_parse () {
>> +	cat >expect &&
>> +	test_must_fail git -C "$1" rev-parse "$2" 2>actual.raw &&
>> +	sed "s/\($2\)[0-9a-f]*/\1.../" <actual.raw >actual &&
>> +	test_cmp expect actual
>> +}
>
> That's dense, especially without a comment (or named variable) that
> hints readers what the arguments to this helper (and its standard
> input) ought to be.

I got rid of the named variables from v6 in response to a "shift" that
shifted the wrong number, but perhaps I should have just removed the
"shift"?

> As long as messages from rev-parse on the error stream never has
> more than one abbreviated object name on a single line, the above
> should give us a copy of the message with expected object name
> abbreviated to $2; otherwise we might be missing a /g in the sed
> script.

In the v6 you rightly commented on the /g that was there previously not
being needed :)

So I dropped it, in this case we can rely on only getting the
abbreviated output.
