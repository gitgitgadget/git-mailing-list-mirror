Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F613C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4434E23118
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbhAFMGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 07:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFMGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 07:06:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B718C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 04:05:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so1885581qtn.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 04:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ai+yur+arDHmhvmpRENw03Gfb/AriIasLz69EYkNovY=;
        b=IRJJuv8AZ5zlWgvg9sFTGy81rZjWPnOG8ci2tB2u/Im8oDa5nVNSU6jkGRq8MMEvPX
         zDJXnPGTmOgY3QFYkfmr5tcX0FmgKcrkyu3ubLwsSudaBJdM87oK8737rlFCyJgAMoV9
         LMlRofT3+r2zjTv/BN9hx/7I0WYMNUSE4jojqZgV/dXs+A+nFoxWIMsuK118qaCyLett
         PDtUdM0/vNWZRGDDl+swFRC7XSFnCZ8V8JKma+IWAcXCZAs/4qG5w3UjNnd31SSMqgA1
         s03PAssVmpzWK1JqiTYjCgMnzOnvxf/xMvrNCjwp+aq4imiwmvw9mfFQ6h+pzsn132id
         yJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ai+yur+arDHmhvmpRENw03Gfb/AriIasLz69EYkNovY=;
        b=t3DpSQPS1Ar850C0ZNERGDLMTG9HvNwryBavJo8MOi4xwhH0NvgdG86H7iH9DsTl+A
         xvHswRVfTBjg+DCUuFsBE4o66ge71BtZisshdH7lOWpGNpLC0och71gkWiYsq4USapQ7
         hYP2zp19bJUdBUvYpLGcH+BvyKjUgTHRs4XuLvt52W1Ms5+XmWr+5OcpThhkCVKPHV13
         QxtOVqvI1MaZCe97aQz0lsixAbFtLwnawMw4BMtvhwjCY7ZBiIPHdANhsVY4sYxWlYkb
         OajHeRCnnJQpC/7AvnIJoRM+BwLmI+w4+2UmDGoOPh/JdVGdSPkjx3vpglASCEdluIUP
         dZHg==
X-Gm-Message-State: AOAM532VDp/fErF9/0Q00TpD2VYyMIdvY9uiLvNqfksfm5ZSMhHgssOf
        Nh6n5vEHRZxB1A7EKKPeW/s=
X-Google-Smtp-Source: ABdhPJydnL40syT9SECR4nP38hFYdR3SGLpfPryFHveB8/f0UhevnzBsoibRXAryavT/tk8EMkt7Xw==
X-Received: by 2002:aed:2b04:: with SMTP id p4mr3691650qtd.99.1609934751807;
        Wed, 06 Jan 2021 04:05:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 74sm1146296qko.59.2021.01.06.04.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 04:05:51 -0800 (PST)
Subject: Re: [PATCH v2 2/2] parse-options: format argh like error messages
To:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
 <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
 <c5f01b0eab1dd13d46ac344e362cd13e7bc365fc.1609933875.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd7d692a-0e78-0e98-6b1d-4157372d6674@gmail.com>
Date:   Wed, 6 Jan 2021 07:05:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <c5f01b0eab1dd13d46ac344e362cd13e7bc365fc.1609933875.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 6:51 AM, Junio C Hamano via GitGitGadget wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> "Keep it homogeneous across the repository" is in general a
> guideline that can be used to converge to a good practice, but
> we can be a bit more prescriptive in this case.  Just like the
> messages we give die(_("...")) are formatted without the final
> full stop and without the initial capitalization, most of the
> argument help text are already formatted that way, and we want
> to encourage that as the house style.
> 
> Noticed-by: ZheNing Hu <adlternative@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

ZheNing,

It is certainly a common thing to pull patches from other
contributors into your own series. However, you'll need to
add your own sign-off at the end.

I also believe that the intention was that this patch
would come before the other, so please swap the patches.
Then, you can update the message in the other patch from

  According to the "Error Messages" section of
  Documentation/CodingGuidelines,

to 

  According to the guidelines in parse-options.h,

Thanks,
-Stolee
