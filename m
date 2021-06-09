Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B72C48BDF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC76613D6
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhFIRrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:47:37 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44923 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhFIRrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:47:37 -0400
Received: by mail-oi1-f181.google.com with SMTP id a26so5182743oie.11
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SdZih6cpBOoWeHdkDK3Koed0P7PTq8LT1VivVXcBIpk=;
        b=jAuA5uF0Majfdh+XxnKSwOi6hWkeClUX+hOVvxSoepJsx4fBdHTXC3EKBSp6em+go8
         flaB5uVcCZCu0R8hsVAfyHdm3yB1v7ZcwJenD7peFZGSuevXsJcZCcD8/MefiuDsLJKx
         YQUI3DrOAX7K0V2OanHwLYoTQmXV+OOKK1fzkwpTVjD42emF0XkWm8V2kQMLcJoTeO7c
         JAjzzKAXj2XgVehO5VgRZWrKdJO7xNY6DReOFZplYd5PJeo0NxDEK9G9Eaep4XAInV+O
         nGGOfEsFKCRAkH+YCjpnnfOR3mOHjFsOhbBQWhBOTxHVL9trEI/anBQlW/F8HWO+F+Kk
         zNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SdZih6cpBOoWeHdkDK3Koed0P7PTq8LT1VivVXcBIpk=;
        b=QWjiTl7WzNdP2tAeDZ1nnQhm/jZ/QKxUaCrmyhSszKflhx2vlY2yCo9bb78JKffe+f
         dnaU4ZGOs/5INKwBMp6Ot7doSHeCHhloY3JCFa12bfJIcz1l6jNkLrnnKAmcDeUMHrVU
         F6BxUoSrKweVr2cxFis6akcJoatg435kL3HZY9zxI3ZYtDhY2qs6aZzaQQm4CGg5XHXw
         6XZbRxuXUgiwjTHjwzUMWZg4mztp95sHfX0z3nUOwTKVKKMOH/w2ghsaTm/ovV/Emliq
         XnFAu5tpHc2cWIHJcDoOzLyDerN/ctxtERP7bIarGwfPU8PLzLWFQw5bkGF1+9eB87Qg
         HlfQ==
X-Gm-Message-State: AOAM531Ym4Y0ALA3A4QZZ0g7GI5Lvxf3/TdJ3yY0kSQGoXWmzY2zpy6x
        LGLSRpK6DuoMlu8LsTA2L1k=
X-Google-Smtp-Source: ABdhPJxEhH96U8xJ6h/uzzpjKwPfh43FfaXJVPY78VxWN3aKj6AA0Z0nxkNH7qOlTik7FQh/NreMLQ==
X-Received: by 2002:aca:382:: with SMTP id 124mr7282359oid.49.1623260682170;
        Wed, 09 Jun 2021 10:44:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a78sm92127oii.42.2021.06.09.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:44:41 -0700 (PDT)
Date:   Wed, 09 Jun 2021 12:44:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c0fe08659fc_10887208d8@natae.notmuch>
In-Reply-To: <AS8PR02MB730269FA1BF5C3B0CE20DD8B9C369@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <YL+p+MlgJ754YoqB@google.com>
 <60bfb1003c46b_1ac15c20894@natae.notmuch>
 <AS8PR02MB730269FA1BF5C3B0CE20DD8B9C369@AS8PR02MB7302.eurprd02.prod.outlook.com>
Subject: RE: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kerry, Richard wrote:
> What do you prefer?
> 
>   A. We thank the reviewer for their helpful comments
>   B. We thank the reviewer for her helpful comments
> 
> [RK] If this is, as it appears to be, a reference to a specific reviewer, then use their preferred pronoun, or possibly a conventional singular one if you know their name and they haven't specified a preference.  
> [RK] Only if they aren't known, and especially if they are one from a pool, then "their".
> [RK] Or make them plural - We thank the reviewers for their helpful comments.
> [RK]  Or rephrase to sidestep the issue (though it isn't clear to me here what that option would be)

The question is not what sort of rules you would like us to enforce (I
for one don't believe in policing speech).

The question is what you as a native English speaker, or non-native
speaker, think of the sentences as they are. Do they sound grammatically
correct to you?


Would it be possible for you to use quoted line prefix [1] as is common
on this mailing list? We only have the beginnings of a mailing list
etiquette [2], but this is something that reads very different from
everyone else.

Cheers.

[1] https://en.wikipedia.org/wiki/Posting_style#Quoted_line_prefix
[2] https://lore.kernel.org/git/20210512233412.10737-1-dwh@linuxprogrammer.org/

-- 
Felipe Contreras
