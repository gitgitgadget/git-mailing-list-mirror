Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B8C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88A92076E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmd9qhxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHEWo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHEWoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:44:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2DC061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:44:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so36905609ljn.11
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3/87Vklc9csfx9Y+abd6MH1HnNsmxwjo6TgY+7LZ9Yg=;
        b=Bmd9qhxTioc5JgdI6Ff9p9R2f9q3SoVHl4ry5fClZtB/PvK6ePvebsHEyra0CuvGKy
         oOXa3yLW4J9UsPg6/J9bsIFz3kFqB7GIDhvDyStLBTsdiSqQwyoTyW2jLpsWFxRXuHw/
         2BdzLCftGulWUNHhQry2KykYzntYiEm4aXw9TiV3cEFfKuDzXCXYFGvDrYq4U6J/KXFx
         DJe7AyqgpxLthZeHJe8vp3O0cXX1NuL42Zhm48Gw2T21kn2TFPgzjvhAXV5F2i9rByQ7
         qJ4Hrso5jNxsLQ3dqHRHHSFxKpvSKuzTfcbwCuP8ozmgE9fM5qLlU6Z0BmWj7z0WoIwc
         Ui1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3/87Vklc9csfx9Y+abd6MH1HnNsmxwjo6TgY+7LZ9Yg=;
        b=hwB44y8rzJmZ2x5a1Ng8vrhutTdXVWI8UokgiHh9k4VeQHRd2BJt2AfRScYxoWML2L
         /1MeOKqZ8UMeckdNVIMWazqx90fMDe91MlQ2ETc7T0Zy1sKKufxkrMmLNFTnZ5eYvExT
         zMYFHQm1JcbGpm428LXRiRLA7nljJA6iiepREpfwXp1X4hgFanhdghdRBFR1C6Xy6gFV
         UVLTtiUhEeGH/I8FXHodLxigaqiTowmdqZF0aAl1bSAgZMiGUmiApoGtjfmZR/tbpc3/
         CYGl5Iyy2Y/5YenZG0XV19dmVoHZG804wU82t7Od4FGLKm9JFh5rLoyg+LW0r7Ur9rDd
         5b7w==
X-Gm-Message-State: AOAM531YonSgi1sydarjKHaFXDkV+BenJ0CF9+1PXHumaTHHJSIikZsf
        JcH7SPf4gGIHw+6f2KvjvGGmBv6A
X-Google-Smtp-Source: ABdhPJwjUjAh3qn0N0bVVQikRxdsoRdKFz1BRWIjfcDdXlHo94HmtbydYF1Rzgta21nhhZt43U5FeA==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr2325401ljp.247.1596667463537;
        Wed, 05 Aug 2020 15:44:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u10sm1469580lju.113.2020.08.05.15.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:44:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com>
Date:   Thu, 06 Aug 2020 01:44:22 +0300
In-Reply-To: <xmqq3650n2rc.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Aug 2020 15:31:35 -0700")
Message-ID: <87lfisk915.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  t/t4013-diff-various.sh                       |  1 +
>>  ...--diff-merges=off_-p_--first-parent_master | 78 +++++++++++++++++++
>>  2 files changed, 79 insertions(+)
>>  create mode 100644
>> t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
>>
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 40e222c94520..86fb11cecc61 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -298,6 +298,7 @@ log --root -c --patch-with-stat --summary master
>>  # improved by Timo's patch
>>  log --root --cc --patch-with-stat --summary master
>>  log --no-diff-merges -p --first-parent master
>> +log --diff-merges=off -p --first-parent master
>
> I think we want to also test it in a different order, e.g.
>
>     log --first-parent --diff-merges=off -p master

Dunno, why original Jeff series didn't need 

     log --first-parent --no-diff-merges -p master

then?

> other than that, these three patches all look good to me.

Thanks,
-- Sergey
