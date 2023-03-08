Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5EBC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCHWkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCHWkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:40:12 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A2D13E9
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:40:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id ce7so241994pfb.9
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678315208;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrhuNDLPZKdcpr1CjQY+qKM0Dcp+lMWhsK9oTw2JMRA=;
        b=gUzd6xv+b09b5/xQPq0vCPdCpO//EalCx5W5a3vCIDTXYQYBONi2Q82WL4ttEdVN01
         ObwW7c19jZ3ndrht/MOKpW6OgbUJDGDEnirRatEJKEX4fPx3S+ccqUl8CNl1ZWGoM+1g
         6xzC3E0zATArViJNWOjYXOJrxQmOBu/Q7oscn4kBbZqVOpKvu8SPH/0unrJEXcyToAI5
         Aziog/7EAB7p7lD4IIdJaxLbkVhGzji/B/ASoVAqXggRBN6TRXciEg2sYTg+fIwbfxOz
         bQtqiYzzubeRqeac99rTgsUAvf+egoPD9TIC63M/098+gvhXS+OY7NGIE/ak8R/HZCgz
         gy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315208;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JrhuNDLPZKdcpr1CjQY+qKM0Dcp+lMWhsK9oTw2JMRA=;
        b=tuNzzLZSYgcYtHppMeI0qjLveVonEfbOisfaTlfGkQjbjPPd73aE7ZpKD1OkH/E5tR
         4g44GIBPxpghCbBvc3WRlc3LfkPiGjSgIH8OwX9rUDbHHTp+GQOzgHhFqyxRNeqC8W/g
         yrsu4TND6Vp+JFW1PyWfhkH8ljy+64D/GwJLrWujDNaDYFqXKt3E+1IfeEG96DTPUegc
         i5fxrkOLepx87PeuxUeIkQtHxEhrBFYQwthmhPGaBwN4Bjk+5PYtr3MZVCdkSlyjaZZX
         XFrZQeFU++SgpeoFofeHKG7Koqft8pRWh7vCkTlxavbEjtA57yz+Gc9R937gxL0ODWRE
         Xm6Q==
X-Gm-Message-State: AO0yUKXzlScSEwZ7eEst/oA1PPdFjusBlQmEL++yq1tI5H6vZf74/o7M
        6ZmRHwHtb43OjnvHyzgawQc=
X-Google-Smtp-Source: AK7set9OE/65Mw0PEECNH11qiGvevDRViSegFgiNeLVcMaixKTBmJlYrMVEJJZHNaqIuKEIaWs8g3w==
X-Received: by 2002:a62:7b94:0:b0:5ce:ef1b:a80 with SMTP id w142-20020a627b94000000b005ceef1b0a80mr16549653pfc.32.1678315208244;
        Wed, 08 Mar 2023 14:40:08 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c22-20020a62e816000000b0060c55702438sm9812971pfi.48.2023.03.08.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:40:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] t1092: add tests for `git diff-files`
References: <20230304025740.107830-1-cheskaqiqi@gmail.com>
        <20230307065813.77059-1-cheskaqiqi@gmail.com>
        <20230307065813.77059-2-cheskaqiqi@gmail.com>
        <xmqqy1o8xuis.fsf@gitster.g>
        <CAMO4yUHEDtZfu+NgsWNjckxAun9kU+8GoyB_poWT8Lam095Wtw@mail.gmail.com>
Date:   Wed, 08 Mar 2023 14:40:07 -0800
In-Reply-To: <CAMO4yUHEDtZfu+NgsWNjckxAun9kU+8GoyB_poWT8Lam095Wtw@mail.gmail.com>
        (Shuqi Liang's message of "Wed, 8 Mar 2023 17:04:52 -0500")
Message-ID: <xmqqbkl2sw8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

>> We create a new directory that is outside the cone, with or without
>> using the sparse-index feature.  We know we are violating the cone,
>> and have to override the safety with the "--sparse" option.  OK.
>>
>> What output do we expect out of "git add" to match in the two cases?
>>
>> > +     #file present on-disk without modifications
>> > +     test_sparse_match git diff-files &&
>> > +     test_sparse_match git diff-files newdirectory/testfile &&
>>
>> As "diff-files" is about comparing between the index and the working
>> tree, the new path should not appear in the output when the sparse
>> checkout feature with or without the sparse-index feature is NOT in
>> use.  Does the picture get different when we are sparse?  IOW, would
>> we notice that we now have newdirectory/testfile that is supposed to
>> be missing in the index and show that in the output?
>
> I'm a bit caught up here.
> Do you mean I need to add a test for "git add" also?

Not really.  The above two tests are happy with _any_ output coming
out of "git diff-files" (and "git diff-files nd/tf") as long as they
match between sparse checkouts, one of which uses and the other does
not use the sparse index feature.  I was wondering if we want to be
a bit stricter than that.  Thinks like "not only the two output must
match, they both must be empty".
