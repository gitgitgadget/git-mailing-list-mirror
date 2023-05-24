Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE9C77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjEXTuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXTuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 15:50:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249301A4
        for <git@vger.kernel.org>; Wed, 24 May 2023 12:50:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba80dc46972so1957477276.2
        for <git@vger.kernel.org>; Wed, 24 May 2023 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684957803; x=1687549803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9pNVo9g7TCC4tFivoX5fc+4MwNRVonMnvB7ih1yE/bs=;
        b=MtLv79YLetNhirIJ6p68JcBTauWkL6ljAa+yyQnupYvGwsBC6hegQ/q6N5zs4RZ50F
         HE1mQOUhpV65i9AR3Iebi6DCJ8HeEJMyFiqztgdHD1wNWbuhyyUazxrUp4GLaDKGk/MX
         IscijO9qf2SXFZobTpYlbBJnszcwAvJLjW04cto1OOGDmOeqWYdD+dlRNemhKgXGDvW8
         sXBHqe2OxpQT255C14JaRzzHVF3LaPdjOzOtXB5yN2OE7hH4gBJfVkzU59Lo+rMXo3OU
         g5L4ycBSTuPenC8aycMJejPpVcYk47PQF3WHW7uCD3qzWkWCCuJkb27Ro7cZdRc3Bm1T
         jsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957803; x=1687549803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pNVo9g7TCC4tFivoX5fc+4MwNRVonMnvB7ih1yE/bs=;
        b=Zon2PgZjmrPzT60w0WYz6WHCdUC+6F/gPyityOnQeF4oulEcMPMYs4aSoDPaDVVppL
         wJ+P+x7zfNrldsEK5QqXBpLLd8g6b8DJbQoUwSZpV1YopeZmaFSz+yexDjkpZjMFf6SZ
         iREcy24f7D3+SHymhWc1FmKkCisWPHUYJpe7107OQG6Ais3MB7X/GPZfp9AExx4WCGO+
         7BCzzqcYeNpQR/twplnoJfTVQOkx7gnQZ/cVgTYlxQBOvkDaQvlFxQRMxxg+ueW8hRGj
         AuSwjSK6KAKNRSaS//QAa/Pio2yt/XOLRJeiLjSJba8Uo+iN09m3DKAd30AXZJqkMFG4
         i4ZA==
X-Gm-Message-State: AC+VfDwE9qBh+PZhDSl9HR2y7TBk5x6kiK9NhJMkMcOnvpQs12XvfMhl
        RyVzo4tSHlqHM9EzqOmucU0VhE6dJuVpQJxeJvQlNA==
X-Google-Smtp-Source: ACHHUZ4duededdhpQn1YHzQyfvEQNNR8tTzH9fk0LxxaXqxQo/lFvvMD/L2zJ9RsphOSpSoNogomXw==
X-Received: by 2002:a05:6902:100e:b0:bac:7294:4fb6 with SMTP id w14-20020a056902100e00b00bac72944fb6mr1151218ybt.30.1684957803212;
        Wed, 24 May 2023 12:50:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e129-20020a0dc287000000b00545a08184f8sm3938487ywd.136.2023.05.24.12.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:50:02 -0700 (PDT)
Date:   Wed, 24 May 2023 15:50:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2] builtin/submodule--helper.c: handle missing submodule
 URLs
Message-ID: <ZG5qac9YVvjN/R3o@nand.local>
References: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
 <bc204f450a80f7e6379b3a8564fc54637a266e7e.1684945504.git.me@ttaylorr.com>
 <CAPig+cT4c4f8DtNJOmNJKRYVX0HNz9fSgkF9hAbzaCXV0ozydg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT4c4f8DtNJOmNJKRYVX0HNz9fSgkF9hAbzaCXV0ozydg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2023 at 02:48:40PM -0400, Eric Sunshine wrote:
> On Wed, May 24, 2023 at 12:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> > Guard the checks to both of the above functions by first whether
>
> s/first/first checking/

Oops. Good eyes, thanks for spotting.

> > @@ -2065,11 +2068,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> >                 strvec_pushf(&child->args, "--filter=%s",
> >                              expand_list_objects_filter_spec(suc->update_data->filter_options));
> > +       strvec_pushl(&child->args, "--url", url, NULL);
> >         if (suc->update_data->require_init)
> >                 strvec_push(&child->args, "--require-init");
> >         strvec_pushl(&child->args, "--path", sub->path, NULL);
> >         strvec_pushl(&child->args, "--name", sub->name, NULL);
> > -       strvec_pushl(&child->args, "--url", url, NULL);
>
> This change is unnecessary now, isn't it? Or is there something
> nonobvious going on here?

Yeah, this is a stray diff. I'll send a cleaned up version as soon as
'make test' finishes ;-).

Thanks,
Taylor
