Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E1C433DF
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C732068F
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 14:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="O9PIxC4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgGLOHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgGLOHR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 10:07:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE42C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 07:07:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so9822947qkn.11
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=lri7GmKFTSLrBa+9fXxgjvmV2QA17IkN9ZNHJLkBdNo=;
        b=O9PIxC4VJ98i7dATM/OfIeLQlpyiZ7sxTqdcQRnVy6y7uUKlQTt5ku/2U79fhgd+sU
         pCIQ+aHTt+pJ/Ew5k9F6Rvj8wDqjR44LX+27BZn1fVefKdyQ4iM5M4o0H/mSVackVAc2
         NOtBpWVDcJkosMkUjUJIv/ek+G7gWrAjEBaIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=lri7GmKFTSLrBa+9fXxgjvmV2QA17IkN9ZNHJLkBdNo=;
        b=fmnDI4TYFTwxP8DoUFbEvx2VZrSzyptsCUSw74tUYS3ZbM4Lsa0JN9SbqbvwahsglT
         ovDEtXfaQ5qgIbIJVf12bC1yC4eqB3ckuKV3GBJkgqs4AcdY1l0mIPxtSTQlAQcM909a
         SctOlBoq5j+MHMeapL/GNqi//SqJouI63TLeupWDUGezirZyPpm0K2AIaGar3nQ+RzwL
         IIh8iolEfvjLe0VLVNwBT+8r67XFGUewtBxZsZuNgkEJ6fbyllwoswMx1K4Fo/vsnsf/
         AShj6HjgksgUy/PWbCNVXx5GY9W34NKC3AFNn0NMcN0+Zt31CigX/El0fQsyT0y83s/6
         Iuhg==
X-Gm-Message-State: AOAM533v4FsLwsmgc9riIFZGYqDILqVBYUo7GZktRbnQrv4gpx2dR3qu
        nshZazQDipbqkad3y7xql8wyHA==
X-Google-Smtp-Source: ABdhPJwZAq9O1GRex6RkItLXp5JI33VRm3N6ued2VDPhq8lwDosGQXyXP+XntirSa48y5zexBarD0g==
X-Received: by 2002:a05:620a:905:: with SMTP id v5mr80171811qkv.268.1594562835902;
        Sun, 12 Jul 2020 07:07:15 -0700 (PDT)
Received: from ZoomDell ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id b8sm16194642qtg.45.2020.07.12.07.07.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 07:07:15 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>,
        =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com> <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com> <xmqqh7uhz98q.fsf@gitster.c.googlers.com> <261a01d655a0$71077210$53165630$@zoom.us>
In-Reply-To: <261a01d655a0$71077210$53165630$@zoom.us>
Subject: RE: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
Date:   Sun, 12 Jul 2020 22:07:13 +0800
Message-ID: <003701d65855$c1874320$4495c960$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGL+c9r+Sj3YnB8Xlh5VXkiFBL/EQG/MxNQAccWvdYCUW6JKAKGaVJn
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I had add a new c function ` git_config_bool_or_str()` to support get =
the=20
configured value for true/false/auto with git. It will make the =
`mergetool/meld`
only calling `git config` once for getting the `useAutoMerge`.

Please review the [PATH v16], thanks.
https://lore.kernel.org/git/pull.781.v16.git.git.1594544903477.gitgitgadg=
et@gmail.com

Regards
Lin

