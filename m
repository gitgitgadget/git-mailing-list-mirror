Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE980C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 19:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjFLTMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjFLTMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 15:12:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCEAD
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:12:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3db8f3d94so5842445ad.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686597138; x=1689189138;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZwUq8xSI8qRkMl+NZVC1TH9GfyZWJMxu5Rt9t32e44=;
        b=b/a507KZlKr7n8VlG4t+g28oOEBWybNVL1gQ2bq4XLBhgWGUqXAlgTlBo+cjUDhP09
         t4bBnQb0TNfbisosgQn+P48tdO9APIHO3nlaobrbWZsU98dsJF8dAlntyhMtSb2CSeS5
         jyYcCEtO6RmgfFFJEgR3jAcpXa30hAr/TRTsAPNaYn3CdpXov+x7XJB/3fPKvJQDy2BL
         qW6q999DG8CnYT+Q1L/i6S3QfhG6K9l/T6goQfLSiJjBGwmgFYa/oWA+sYBC1lBZbxFP
         VVs3MLshNsoVKuEBy+pW8sx4qXTNRSW/NKIb99bzHObUZ1KBu8ggxLWA/L3Uv3DGYthw
         LQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686597138; x=1689189138;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ZwUq8xSI8qRkMl+NZVC1TH9GfyZWJMxu5Rt9t32e44=;
        b=XAq04KJ6sUnfLesJvQisAqkfA7FDl5dOKsDITf3nq0UWJSdPB7MQFmTn2RyNtEcbDE
         4dDLkPeOuNGF4gmufCezjEe4FmNQVAQiEnFW75s8THnlx7k/+6f+S2jHOsK5FQ6KLnCB
         p9EL71ZigFwyu0RZ0tuBTtK7kzIAFZePGekOhRxpA0ITyUNc01Gp+rLOUCZxcJtF17kn
         tEQKFoswM8QvQJgNP3ZuWoz8t5UZ1AyUTHDFqDGgzHXrwWzEpkmh7sUAFeY+0RUEPL2o
         UG58ZqoD0XdT8bj4Nk0zx3tcua7A4lml2Bfajaonvzbcuf5JFRNfNcGvTHbDtI6ldiuc
         pSXQ==
X-Gm-Message-State: AC+VfDxMcgxpB2hraQWbHaSvLfyCfzH4YebJWJgMRyVjjsiw9UV9oWC/
        sDdF1oLN3FiGnAEC+hXfU7M=
X-Google-Smtp-Source: ACHHUZ44T+gkWFAncmlLooOTqK+Qgb0Z/Gl9vvRT1N1Iki9KLpVEUj2pto9H5YkSZfm0WbbW8kOZlA==
X-Received: by 2002:a17:903:189:b0:1ae:4c3b:bb0b with SMTP id z9-20020a170903018900b001ae4c3bbb0bmr8399157plg.5.1686597137684;
        Mon, 12 Jun 2023 12:12:17 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id y12-20020a1709027c8c00b001b3d6088993sm1904546pll.24.2023.06.12.12.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:12:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
References: <cover.1685710884.git.ps@pks.im>
        <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
        <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
        <xmqq35355utz.fsf@gitster.g> <ZH67eBAtFxo95aBL@ncase>
        <xmqqsfb5np14.fsf@gitster.g> <ZH7Eoj_5oTzmSd4G@ncase>
Date:   Mon, 12 Jun 2023 12:12:16 -0700
In-Reply-To: <ZH7Eoj_5oTzmSd4G@ncase> (Patrick Steinhardt's message of "Tue, 6
        Jun 2023 07:31:14 +0200")
Message-ID: <xmqqr0qga41b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> > That being said I'd be fine to change this series to mean "-Z changes
>> > stdout" if you insist. In that case we should be pointing out in our
>> > documentation that "You should never use `-z` without `-Z` when you
>> > process arbitrary input".
>> 
>> You are not making sense.  If we were to leave them orthogonal to
>> keep flexibility, it is because there can be cases where using '-Z'
>> without using '-z' (and vice versa) makes sense; "you should never"
>> has no place to live in such a world.
>
> Well, that's exactly what I'm arguing: I don't think it does make sense
> to keep them orthogonal.

I was not commenting on that.

My "you are not making sense" was because you said "I'd be fine to
make -Z to mean 'stdout is NUL delimited'".  If somebody thinks it
is a good idea to make '-Z' mean 'stdout is NUL delimited without
affecting how the input is delimited', it can only be because that
somebody thinks that it makes sense to make input and output
orthogonal.

It is perfectly OK if you are not fine to make -Z to affect only the
standard output stream.  That stance is at least self consistent.

