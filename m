Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7CD2095B
	for <e@80x24.org>; Sun, 19 Mar 2017 09:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdCSJep (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 05:34:45 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34729 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCSJeo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 05:34:44 -0400
Received: by mail-oi0-f46.google.com with SMTP id w81so11470041oig.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7fE/Thuc8kAA5bgQkfTbAmPxp7Hw8Hk2gPcqhkV14bY=;
        b=Jvdiar5BoONR7nYvXL7rADabRTuaowiBhENdnLka4dYJvyIzoPNhhwOCpkeUa8WoV8
         PrQ07HKP/h1GRqvLttKZx4emrwjoWIdxplJDUOXfKGqzkG431ynKorEt9Oecp+cdDpWv
         WQcX3MYhTUqdbCNFromA9i1H6W9+rERKZKs9wlBAa/tzltbGJbvpHZj400WBqdDiam4M
         7en/4Z8zT6Tq6eaUZbAXt9TvWuOsulAltGOvsLUPLvbOWe8Nt3Khp49FJhS1nq4Qb4aL
         zHyfkXYsa6kljDuQ/NVE+s9dCCj4DoRXPIs96q6OWZyKhy0JCOJcDO5+2wwC3is5EwuD
         azwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7fE/Thuc8kAA5bgQkfTbAmPxp7Hw8Hk2gPcqhkV14bY=;
        b=fynArlFKSQZUu5oa7skkjjQa+LO4dYIddDOnB8gg9BGJCWm/nZa3tmsmzgJvoV0nR4
         cTCAMKNLgWisRQ0Kby0SRjLRtN9pfZeIoWx7gE7Vgc50MyeqkAk+Y3Yh0XftB2DoL10m
         n1HTLoRWl+h0I8RsTck2RjF7F5uAG9HKcHSqdPyhVQcS5I02mlRKfjq/jFbWqTje2HfP
         +CwT/HD6HGLXEi9kUiy0qjeH3JOlOWCG5SBs8MnRSWaCn1hfSyRYAhKZkDHgo/KLLMgP
         diwZN1q9B2hJDTVcH/cvp3Bu/ozTUB4Bug9+c3ipGXmh7icgChfrorAE9bkTvt2gfi15
         p9BA==
X-Gm-Message-State: AFeK/H3DmIJ+qlK8SS9na8q6rypUNl1yk/xxtrMxSb18v6uqc+h4dB6VlFeLGaFcRl1XS2qrJML/r3uK3xuT0A==
X-Received: by 10.202.181.135 with SMTP id e129mr12662148oif.124.1489916083175;
 Sun, 19 Mar 2017 02:34:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sun, 19 Mar 2017 02:34:12 -0700 (PDT)
In-Reply-To: <xmqq8to24gif.fsf@gitster.mtv.corp.google.com>
References: <20170216120302.5302-1-pclouds@gmail.com> <20170318100206.5980-1-pclouds@gmail.com>
 <20170318100206.5980-2-pclouds@gmail.com> <xmqq8to24gif.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 Mar 2017 16:34:12 +0700
Message-ID: <CACsJy8B=NKAERaGWCH-kvU0WE7j8KSXz74U3N+fHmkhqXWTBeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] environment.c: fix potential segfault by get_git_common_dir()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> setup_git_env() must be called before this function to initialize
>> git_common_dir so that it returns a non NULL string. And it must return
>> a non NULL string or segfault can happen because all callers expect so.
>>
>> Normally if somebody has called get_git_dir(), or set_git_dir() then
>> setup_git_env() is already called. But if you do setup_git_directory()
>> at top dir (which skips set_git_dir) and never call get_git_dir, you'll
>> get NULL here.
>
> Hmph, and the solution for the problem not being "so let's make sure
> get_git_dir() is called even when the command is started at the top
> directory" is because...?

-EHARDTOPARSE. There's a hidden dependency between get_git_dir() and
get_git_common_dir() which is not good. If we lazily call
set_git_env(), make sure we do it lazily but consistently at all
relevant function calls (i.e. including get_git_common_dir).

Alternatively (I was thinking of this but didn't really follow up
because this was side issue) we should make sure setup_git_env() is
always called at the end of setup_git_dir...() and remove the laziness
in get_git_dir(). This may be more in line of recent attempts to catch
repo access without calling setup_git_directory..() first. But sadly I
haven't read Jeff's series, so I can't say whether it's true.
--=20
Duy
