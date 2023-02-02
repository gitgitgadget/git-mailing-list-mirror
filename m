Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C9C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjBBQe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjBBQeq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:34:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46AE69B06
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:34:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a850400b0023013402671so6070442pjn.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tx/8Xo6Aa62Xzea3Ub+qC+jpwW81CoiLGw1P+nMUj4=;
        b=a1vifOI6DXOgCGsQwgT4gn12mdFpgHbjrWmUHuz3DRq1Oqqd/zdJPblMXa7XC8pnQS
         ca4Ytz5viomOJe5Xtog/bZY8ijDmVr0ARfLYOHDOlvGWSjk5ZDJOX+iWo9KCEy7Ws3Hx
         Sd8o+dEFHQykZNW9Pt0FkkxcdDUqj6e+cyGFXgwpMYWttXFmT79KrfLZ7aVW+TVj41kn
         nk75SH+OGNQpr8Llo0hduhSj0kXEXjuD5XMySVWYi6Nd8p8IQW8RswapQqGwfUCCUuoW
         MzgCTf4p50zZ5nkgXbKbkQjAsHTmeu9wuJoQWsvA/asjg56jr+6H0Bd/hc3HzgUzoKkj
         CKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tx/8Xo6Aa62Xzea3Ub+qC+jpwW81CoiLGw1P+nMUj4=;
        b=KSpS4GEzP1LGFawP7a5z3ATgTwquwuvdU9+TWsJOg9XZy/Sw8tT4jTi+bngxSVgMzD
         1Hc8z5bW+sZnUKp+Gr+ilW7tZREnqrl/+XFVcFogutndY+4RKZvR13f/LIqttuPZ42qE
         jlsjDAsdCrgm47+8tSiNLEEjYBtysax5Oj3gwFQMoiLqhu3xAyo0yzgaKjSZDGeHJTXI
         gTlOb5tXtdVIlqcx8zmpQDzpJLWrYiCHt1kn53Ma7/7kldpyDyhb5Pzc82UhgHBiNvU8
         SL7UFJbR3c7hwz1IFwVnMnczuV3tf9YhYuGWyNoF/KWRowiHsmFGNuLO9EkG0kuV4X7M
         mvow==
X-Gm-Message-State: AO0yUKUfumHSKa+YK0toKtriy5jek0hPVZ5FbwZOyZB5utQMx9qlM4X+
        E9MF9HaTzAZB1QO9H+idlTs=
X-Google-Smtp-Source: AK7set+KbfabHymUguyFhFWDOGovmU7dkSPg3WyCtvrLcVmejyMil3D3LuYO/K780ADIVYrMTefipQ==
X-Received: by 2002:a17:903:187:b0:198:c4ff:1c6 with SMTP id z7-20020a170903018700b00198c4ff01c6mr2331976plg.4.1675355685156;
        Thu, 02 Feb 2023 08:34:45 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b0057709fce782sm13860362pff.54.2023.02.02.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:34:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 9/9] git archive docs: document output non-stability
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
        <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
        <patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com>
        <Y9uPhPnNFlCju8Fo@tapette.crustytoothpaste.net>
Date:   Thu, 02 Feb 2023 08:34:44 -0800
In-Reply-To: <Y9uPhPnNFlCju8Fo@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 2 Feb 2023 10:25:08 +0000")
Message-ID: <xmqq1qn8vxej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +* We will do our best not to change the "tar" output itself, but won't
>> +  promise that we're never going to change it.
>> ++
>> +If you must avoid using "git" itself for the tree validation, you
>> +should be checksumming the uncompressed "tar" output, not e.g. the
>> +compressed "tgz" output.
>> ++
>
> I don't think I want to state this, because it implies that the changes
> I made that broke kernel.org (making tar.umask apply to pax headers)
> wouldn't have been allowed.  We should probably just state that "we
> won't promise that the tar output won't change between versions". Maybe,
> "We won't change the tar output needlessly, but it may change from time
> to time."  That is, we won't be "let's change the format just to mix it
> up for users", but if there's a valuable patch that could be applied,
> then we might well take it.

I agree with you.  Giving "will do our best not to" is still too
strong for that.  We won't change the format willy-nilly but when
there is a good reason to do so, we should be able to fix or improve
the output.

>> +While you shouldn't assume that different versions of git will emit
>> +the same output, you can assume (e.g. for the purposes of caching)
>> +that a given version's output is stable.
>
> Unfortunately, this isn't actually true if someone uses export-subst.
> That's because adding unrelated objects can increase the length of
> abbreviations, and then the tar contents can be different.  I've
> actually seen this in the wild.

"subst" is certainly an issue, especially when the substitution is
unstable.

There shouldn't be cross platform differences to break bit-for-bit
stability at least for "tar" format, as we do not rely on any
external library.  Can we say the same for "zip"?  I thought we
throw the blob at git_deflate_*() so the exact bitstream is up to
the libz implementation?
