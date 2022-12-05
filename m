Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1B3C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 00:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiLEApn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 19:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEApm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 19:45:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CF101CC
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 16:45:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13281174pjs.4
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 16:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inSC0ss+IJldE/2OBVA/jxvrCBJJNmmKy1zMmuD3aiY=;
        b=fHtrLre0HgNp0KnEsDBZ/slF6LT/YY//yUxz7SKKztAVa//HxMSUiq4FMV/eg4MCag
         JkcrmfiNBd7EeAypS1LPyia4lKJ7uSB2Zbym0iJ2gTFIxE3RUCMihev+U6zlDtb4K4ZU
         DcFNkzvazp41XAJukNEaqj4Dc+9DHz0uKJqpjxE6NVRpRU7luPaoVB+HLL+3/g1ZNO6g
         fVzi+0nscIfGyQc+Rr6eXSuD6KjCVGpq/V6t8XidrhwS87mK0Uu57NaBug99WM8ejaN4
         /kM88lZElooeSYzxrGTJV7/V3WGzcXMRTa1FQYQ11L6rHRE3W5QiGnImO4W7jDkQW8J8
         lk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inSC0ss+IJldE/2OBVA/jxvrCBJJNmmKy1zMmuD3aiY=;
        b=xCq3joEUWq9BPkOv1Og6x1BJPQpsHAY68TQuuRO2EjEg973o0BZrdNTzq6b1n8h/8t
         6EhHzJCm7JG/6oqz6MoOpV2V/ur9X4rE0bdvtazZTL2apQRVSp90l0gkzEn0r/Myv1p2
         WFy8bmulkl+GvLnwO33SWLPKYyK+LHJcrZC31rr6U3czkcuKibU58whXHXUzCYLVzdaj
         Y/oVbdzcjAKyTYfNPdBicTIIV3U4QF+R81BuEleo3AIQv6e519vcsPkgC/fPuNmSltxJ
         6IcjRgjp0ZfNP8B+NcVhODLV4LMJem2/JCshu7oYtEU9ZoRzqZS8fo2SevLuubxzit+v
         Qnbg==
X-Gm-Message-State: ANoB5pmJALM3u/AkO56ZA5sFcNYojZPTmcSchmst2ZEoZz8UUG9wOQcS
        Uijxih5LHD2GUZ2uE0Nfuf8=
X-Google-Smtp-Source: AA0mqf69mcu41uPtl+scrn9lGhu9345Yyxx/HpayhQw3wAgzojWF32+a/Bnr+UaXV6gPEoenfN816Q==
X-Received: by 2002:a17:90b:1948:b0:219:bf1a:9dcc with SMTP id nk8-20020a17090b194800b00219bf1a9dccmr5767662pjb.56.1670201140789;
        Sun, 04 Dec 2022 16:45:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79ad1000000b005736209dc01sm8554803pfp.47.2022.12.04.16.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:45:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 8/8] tests: don't lose mist "git" exit codes
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <patch-v3-8.8-37c75f4a097-20221202T114733Z-avarab@gmail.com>
        <CAPig+cTh487GoAnw9CD7i2GmKzAtoG=1hwGdxXHQYoK6Vi=Arw@mail.gmail.com>
Date:   Mon, 05 Dec 2022 09:45:40 +0900
In-Reply-To: <CAPig+cTh487GoAnw9CD7i2GmKzAtoG=1hwGdxXHQYoK6Vi=Arw@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 3 Dec 2022 19:40:49 -0500")
Message-ID: <xmqq1qpeu18r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 2, 2022 at 6:53 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> tests: don't lose mist "git" exit codes
>
> "mist"?

s/t/c/ I thought.

In any case, it seems like 5,6,7,8/8 all are about using $(cmd) as
an argument to another command (as opposed to placing it on the
right side of a variable assignment) that loses the exit status of
running $(cmd), and it is a bit confusing which piece should go into
which one of these four.  It might make more sense to reorganize
these four steps along the file boundary.


