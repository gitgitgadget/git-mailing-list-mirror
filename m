Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47299C433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2BD2075F
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 11:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB0UJra7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGLL1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgGLL1K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 07:27:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B8C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 04:27:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so11023526ejc.3
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zeo28TWAvkfPxb9rfdkyrOC25rgH7YeSsDQSFyFLhig=;
        b=CB0UJra7SUk61R7ZQGh1ArieNdWw8NNl661680aguAEiaudgb2DM4D3q9cowx+7Fpy
         P+BRu6NW48JGkzAlG8iWt2ZauVx4eeiZMdClVAxC3v7Z37QCyWwoiiqFqQXlc3Vi9gC4
         6X8y3Tdb08QhnwjttKvJs0sfhdliym1KMLwRbkgnI+y2p+4CGEod1ITLdn7OosF2j/a6
         8+9RAnuZ9GIf8ueFrEvaIBT8NAVPCw+NS1d6vIxx7NyQG4JSSXkoJssYS+elKSejtyFi
         BPYmSiZCuGnjjsGtuVeHSyg0HEEVNUWDKe7P3qTOBCphJ2TaMvv2cy2gMN3A+sADtOno
         rfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zeo28TWAvkfPxb9rfdkyrOC25rgH7YeSsDQSFyFLhig=;
        b=dGwzjCPTyWs6fhaMtBmnAASQH49bvZFnWDhxIIrFdKWCDn+TCswFhWyhEugO0vGj4u
         LV8/JJjOwetNVa5I5AzT+FNXIOhjxjYp4Kdexu5hayQ3FTHeoLEXyxQZ7gLkEVm1PwTd
         HRN5S3eqM3hVNyHkqVVipZadYWrRwuj4dv5VaOCQk9K6VkhyJUkJwm1Ir9QAv4X02pB9
         UcUTKNkjuVpuZOX7phTZamgygXxgBokLPGWH85Bw07heCLyGtg77CsSjEE8zcGKLXB+s
         nlZkK1UJZ96ZfJMLyk9ehliy0R7q0t1937XN1BsqEtspnC30meIvmlhmXnokP8x2cjGu
         Elbw==
X-Gm-Message-State: AOAM532IbgSHcpxZiwlAiPybfkOIVkf87MfLZoCGoNM2VaBTUs2Ps1GG
        0a3xYwcTb3TP52nwrv+gLZo=
X-Google-Smtp-Source: ABdhPJxRSnsYfyPW1eCOG44WO7Hu9hivb9Hwc+hUnaWB9S+dfxrKMMPe0ELxxVqbbC8i1WFazZRTGg==
X-Received: by 2002:a17:906:8607:: with SMTP id o7mr68101991ejx.142.1594553229152;
        Sun, 12 Jul 2020 04:27:09 -0700 (PDT)
Received: from andromeda.lan ([80.215.156.54])
        by smtp.gmail.com with ESMTPSA id cb7sm7435262ejb.12.2020.07.12.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 04:27:08 -0700 (PDT)
Date:   Sun, 12 Jul 2020 13:27:03 +0200 (CEST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v1 16/17] sequencer: use the "resolve" strategy
 without forking
In-Reply-To: <6bee3870-a363-2f02-1319-4c0bee7dec95@gmail.com>
Message-ID: <alpine.LFD.2.21.2007121323220.17922@andromeda.lan>
References: <20200625121953.16991-1-alban.gruin@gmail.com> <20200625121953.16991-17-alban.gruin@gmail.com> <6bee3870-a363-2f02-1319-4c0bee7dec95@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463785727-1897089796-1594553228=:17922"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463785727-1897089796-1594553228=:17922
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Phillip,

Phillip Wood (phillip.wood123@gmail.com) a écrit :

> Hi Alban
> 
> On 25/06/2020 13:19, Alban Gruin wrote:
> > This teaches the sequencer to invoke the "resolve" strategy with a
> > function call instead of forking.
> 
> This is a good idea, however we should check the existing tests that use this
> strategy to see if they are doing so to test the try_merge_command() code
> path. I've got some patches in seen that use '--strategy=resolve' to exercise
> the "non merge-recursive" code path, so I'll update them to use a proper
> custom merge strategy.
> 
> Is it worth optimizing do_merge() to take advantage of resolve and octopus
> being builtin as well?
> 

Hmm, I see that do_merge() doesn't call directly the strategies, and 
delegates this work to git-merge.  If calling the new APIs does not imply 
to copy/paste too much code from merge.c, then my answer is yes.

> Best Wishes
> 
> Phil
> 

Cheers,
Alban

---1463785727-1897089796-1594553228=:17922--
