Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FCFCE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 19:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjISTxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISTxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 15:53:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3E0E1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:52:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5033918c09eso488303e87.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695153175; x=1695757975; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lswYXfLTe+XYoOFpAqIo7D6l+Vax+DZ5i+29ThZ8+Pg=;
        b=J+W5YkO1dfY/zXoFzGkV3AuARwYQIsF1Icmfo5Slkdn/8B2ysDTvzxcGLH3svmmyZb
         6mpsx9iUTpwyXnOPmZmhBLXOhfU9CXl8RqHwp7rrvzQxkASxlgGwXj6ds7QF6B+5MVSg
         B6HiKsHL8DFcBLTBC9JlPASFVyAdlePiXwAROR8W6PJMK/EHXkgnmv2RGC/6dEwaGTDx
         XM5357Dd0bstUBw5AhYRsKbCDT3sAUds73jLxdwsmgZP3EhOX4dapPbfeTFHUifQY66V
         UVJIYeGLjydXI5YEU0te/0NZH+oPTdN0axyiSkCFsuOQ53Og9ez8zCRm+kgmvWIAoP/t
         K72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695153175; x=1695757975;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lswYXfLTe+XYoOFpAqIo7D6l+Vax+DZ5i+29ThZ8+Pg=;
        b=Saenyn2ChicG5quzyhNXUALiSUkmiI0qdX/94HH7CdW34reL1mAdhNVjBcPv87NyFm
         tnPxsiH4OhN6NgvTuBmtMv8YhfSN+H4oUAAOruQ6dJqAzr9nO9612fqCmtsbRIEOlRXY
         b6edGlJFHNkKCKYfafmf+zhfdfkYW8NGIAWjavYqP8iYqwkKu4YDWZUXX+riLQgDAoIG
         /o8AZDVTyw6jLVSkn0h0WPetq2WHuh0DpdTNAKlHhOiBQPFCksn/LlxUVkRs1z8/SqYd
         MnnxmwM8jAg5rPwvMUaAu3IgX50Wbh/U0i1xOpEFCk1j1a/DfeNgxHuCnGv6ZvpdSwIR
         G4xg==
X-Gm-Message-State: AOJu0Yx4ikvlzud+poiyaFRwQqsxdKD6UF5N82TQGzeM6b//VZf70gVU
        gNqhx2rew1s3BJXrZhERvU2RpaTbmEI=
X-Google-Smtp-Source: AGHT+IEtdKlGj5Kd3zuFD615yj3rcrXxLB4O0u6oWo/z43sLBICvMt+96KDII8AVaMJvBMiFqf8/kg==
X-Received: by 2002:a05:6512:44c:b0:500:a5af:86a4 with SMTP id y12-20020a056512044c00b00500a5af86a4mr466015lfk.43.1695153174327;
        Tue, 19 Sep 2023 12:52:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t4-20020ac243a4000000b0050096cc3ba1sm2401648lfl.255.2023.09.19.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:52:53 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-2-sorganov@gmail.com>
        <xmqqfs3ktnvo.fsf@gitster.g> <87ttrzhmfu.fsf@osv.gnss.ru>
        <xmqqcyymly5m.fsf@gitster.g> <87v8c7mp1j.fsf@osv.gnss.ru>
        <xmqqh6nqgltw.fsf@gitster.g>
Date:   Tue, 19 Sep 2023 22:52:53 +0300
In-Reply-To: <xmqqh6nqgltw.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        19 Sep 2023 09:38:19 -0700")
Message-ID: <87il86q6sq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I was only trying to help you polish the text you added to explain
>>> what you called the "legacy feature" to reflect the reason behind
>>> that legacy.  As you obviously were not there back then when I made
>>> "--cc" imply "-m" while keeping "-p" not to imply "-m".
>>
>> Your help is appreciated, yet unfortunately I still can't figure how to
>> improve the text based on your advice.
>
> If I were doing this patch, I would start from something like this:
>
> -m::
> 	By default, comparisons between parent commits and the child
> 	commit are not shown for merge commits, but with the `-m`
> 	option, `git log` can be told to show comparisons for merges
> 	in chosen formats (e.g. `--raw`, `-p`, `--stat`).  When
> 	output formats (e.g. `--cc`) that are specifically designed
> 	to show better comparisons for merges are given, this option
> 	is implied; in other words, you do not have to say e.g. `git
> 	log -m --cc`.  `git log --cc` suffices.

Well, to me this piece looks much harder to understand than current Git
documentation, and then seemingly contradicts current Git behavior and
implementation, as "log --cc -m" is not the same as "log --cc" in the
current Git (so we can't say that --cc implies -m), and "log -m --cc" is
the same as "log --cc" due to absolutely different reason: -m and --cc
are mutually exclusive options, so the last one simply takes precedence.

In the current Git, as documented, -m just produces separate diff with
respect to every parent. Simple and straightforward. Users don't need to
learn about --cc, -c, --raw, --stat... to figure what -m does and if
it's what they need. Unfortunately they still need to learn about -p,
but I'm already done trying to promote this simple change.

>
> The rest is a tangent that is not related to the above.  I suspect
> that this also applies to newer `--remerge-diff`, as it also targets
> to show merges better than the original "pairwise patches" that were
> largely useless, but the right way to view what `--cc` and other
> formats do for non-merge commits is *not* to think that they "imply"
> `-p`.  It is more like that the output from these formats on
> non-merge commits happen to be identical to what `-p` would produce.
> You could say that the "magic" these options know to show merge
> commits better degenerates to what `-p` gives when applied to
> non-merge commits.
>
> Another way to look at it is that `--cc` and friends, even though
> they are meant as improvements for showing merges over "-m -p" that
> gives human-unreadable pair-wise diffs, do not imply "--merges"
> (i.e. show only merge commits)---hence they have to show something
> for non-merge commits.  Because output formats for all of them were
> modeled loosely [*] after "-p" output, we happened to pick it as the
> format they fall back to when they are not showing comparisons for
> merge commits.

I admit you are very creative producing these views,, but currently
these options just imply -p. Simple to understand, useful, works.

Overall, as you don't like my simple clarification, and I don't like the
direction(s) you propose, I figure I rather withdraw the part of patch
causing contention in the re-roll.

Thanks,
-- Sergey Organov
