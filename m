Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE13C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7A96102A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFQRJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQRJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:09:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD81C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:06:52 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so6869620ott.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kyL8WEyJJ3hy55XIu5G/7Ev+7Zf0Inf1sqLMZ42iXwQ=;
        b=Ua1Ln9BGrAcjKlFfcXBeeOUwFtmhgPnnTCegOkLDld8/ckpRvxum+1SUpHlx76Sm8Z
         QhdpeuQ92LWhLaTUUdcxivnMqo0yqc/k2v4Y8J7P/PEzLEUw4g/SOkBjWboz4K0aRYI6
         Pt7YvqQNOj9RFGYu3v3ofKh2BI90HoAp1Q4MNGUmalKArZoqOxeIltcQ2qitS9JXvmEI
         U+09BJwxbDzduUYa3tyKDhw1W4wWXVCgki4p19wkHt3r5uQHPgSVngVdwVRgYHfs0nmW
         Cc20kcI4ARr3mL6memDm6gFF+gIJXAFz6nkEGsvKAkstrSxL4inCjxB6gdxOmGv/jMpg
         BSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kyL8WEyJJ3hy55XIu5G/7Ev+7Zf0Inf1sqLMZ42iXwQ=;
        b=uSggxTk8lNhxoRH3m7ThgyafVXavps1LirCXTGcXd27UHp1ZUqDYpC80mGfKs5v/Dr
         QSBF7stTIQqGADBM04o3PTUH8R4UBlB/nqYX3+RDMnPPmPOlhMHrAVpQXR+2Vi8lp3rY
         0GLY+3/zd2vU9/wFsqpCcF3XW/hBMVqOhzc2C53YS0/hLcDOvLbYSOpaR1xHhHAOJHOn
         1Yxr74V85r0onQEginpop/1sZNOjfEpURSYirrvxpQPD2vaR4OydBtGrHgtKXHEKH0+a
         AZTz9sdfmAdfa9zhn9sMm6JsV+Wm+uhAIbeowzipmN/UbeTlIWz3JuMfiSZUwNJ3AN7e
         uVJg==
X-Gm-Message-State: AOAM533nTTuiORFbq1JwOEgoC6G3nzyi+2caCzOe7Fzuh6a0ebMQtib9
        t4c3BlgU7NJM2oCJnzddhB4=
X-Google-Smtp-Source: ABdhPJyR9KAlLET2eD5ubORBEoZJdmDr7e3pFMsR+BezoDAIKah8RKTho3FhEtCq8EQA9aBF7NYcBA==
X-Received: by 2002:a9d:4592:: with SMTP id x18mr5471712ote.74.1623949612248;
        Thu, 17 Jun 2021 10:06:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q9sm1061251ots.1.2021.06.17.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:06:51 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:06:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60cb812a1be73_13057208ef@natae.notmuch>
In-Reply-To: <87o8c4wkn7.fsf@evledraar.gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
 <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
 <87o8c4wkn7.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> I'm suggesting that 5% of their time would be better spent on something=

> that clearly has direct applicability to the maintenance of existing
> code and documentation, and the authoring of new works. I also think it=

> happens to gives you 100% of the end result you want in terms of what
> code/docs we end up with in-tree.

Agreed, but what about *our* time?

I feel like we already have spent more than ten times the amount of time
this non-issue warranted. Can we return to do something actually
productive?

I vote for a moratorium on this issue. Can we leave this as it is and
return back to it in a month or so?

-- =

Felipe Contreras=
