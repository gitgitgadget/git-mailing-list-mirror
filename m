Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3612FC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 22:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjAWWwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjAWWwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 17:52:11 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264123D94
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:52:10 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x4so10030273pfj.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPEW8/EQqDhZKC5HTyhYHauWuhregtCr+c8JDBhqgEs=;
        b=W5Y3gLrSpXlFfM1ILmncY2qwniojzqDk1hOdsGERdTT0vaOlASDlbdjiiuXLjv3AjB
         MoDopDNpbtFFFaKZ2dC1+E6LqIN96j9VQYzyWUP1LnJ0622uiHKYhJsYStAxkOCGqCgV
         4dNGL16JXAVrqNvKBrwRwsTLuYsQSmafmZ2hzCKROhnOjQycdKMQnns8kP2Bau7AtQRh
         W67JVobe5h4tyYwl1vdLdS7L5any5eL3fG8GzEGBsG/OV3fr9twjIIxHM+sYCQObcHlM
         DLvUl5rN9nLUUsg5GVHscpkBTywBvY6vHkCFmKrZ8YfN8cXeAoWNiuK9st8LuAO4Wh8u
         BS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPEW8/EQqDhZKC5HTyhYHauWuhregtCr+c8JDBhqgEs=;
        b=lFQe6rdjVyf+3ZP+J7w9h0Aw3+mLJX5Apz34Paw6fyoIZsUN+qK256r3PLDpyqSg0v
         gnBF9e0agk/aE+PTefwSlHUaDUptK4IRHf8PmqfFA6eEVw0HE7JFk5eZAbg9rP0w4bYT
         Q6zFkp5xjRyxVjqouV7ysHziI0f5u9LsVrkJSAWktGnDeax9ZNrygqU2nrmZDokVeTRr
         SUGiqmA8FAkEGlmbIfeqOSY8stA8E/QOKG5gRLuYsLfg+x74zdTQWuU4PuFWXekP6F7h
         jpo8ZXcpoRLQEQkiB7YGQeL4tcgKOhBlW2NqWzx9Dc/7o71tIPxOhtUI897688/Fnex5
         w0PA==
X-Gm-Message-State: AFqh2kogKJ8EboRksNZvk49NP9mPMSTdGWHkUeZUuCF9OD1Kf8qmgBtW
        bfZgS80uhCJSkilEKcpLEO8=
X-Google-Smtp-Source: AMrXdXsPVKz+wbZBSRPJEKK7JPet/vOWKIctYczyIYaGqhyUN02sRVbghMxCMHwtXNblvJj6QCkf9w==
X-Received: by 2002:aa7:8283:0:b0:588:9c15:65c4 with SMTP id s3-20020aa78283000000b005889c1565c4mr25631167pfm.3.1674514330275;
        Mon, 23 Jan 2023 14:52:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 186-20020a6206c3000000b00571cdbd0771sm110368pfg.102.2023.01.23.14.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:52:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH 2/5] run-command: allow stdin for run_processes_parallel
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <patch-2.5-81eef2f60a0-20230123T170551Z-avarab@gmail.com>
Date:   Mon, 23 Jan 2023 14:52:09 -0800
In-Reply-To: <patch-2.5-81eef2f60a0-20230123T170551Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Jan
 2023 18:15:06 +0100")
Message-ID: <xmqq8rhslv8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +	/*
> +	 * By default, do not inherit stdin from the parent process - otherwise,
> +	 * all children would share stdin! Users may overwrite this to provide
> +	 * something to the child's stdin by having their 'get_next_task'
> +	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
> +	 */
> +	pp->children[i].process.no_stdin = 1;
> +
>  	code = opts->get_next_task(&pp->children[i].process,
>  				   opts->ungroup ? NULL : &pp->children[i].err,
>  				   opts->data,
> @@ -1601,7 +1609,6 @@ static int pp_start_one(struct parallel_processes *pp,
>  		pp->children[i].process.err = -1;
>  		pp->children[i].process.stdout_to_stderr = 1;
>  	}
> -	pp->children[i].process.no_stdin = 1;

For this single process, by default .no_stdin is set before it is
passed to start_command(), so the default behaviour does not change.

This needs a new safety to ensure that processes that have .no_stdin
turned off do not share the same value in their .in member, doesn't
it?  Hopefully that will be added in a later step in the series?

Provided that such a safety will appear in the end result, this
conversion does make sense to me.  Let's read on.

>  	if (start_command(&pp->children[i].process)) {
>  		if (opts->start_failure)
