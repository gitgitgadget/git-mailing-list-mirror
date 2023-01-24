Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B8C25B50
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 00:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjAXAzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjAXAzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 19:55:40 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6D36FDC
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 16:55:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z3so10189967pfb.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 16:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E33AgR5LjZf1EU5FItAXH4azkRPAcmSxk9kx6z+zInw=;
        b=Zpcr1pbfXEMaJ2wktSppUe7uRT/44ufjGYV70LaJdI2K+GLYA7rNUhaDkfoKTPSBcb
         KImVrXh8TM55oiy05g24IrQrmtJK2VfL93PLvOe711UyTmyqnQIilVkxW0PnypxjlRPG
         YlAVkj8BdMg2FLkpCxG5VtuvaGlKvIXFmHXie4SCzKUXtm2xhGrmNUgzTfEq6K3f9wIp
         cQz3xMPqIKM6JxqEd0Mp3EOnR508T9slfi3XMHl3IUj51rqWncNjmDTs+tZsQf6quuu0
         NvtlQOwpQzg5PHAMx0lf7yxdeGDnMIBiaAfuG0MEVn8RR30mk4b0XkTGW+DLIkNkDND/
         W5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E33AgR5LjZf1EU5FItAXH4azkRPAcmSxk9kx6z+zInw=;
        b=vTWjZwAbZbERloWn6e/nPhG7m5udGCFCUSiSrgSXw/FNvObY/FjWXe8lawALG+J406
         wSgazqHP+Tj6us+ZFmygUFvHuF7BommolpFg3mlgE3izFKgP57G0/XT6cq8PWlTLSS/d
         u8DgQGMiQ3C0hlVlp0OhLZ0+RZH/W07nSNSAq9C3e1g1tiWO1FeeOXEl8cjG7CWT3e6f
         Pkj91DbDdvZVf9ErFYOMGfUS1fJOHYsD9pGgsSexmyETTa3PSd64urP0KjsfswpuusMQ
         Lx+G7x4ESmGMN/xMPmx35aBvP8V3HuUsPtGmfYxuUpmdM23P/JPMLuzKQK7MB5gYekQ8
         7cHw==
X-Gm-Message-State: AFqh2kruQEDVDBazavjkMxm5OFqWHv5eOSn9rSmnNadWl2lke/kQ+nMv
        +dWq5W5ABpMOj6S312kxrkc=
X-Google-Smtp-Source: AMrXdXsnc+DjH0Abfyif2AvWKdyemg3YvUKAhASCQami/w8kTUki0lQWgcCSaxizSuUnn6OsImbcHw==
X-Received: by 2002:a62:870f:0:b0:582:bb80:58d7 with SMTP id i15-20020a62870f000000b00582bb8058d7mr48971302pfe.26.1674521738609;
        Mon, 23 Jan 2023 16:55:38 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n37-20020a056a000d6500b0058215708d57sm209442pfv.141.2023.01.23.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 16:55:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH 5/5] hook: support a --to-stdin=<path> option for testing
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <patch-5.5-cb9ef7a89c4-20230123T170551Z-avarab@gmail.com>
Date:   Mon, 23 Jan 2023 16:55:37 -0800
In-Reply-To: <patch-5.5-cb9ef7a89c4-20230123T170551Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Jan
 2023 18:15:09 +0100")
Message-ID: <xmqqtu0gkaye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Expose the "path_to_stdin" API added in the preceding commit in the
> "git hook run" command. For now we won't be using this command
> interface outside of the tests, but exposing this functionality makes
> it easier to test the hook API.

Presumably, the send-email validation topic would be using this
immediately once it becomes available, no?

When "git hook" finds and runs more than one hook script, do they
get the same input?  What I am wondering is if "to-stdin" should be
exposed like this interface (which may be sufficient for testing
purposes).  I imagine that scripters (e.g. send-email developers)
would find it more convenient if they do not have to come up with a
temporary file and they can just run "git hook" and feed whatever
they want to give to the hook from its standard input.  "git hook"
command, upon startup, should do the reading of its standard input
and spooling it to a temporary file it uses to pass the contents to
the hook scripts, in other words.

Other than that, it surely looks not just handy for tests, but has
immediate uses.

Thanks.
