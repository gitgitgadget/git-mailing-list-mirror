Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E79C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC0E207CD
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 21:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH3BOtWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZVzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 17:55:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3A6C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 14:55:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y2so4134917ljc.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FBTgi1Urj+M8VhJr75K04kg96/WXsiKHhfa1lrk/rNY=;
        b=YH3BOtWDuOdm/OuLB5HmyTBHFBantK1E87SGI7s2vgioDltK1KnLt6xWPcTKOvNV4B
         UntWhcG2hQLEb2cu522z2lwMT7OtI1gyzwjw4AFtuXp2Qp86J7PRq6htsd/J938FseZ9
         ZImz3SPFJNzPNIAjtlEQL2L7paECiEtbp6bU+qJ+EAFiPzGmk9eaNvHuSyOQhpeJDEbY
         7OeuYMCoiX9LIP0oTqD6/Nxq5plWOaLM3kPx/RVpgAv8jhjKrlo9AOh7oIPHGITuAv3M
         ai4yhP37snMjp7ASgVj8NRZeuK2QcIxZMVJdgu/ewjEMkN2crMu9Nt+XSdLIR7vdZE1S
         zLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FBTgi1Urj+M8VhJr75K04kg96/WXsiKHhfa1lrk/rNY=;
        b=qF6GDgZQF6H2mx4dxAYhiqWZZMJAmyYlrGK6Ba5WyvJPP01/n2k5cxRR9Q3nhzJidq
         ez0bBs5/ERmYGaPErJVtJDx9TXRE2qvrEsXBDqeXPlluCmiojVnTSakE2Tl5PVSgu3s5
         smQjMGYzBykaPMjQ5KvA95Y+2NtsTSHQNVY4hEVPZh6wUzieANl56+CWAiSzzB61r3in
         +ROPkIousSp1YR8swWIwEj56ut3l3NnZBg9a4W4EltP3H00WYIigJ1FBNlKzHCg6AWEp
         OWffhluttIcr76I9JJgbgYPw/PpQpJyBy7pb3af5kb15oXrn1FJYnFH/Wx9BHe0gkPEz
         qUpQ==
X-Gm-Message-State: AOAM533ZEER/Ti1A8wfYpGen3NaPG9Qcy0jaXDtPUqPYOWUVydf+IbKy
        jdaKG4oqxS3HKwm86CxYgRccqOLk75o=
X-Google-Smtp-Source: ABdhPJzLpwxZC7OtJ3MNa0WRreeuWYnXt2JsjPbwrv/MHP/RbK1oKOoyrTuRINBq1IuvhkJYNvtcWQ==
X-Received: by 2002:a05:651c:1050:: with SMTP id x16mr7621137ljm.457.1598478919964;
        Wed, 26 Aug 2020 14:55:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m7sm2744lfd.77.2020.08.26.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:55:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty-options.txt: fix --no-abbrev-commit description
References: <20200826144923.16806-1-sorganov@gmail.com>
        <xmqqv9h5uw7u.fsf@gitster.c.googlers.com>
Date:   Thu, 27 Aug 2020 00:55:17 +0300
In-Reply-To: <xmqqv9h5uw7u.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Aug 2020 10:56:53 -0700")
Message-ID: <87pn7d9inu.fsf@osv.gnss.ru>
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
>>  --no-abbrev-commit::
>>  	Show the full 40-byte hexadecimal commit object name. This negates
>> -	`--abbrev-commit` and those options which imply it such as
>> -	"--oneline". It also overrides the `log.abbrevCommit` variable.
>> +	`--abbrev-commit`, either explicit or implied by other options such
>> +	as "--oneline". It also overrides the `log.abbrevCommit` variable.
>
> I personally do not think it would be crazy to misread that one-line
> format itself would be defeated when no abbreviation of object names
> is requested, so from that point of view, the original text would be
> OK enough,

Well, I don't think it's OK to essentially say:

  "--no-abbrev-commit" negates "--oneline"

when it doesn't. Yes, I even actually checked it doesn't, just in case.

> but as long as the updated text is easier to understand,
> that is fine ;-)

Admittedly, not being a native speaker, I'm not sure the form I used is
a good English, but at least it's factually correct.

Actually, I'd drop it altogether, to read like this:

--no-abbrev-commit::
	Show the full 40-byte hexadecimal commit object name. This negates
	`--abbrev-commit` as well as overrides the `log.abbrevCommit` variable.


as I don't see why such clarification is at all needed in the first
place.

I'll re-roll if you agree this variant is better.

>
> Keeping the original sentence structure, e.g.
>
>     ... and those options which imply abbreviating commit object names
>     such as ...
>
> would have been what I wrote, instead of "either explicit or implied
> by", though.

Sorry, but it'd then read:

  This negates `--abbrev-commit` and those options which imply
  abbreviating commit object names such as "--oneline".

that again essentially reduces to:

  This negates "--oneline"

that is simply false statement, being exactly the problem of the
original that the patch tries to fix.

Thanks,
-- Sergey
