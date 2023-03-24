Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E5C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCXOvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjCXOvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:51:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014DE059
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:51:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ix20so2020477plb.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679669465;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sx4FxuHRp6/PUEhFYdc2ywAGtuzjlN+438nnNu7viFA=;
        b=f4Cj03wsudguJWQMYx7daeB5FH9j3ctz5a47VNU2uR9PkOPD+A+19F1ASS7h1yGGT5
         XX+Gu7qNHTSHN3E66o99W1lTIf6L1LR81pkt9BjJfVmnl0ZLedtE+72ldiwVuiJ9SKDn
         mifmsjkdWk+Yd6EfQwMuJ2iw/nq+nvEbh57TwF2hxFEawNYnsGH2bisXyK5nFAMMUYuC
         HMjjfN9Zd9WKf7o5KV1TR1ZMhnKeGDqiq6F5SZA1J1bq3IZ/mm0N4jDXbZUZ7eC6eclx
         LG+m7d0PuwliaTVT9efnuKFAyYYlP90Y9WL/dMdbevrvQgD6OyQRTQKbHkITgJXdk4D+
         J6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669465;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sx4FxuHRp6/PUEhFYdc2ywAGtuzjlN+438nnNu7viFA=;
        b=vE/xfU4tcyhHOPATBFtrCS1AfIQBPkxmJTHRW0ZlNsd5O9nWdYrVwivEHoGCYDtMK+
         Ok0CoceWpUr5HoSt/GxIS5JgejZTVE/iL7yb8f9IngpbbCX9wK5IgBpBuqgCdwqziIqZ
         rwAY9Ypz0vJCAz2oCseNSS41a8DkZ6zUY3pTvjiALsreDmwrDiezlBt96Hoplfwltyue
         YJYA2FNY5C3hVjiMsLXkU8gGYTjG3kDmM2azpvr3bDA/0H6maEoU304QgRaG8fzHxip7
         0j2dLyk3z5CRxxoEW1jC7Txrs6iSl3FPlTjN46lXaytBInX2srbVesbVIwX253xC/gr6
         ivBQ==
X-Gm-Message-State: AO0yUKUMki0BxwZqcr9bwBoIBPPZqKrz3vWJyveNArdQggZiYFXAUUGw
        oBB9OfJuBPFPVeyKEW92SYA=
X-Google-Smtp-Source: AK7set+GjDamhUeT7D7CiwHXMvscpChn1kXpuaH19mjLXZrMEOfnEh/OwUFSec6fm/hBi53JJuWApQ==
X-Received: by 2002:a05:6a20:bb06:b0:d6:847d:c7af with SMTP id fc6-20020a056a20bb0600b000d6847dc7afmr3083393pzb.16.1679669465090;
        Fri, 24 Mar 2023 07:51:05 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x16-20020a63fe50000000b005004919b31dsm13472341pgj.72.2023.03.24.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:51:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: remove pointless rollback_lock_file()
References: <20230323162235.995529-1-oswald.buddenhagen@gmx.de>
Date:   Fri, 24 Mar 2023 07:51:04 -0700
In-Reply-To: <20230323162235.995529-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 23 Mar 2023 17:22:35 +0100")
Message-ID: <xmqq8rfm5hk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The file is gone even if commit_lock_file() fails.

Good spotting.  

I glanced over hits from "git grep -A6 commit_lock_file \*.c" to see
if there is a similar mistake, but this seems to be the only one.

Will queue.  Thanks.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>  sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..2da9b9f890 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3676,7 +3676,6 @@ static int safe_append(const char *filename, const char *fmt, ...)
>  	}
>  	if (commit_lock_file(&lock) < 0) {
>  		strbuf_release(&buf);
> -		rollback_lock_file(&lock);
>  		return error(_("failed to finalize '%s'"), filename);
>  	}
