Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935AC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJCQCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJCQCN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:02:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96C33371
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:02:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d11so10064868pll.8
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqP9Sf/eGR9x1S3bi6hDAo8/poZlFU7mKWa6d4xqLBA=;
        b=q0NxWTl3VM2M/6Y/NDnwaKXQbeFGZ2vPHeFp1XliFqDSVdlLfO4cJ+SmdmSliGjrAU
         aDeXmWDMgYDjP+S0zvS3C/ZbAgeG7iovVd671Zy7TYJfy5BryNXYrJotrnRd8ivvKVHE
         nfHFd5u8g7JSLagd6GrN3NfB/samIwvEYg27AvrmqYaAJP0YDJkY5xgsGOKp7z+wIXNS
         qSq3xIUYsyd//KV/AU+UJHs1YmifIyN8C6b40MMkTtXVLJPBzgKtae0zbDmSu8i4LUrp
         9wCHU+Is4+9z9+bIC19TYKa0lfqc4TD3R1a0dcp9HjL5nAvNYIWhh/6DUHeD7UYl7jCe
         wVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqP9Sf/eGR9x1S3bi6hDAo8/poZlFU7mKWa6d4xqLBA=;
        b=K0yjsxw8+nqOYg2HCrWr85bZksll1xwvFa8MGg6GjoQ7pSWfg5QMZph85xGwMnfJAx
         aS8gcqW/GnXBLwOmnn4cNszALk0/SWj8sNL/tzfE+E/JmA9iznJEgaCJIq3k8/zPYkGv
         2X9bDb8G2oGk/GLSLSfJNlKRMQs+ChzTVoOLXGNqE+vOitlu+kauLWs1YEwZ8G5gy1fm
         q5UNtYw7B0uxDfZOKUinFMH2+RQMokBP5i+IqxvM6JuRNVI6zLAIMSeQ1kCs1slKgfwJ
         1c6MBCP855JbZFLg1PeYpRwAtsRfgacsHWWgM4mgbi9Kf/VeN+xqVKNQA526QlnvCalY
         AhiQ==
X-Gm-Message-State: ACrzQf0AtNIDPm/X5TZSuNiD+8wkU8dA6TMlI4a+19YDBaGjmljijW5P
        UGcUnjK5lZbvQW4n0a0RHWk=
X-Google-Smtp-Source: AMsMyM5/6AU8DfoHsw9bpGSjQM5HVbiw9uJxp+JGjEmWsL9A0wNMEAW1UnEnMPwFJsHHmJ64Dg3Upw==
X-Received: by 2002:a17:903:240b:b0:178:a475:6644 with SMTP id e11-20020a170903240b00b00178a4756644mr23071141plo.96.1664812930189;
        Mon, 03 Oct 2022 09:02:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y12-20020a63b50c000000b0043941566481sm6783317pge.39.2022.10.03.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:02:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] mailinfo -b: fix an out of bounds access
References: <pull.1372.git.1664789011089.gitgitgadget@gmail.com>
Date:   Mon, 03 Oct 2022 09:02:09 -0700
In-Reply-To: <pull.1372.git.1664789011089.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Mon, 03 Oct 2022 09:23:30 +0000")
Message-ID: <xmqq8rlwyjy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> We have tests that trigger this bug that were added in ae52d57f0b
> (t5100: add some more mailinfo tests, 2017-05-31). The commit message
> mentions that they are marked test_expect_failure as they trigger an
> assertion in strbuf_splice(). While it is reassuring that
> strbuf_splice() detects the problem and dies in retrospect that should
> perhaps have warranted a little more investigation.

Indeed.

> diff --git a/mailinfo.c b/mailinfo.c
> index 9621ba62a39..833d28612f7 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -317,7 +317,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
>  			pos = strchr(subject->buf + at, ']');
>  			if (!pos)
>  				break;
> -			remove = pos - subject->buf + at + 1;
> +			remove = pos - (subject->buf + at) + 1;

How embarrassing.  

It really is (&pos[1] - &subject->buf[at]), subtracting from the
address of one past the closing ']' and the address of opening '[',
so the rewrite is correct.

Thanks.

> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index cebad1048cf..db11cababd3 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -201,13 +201,13 @@ test_expect_success 'mailinfo -b double [PATCH]' '
>  	test z"$subj" = z"Subject: message"
>  '
>  
> -test_expect_failure 'mailinfo -b trailing [PATCH]' '
> +test_expect_success 'mailinfo -b trailing [PATCH]' '
>  	subj="$(echo "Subject: [other] [PATCH] message" |
>  		git mailinfo -b /dev/null /dev/null)" &&
>  	test z"$subj" = z"Subject: [other] message"
>  '
>  
> -test_expect_failure 'mailinfo -b separated double [PATCH]' '
> +test_expect_success 'mailinfo -b separated double [PATCH]' '
>  	subj="$(echo "Subject: [PATCH] [other] [PATCH] message" |
>  		git mailinfo -b /dev/null /dev/null)" &&
>  	test z"$subj" = z"Subject: [other] message"
>
> base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
