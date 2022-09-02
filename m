Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9852BECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 07:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiIBHPb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Sep 2022 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiIBHP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 03:15:29 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660826AEF
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 00:15:28 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id t184so1948351yba.4
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 00:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZHifAYcft954hZknXy5LFlXShPuL2yDdJUHBODnapvo=;
        b=SKeXbytFe7tydu05Og5UYjwkX0jFtAkcKWjdeOujUydVXmPb1Ua2tFwqROobqenST7
         wn4rsQRRJ/QapQuk27ASwfA57seeJD57duXzfNFgwUfyFD7Z2wVCxf1koEfqq4cPCdrZ
         8KAPk2s4cycuK/eV0sHDe2yW2wV5rKj+Zx8GcKzmA73CvWbzysOaKlcWE3TADcGKTljQ
         3nUFgibdkhYNYaHI5sCpIEtYgC3OpkGs9bKMnWHHbf9HPkVl13bOqIRd81Gnpws9ZvQv
         T6N8CMiBCyYvQ/lxnzjMkOMZ08qV1ivZuGPQKMLrzFO8TZrVzNn/ta1osjD5f3ylgZbb
         rUgQ==
X-Gm-Message-State: ACgBeo3beMcvNdw33wLt9wVbje+BjzifHvKsFfLjmq2+Ddq4wUshawBj
        ca8MbK/3eQjWVzZQySJSJK6DEBbk23oZPy6jK5O7kyTnXYI=
X-Google-Smtp-Source: AA6agR7hH0kJaoYLdzPTHENY6/ycb1mzPb8d7cD85FIQOV89DpMnuYDsppRlp0JAP8Nzzte5RT2OQP4yeqkg92bKsTc=
X-Received: by 2002:a05:6902:150b:b0:695:6547:be9a with SMTP id
 q11-20020a056902150b00b006956547be9amr24526980ybu.475.1662102927692; Fri, 02
 Sep 2022 00:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cTAN1F1D=DxZF9jbUiTtc4UPnx0hZLLaVFKEecAa-gMsg@mail.gmail.com>
 <20220902063958.2516-1-oystwa@gmail.com>
In-Reply-To: <20220902063958.2516-1-oystwa@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Sep 2022 03:15:15 -0400
Message-ID: <CAPig+cT0dWW9XCEsjdtUGV3as=+jftp13PVREDW=FPM-Tkgozg@mail.gmail.com>
Subject: Re: [PATCH v2] rev-parse: Detect missing opt-spec
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Git List <git@vger.kernel.org>, ingy@ingy.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2022 at 2:40 AM Øystein Walle <oystwa@gmail.com> wrote:
> If a line in parseopts's input starts with one of the flag characters it
> is erroneously parsed as a opt-spec where the short name of the option
> is the flag character itself and the long name is after the end of the
> string. This makes Git want to allocate SIZE_MAX bytes of memory at this
> line:
>
>     o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
>
> Since s and sb.buf are equal the second argument is -2 (except unsigned)
> and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.
>
> Avoid this by checking whether a flag character was found in the zeroth
> position.
>
> Reported-by: Ingy dot Net <ingy@ingy.net>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
>
> Thanks for the review, Eric (should I then add a Reviewed-by trailer?).
> Fixed the casing, added the suggested trailer, and remove the
> superfluous test_done which indeed was a leftover.

Thanks for addressing my minor comments.

Since I only scanned my eye over the commit message and patch text,
but didn't actually dig into the code to verify if the fix was
correct, a Reviewed-by: would be misleading, so let's not add that
trailer.
