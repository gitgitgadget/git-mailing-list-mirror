Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E7C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9AB61241
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGVG2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhGVG2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 02:28:54 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CCFC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:09:28 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so4432872otl.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lPVjWWeq3esCzU9Ts6F0FKvXTNmZ3L5e4iP5ByzqHYI=;
        b=r0GpLVCpaBqV+tkLwO8cWz8Z7PaUIk4v1/5nWX5LflQK0WsBdMCf1Z5f9cZqUwbsxD
         zOqxDlBTWqss/n2EJf4ox+BfQXtlITUwjbjA+8rRT79LunL+Fa/WdZHGYinBwPQSBopK
         52UoZjNdP22dfx+qLZ2NR5xz2avsYQGKJhUPjufqNRzmNOaOKYL/9YoebBU6k2eU3jIn
         YOek/DSft7PF226JXpOkGuvsLYHTd4ffxYCslUe8LFcaOvcvFc/qTKg8RFJCaifBkmCb
         E3ytZ3kTAN1WEgy8lQtxT3jVwzj/HBDCdwC5s+PR1TWSNML7ayUrqNzMU9WFePL4XO2B
         MQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lPVjWWeq3esCzU9Ts6F0FKvXTNmZ3L5e4iP5ByzqHYI=;
        b=WXPV20uQS2zBUhofLxop3NNHfQRRxw/l1DGyGk+RzhQMqdo23H8PPnSYxAjtOUQCUc
         fzqCv+XU2JNI5hw6yVMfSNU+gJceqqJ48hyIYL5l6UuEoOgmmk704DyCY7gCfLLw8rMp
         23U6kHLfGSa6AyC8v2AtigkQ6G4/PO50toaeWDlJtd2/j0RxKirjkYPmj9cU0XTCQSyW
         KQfPEVlj7mkPdDlQXVqK/v/dVcusrknjQpgn7VpzSbJMoxrWxPIDzB1oAf58LYbusKQu
         JvZ4xcrQC2VuxmtBp2I4kzrLtqD4GzXpOP/NtCzF0tS+B4EgranYYPsm5Ri97k7LkIoh
         wN0Q==
X-Gm-Message-State: AOAM533hww449Mr+vN81zH+YdIEgmZKsCImlMN6+NStj8S+ffrioVqFI
        gIcHXLK9jjaNkdLePHtMK9s=
X-Google-Smtp-Source: ABdhPJzkIOLGHqRAOwr0h6l4LXH+UG7lfuEISEsV+l7ccYwXTYzDXRNxU2bLyJiy5NW0NNm9NYi8Cg==
X-Received: by 2002:a9d:638f:: with SMTP id w15mr10298118otk.148.1626937768313;
        Thu, 22 Jul 2021 00:09:28 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 48sm5053012otf.13.2021.07.22.00.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:09:27 -0700 (PDT)
Date:   Thu, 22 Jul 2021 02:09:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f919a6939ec_31ad20835@natae.notmuch>
In-Reply-To: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
Subject: RE: [PATCH v3 0/8] Handle pull option precedence
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> Based on a recent list of rules for flag/option precedence for git-pull[1]
> from Junio (particularly focusing on rebase vs. merge vs. fast-forward),
> here's an attempt to implement and document it. Given multiple recent
> surprises from users about some of these behaviors[2][3] and a coworker just
> yesterday expressing some puzzlement with git-pull and rebase vs. merge, it
> seems like a good time to address some of these issues.
> 
> Since the handling of conflicting options was holding up two of Alex's
> patches[4][5], and his patches fix some of the tests, I also include those
> two patches in my series, with a few small changes to the first (so I've
> kept him as author) and more substantial changes to the second (so I've
> given him an Initial-patch-by attribution).
> 
> Changes since v2:
> 
>  * Remove some unnecessary changes in patch 4, pointed out by Junio.

All my previous objections to v2 still stand:

https://lore.kernel.org/git/60f80feeb4461_1305dc208b8@natae.notmuch/

-- 
Felipe Contreras
