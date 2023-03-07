Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA7C6FD1E
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCGSDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCGSC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:02:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBFA1FE5
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 09:55:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i10so14982684plr.9
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678211744;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21X5w/KK2Am7A0BPGLpaaY+T664U3AaYgzxh0q5y8jQ=;
        b=STuz5kIxKp6z8FU3rad2MRKS495jSyL+pUzVQfenPVMA5l7Quw60om5YEumBJnOFYL
         OgymI0FyAGrPowmKcTxlzg2dwran+keH0DlHTHjKYl7zEkXgcxx3zMnQY7LWyb+iF5qi
         rQSCDkRd3GWZ2skh620DR9XpTbY2kzyk5ErO+dYZv0tlJJLdeVKCRN8i0/fVuf1SY09i
         dgkhN5tcX2VlaNx+l/ZWW602Qo71kYmk039D0Lk5YN8NCKmMGzTpsgfxYQSCOmsaNoum
         yQDu8tFLhLvdCKKeGzCFjhTWEd6kPd8F4zIPLzuGB0RGdEUTwjZLyDHfrVuoHo5+ktlb
         Qm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211744;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21X5w/KK2Am7A0BPGLpaaY+T664U3AaYgzxh0q5y8jQ=;
        b=Cd0NmhrfE5g+OT8ujqaHF/zWt9vS+Wpy9+8VXA24z0hSGmWwqW8tVVNkhxPgKmE/2E
         Pj2ZWd94dOBVZQBYXdEY4HRHYdJawNdfenNHKcUscA1ZbUmBUXajAg4Cq/RWMDBUybWJ
         krJnEeDUIDJenj9rtE6IaN+y75yUE0H5hVpyY/XJ+Ak3jiDqg8ZL1y94lOPXw2wNuzqr
         C3b3qX5j2Xo7xbSeVihw/3dDGMaVE7LCsV/3/0xGpW1Z42cmhGHa/j8csBQDdlZPdMNn
         yvPPieqjqJ+06C14piVueRvni7EeNLQqjXT22Kck2BoRL3ZTVzucolY+h+9AK1YIXEOn
         sYYQ==
X-Gm-Message-State: AO0yUKXjY0xfLonrbNn9PJYw1iLry9lSnJ7tCD70MPJE35IkeQmL5n3T
        uNjJhQlOD+JvusoLXnuf/yY=
X-Google-Smtp-Source: AK7set8bCEz9X+hj6gFd2YFB1pekw6RFkZk2GO8LcbfPNPu//vePZP7LPAiyVe3pypumyx6uk1a+/w==
X-Received: by 2002:a05:6a21:3385:b0:cd:238f:4f4b with SMTP id yy5-20020a056a21338500b000cd238f4f4bmr16813721pzb.23.1678211743873;
        Tue, 07 Mar 2023 09:55:43 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7870d000000b005ac86f7b87fsm8150114pfo.77.2023.03.07.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:55:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v9 6/6] diff-lib: parallelize run_diff_files for submodules
References: <20230209000212.1892457-1-calvinwan@google.com>
        <20230302215237.1473444-1-calvinwan@google.com>
        <20230302220251.1474923-6-calvinwan@google.com>
        <230307.865ybc273g.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Mar 2023 09:55:43 -0800
In-Reply-To: <230307.865ybc273g.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Mar 2023 11:21:10 +0100")
Message-ID: <xmqqv8jczbs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 02 2023, Calvin Wan wrote:
>
>> +		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
>> +			parallel_jobs = 1;
>
> Something I missed when eyeballing this in my just-sent review, here we
> have a "revs->repo" already, so let's not fall back on "the_repository",
> but use it. I think you want this as a fix-up:
> 	
> 	diff --git a/diff-lib.c b/diff-lib.c
> 	index 925d64ff58c..ec8a0f98085 100644
> 	--- a/diff-lib.c
> 	+++ b/diff-lib.c
> 	@@ -312,7 +312,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
> 	 		unsigned long parallel_jobs;
> 	 		struct string_list_item *item;
> 	 
> 	-		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
> 	+		if (repo_config_get_ulong(revs->repo, "submodule.diffjobs",
> 	+					  &parallel_jobs))
> 	 			parallel_jobs = 1;
> 	 		else if (!parallel_jobs)
> 	 			parallel_jobs = online_cpus();

Good eyes.  Thanks for a careful review.
