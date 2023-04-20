Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B316FC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 16:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDTQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDTQ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 12:59:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB949EF
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:58:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b70f0b320so1708933b3a.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009852; x=1684601852;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WORbkbRelSDwkFcq71Zgb/CymBuj/mgJbMoCEO656tY=;
        b=gxvOFpThQjN/WybohQGd8avMtu0fdwV55xJAXYyBFCrMuoOtWhS/st1IQeWy9uQxjo
         zwiDX7nqkwEAGo1Yk/cDJcDfAElTG0pYa+2ZM/wIiavbtOwyFtr5DKKSpzZFQF2Z6jDw
         NDAxyb6MTs4hQ/oqMuO8NGvkrGv3pQRypvOlH+e367UrKS5fgEP3R1H2R3uY6/zI65kL
         wqemO51ilJ0uNSvqRFzhbyIdqFCn5RbCSNyM+VaeRyHcSuWMBOBfvAiQ2U5/BqEX0764
         K9G3jj0S2XBXVxYKYdrnDEHmKNoPYzMSFr3tOBMQly+8fGrwgwLJM5c95N2Zpi8lHxbz
         Lu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009852; x=1684601852;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WORbkbRelSDwkFcq71Zgb/CymBuj/mgJbMoCEO656tY=;
        b=HIAHPfpPzU97An8ne11iosGwpad50QFJURJeW1k71bsHlSnI3nEycA07rIy+ag5VCH
         7BEGA/e88xfi2R0pdHhu+Gcs5ZlLUwxiQnJMIVXAGynBU7uX6sXEVPHymYO4I1FrIJVv
         WgblI0Jr/sfqzTMUToZWcBSN75OCEzu/FrirLS9y+s38abRtGWyEI0RyFVj3czJKjtOH
         FW14n4XdCiPREocH78ostqKQCeGX7VxGD4WMz/8/KfllhoN1lgO8NrxD7zyXHOkbMwvb
         V8iuAmmB40vDlNAC0dFbkUeIKhHKZKPoTopqOUl0UAocqOFZ6tEMszgy2UxJh8gVlV2Q
         gAmw==
X-Gm-Message-State: AAQBX9epUXtyQKMLiHQGn6bD9jJ98Ni1okLt8Oyi9RngWf3E0CM9DQ3b
        AFa6gg68NUvwRjLkwlad0Aw=
X-Google-Smtp-Source: AKy350be5810miX96IC7evG/rYNXcCYy/4cuaGQM5ADJA3cZEK34OpXAPOpiHXLChKSAB0RyuJsbhA==
X-Received: by 2002:a05:6a00:1956:b0:63b:5082:d9f1 with SMTP id s22-20020a056a00195600b0063b5082d9f1mr2524340pfk.4.1682009851778;
        Thu, 20 Apr 2023 09:57:31 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a00212700b0063b6fb4522esm1497583pfj.20.2023.04.20.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:57:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 01/10] pack-write.c: plug a leak in
 stage_tmp_packfiles()
References: <cover.1681764848.git.me@ttaylorr.com>
        <cover.1681850424.git.me@ttaylorr.com>
        <c477b754e7ddde0d6e696cfd4027ad88c18aeff3.1681850424.git.me@ttaylorr.com>
        <xmqqpm7z7crz.fsf@gitster.g> <ZEFo4iGFTg1UWpL0@nand.local>
Date:   Thu, 20 Apr 2023 09:57:30 -0700
In-Reply-To: <ZEFo4iGFTg1UWpL0@nand.local> (Taylor Blau's message of "Thu, 20
        Apr 2023 12:31:30 -0400")
Message-ID: <xmqqh6ta1og5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> Indeed the string that holds the name of the file returned by
>> write_mtimes_file() is leaking.  Does the same logic apply to the
>> returned filename from write_rev_file() and stored in rev_tmp_name
>> that is not freed in stage_tmp_packfiles() in another topic?
>
> They are similar, but unfortunately different.

I hoped "fortunately different and there is no leak", but it seems
what you said below is a bit different X-<.

> But in the case of `write_rev_file()`, it only *sometimes* generates a
> new name from scratch. The first parameter can be NULL, in which case
> `write_rev_file()` will generate a new name. Or it can be non-NULL, in
> which case that name will be used instead.

IOW, it is a mess.

But I think the topic to introduce that variable is being rerolled
and has no interaction with the codepath we are discussing here, so
we are still in good shape wrt this series ;-)

Thanks.
