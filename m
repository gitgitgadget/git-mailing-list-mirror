Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB5C43217
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 00:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK0AYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiK0AYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 19:24:18 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0061789D
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:24:13 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 136so6873676pga.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYazG8gcDBBP/BaqN6MhN2GDq0G8mSvoLSZaer2AhSs=;
        b=R33kyTRhK1mMdAhOgvZTD/lPG4GoNOZ87bH7zN3UGN5YH7Rudv1MlbGVzJvM5bfAcE
         oXlfJt8ZjMpmfrTWGKwL73/VvB6SvQo/WQ8Yp2JwwJJJ67TbWtaP7+K1UJLwq8P+vj0C
         jxqAk3Zt3d+wWZuE2ge8Epc0NX61GqITR1ojcC/jatffSTMCavHMIzoOp/MRJTMilrID
         smDucCm6hc0nS8jKNP4UlPUd230uReazF213wdaoJQr/+/mPOEwnscDbLkKXKJU9ogBJ
         UKU9rPKEyq5Tq/5aq3NFRqx78eFE7W8BMxqTBiDu1k4T68EQ56sQKAAOKnfewwgXSqUo
         +dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYazG8gcDBBP/BaqN6MhN2GDq0G8mSvoLSZaer2AhSs=;
        b=EA4jOeAbT9DRfwLJOi1yhGqliFmZGENvTO/MG3nSyutKBUu1bvGiE1iRZ01C9Pw/bL
         m4UfKs2mAdWrHD5IL/Ggiy6tEp90BtC/eeuFUpXn7Nore1Pe1T/f5r/hLXHTri/lHIt4
         cbanPU8HyMivvSt7BJ8zd7uc8drGz5gDJ10RplT725ZrKhzz7FSRCbpaKLQ4nFkJbQ0H
         OAzsSgBw3yBJ6QA43A1NGbBjfYxiZBQ2yyqWkGVbqwyBhWhKhEW6cTHyUVqv6pwEPXF6
         7FqDuZIs86NDHSV/qvuNpUdRL9kXkY9FdALGnTYx2UHvVtmMj7EhuECgG3O36oloVIcF
         cv0w==
X-Gm-Message-State: ANoB5pmfE2F/1Shfux6n10xRJnk/DDLlC5WjbLvvDLmWbjkBpoxPr4Vj
        592+p7ZpGAop24wtjd7NC/g=
X-Google-Smtp-Source: AA0mqf6yhEP2evnHp5yLx5jXW74aO2By/fhHcWfLnHHLy2cPPGYm8yYaRfuEM9ZG5QnZ4ZsPBXbzXg==
X-Received: by 2002:a65:5782:0:b0:470:3fc1:5ed0 with SMTP id b2-20020a655782000000b004703fc15ed0mr21941606pgr.370.1669508653183;
        Sat, 26 Nov 2022 16:24:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902bd8300b0018689e2c9dfsm5897654pls.153.2022.11.26.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 16:24:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 2/4] ci: remove the pipe after "p4 -V" to cache errors
References: <20221124153934.12470-1-worldhello.net@gmail.com>
        <20221125095954.4826-3-worldhello.net@gmail.com>
Date:   Sun, 27 Nov 2022 09:24:12 +0900
In-Reply-To: <20221125095954.4826-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 25 Nov 2022 17:59:52 +0800")
Message-ID: <xmqqlenxb5xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Subject: Re: [PATCH v4 2/4] ci: remove the pipe after "p4 -V" to cache errors

"cache" -> "catch", I think.

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When installing p4 as a dependency, we used to pipe output of "p4 -V"
> and "p4d -V" to validate the installation and output a condensed version
> information. But this would hide potential errors of p4 and would stop
> with an empty output. E.g.: p4d version 16.2 running on ubuntu 22.04
> causes sigfaults.

... before it produces any output.

> By removing the pipe after "p4 -V" and "p4d -V", we may get a verbose
> output, and stop immediately on errors becuase we have "set -e" in

"because".

> "ci/lib.sh". Since we won't look at these trace logs unless something
> fails, so just including the raw output seems most sensible.

You started the sentence with "Since", so "so" should be dropped.

> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/install-dependencies.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Well reasoned.  Will queue.  Thanks.

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index feefd6e9bb..97a1a1f574 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -83,9 +83,9 @@ esac
>  if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
>  then
>  	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> -	p4d -V | grep Rev.
> +	p4d -V
>  	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> -	p4 -V | grep Rev.
> +	p4 -V
>  else
>  	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
>  fi
