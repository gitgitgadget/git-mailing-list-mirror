Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D75C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDZUXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjDZUXy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:23:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164919AE
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:23:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b70f0b320so9671176b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682540632; x=1685132632;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L22PNVgKdBZ478VeLAXujHqdKC//yM93s80zfpCEQCc=;
        b=VKV0EMgHwWWEYKsEJHR8VXSr1JcJnvjvDNxrAXzU0xFeGg23RMDN7sReytCb9tyqrz
         InUJ09/Ye+p9OKJrrXNSlss6/QH8Ya6YjWLZ4P2PgZ2V/x5CouKVKfCnVft60qRu6JJl
         hNC3nn0gW35UrJfQmtrwp3GV/2o83lStS+ZlsI+KMyJE5D4prbLMzX3DrGh76m/yKwai
         8xKxpqnhm7l0xWSQrrI3C9pY6ocK+nfVLLAlP5VRVdiwT1R0ELkeAwp1bn/rYIhpAhVZ
         Ug1plC3POGLAikaNISStnFixUfLmSp+MQcuTK9phtszr5AJvhBVySkzxCVtzlmT7IUb4
         X6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682540632; x=1685132632;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L22PNVgKdBZ478VeLAXujHqdKC//yM93s80zfpCEQCc=;
        b=FZGj1VbV2u9RpNLrZVxZBtf6Lcs5+Y4jNbhyvek6cQK5sOx2s105bfOBeF2y41qkaY
         RF7/Dl6LNRyX9lK/LFxrVbtpvm94k03rH6f99bpeDo1rrEczFpwUmifoOXevo+i2cxIu
         OVflHbKu1wfZ/zBC3kCIz15tdyDtgs5m1JRWniuYT2XIb44Qqbcf4m9SGt7zLAaELDak
         h3Iy6QnE1cqA3DKAwH81E67ud7AZ/GMKPmelNkBbyXSH+JvbeGrMsynJTvA3ia1w83JA
         klDv13z9AWdWoLRIgH18RwHEzoWU8AuKTGoNwygonPD1v+J8xif2beErSb38lhqjRdV1
         uq5w==
X-Gm-Message-State: AAQBX9fngTB4HvKoAEh1g6BYWyeakVI1VBHivvfFT+gAsM7QvVzkmC0D
        jlbd+9ocYi2jEUPYXMnO7SvFTz891QE=
X-Google-Smtp-Source: AKy350ZUWieKPfxSwsoT+GEZuUQMoEnE0hB8hTjiXm94W/+JTh5PFhMqXICVC7zVsvsI8CC/iXaNyg==
X-Received: by 2002:a05:6a20:54a6:b0:f0:ffb:d1e2 with SMTP id i38-20020a056a2054a600b000f00ffbd1e2mr28789937pzk.53.1682540632232;
        Wed, 26 Apr 2023 13:23:52 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 145-20020a630797000000b0051815eae23esm10122195pgh.27.2023.04.26.13.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 13:23:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
References: <cover.1681906948.git.ps@pks.im>
        <6446e3db4702d_cd6129452@chronos.notmuch> <ZEekRNuPmObU9Vsq@ncase>
        <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com>
Date:   Wed, 26 Apr 2023 13:23:12 -0700
In-Reply-To: <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com> (Jacob Keller's
        message of "Wed, 26 Apr 2023 12:14:57 -0700")
Message-ID: <xmqqildis89b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

>> Yeah, I'd be perfectly happy to rename this to `--format=porcelain`.
>> I'll wait for the Review Club that discusses this patch set tomorrow and
>> will send a new version with that change afterwards if nobody disagrees.
>> 
>> Patrick
>
> We had some discussion during review club about this, where the idea of
> using "--porcelain" came up because many commands use that when
> switching into a machine readable format.
>
> In addition, this format not only changes the output but also moves it
> from being on stderr to stdout, which is a hint that the intended usage
> of the command is now a little different.

A little different from what?  I do not think the answer would be
"other program's --porcelain mode", as sending them to stdout would
be one of the things that make the output easier for programs to
parse, so it does sound like very much in the same spirit as "git
status --porcelain" where its output format gets tweaked to be more
machine friendly.

The output with "--porcelain" option enabled tend to be less human
friendly and the distinction between Porcelain (for humans) and
plumbing (for scripts) is reversed in the use of the word there---it
started as "this is the option for those who write Porcelain
commands to use", but still it is not a very good name for the
option.

I am perfectly OK if the plan is to uniformly use --output-format
(or something equally more descriptive) and migrate and deprecate
the "--porcelain" option away from existing commands.

Thanks.
