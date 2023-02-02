Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E46C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 10:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBBKlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBKlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 05:41:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A772279B
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 02:41:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so1522754edb.7
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 02:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjbSqZ6X9d5PKUbl+pzfL6Y/zuGuWYnbTpYdtI8FHdI=;
        b=o3v5l2sUy0b4NEIdrihiEgRofSjLI4ULpuV32XFN5Cw22YK1Nzee9MGWn7mk937cZ0
         vasvk7CqoX9cULhMmSm/FMwQhnfccreylysyS6bRK5mOHfTspdb1Hiw5u5SEXWVFy4Ad
         2CcfR6zw7f6H2Z9DWPeSsRX6fXf9Sa92G4s1Y+BfRVXszphiVjKXH2F9JzZgyy6FW61a
         bHtRylMJn3Br8NUMuIcVq9nvNGsVqC1wgnAjlGe+SoEMCu12EuIlIyCSx0+4DsVj5IKG
         1Y/tS2VKs5D2lQI0UzGx2bxqR9uVFfGcTQt44UWJE9mBbr0Tcu3JjclPf8BLNwGmfHkS
         1P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjbSqZ6X9d5PKUbl+pzfL6Y/zuGuWYnbTpYdtI8FHdI=;
        b=2cBtT5N+OK/Lkze84f/vRC9VpyzR0allxjVjzLtfIcbz1zCceP7ETYe1lYLBgVx90D
         v4Lqjyp5BJO2mXu+r/vj605SkxDBSTD03kM+JslRx6cf+p/tlsASAvQgf+6lIWO5IDF4
         OdG4FODWvJ0anBJrkJTaEpBGhrP24p3FzlyWSglFjbMlRqdLL2V481gXv0n67bI2+E/D
         7MV6xN8gIkL7BG2q5Tm4rnnrcTrpGKPOwcIgvZSIRxOJCY3/bW+6kRjXmPXSXbqmqX0u
         wQxhXVin2sxGn9uqibdErJRqPkLuODnviyeXzHqRCUMvn7zRRgdoe7RwYmPNp5VVqji4
         VChQ==
X-Gm-Message-State: AO0yUKXF2ZxEKoZWYusCR3uq8VbJ0fV2oyjS/ewQybAzbKxB9qcP7jPW
        7c2TaLAay2uomyNlu/aTfNs=
X-Google-Smtp-Source: AK7set96kDjKH+CZ4ujJxBw864FV1zVSg8vXC1Gia53TAuz6z5bp3Bmzv1jW7MWOGv+0zS18oXSxKw==
X-Received: by 2002:aa7:d612:0:b0:48e:bf0d:f3a8 with SMTP id c18-20020aa7d612000000b0048ebf0df3a8mr5380120edr.38.1675334463453;
        Thu, 02 Feb 2023 02:41:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id dn10-20020a05640222ea00b00482b3d0e1absm11021029edb.87.2023.02.02.02.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:41:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNX1a-002fjc-0s;
        Thu, 02 Feb 2023 11:41:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 9/9] git archive docs: document output non-stability
Date:   Thu, 02 Feb 2023 11:30:45 +0100
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com>
 <Y9uPhPnNFlCju8Fo@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9uPhPnNFlCju8Fo@tapette.crustytoothpaste.net>
Message-ID: <230202.86ilgkpcxt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, brian m. carlson wrote:

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
> wouldn't have been allowed.

I don't see how "we'll do our best, but it might change" precludes that...

> We should probably just state that "we
> won't promise that the tar output won't change between versions". Maybe,

...but it sounds like you'd like this "softer" promise. I think it's
saying the same, but picked the "we'll try not to" wording because I
think it more accurately reflects reality, but...

> "We won't change the tar output needlessly, but it may change from time
> to time."  That is, we won't be "let's change the format just to mix it
> up for users", but if there's a valuable patch that could be applied,
> then we might well take it.

...here we're back (at least per my reading) to basically what my
proposed patch said. I'm happy to improve/change the wording, but I'm
confused about the "because it implies" part you noted.

> As I said, it's my goal to provide more concrete guarantees in a future
> patch, probably this weekend.

I think that would be great, but also think that if we're going to make
new guarantees it's probably best applied on top of a series such as
this, which aside from the reverting back to gzip as the default
attempts to clarify the status quo.
>
>> +* We promise that a given version of git will emit stable "tar" output
>> +  for the same tree ID (but not commit ID, see the discussion in the
>> +  <<DESCRIPTION>> section above).
>
> I think that section contradicts this.  The tree version uses the
> current timestamp, which would make the archive change based on the time
> of day.

Thanks! It's referring back to the previous discussion, but I managed to
somehow get the tree & commit cases reversed.	

>> +While you shouldn't assume that different versions of git will emit
>> +the same output, you can assume (e.g. for the purposes of caching)
>> +that a given version's output is stable.
>
> Unfortunately, this isn't actually true if someone uses export-subst.
> That's because adding unrelated objects can increase the length of
> abbreviations, and then the tar contents can be different.  I've
> actually seen this in the wild.
>
> Modulo that, yes, I agree with this.

I didn't know about the export-subst case, I'll add that caveat in
there. Thanks!
