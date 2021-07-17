Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BDC636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04C8610F9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhGQRGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhGQRGo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 13:06:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BA7C06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 10:03:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a80so716371qkg.11
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dRRMeOIOmKuImUZjC6XEF8vj6iqVHA0oHTXEGy/WDOY=;
        b=lS/T4ChQi4xNf6FELdKou0810K8wueXgd3+O+SHUg3AC6SukTphoa5OsNQ6s9VrDjd
         B//z9nirY6VWJ7BhDvCr1vtAV9knpLrNFQOaRg5wdu8UfaW25zqi0mWX4Ctnr06PZrCg
         ZHq6zMleaIghFJnyQ/BpwKLAIdk1H/3MUzMh9dRfhLAGnXUDLMrTLwBW1rVRjCzaKfuG
         tXAzrLUq6JXAMZmM/CpG1dCiOM6x4Qvy+45uIFJT9VikH6R54F4CwkdD9bttxrpa1Eo2
         4KfjDxZN8QLbtVoGF/OB8dCvpzg2GX5XUbkcanP3druJ1CbYwtcEAVuZzlAdOSIJpt3h
         lWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRRMeOIOmKuImUZjC6XEF8vj6iqVHA0oHTXEGy/WDOY=;
        b=dxkQbZQIFSqb/a8BeWr0e48MgCFtcCY6wT3eLUzpd7OdR+gkNT0rj9Cb2dzxcGReUp
         +xkkDk5nVvdpal1xv+Gkw+DLr11qVmuhAGGPI/rk4Z+HxEPNmMLdGbwYYIProA4Mi0gD
         MICcsIfjG/3ayBcr1cSEjHhKcXkbt24wTbUvgesGfl6ToAoyq7uzlS6Z0pmMDA8jEEfP
         W3b4RTqHgYfXAKB3cu/Tewyut82ep6BJ6Pn8AreUSZO1s+6gaRLW1gOYHV67ozVwDw2Q
         PDDb2rCJX5CL0JKMIrWmID19PaLuRgyQn5YAYrz5VpFjUGAJGUostuEKV56318WWb9vO
         f4QA==
X-Gm-Message-State: AOAM530ZrdgzkxdevdqY9I5nICCVtSFLSoB9cZjbA+liqxOEe86OWdX1
        NYyvGSxATdg2fKeb0GuF5u0=
X-Google-Smtp-Source: ABdhPJzcXKd8lvdq1yrrV1jAlG4V0dykcbq4Vipmlg2jPWDpLVqX1Sg9lV73PK+iJ63zN0HnvN2uiQ==
X-Received: by 2002:a37:9606:: with SMTP id y6mr15985357qkd.13.1626541426382;
        Sat, 17 Jul 2021 10:03:46 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id j20sm4450961qtq.14.2021.07.17.10.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 10:03:45 -0700 (PDT)
Subject: Re: Regression in 'git pull --rebase --autostash' since v2.32.0
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
References: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
Message-ID: <109545c7-7245-6146-d39a-2a44ac450db3@gmail.com>
Date:   Sat, 17 Jul 2021 13:03:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 2021-07-17 à 11:29, Philippe Blain a écrit :
> Hi Felipe,
> 
> Your recent clean-up of 'git pull --autostash' seems to unfortunately have made things
> worse if the pull brings new files that conflict with existing untracked files,
> which makes the pull abort,
> and there are tracked files with modifications (so --autostash comes into play).
> 
> Before your change, 'git pull --no-rebase --autostash' did *not* apply the autostash
> after the pull failed, thus loosing modifications to tracked files (and it did not save the
> stash entry !). 'git pull --rebase --autostash' correctly applied the autostash, but ended with
> a strange "error: could not detach HEAD".
> 
> After your change, both 'git pull --no-rebase --autostash' and 'git pull --rebase --autostash'
> have the same buggy behaviour: they do not apply the autostash and do not save it in the stash list.

The change below seem to fix both cases:

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..b2ad70c50a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1560,6 +1560,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
  					  &head_commit->object.oid,
  					  &commit->object.oid,
  					  overwrite_ignore)) {
+			apply_autostash(git_path_merge_autostash(the_repository));
  			ret = 1;
  			goto done;
  		}


*But* from a quick audit of 'cmd_merge', there are still two code paths that
call 'create_autostash' but then fail to apply it before calling 'goto done':

1. the branch 'if (automerge_was_ok)' (line 1693)
2. the branch 'if (!best_strategy)' (line 1704)


Cheers,
Philippe.
