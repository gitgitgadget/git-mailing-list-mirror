Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D9FC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C7622CB2
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgLUEof (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgLUEoe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:44:34 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F215C061257
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:43:54 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 143so7848776qke.10
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VHIijOP++xeMfl7Rf9yNRjLRvsaskUnYrH6VJFOL16I=;
        b=ChEdy2FHQ95S2JfWyE53O9GG263c2/ANz9Pxtvrf3zHm4WsCZ97OhEozY8ZjKMSh4v
         N7G/pKfuIu69zDEavur6LzyC/06jCyMMM5Z70M1Z1InrVvD+JtQf0Sw44UNPDyVwMnJu
         klxqc+t40eNoHJlBH352RSldgVDiCE5nBPpcJdeRM1RKIEO+ZvEPqLJwKpc2WReYui/a
         0uGcDOGTYQvQ1QVKFTwD/pNG2dTuXPKAKKBr+iodGALByG0R6xszeJ2Yq3LhEHzYAlXN
         heXe6dadYgpyk7CDoX8/lwqGzmTY/5t7ujbtWAUx+k1k4+HSfisdJ+j+uNVDanMVy3oc
         KUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VHIijOP++xeMfl7Rf9yNRjLRvsaskUnYrH6VJFOL16I=;
        b=ZTytJWsL6kvK6J4tfn3V//0AatGNOt/OZHo7DPSqq0fNY6Q7eUQ9RYWCJ1X8b6Hrfi
         XWc6DsVq9cHDaYZjVw2TgOUjDrAlU9k9i8AyowR71NdYDuZD7MVueQ27ictqw4kXLlnQ
         inmvaXtqEO9Uo7cqJLQlQOhSeit3KRT5aVWrYB9pB6oZpA1wTNaEF746034ghddVRmFa
         6rx8JBCGzrJbNz9wpD659uGT47+NDPzQpRLtMex+Mb97YlwK0lyAusUriV+2ohuj448f
         MpSO2uXiBskMJeLan8hnN3glz111VubEu+hG7wJ8lV3ymqo7DlTVWPZHLYDwj2UxGxMR
         l5wQ==
X-Gm-Message-State: AOAM533snh7y/DM9YE8GfUWOTi1VmS0a8TnvXhJxyvGMfAcAbQULMuhH
        Sz2BIIru9gpNozIXwMlf7jShOFvsmCoSWi/z
X-Google-Smtp-Source: ABdhPJwMLZyDweLUKkMGZyacrAlIoJaWtdcQEpQ8IOKmQ2O+9WGM8/+YJk/jv8qpiga8mO3PstpaVw==
X-Received: by 2002:a05:622a:243:: with SMTP id c3mr14453007qtx.202.1608512929608;
        Sun, 20 Dec 2020 17:08:49 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q37sm9722580qte.10.2020.12.20.17.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 17:08:48 -0800 (PST)
Subject: Re: Git fetch failure in submodule if deeper submodule pointer
 updated
To:     "Yngve N. Pettersen" <yngve@vivaldi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <op.0vvmwohypvqxoc@damia>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d1fcf5ed-9dea-9721-55da-a3d85a9916d8@gmail.com>
Date:   Sun, 20 Dec 2020 20:08:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <op.0vvmwohypvqxoc@damia>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Yngve,

Le 2020-12-19 à 09:37, Yngve N. Pettersen a écrit :
> Hello all,
> 
> Recently we encountered a git fetch issue similar to the one I have reported earlier, <https://marc.info/?l=git&m=158979416620251&w=2>, which AFAICT has not yet been fixed.

Regarding your earlier report, I don't think it has been fixed either.
The fact is that I don't think any full-time contributor to Git works
on submodules much these days, so issues like this one, that need design-level
discussions to be fixed, often take more time to get fixed, if they ever are.
Now on to your new report:

> 
> In this case we had checked out a submodule, but not the submodule(s) below it.
> 
> The full submodule chain was like this:
> 
>    top->middle->bottom
> 
> The actual checkout was
> 
>    top->middle
> 
> Because only "middle" was needed for the cron job script used to push updates to "top" and "middle", "bottom" was never checked out (and it should not be necessary to do so, either).
> 
> When the pointer to "bottom" was recently updated in "middle", the cron job failed, because Git "could not access submodule bottom".
> 
> As I said in my earlier report, this kind of issues should, at most, only trigger a warning, not a fatal error.
> 
> 
> The Git version on the system is Git v2.25.1 (Ubuntu 20.4)
> 
> This problem is not occuring in Git v2.17 on Windows.
> 
> Attached is a zipfile with a script that reproduces the problem.

Thanks for the report and the reproducer. This bug was in fact reported and fixed
earlier this month [1] (full threads: [2], [3]). The patch series is currently cooking
in the 'next' branch [4]. You can check out just the fix from [5]. I don't think
it's going to make it to Git 2.30, but it should be in 2.31.

Cheers,

Philippe.

[1] https://lore.kernel.org/git/20201209105844.7019-1-peter.kaestle@nokia.com/
[2] https://lore.kernel.org/git/CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com/t/#u
[3] https://lore.kernel.org/git/1604413399-63090-1-git-send-email-peter.kaestle@nokia.com/t/#u
[4] https://github.com/git/git/blob/730f2a8a60960c30a79e00ebe034836f60befbf0/whats-cooking.txt#L765-L771
[5] https://github.com/gitster/git/tree/pk/subsub-fetch-fix-take-2
