Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC620C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 07:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiDEHt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiDEHsr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 03:48:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEDD66
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 00:46:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dr20so24757729ejc.6
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 00:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uRppzkHzzyFdl+RbxW3NuJfIykIbyydrLV8qf9Nxf6I=;
        b=j0Z3of2a9dSG65tnqW+TgDTAepGXWsH728n1GcBnfl6YbjnEd0flsK9RMZG+jF5TNQ
         O6ovPFZOVHFQS95+yhSBfsxBgg9cYaRI0Uwjudt5jw/1sJ8PPj0Qq9FXBfOMAIP1Nwv8
         aMUutqgsLZWJSi3CqBSQjFsSVZKK7osPD0G4PZNkntUYZIbumJ2JlXftltRTEjHb5bgK
         f6G8JRI0Ma+hfl6Ig1KWbIvX06aLBVqkBRU9AaKPdV0BsKe5yM0bGatnpUBME+TlCnpQ
         kN+jdgd+R/ScLVZ75NMVAQk5WSKqZTIGQgtLWJ9ycF2N6YzTsOAksS0dj9CUzMKs+ZTN
         vd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uRppzkHzzyFdl+RbxW3NuJfIykIbyydrLV8qf9Nxf6I=;
        b=u+C3db52HjSXO4iI+4+faJQ5HX2kkILg1zTUhGn+HiJRZdWf8MYvmC1pac9tFfZ0In
         MJHQNLZqdQtqwlkk+R3ETPf1reLc3cejc9oXskMpm1q4ZbhRsV2vb1DejN8HfW0Jn7bV
         8ns5CHMAqjmXFpH0kPMASM6E67Fcj32DDJdxSqJuprHPZQlBFMnxymIQGYt3KyXtbhkz
         PsBdlousr4YCFagPei6ZN5g7KozP8B/eF/K53WVi//5Z6pmERExby9uZRNDozDM92T0q
         8SOI2C2VIfpqb5bBcX8+r0aK0/xGvx5vR1wzzNBLz2ReVIPaVthPppg6PiwQiIRKE18r
         9+8Q==
X-Gm-Message-State: AOAM5314TkWj3tvKKntuMjJVJnUqe0tMjttVDACbu0/xgna+hr5jCy6i
        5imeEyK2nBoAu66eU57EWUlqbL7YIVt8Qg==
X-Google-Smtp-Source: ABdhPJyBpY1hFDdcp1VOO9oHismEiZ+QGoCvU1SkbIcjlH2CSq743nCPxjfIE81180N8ZdjdhjOiRA==
X-Received: by 2002:a17:906:a057:b0:6cf:2736:ba65 with SMTP id bg23-20020a170906a05700b006cf2736ba65mr2196500ejb.171.1649144801431;
        Tue, 05 Apr 2022 00:46:41 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bp11-20020a170907918b00b006e6d451dc36sm3571512ejb.49.2022.04.05.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 00:46:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbdtg-002p06-1E;
        Tue, 05 Apr 2022 09:46:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, gitster@pobox.com,
        whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] blame: report correct number of lines in progress
 when using ranges
Date:   Tue, 05 Apr 2022 09:46:10 +0200
References: <20220404182129.33992-1-eantoranz@gmail.com>
 <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
Message-ID: <220405.86wng4km5c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Bagas Sanjaya wrote:

> On 05/04/22 01.21, Edmundo Carmona Antoranz wrote:
>> When using ranges, use their sizes as the limit for progress
>> instead of the size of the full file.
>> 
>
> The progress limit is defined by number of affected lines, right?
>
>> +test_expect_success 'blame progress on a full file' '
>> +	cat >progress.txt <<-\EOF &&
>> +	a simple test file
>> +
>> +	no relevant content is expected here
>> +
>> +	If the file is too short, we cannot test ranges
>> +
>> +	EOF
>> +	git add progress.txt &&
>> +	git commit -m "add a file for testing progress" &&
>> +	GIT_PROGRESS_DELAY=0 \
>> +	git blame --progress progress.txt > /dev/null 2> full_progress.txt &&
>> +	grep "Blaming lines: 100% (6/6), done." full_progress.txt
>> +'
>> +
>> +test_expect_success 'blame progress on a single range' '
>> +	GIT_PROGRESS_DELAY=0 \
>> +	git blame --progress -L 2,5 progress.txt > /dev/null 2> range_progress.txt &&
>> +	grep "Blaming lines: 100% (4/4), done." range_progress.txt
>> +'
>> +
>> +test_expect_success 'blame progress on multiple ranges' '
>> +	GIT_PROGRESS_DELAY=0 \
>> +	git blame --progress -L 1,2 -L 4,6 progress.txt > /dev/null 2> range_progress.txt &&
>> +	grep "Blaming lines: 100% (5/5), done." range_progress.txt
>> +'
>> +
>
> Why not using test_i18ngrep?

Nothing should be using test_i18ngrep nowadays, just grep is better. We
no longer test with the gettext "poison" mode which necessitated it.
