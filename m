Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A698C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC1OL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjC1OL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:11:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB8B45C
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:10:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x15so10937920pjk.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012552;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN1wrp49hSzvkl8MAgdiFk0mugBO6G0qyelo67btn6I=;
        b=DkW8uYx7I8kyLugzj/2K+ChpSmt8tAb8qL2xnpC6kOMsK+/HV78IaJ+TC8rRTstLpP
         XUvqnkauk8ej54JdmXoWTDfHhsGWXnk8BbJZUPLcFL2O9mLgjGNhCqxqpLWu/QjQZ741
         d2vMKk8/BE/qadZ3HJyEnxY2ojn4CI2N5I2plvKeL+QwV8eLgpeyEqDb1LHBzyy5X64i
         cfn1dW97OBXqVin76aJtKoCyfZ2NYElEdeVIZevZZge2W/TOSkHvHOJZwRpYuNi2Px48
         2sNKWlylv4VaAGFZ8Hw506lc0xUofZ9D0EWcV1CU5Vxx3OlmLb+GQAHLF4yQcvlOVIg8
         RigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012552;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN1wrp49hSzvkl8MAgdiFk0mugBO6G0qyelo67btn6I=;
        b=5n8olfyK3fTg0ehJLaJ6g1+FnMhMvtHmZ1bBsRqqi+uMKk4kbIzja7C0zjyNQQBA8S
         QiCax10DFhKUsLOo1tQqOwuixvcTVYG+6d7vuMyGdto8i1KQ7s2c4jlOLbxBCQTx2/y3
         qXwGTY4POAStBDKUtL/y5lqY1F+20xMcMBZpG8OPP9+5bX4XNcOulKYomTxTQdKq33PV
         g9RngGaJ0uhDj0VZbxDKUV62QC8Z092s31tNrE+wWbU8KzA0tObrlcWxKpGXtZMQ4Uai
         UFwyK3lPf5T1G/LZGqysBJ1Ug+Mz6YE0+JWeuTMhdPBw877wbKIagyQxqQrs3ZGDdkb4
         PfOg==
X-Gm-Message-State: AO0yUKXLIwlhKe6dh4BF8fTnKFgu+QnxQrmGBnIFNS7lNcTfvqoz7JUn
        ygOocer5ItgJld4TU0XFzl4=
X-Google-Smtp-Source: AK7set9/iPzyZqsEzXFbA08br4UXyqZEUQlM4cGDvMaUaRZWmEFcvV+spjV9Ql4xlNCA/PVEqPwWDQ==
X-Received: by 2002:a05:6a20:85a7:b0:de:1937:ecef with SMTP id s39-20020a056a2085a700b000de1937ecefmr12104216pzd.24.1680012552109;
        Tue, 28 Mar 2023 07:09:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78dd8000000b0062d7d3d7346sm4553812pfr.20.2023.03.28.07.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:09:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
        <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
Date:   Tue, 28 Mar 2023 07:09:11 -0700
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Mar
 2023 15:58:41
        +0200")
Message-ID: <xmqqpm8thss8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A v2 of the removal of "the_repository" wrapper macros and adjacent
> cleanups. The v1 subject for this said "the_index", sorry!
>
> See v1 [1] for a more general overview. The changes since v1 are
> trivial & best skimmed from the range-diff, just a rebasing,
> clarification in a commit message, and a typo fix, thanks all!
>
> As before this has a trivial conflict with "seen", but this time
> around the conflict is different, but it's trivially solved as before,

On what commit is this targetted to be applied in the first place?
It does not look like it would apply on the same base as the
previous one is queued.

Thanks.
