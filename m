Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A7C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 10:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiK2K7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiK2K7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 05:59:16 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7515CD0A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:59:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e27so32784972ejc.12
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 02:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ioF3dG9FSZmxjTs5MbUM3QbHj9Rz5UwWmBujpLm5r0=;
        b=b1+cm5zoLbc1dcIlXNKqyfYn8I1tCpxfqCZAz6lhrUoDQjvQp+FynL0hBECLldRjAC
         FNDgTk477IHanVKQZHKMgpEZn6kWrlSmf5jmtabv0Gb5huomU9qZbSbD5OBLhJKFuLUu
         vSP0vBlapwFDNAJuRvF1M/s15NyhBDXACzE3riDsHxdjcOHp2NQtuq1YW3v5ncSV9anz
         HxhCQL/HVauVeadPn1YOez9L2Uh6s1rVsu+5XB/IBkRrheNE+c1jEGVrvXZqmma8IibS
         PXMqKviwBfLcOpiXHT86ovnul4TEUNFAZZArlj7ZcAEAlEwfZtNhoDYkIP4v6TKK4lzI
         VWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ioF3dG9FSZmxjTs5MbUM3QbHj9Rz5UwWmBujpLm5r0=;
        b=iAMGk7uZ/NMvW7I5E1Dg1MqCW0tFMQg9V2obXD50APmIxk9ZMoqnay2Is1h98XCUpd
         yHlL2XytqrZXfyFE/oISk2nZNByACFo77yMeC2QtC5RtLSVplq82prPSDcxCwNEN9dJ/
         c6t3IU2+34nbsIJ6tuB59N/tfnNyoXtOVYdtgIl64xzIeBVgEJt5p5TrfILobjYHG9Sb
         OdwJvheffE1WLde9WyUjogden5g//CFOqsEBfY5U/U7KpLqebTTaUBCg3e10oJGaLm3O
         NwXIfn6qtJ5m5KNo4BRS4gwVjj8uOy91zyyb2WaBWPoJ5xkwRcz/5IFNUDCWmYK9WEyM
         CdaQ==
X-Gm-Message-State: ANoB5pm5v16o34BxLrE1GxZSmRMZEpRprG/p6Q3ZCKedbkZ1YaN7PEjx
        l8Fmo2fAMVRuK8wXl3HT3jrnekEVw3RUZQ==
X-Google-Smtp-Source: AA0mqf734MGy22auC/cH43T8gDdEvATs6pQyXsGIeIwfFZxoTjrlhfGjcT9kkaON+PPnyFloUnAfsg==
X-Received: by 2002:a17:906:a20f:b0:7bf:f0e9:1cde with SMTP id r15-20020a170906a20f00b007bff0e91cdemr7801576ejy.512.1669719554346;
        Tue, 29 Nov 2022 02:59:14 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l16-20020aa7c3d0000000b00468f7bb4895sm6152161edr.43.2022.11.29.02.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:59:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozyKX-001NnO-1g;
        Tue, 29 Nov 2022 11:59:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ping Yin <pkufranky@gmail.com>
Cc:     mailinggit list <git@vger.kernel.org>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
Date:   Tue, 29 Nov 2022 11:52:38 +0100
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
Message-ID: <221129.867czejabi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 29 2022, Ping Yin wrote:

> Result of "git diff"
>
> -  =E4=B8=BA1
> +  =E4=B8=BA2
>
> or (if chinese can not be displayed correctly)
>
> -  <E4><B8><BA>1
> +  <E4><B8><BA>2
>
> Actual result of "git diff --color-words"
>
> <E4><B8>[-<BA>1-]{+<BA>2+}
>
> Expected result of "git diff --color-words"
>
> =E4=B8=BA[-1-]{+2+}
>
> or (if chinese can not be displayed correctly)

I think we could provide new ways to do per-language diffs, right now
you can use --word-diff-regex, but it would be handy to e.g. have a
built-in collection of those (or other non-regex boundary algorithms)
for Chinese etc.

But as for considering this a bug, or changing the existing behavior I
think we'd need to deal with:

 * We (approximately) split on space now, which is certainly
   ASCII-biased, and outside of CJK fairly somewhat universal.

 * If we're going to split on "real words" in some cross-language aware
   way, are we going to run into conflicts between what different
   languages would consider sensible rules?

 * We probably don't want to make the "diff" dependent on the user's
   locale, but e.g. saying "I want a Chinese diff" via a CLI option
   would be OK.

 * Even for say Chinese, there's probably interesting edge cases when
   it's combined with other languages or character sets (e.g. Chinese +
   HTML).



