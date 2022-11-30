Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998EEC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 22:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiK3W0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiK3W0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 17:26:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7674A92A36
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:26:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3366286pje.5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZQLvDuiqCsz5V4VXnCuyRFaqlsgOvEaZGKIsA0r/ks=;
        b=iWE2W5eeRMDmrj8rB0jZ1IPKE4Qbc7EwayVUilUg4AJMN+nFhAmhmJ3WpUylxFHZ/h
         /fHit8i/oRBy1hIwzDub30FDca/f4jNh/jpOFH81ddZwMJyUyj5J6J+Wr2T7n9Okrz8n
         DiLbgNnHGIwP0zfxhlLvTVdWQJzgUY4AxI8WLeW9UDBc9UF6SQNi5Mm42MSYpafFpyxD
         kAnrgFTcDqjPbvIcu6xTH3z9pc9oZXEE1ADpQPNIQbQVKXsTyF+VYY5L5rETtwS38N+E
         ITOsu/QSU2fDvudt39cnqbgg9CnfautRnu6FllqViB9B5ARTeYj27+w1bf+/VumZomEN
         O6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZQLvDuiqCsz5V4VXnCuyRFaqlsgOvEaZGKIsA0r/ks=;
        b=l27B0e0C/dqIORFqZjo8tPr4bRqt3fCY7ErlDc3ZZ95y6mOEne9P7fWouxE/8xyU2p
         SbU14ERv4v3mn33QevFGTKROtooaV1DDKmAsCJ/FfSI+9UQKv3XZJOdvN6eV66KqriTD
         iNM0S77X8TJk0cgG+RwuNinX1+KQOZXs0x+vl/DbVXnZFaetqaQ0R3BPouaItgjl4JvL
         86NpEjUbTW3zC3ZrZKl0SbT6C1LD1GFofJ0Q9UOn9I/8OGKJdVR49aF8bjm3MV17AFam
         jaiYlOrFQ6CWnwJWhaOgcSsdhae5Cfo5fTwbzh6SU8xoDU/ZsQTk4i5P5fc0yNWv2GWu
         uFfA==
X-Gm-Message-State: ANoB5pmdgZq90k2ph5IRHjepUKcMA5Ju0M18Djj6CuU/RZxbpGBXLRIa
        ant8aXBWBlWYHWuBn+VQYR0=
X-Google-Smtp-Source: AA0mqf5+Z0pOolb2O0A4itc766U8Qmp+uZmOtxn8lQn4G2piN/vIySMSpvrwMMgZeIkS0LOK+IB7oQ==
X-Received: by 2002:a17:90a:14c5:b0:20d:bbe5:f35e with SMTP id k63-20020a17090a14c500b0020dbbe5f35emr66185556pja.120.1669847179695;
        Wed, 30 Nov 2022 14:26:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a420800b0020a7d076bfesm1699759pjg.2.2022.11.30.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 14:26:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cocci: avoid "should ... be a metavariable" warnings
References: <patch-1.1-31af153702e-20221130T082521Z-avarab@gmail.com>
Date:   Thu, 01 Dec 2022 07:26:18 +0900
In-Reply-To: <patch-1.1-31af153702e-20221130T082521Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 30 Nov
 2022 09:28:23 +0100")
Message-ID: <xmqqlensulit.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Since [1] running "make coccicheck" has resulted in [2] being emitted
> to the *.log files for the "spatch" run, and in the case of "make
> coccicheck-test" we'd emit these to the user's terminal.
>
> Nothing was broken as a result, but let's refactor the relevant rules
> to eliminate the ambiguity between a possible variable and an
> identifier.
>
> 1. 0e6550a2c63 (cocci: add a index-compatibility.pending.cocci,
>    2022-11-19)
> 2. warning: line 257: should active_cache be a metavariable?
>    warning: line 260: should active_cache_changed be a metavariable?
>    warning: line 263: should active_cache_tree be a metavariable?
>    warning: line 271: should active_nr be a metavariable?
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Thanks.  Queued.
