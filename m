Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5FEB64DA
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 23:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFOXqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjFOXqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 19:46:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEB213B
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 16:46:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6667a0811a2so238041b3a.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686872805; x=1689464805;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7wXtYOvkzgRec7BYwNYLrvgkNOP2OQsUPMaDB5V4Lk=;
        b=fGDWtLbnKYS9IZen6MoJhmpg7z/dF6Lf5HlW94jlu0hUPepK/j7S2g+S9lzBYYv+HQ
         fZaE5FFimQ7j50uG1NEBIU6HqFH7uus+XPqMdtBf/dwudyx10P4VixBKTQ+o+tTKmSCI
         ps3IGEC2E8yfaMAT3bcmNvnevacxORxylZeWveqgvWd+6QMxpTgaC8Q30BSO9X9wqFl2
         /BgiyLiNCYUVG+2WeRHvRShRxMo2cfObkdG6rILtb7g2O4brRpC9yt9Ab2dScCgz7maT
         QSvHjWjB46T3TgOB14gBLl7+W72acG6+uKtxR1SjZmwCV1OiObw/nHY9VIUMdrJU5YdU
         tHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872805; x=1689464805;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7wXtYOvkzgRec7BYwNYLrvgkNOP2OQsUPMaDB5V4Lk=;
        b=OQJ0W5v/LQoXD7A/ItauLYiMQvvxHH3Ca+EgizqYpB0d8+uIR36WyrqGte3ju5a+X6
         3nK3Ld3Me/ArS6a0b3pfza6bc3hQ6HjciXrbBemhkAFK/IdJuFbMYPZYd+BeDJoxFH+e
         ITFgKGUA3JcI541E9/ojBnaw6a01qhgljlDVpviF3V9dWLqGOJiMn5RRbUe9osY2izbP
         LD46mV2tdtRkE9A4JDMvhxrRuUhIV8M1/lYXQtIYHyQyt5VNiOhzuA/KX6NTpHWGJrN1
         R2uJKPqtWStthzoiY+EX/SoJgwCQQ8d65FyuLZJ360e2UZD7+DTFXQ9Pm80f5oKmEfb2
         vaUg==
X-Gm-Message-State: AC+VfDwnIp4ER1/8wBroQuWwCWv/lLGPxlHaXotW6jmFSoQFCevTQV4p
        ePQakkskSM6cunUjXxCO8wY=
X-Google-Smtp-Source: ACHHUZ4R58K0kPPra6WCTaYOFknoM5YYB42tknRbeAZqZq2iHoga3gsnel/wDm4ty+9MAkbdbRjTWQ==
X-Received: by 2002:a05:6a00:1913:b0:63d:3981:313d with SMTP id y19-20020a056a00191300b0063d3981313dmr605704pfi.10.1686872804501;
        Thu, 15 Jun 2023 16:46:44 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id s4-20020a656904000000b005533c53f550sm345231pgq.45.2023.06.15.16.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:46:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/9] repack: refactor piping an oid to a command
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-5-christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 16:46:43 -0700
In-Reply-To: <20230614192541.1599256-5-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:36 +0200")
Message-ID: <xmqqttv8thjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Create a new write_oid_hex_cmd() function to send an oid to the standard
> input of a running command. This new function will be used in a
> following commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/repack.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 0541c3ce15..e591c295cf 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -182,6 +182,17 @@ static void prepare_pack_objects(struct child_process *cmd,
>  	cmd->out = -1;
>  }
>  
> +static void write_oid_hex_cmd(const char *oid_hex,
> +			      struct child_process *cmd,
> +			      const char *err_msg)
> +{
> +	if (cmd->in == -1 && start_command(cmd))
> +		die("%s", err_msg);

I am not sure why we would want to conflate the "if we haven't
started the command, auto-start it upon our first attempt to write"
in these low-level "I am designed to do one thing, which is to feed
the object name to the process, and do it well" function.

The caller in the original shares the same issue, so we could say
that this patch is not creating a new problem, but this somehow
feels it is mak ng the existing problem even worse.

And I think the error handling here shows why the API feels wrong.
When auto-start fails, we have a message, but when write fails,
there is no custom message---it makes as if write_oid_hex_cmd() is
primarily about starting, which is so important relative to its
other functionalities and deserves a custom error message, but that
is not the message you want to be conveying.

> +	xwrite(cmd->in, oid_hex, the_hash_algo->hexsz);
> +	xwrite(cmd->in, "\n", 1);

I would have expected that the "refactor" at least would reduce the
number of system calls by combining these two writes into one using
an on-stack local variable char buf[GIT_MAX_HEZSZ+1] or something.
