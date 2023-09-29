Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FBBE743D5
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 00:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjI2AvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2AvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 20:51:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9732139
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 17:51:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77acb04309dso484223039f.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695948662; x=1696553462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KexeUcIdRLhH68qqAB4ijUDW1YwwgOq+7EvxhN5QTRg=;
        b=iuH2vqJkz1ux8iz5Rc2/KdL/zqMlDl3rfJyiYkpu9ULuy0uL+Em7gHbGa4oAzLrZda
         Yl4/bwd3RK+w68E5Ayi/Gk47Z90qmlMaAbbF9gJloMy0xhpX6LkdieRP5S4WrE6xNmRr
         I+fxtEXlFK0XCL03dfjY0ih/8X+v9FK9s3cbuTb+xRoPNx8FH/tB9wU/uhG0dNxWUyX2
         nO8UtMIhxEXH/IsqznMiJayhoWJ9Ba7njLabDLx/Oehnb/q8BamjS3tZYOb6HZBK3WnS
         iRNydjT2L/0u25H6CJLlsdbIdjLPcjN/tEbeuSuVr/EWqDBS+XlIgja2WB5CvRMxzxyj
         ikEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948662; x=1696553462;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KexeUcIdRLhH68qqAB4ijUDW1YwwgOq+7EvxhN5QTRg=;
        b=LmjAbwelRSldccJqyih9VWKGCVaTPqH9tV+uZsiCxyoGINFymBar65ZLXH9SLsOtiR
         vWgbtA2HjGgKkrAqORJT/k3Rv/Ymgia68Tvy3uZSDPO1d3knjosQq5IEkdSvIbbSx+tz
         Eyk6xECfNVlUcnQx4EqyKSM5NDLlZNu0U+PKcC4YWf2tdVFeWDwmrPKiNzPHek1sqV0m
         wtHYUTnt2S7bQIXoXYT89M4h7QnhFf6wDWOdptElG1HGTbGD09lAF8bxgOiuoTJijsW3
         EHlUeGCH0kSsSoUAdXC3wZdIv+nYxq63UkrrS+YasZc3qCOg6se7B6jGhTiXtBhc7hjt
         V9kw==
X-Gm-Message-State: AOJu0YyH8BZwXuSYMFTXNjJi8bqHBKkH121lJoC9WPFuQ51euNq0E3l5
        TO0Qh869wugsppN2Ed7JREM=
X-Google-Smtp-Source: AGHT+IHTDOj6990Xy1XUxZ/j9SqQvQ1jQRxNZUEghE12/GYoTjp+Hfn5jMJBSSUSXkHbCAdmJGq6cA==
X-Received: by 2002:a5e:8309:0:b0:795:fa0:c13 with SMTP id x9-20020a5e8309000000b007950fa00c13mr3254687iom.12.1695948662220;
        Thu, 28 Sep 2023 17:51:02 -0700 (PDT)
Received: from ?IPv6:::1? ([2602:43:385:e901:7c55:391e:ead6:bb51])
        by smtp.gmail.com with ESMTPSA id x5-20020a056638010500b0042b54797bdcsm4942188jao.58.2023.09.28.17.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 17:51:01 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:50:56 -0500
From:   Eric Biederman <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqbkdmjbkp.fsf@gitster.g>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> <20230927195537.1682-21-ebiederm@gmail.com> <xmqqfs2zl2iy.fsf@gitster.g> <xmqqbkdmjbkp.fsf@gitster.g>
Message-ID: <409703AB-9349-4AF4-ADE8-750EFA768074@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On September 28, 2023 3:18:46 PM CDT, Junio C Hamano <gitster@pobox=2Ecom>=
 wrote:
>Junio C Hamano <gitster@pobox=2Ecom> writes:
>
>> "Eric W=2E Biederman" <ebiederm@gmail=2Ecom> writes:
>>
>>> diff --git a/setup=2Ec b/setup=2Ec
>>> index deb5a33fe9e1=2E=2E87b40472dbc5 100644
>>> --- a/setup=2Ec
>>> +++ b/setup=2Ec
>>> @@ -598,6 +598,25 @@ static enum extension_result handle_extension(con=
st char *var,
>>>  		}
>>
>> This line in the pre-context needed fuzzing, but otherwise the
>> series applied cleanly on top of v2=2E42=2E0=2E
>>
>>> Subject: Re: [PATCH 21/30] repository: Implement extensions=2EcompatOb=
jectFormat
>>
>> "Implement" -> "implement" (many other patches share the same
>> problem, none of which I fixed while queueing)=2E
>
>
>The topic when merged near the tip of 'seen' seems to break a few CI
>jobs here and there=2E  The log from the broken run can be seen at
>
>    https://github=2Ecom/git/git/actions/runs/6331978214
>
>You may have to log-in there before you can view the details=2E

Thanks=2E

It might take me a couple of days before I can dig into this, but I will d=
ig in and see if I can understand and fix the build failures=2E

With any luck it will be something simple like forgetting that {} !=3D {0}=
=2E

Eric=20
