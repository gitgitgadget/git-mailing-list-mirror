Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A597C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEQSJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 14:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEQSJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 14:09:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3AA30D1
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:09:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae4c5e12edso9358055ad.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684346957; x=1686938957;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5xjW4zOFCZ6ds10N6FluXG1DmoKQOuh9MzLtTRSFFA=;
        b=YDsHfx9JUvIeG6mNCX5BcC7To/mbOcvDEfae8WoEuRGzF3E8Zu0MOEG7Ta52zUWkAb
         hgbRLPW3J3myFls0LrK2JaqNl3J3QWUrHl1m9VTJ16v7UaAtCw74yx+Qf6kxTPaeoyeV
         1k0PyHdYZzh/t+HDQRc2ZzN4hZvMevw0Rkx3TFMeXkV5/WE3wunY/PjWqevAoTRm2MFW
         IIhj9xly+FAZTAtgw6lG6sJGw51m6dQPt0/V/0/oUnvJPkg2R2kw/lGmpY4YjbPUsgWP
         7FipskCP7vY0ehGwLlY01FKl+dYNXAsr16E8aLrzzijMA5uLTOGAzRjEDKBHyPny2epw
         593A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346957; x=1686938957;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M5xjW4zOFCZ6ds10N6FluXG1DmoKQOuh9MzLtTRSFFA=;
        b=gCzHUekj18E+tpprNTR8agkOwqWWfWMCCypOKIeS1Evmbsf02v9I+RDb5mW/2E78zN
         PXisRBnL9GPU/xB9MDvwJvjiTA2m7mvc5ZCuvn404CcLjvk9aEoiMp08Ec+VJAWEwB1v
         wXdge93UTVjmeAnqtnSKHN5z1VqQWYnv7dh7h2WcWYvJZxkqsk0NdeU3DD5nJAbX2EN1
         aWrDL2QUHrVHb6o+/MoYAVFF4lFmWAgYspGpG+kSRonl8epdjIKnVfN3MhZ7lmWjntl2
         RT86ColCSCBjF6NB+7Qxo9hjkcATj3VW25lQQggGI/tponE0XuwJcvm2nKs6opaAHLyD
         UXSA==
X-Gm-Message-State: AC+VfDw6uUV+SCqFWJBMsu41JFsyeIgkRyvZjl+1mQTKvxN8xsZHdtPS
        kdyQ8DrFtuYks6R5OFYHmgk=
X-Google-Smtp-Source: ACHHUZ6j1UkKHkL7orNjrC2X4zYrVbXa6pdPVnX5kRCFkFv8jNP69m2aDw17cdS7g3ETYBsHOxv5iQ==
X-Received: by 2002:a17:902:9a81:b0:1ae:6290:26d with SMTP id w1-20020a1709029a8100b001ae6290026dmr521595plp.7.1684346956990;
        Wed, 17 May 2023 11:09:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001ae44cd96besm3113752plb.135.2023.05.17.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:09:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g>
        <xmqq8rdmrixc.fsf@gitster.g> <ZGUVvjG+xou3w8YW@nand.local>
Date:   Wed, 17 May 2023 11:09:16 -0700
In-Reply-To: <ZGUVvjG+xou3w8YW@nand.local> (Taylor Blau's message of "Wed, 17
        May 2023 13:58:22 -0400")
Message-ID: <xmqqy1lmq183.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, May 17, 2023 at 10:01:35AM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >>         if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
>> > ...
>> > What does the above prove, more than what your regular compilation
>> > that does not fail, tells us?
>>
>> It is actually worse than that, isn't it?  This does not even use
>> the definition in the config.mak.uname, so it is not even matching
>> your build environment.
>>
>> I am uncomfortable to use this as an explanation of what due
>> diligence we did to convince ourselves that this fix should cover
>> all similar issues.  Perhaps I am grossly misunderstanding what your
>> investigation did?
>
> Oof, yes, you are right:
>
>     diff -u \
>       <(gcc -I . -E imap-send.c) \
>       <(gcc -DNO_CURL=1 -I . -E imap-send.c)
>
> How *should* we test this?

My inclination is punt and simply do not to claim that we have done
a good due diligence to ensure with all permutations of ifdef we are
including necessary headers.

