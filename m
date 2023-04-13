Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA9CC77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDMPGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjDMPGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 11:06:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ADB8A46
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 08:06:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so1406941pjb.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681398410; x=1683990410;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Je+0xazmNIxE+xT6JufOFIXnvMMtNBcV+PV7HVOj+Ms=;
        b=N8FleQpIg/OAJWDUoClFCi35dwShsqW4ZU8GUaG4LU/LwxkTG0RAGkCYkVrjP1v7Sj
         D9DbI6cVUXgizjF0TgA0xszyKHwoSzwf9ew2bAL7XOmZ/eF9bsak/Dw9quUQM7IbI5X2
         H5RYi02YiXF20adyQqPTUwx3tMTmUEWzdyJ4i+DPOR1imPSjWH76xP4gT+f1t1+k3B9/
         UKkD+Uvz/sZaf/pD+GhPL0QbuILRmMm4ZNaCRxvYZJ+oUa2V5xQI1Yof+6895EYVzum/
         qll65EuX+4VqmIwddLOCsYQsj588hlJfONQPxZMM2DJbLUMl7AvUf6PWm+iw4PfKKKjM
         sCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681398410; x=1683990410;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Je+0xazmNIxE+xT6JufOFIXnvMMtNBcV+PV7HVOj+Ms=;
        b=Q7yKZAVxDHT5dkAWLVmtELjzyT409OGhoFQL9SELK8Uj/a8jOOyCA8M/y1vo2jzam6
         NbIPJaHivdZIZsTJB7ZJKKky/yATncGDPfBjccgRZWRSwY6IdRJLFpJeHTFWjfkatxEs
         0aYPCj8YIbDaWPHMzJK8vWGcCBE+RMziJJeLv+0bhTpq5R+jkB6cv3vBwHXaioZOIHtA
         3jT5d0tvcQlWKHtrIg4HyPSoFqYM3YzEXeakRrKaEQyMo9MnZBrkBhKIPF9T6K2GKuM7
         vWHiN1e1UgFamkDgSnSTG4hhYaUqa3XbGVT9VN5n0ypvhPTiv5CA7XHxDsIfgKyyhz1T
         hNRg==
X-Gm-Message-State: AAQBX9c6lBAH+JqOWB7sz1qW9nT9MmilTZ1iU7FpdN7OiXQcS/kVol4s
        AwpeQoMX5W8g9cEG7PbCpdskOvJk7Kg=
X-Google-Smtp-Source: AKy350YJ7bJHZkLlacrdWRvS0weUkS1NrKRrw36dsunZO308AnFC1lC0DoiCmffAIOBkEfS9i3+Ohg==
X-Received: by 2002:a17:902:ec8b:b0:1a1:465b:2d22 with SMTP id x11-20020a170902ec8b00b001a1465b2d22mr2882203plg.47.1681398409835;
        Thu, 13 Apr 2023 08:06:49 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001a68986a3d8sm1346568plb.24.2023.04.13.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:06:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2023, #03; Tue, 11)
References: <xmqqo7ns69sz.fsf@gitster.g>
        <6d572a02-0e20-1cf6-db6c-7306ac912049@gmail.com>
Date:   Thu, 13 Apr 2023 08:06:48 -0700
In-Reply-To: <6d572a02-0e20-1cf6-db6c-7306ac912049@gmail.com> (Andrei Rybak's
        message of "Thu, 13 Apr 2023 02:24:53 +0200")
Message-ID: <xmqqildzzurb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 12/04/2023 23:59, Junio C Hamano wrote:
>> * ar/test-cleanup-unused-file-creation-part2 (2023-04-03) 6 commits
>>   Will merge to 'next'?
>>   source: <20230403223338.468025-1-rybak.a.v@gmail.com>
>
> I wanted to wait a bit to hear back from Ævar Arnfjörð Bjarmason and then
> to resend a v3 with any necessary fixes and with "Acked-by" trailer from
> Øystein Walle for patch 5/6.

Thanks for stopping me.  Will look forward to the new iteration.  No rush.

>
> https://lore.kernel.org/git/CAFaJEqug4bghEMnEQzGDN10EqM8e8iSf5i12AvOm+NZzDCQKOw@mail.gmail.com/
