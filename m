Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F135DC636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBHVDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBHVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:03:32 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1414B4A239
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:03:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ge7-20020a17090b0e0700b002312568942cso1548581pjb.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVYLRLmGoGOUxTz/2T8Sxmu6o06+9ek6g0tuT6inv94=;
        b=bP++vVPLbxNdOsmfIJ/xoJZ+Uxq7lFhG6jm7p5NFmEOtf6R1RfwcHj/SRlnzCe6t/2
         ocITh9JNzaLp2BjA7UET0S5t4q7B39LjNtwBxkZSnprsaRZW9zPqlNwrsy92NvvGPZoG
         SzfXhZLl5+AjLfHKZOuS7QSSQqS7H+oRnwnSQmmCJHM8Dp1SSNtDDFl8YiBda5ajaeoM
         EBIq6O256QobvDdZ5Pqrc3UWI9lu75XdAJbNddEfcuao4R9j2w8QIe3Mou67CEcZsEZA
         JwmSHb8SnVK6vxGsyEI+65WaG7vvXINex76RQ36SGlaTvaP7MdzMutO/GUzj6cVqV97B
         ug7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVYLRLmGoGOUxTz/2T8Sxmu6o06+9ek6g0tuT6inv94=;
        b=Txx7WHRNI6EmARM8rfCDza64QElMrJDK6HRK/zBCgTQY59yQCts1kq0Yyq6oWDq0ja
         IRRsniVWQf8dxssirI2A4dfuoS86QvcdP0wNZmNqFoqusUI5Qqa2BQVLaDF5GeTJcEQK
         bhe5YZrpUARttgyR7bmUkPUzmFc9qebgd391IwULDLIx02SOWn5hWa7/7S58sKLb/NFA
         Rqles0ct4tXbFKXOrRC72k3R5zRX6M+iiXjj5RtZqBG08ogFZmwlYx/3hRb4egA7ObGP
         SbQlj78P5GX2xNhsfnxNDGdfzv4I+4t7BKI3VZHi3waNR+oC5Qvnm62KBsTbqyVOM/qv
         srqw==
X-Gm-Message-State: AO0yUKXAYOla2GrdQH0sp0lP75C7wRl0YKq9SupyIGeLtDWTBeBX45Sh
        RVHU+TsUDZcVs4xvDRwcMpE=
X-Google-Smtp-Source: AK7set97GFQQ35mqYG3AAi40fwYNZ/HJl8CEiR0qe3YFFNKGlUOXwBW6QE+LH1vAee8H2AQM7NyUow==
X-Received: by 2002:a05:6a21:3809:b0:bc:d288:a67b with SMTP id yi9-20020a056a21380900b000bcd288a67bmr6945030pzb.43.1675890184445;
        Wed, 08 Feb 2023 13:03:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s7-20020a639247000000b004faf33e2758sm3837875pgn.40.2023.02.08.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:03:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/5] run-command.c: remove dead assignment in while-loop
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
        <patch-v2-1.5-488b24e1c98-20230208T191924Z-avarab@gmail.com>
Date:   Wed, 08 Feb 2023 13:03:03 -0800
In-Reply-To: <patch-v2-1.5-488b24e1c98-20230208T191924Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Feb
 2023 20:21:11
        +0100")
Message-ID: <xmqqa61nrhtk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Remove code that's been unused since it was added in
> c553c72eed6 (run-command: add an asynchronous parallel child
> processor, 2015-12-15).

Obviously correct.  Thanks, will queue.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  run-command.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 50cc011654e..b439c7974ca 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1632,9 +1632,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>  			     const struct run_process_parallel_opts *opts,
>  			     int output_timeout)
>  {
> -	int i;
> -
> -	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
> +	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
>  		if (errno == EINTR)
>  			continue;
>  		pp_cleanup(pp, opts);
