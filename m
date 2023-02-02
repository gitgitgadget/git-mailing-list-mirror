Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B32BC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBBWKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBBWKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 17:10:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0C63853
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 14:10:15 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so2349646pga.13
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvkirxIGryTxvk83cqyuOC0nse2ye9ULTK4mzXqoKcc=;
        b=DALTwlGhOF4OTA/4ylAwIkIWhZvWtfw8iO5nt9a9x6f26L0DiRp/MSb/dVaYu9xH5X
         FxLA5zkfwkhm44uCYAk+qD3N+jWWewXTy13lmsisTbsm3JhLNc8uxlxLKZWpJXVNHL3v
         t5/CgSgRKh9ehWv8t+y2kJyqJ+3kvURO6td7tlI13uocdqzDvEUAY+HCHyLQnhEqYnWX
         O1VXpy4P3wXHiOBg9IS28GbWFUw8TOf+HUjom/O0k8o+CNyjYXcQJIv1cuaKw6gXmUmv
         pCp4YOpUvTaEid9GYUosyBi2KRQ1CCVKk9q9HIABkILJqju+X/FkCU6AMWGlMzuBspUe
         b/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvkirxIGryTxvk83cqyuOC0nse2ye9ULTK4mzXqoKcc=;
        b=OuVLLbN/mndk5RIkcVInNHMVb7g0SNKBdTDkil0L/CXDSGbRDe8pln3/XaviOAnbkM
         hnPuKO5gutIvsYFhsRLNF3jzpy2YDNYTYFGcqDyYOlVR05mFPLnZ1LolZysg+7cC/iFB
         V95Hc/SE4Tz/TnKLas0kMcOqJ7OsgNegCgMjA4BheuBp+srUX78vgXPN+6prYPId0qub
         PaCR3wQgOBF/cczQPZiyangqLEN+LgOl+FwbL8XDTwsXNH/Dzlinm2ZR6inS6eqCLJcu
         oORbEhrSWVi0DXU22U8NCXURSWN2XqJRHNNujYydyoOR2cMai4QRIBPivY9OD39DrOhs
         2Uvw==
X-Gm-Message-State: AO0yUKUGF7S7EQ8pHELy9gPPFsLkv480dlQ0QSCuuYuMGDDUBDAte59a
        LNM3i/JRtHQ+IwY71NJRxEg=
X-Google-Smtp-Source: AK7set9xBtT5T5/ec/aCJe81SL9lFwpE8OM13fATY/M0xTscoXCSSG7k075Ha8vd3/vq5mh0xmQJnA==
X-Received: by 2002:a05:6a00:1d81:b0:58d:bbf:8bb1 with SMTP id z1-20020a056a001d8100b0058d0bbf8bb1mr6451852pfw.14.1675375815183;
        Thu, 02 Feb 2023 14:10:15 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id n16-20020a62e510000000b0058dc1d54db1sm152689pff.206.2023.02.02.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:10:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 18/19] push: refactor refspec_append_mapped() for
 subsequent leak-fix
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
        <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
        <patch-v6-18.19-aa33f7e05c8-20230202T094704Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 14:10:14 -0800
In-Reply-To: <patch-v6-18.19-aa33f7e05c8-20230202T094704Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:52:49
        +0100")
Message-ID: <xmqqk00zsoqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The set_refspecs() caller of refspec_append_mapped() (added in [1])
> left open the question[2] of whether the "remote" we lazily fetch
> might be NULL in the "[...]uniquely name our ref?" case, as
> remote_get() can return NULL.
>
> If we got past the "[...]uniquely name our ref?" case we'd have
> already segfaulted if we tried to dereference it as
> "remote->push.nr". In these cases the config mechanism & previous
> remote validation will have bailed out earlier.
>
> Let's refactor this code to clarify that, we'll now BUG() out if we
> can't get a "remote", and will no longer retrieve it for these common
> cases where we don't need it.

Another thing this does, if I am not mistaken, and the above does
not mention, is, that the old code called get_local_heads() for each
and every ref from the command line, and the second and subsequent
calls to the function and assignment to local_refs would leak the
entire local_refs linked list.  This step does not release the
linked list at the end, but at least it stops leaking it in each
iteration of the loop.
