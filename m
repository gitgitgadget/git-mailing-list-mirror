Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A95EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjFNTId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjFNTIa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:08:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F761FD5
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:08:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3c578c602so27702405ad.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686769710; x=1689361710;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1xOXwg8hSX891OhlKJKY9jVJ7gpNZFobW85bRcbBAw=;
        b=aADYE7yr4zSKqjfaMlX+Vzn8HzXLvxkPMIGVs2FEierMgQX3xBYbQLMAvVaEE4q++f
         wC/yOm8QPXi6jRcTxBEy12iCF887UPffbHditGJH8lzKnW6G7/HXecAF/tpWJKIcqoLH
         +UGDN39v+Z8e3ZmfgBxarjMa1u/q/iYuDhMtcqZpWuGVrBFt/Pks0lIGG3SB0ehcn14G
         9BGuxI6bJsUlsg+Rv0PsIlHwUo4q5nrngBqxF/GjEAUI+fHSRR1YK4Y4Iv9kRAzB2iut
         UowDxvIQDs+bucgT9m1RbGYna4+AGcz9wkJHnNLz/Vzo8GUqzJIBOR8OVqhuAavLE0GO
         IJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769710; x=1689361710;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y1xOXwg8hSX891OhlKJKY9jVJ7gpNZFobW85bRcbBAw=;
        b=SY8SYjbOvCgNaTScdSCRnOEeomwMFWx4jloDRX2ydPalWUThQaoG9IUmEa379Q77gg
         F0674Q/APwmbv7KoBNRHeVxxZKsVua9oZ7+QXNd5meoNrsj6XE/CXUKUBu+bLun3habX
         WYE0obW8itUhDQx9fZWE3YeiLVFqPbFPXcYgRnmaQo4Q5qyf3jKiL76ptWkBCEn3B+UD
         Sb+LOaikCDlcwpD3OdNC2O3SQ6us1ZvZt8cm+pUNgWcqsjobjALGs0mbN2enZCcexWVt
         DqzMTmX3TUuCZkvXx4tuZbzeUUw36VN4PMS3R6D6fa8lXu8fEwsp97rHTqfK4FGNuNkE
         UgGg==
X-Gm-Message-State: AC+VfDzwmcBFUm+gOuFOtzEjQP9DX715Di8KctdfFhEdEnvUk1hO2vvK
        Xzf/i/5sQE1mIfhZ6DVdOsjn/Vxl4UI=
X-Google-Smtp-Source: ACHHUZ6OPW44b0qMD1AncEY7BbT3AYCmAy24ojOjiKmBjdRCaKrrCGANKmbuDVXTiF96Q5mwNIMQFQ==
X-Received: by 2002:a17:902:d2c7:b0:1af:9c06:22e5 with SMTP id n7-20020a170902d2c700b001af9c0622e5mr14621819plc.69.1686769709664;
        Wed, 14 Jun 2023 12:08:29 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id jd10-20020a170903260a00b001b3d4bb352dsm5925639plb.175.2023.06.14.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:08:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] diff-lib: honor override_submodule_config flag bit
References: <20230614164856.3186012-2-sokcevic@google.com>
Date:   Wed, 14 Jun 2023 12:08:28 -0700
In-Reply-To: <20230614164856.3186012-2-sokcevic@google.com> (Josip Sokcevic's
        message of "Wed, 14 Jun 2023 09:48:57 -0700")
Message-ID: <xmqq5y7pyi8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> When `diff.ignoreSubmodules = all` is set and submodule commits are
> manually staged (e.g. via `git-update-index`), `git-commit` should
> record the commit  with updated submodules.
>
> `index_differs_from` is called from `prepare_to_commit` with flags set to
> `override_submodule_config = 1`. `index_differs_from` then merges the
> default diff flags and passed flags.

Great.  Will queue.  Thanks.

> When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
> both `override_submodule_config` and `ignore_submodules` set to 1. This
> results in `git-commit` ignoring staged commits.
>
> This patch restores original `flags.ignore_submodule` if
> `flags.override_submodule_config` is set.
>
> Signed-off-by: Josip Sokcevic <sokcevic@google.com>
> ---
