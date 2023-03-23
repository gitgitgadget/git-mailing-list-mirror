Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA6BC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCWUnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCWUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:43:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6CD9001
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:43:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7so5493312pjg.5
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679604184;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH5+dRHNPaOA79uHsvnBQMBBU86LZIK6aBmY/vdOLGM=;
        b=YLCUT8A275omi4na534K23zEalyhj+yW6E1vR69xdBv/nQ6RlXamKXYLlacjWJmnOS
         CJI9//y5qDSyzgcgxZ5GNc0snJdTiZlBZg2RD+maXOegR5EGZn+aX7I1fgoj8nNuZtym
         24ZUjBKnikBGbhC5+qXNJ+G97b2cDfhrooewcAAbal1333jywvOQrXD6k12DPi5Q4obS
         P/TENSvbkidV5Coxbvh4SCntgPO3Ybfmc6wZhOpeuo4DzYnC8Ib81G/WdDGZ+T/TX9Lp
         KRNE9ZJfZxRTbWkalgAWDE6PFxkd1G95ZEEYw5QbjI7YFykPgv1djybqixG6PQviAKPb
         zv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679604184;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uH5+dRHNPaOA79uHsvnBQMBBU86LZIK6aBmY/vdOLGM=;
        b=TVXpuCE6y3vVmgiPclFc0PpsSs1ZNr/gVqId0mKCA1Hw5N5HzUk/i9HAbtSX+CZVrE
         LRk3qFqG4E/1iuYsyfBqxyjb2xA1lojq5uNt6Gpj7c5VseI6Jx7yMSl+ey2V3AeBu7rn
         nTPhDeeUpt0CxoGQ3LlxVi4HYarQH5RTv0PmpFe1usVTREEARmCu2z7EqrmPGpWpxC9S
         9GwvV95zxRHzblNNgGcjhl6xnts8V7DnsX3BQwaHFmEGW0WCgEf1bwdFBVgNSWmdjX71
         wKIpsvAuZHK2+fOiFXURDs3HzsB5uAldhshP4+nqbUBcsvveZlnwHw/KZM+XKfILPAq+
         AofA==
X-Gm-Message-State: AAQBX9cBn5nUibj7IDeMUBUv8shaSu3wGx92VXm9WXV4Phg04Jo5DURz
        a51BwOg5YkQLRjy6bCSnaKI=
X-Google-Smtp-Source: AKy350aDhGbckxKNQoSTCOICQsEk2lmaq9VF/FWRIr6GzyMQbZk7A2D7O5r5CqN42kDgBukaoJin7g==
X-Received: by 2002:a17:90b:4b51:b0:22b:b375:ec3f with SMTP id mi17-20020a17090b4b5100b0022bb375ec3fmr302011pjb.21.1679604184451;
        Thu, 23 Mar 2023 13:43:04 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id bd8-20020a170902830800b0019cb6222698sm12671273plb.266.2023.03.23.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:43:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] sequencer: actually translate report in do_exec()
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230323162234.995485-2-oswald.buddenhagen@gmx.de>
Date:   Thu, 23 Mar 2023 13:43:03 -0700
In-Reply-To: <20230323162234.995485-2-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 23 Mar 2023 17:22:33 +0100")
Message-ID: <xmqqpm8z6vxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> N_() is meant to be used on strings that are subsequently _()'d, which
> isn't the case here.

Correct.  But the original does not look particularly a good way to
allow people to translate the messages (namely, it splits a sentence
in the middle and makes a sentence lego).

I wonder if it should prepare two full sentence messages, one for
dirty case and the other for non-dirty case?  In any case, I think
the latter half of this big warning() should be done as an advice
message that the user can squelch, so I wouldn't worry too much
about it before that happens.

Thanks.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fda68cd33d..21748bbfb0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3628,7 +3628,7 @@ static int do_exec(struct repository *r, const char *command_line)
>  			  "  git rebase --continue\n"
>  			  "\n"),
>  			command_line,
> -			dirty ? N_("and made changes to the index and/or the "
> +			dirty ? _("and made changes to the index and/or the "
>  				"working tree.\n") : "");
>  		if (status == 127)
>  			/* command not found */
