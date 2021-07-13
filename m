Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70AC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9913C61353
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMTpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMTpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:45:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19CC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:42:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id r125so15275819qkf.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PPs7ES+4Izr1TvT8y088wwCziIfC2Kla3rsHg1reFWA=;
        b=o2U5teqBwML9+nKQDhfk6WTN41I4U37HiKadj5vCoWPPn+nB73V70ZVbnGcCRaRe4G
         JfXEzda6hIbxzJ3a5LSE3800R1BLTD+eZqj4y8y8L/sTteF38oBINQo8ihTbdjflMKEK
         i0SN61u6GE/pNSNKPloXUUDxe9A/Lt6L2FP6Fnq9IC3WFaH/CDvLZQIAJfEH3qDtMdiz
         hdlL6AI35uM5hEa6NTCR6bAxWoaJMhFL4amQXBP2r/AcVtp8AP3Gmc8ybCEAZ7QUqnJW
         2N+prkYa+NJvhyenii9N3zq2+ntsaHR5SFWQg4qxQ4BfEDOAmQrQjT5ExQIh5ZsHHX7H
         L+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPs7ES+4Izr1TvT8y088wwCziIfC2Kla3rsHg1reFWA=;
        b=gydL5yNNjS2eJMMj1pBxtnMbcBIYRIJNAl77zdmDFtVtKPTQzN5OwqVJyAOMBz+JSb
         T/cHLF1B9axTWjOUgSU4r2q8bluiBOx9kxpbExuhrHHn/oNZDprzUf02qodkoHm/1gZu
         HXfGtbGxOukcjRiYnkdi+n1dcyHfCuECkDSoHgSDjqb4LlVEkHsTJUM+4W9lDmQyCpMm
         WQK4Eo0h0FX+3U5Ox/xb3QAMe3NnP3RUezKU47yawlNcG3wKCXvF9cmZXytBKNwELpu8
         aHHCoppnnesZyXFk8nr0t8Bt/5mriW7pWos7omzkrOmwxvH66GvkYeXaUzCigEDpvcPI
         nNcQ==
X-Gm-Message-State: AOAM533P49yCR+Igdn3wCNturZvp+eUJcq4XF102iDuNQ1CtC4TYRajM
        UGg+VvbDVQY207s25FEZxrokPYpvvickew==
X-Google-Smtp-Source: ABdhPJzMrvTNVkFIPP3kSZK7fLZCY3HQcYCcqhxTZtNdGl4/HUikl+Oyqab8c/0vJtymbbhhsULwyA==
X-Received: by 2002:a37:6241:: with SMTP id w62mr5880102qkb.413.1626205363035;
        Tue, 13 Jul 2021 12:42:43 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id v16sm7029803qta.47.2021.07.13.12.42.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:42:42 -0700 (PDT)
Subject: Re: Confusing interaction between 'rebase -i' and 'commit.verbose'
 when squashing commits
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
References: <9515534e-705a-ad1c-a1ac-704b2d565f37@gmail.com>
Message-ID: <33021bd4-a126-c740-4a41-f357be8fe6c6@gmail.com>
Date:   Tue, 13 Jul 2021 15:42:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9515534e-705a-ad1c-a1ac-704b2d565f37@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 2021-07-13 à 15:34, Philippe Blain a écrit :
> 
> Running 'git diff --cached'
> in a second shell shows that those changes (the ones from the second 'squash')
> are correctly staged. HEAD points to a commit that has the changes from
> the 'pick' and the first 'squash', and as commit message the message I'm
> seeing in my editor.

Correction: the message in my editor has the messages from all three commits,
but the message of the commit pointed by HEAD only has the messages from the
first two commits, i.e. the 'pick' and the first 'squash'

This is on with Git 2.32.0.1.g2ac0338718.

