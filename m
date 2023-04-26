Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EBBC77B7E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjDZUYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjDZUYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:24:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D061FCA
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:24:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso57949005ad.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682540671; x=1685132671;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L22PNVgKdBZ478VeLAXujHqdKC//yM93s80zfpCEQCc=;
        b=quibJxdqs+v6/4PWOrYvkblISDF1xuA0pkoggvmcZ8d2l65lriDu6aaolLM4gZpjZ0
         5wPzzEqVJTMCSm9QnWV+XxwiJPgrGYAkmFIB6eLJ8+eBvkqrZcuCoWlEtvrnBpmvcONs
         ul3JU4VRPau43oDR4UQmEz5xBXlkB1Rd9ewgIdsOpvKN+t9XldAKL3cqXuaSajFA2Ly4
         zx8U/GTIq2PZ0qiKpc6Gmkd6yGqHEV3vutC9XWl6D8cGS+f4s3f09ShX86qEmDt9hXom
         yFOyOC/ADL2stB/wC0Ax2fLuDDUWDTHHu6IYTlNIaLwAD0FZVy9/dJjAkzYnMMQILHvO
         tINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682540671; x=1685132671;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L22PNVgKdBZ478VeLAXujHqdKC//yM93s80zfpCEQCc=;
        b=dVTrScS0fJviKPlkmu0HzZ5fCgHNa2o5bM7Ha7ps0HZM7wnSBzmie3/YaMBLA9w784
         RGjdY+JVQR04emSHf08M+y6f6bUbZnahYBFfP+sa6TZQT8PvcXqsqqPYR+BefdYi9SOf
         yk1DAZmnQHqWB1N3GhD3r113OOs0exo0zsuXj6lIqpEyRtEkug1/ONiszXw6hSfS5PI1
         knXVp4uGtW6l/Ud2xl5w3emn3y/bnPKRDtsRu4YbFe5MTVdDagRaE66cR2w5YfYIchfV
         +Ah9kLq2P0ItHXF9QKtvAFyLpgTQpjs7hhT2nvFRl83Kz3P6srtAUvEgVbtYVlfh11zR
         S4Yw==
X-Gm-Message-State: AAQBX9fHMrWbnHMbTrr6ZL7lk+bGoSxcqHYZRnAOjKcHcx1E+W64eIQc
        99xoN+wzCk4sJOtMdz0fa70=
X-Google-Smtp-Source: AKy350YQU+X1wfXubQAVGPc4sjrKlZEgro1ukRczG7WATAo/OhugiPisdQhNkhdk2v9lbEObZtEEpQ==
X-Received: by 2002:a17:902:d50f:b0:19e:b6b0:6b3 with SMTP id b15-20020a170902d50f00b0019eb6b006b3mr29547950plg.15.1682540670725;
        Wed, 26 Apr 2023 13:24:30 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm10353668plk.168.2023.04.26.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 13:24:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Patrick Steinhardt <ps@pks.im>, <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
In-Reply-To: <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com> (Jacob Keller's
        message of "Wed, 26 Apr 2023 12:14:57 -0700")
References: <cover.1681906948.git.ps@pks.im>
        <6446e3db4702d_cd6129452@chronos.notmuch> <ZEekRNuPmObU9Vsq@ncase>
        <b8225865-7eea-3dcb-247f-10cb22899b2a@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Wed, 26 Apr 2023 13:24:26 -0700
Message-ID: <xmqqa5yus879.fsf@gitster.g>
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
