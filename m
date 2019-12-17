Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF0C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 15:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC3F21582
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 15:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az0vSDnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLQPeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:34:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42298 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfLQPeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 10:34:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so8567149qkg.9
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 07:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tgonogmSeRR5KiRXb4EGQnmA3BDwM2bNyJrQvwPA+EE=;
        b=Az0vSDnv5+kRqCKXtA0bg+dwSz/YedLN7N9ThKPgv1hLGtZ53j7S8DPdk7gwGMBdPM
         xarRABAB0QVUfUCo2elYg6s96FLtSKvMrtC7vSWRhyY9ojsRwk+0Jdbm5SWdIIibElBs
         vJiitsZ7zPipsgzInoqnZ7yThA1rkSBKHDOXKa49OaPpveQo1sVg9KZ8aS3O3hDkxMe5
         5SP1vLrVDO+ZDs/195aIr0T17NhQGImLk0adlAnmA5zEghzI6nsNznYDGLlj1c6gfmGl
         Ja/optdB0dMBm9a8Uu0wJL62M+vLnc5/59l6x5VYOL0cB9udZSoV5UX0MVvB5mXLiP2F
         eSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tgonogmSeRR5KiRXb4EGQnmA3BDwM2bNyJrQvwPA+EE=;
        b=TqMHzYiY/ygRPFnMR9chfKt3sE92n0vDIWM6nKNxEdqNP0S8t50c53qc72sythp41j
         68Z2XbbObwUnFtwpOFtPB4tzi/5GZI9Z8Ej1bIFFIAXiMQqp90esgmOv17LL1hDthX/b
         0yoKuYcb6xrMwfYKXZ9fktTyphOGpFfmqZrrQIrYR06Ke1mIa7nUj2BFij32maWY059q
         er889UIUdPxLPs0d+KfkVDWVb6rA4mTUNrV1pP47VR45ORXLHoERVGMPr+v8qFiPA/H8
         fccUAtMkzsOv59pjdyXhYv3NO9nu4CYPDadJ8D4rhTRaHfYNz9AjfnMahz4Fl/TLZeJW
         CNzw==
X-Gm-Message-State: APjAAAUfBwRARdNIGFrnEeizuIMpFA+JhRwFpNHyEhkvO6fCHv109Xn7
        ftW/EfBYI5NrdtAkpLWD0P4=
X-Google-Smtp-Source: APXvYqwrlHs+H8/YMbIOaJWFOJkz7veRxg16mUWf3k/2oPZ2Wu0yIaZvJDjJFt/3Nz8HxtieY5lJiA==
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr5687775qkk.0.1576596884923;
        Tue, 17 Dec 2019 07:34:44 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:69bf:641a:5651:1a45? ([2001:4898:a800:1012:1af3:641a:5651:1a45])
        by smtp.gmail.com with ESMTPSA id m10sm7166531qki.74.2019.12.17.07.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:34:44 -0800 (PST)
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex
 must match in starting revision
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
 <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com>
Date:   Tue, 17 Dec 2019 10:34:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17/2019 12:07 AM, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> When giving a regex as parameter <start> or <end> in
> `git log -L <start>,<end>:<file>`, or a function name in
> `git log -L :<funcname>:<file>`, the given regex must match in the starting
> revision, or else the command exits with a fatal error.
> 
> This is not obvious in the documentation, so add a note to that
> effect.

This seems helpful. Thanks.

-Stolee
