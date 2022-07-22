Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05673C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiGVNva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 09:51:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C42743F5
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:51:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v12so5930537edc.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v2TDGTpjWTVqzDj8/YNNylZ1oF3bUiwe+DNW186zmBU=;
        b=K9TKF5pnihswfmtfxieniS142mx/O3NJNvlCJWUGNcpVHL+WHUmlmbcjFnA2S0chcR
         S6arwH0m5ZtGBj4TT1qP0rwC+BiA0IXWDdu5ZjCMMArH6j/lED/0FS9OfuZb6XZPs56u
         B35/UlgBO9QOX0sMD277Bj2k9UuPnG83vLQX7cT5L0fw2bbSiQQBsvSFpM+vqAuTXhVY
         lmtQ6MvQi7dFi35mUC8BWq7Xndt5ytgTIY65jPsNY191zU6ThNONvBeXRNeGWMN2sDrX
         ecGlh3vkoqRN3/jOOZhPgKG+/ywFIuW+pqz8aVDdxPvQH4B9BKHhuYQRr6B98o+/1M/q
         a12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v2TDGTpjWTVqzDj8/YNNylZ1oF3bUiwe+DNW186zmBU=;
        b=y98/Rb811KoBP3qV32yIYn33EI9JvYTYzJVCIZiooIPhopvzLAGA2GkV6NRPrUhMny
         4yIu236Blydlpnt/JhpU15t9j1yQS07xPqgCMUc6+ekVZUMZMGF7kPszPWoJDNQGuQdO
         B0Cd/zgTW+6Icq7SSPmzGpaIDiwJ4oG4iHiZgqn61Y3GlzWyyx+nUrsI8L5afmaId2iV
         1LzL1qklQ7y65eIqdpNEfIREJJtPIVRKgIYmuBI5XiThNIdsnua1V8SLVzrL9EUXO3TL
         HrfOOQi+9FayXrPLUqGcqPutrNXgn+Sq8FJdhzng/JIfGIJetbbS6FvVA+OY7LsRepkg
         tOaQ==
X-Gm-Message-State: AJIora81Z9ZRTmlMRpfAI0V9s1iuCzM709ILnktLjAWw8gscKBfYYWN8
        UCoVRRZ9M/FJ+ohLpXsTAH4=
X-Google-Smtp-Source: AGRyM1tzGOZ7vO1PSh/oompwcY3o0yGDF+O2/rTL1Yb/nDZNnzbei9jXHHVGg0oyCjMzDjdGbKgI7A==
X-Received: by 2002:a05:6402:529a:b0:43b:b8e4:fca5 with SMTP id en26-20020a056402529a00b0043bb8e4fca5mr821617edb.344.1658497886433;
        Fri, 22 Jul 2022 06:51:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ej22-20020a056402369600b00437d3e6c4c7sm2564647edb.53.2022.07.22.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:51:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEt3s-005L8u-VN;
        Fri, 22 Jul 2022 15:51:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 02/26] submodule--helper: stop conflating "sb" in
 clone_submodule()
Date:   Fri, 22 Jul 2022 15:50:32 +0200
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
 <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
 <xmqqlesmf9or.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqlesmf9or.fsf@gitster.g>
Message-ID: <220722.86y1wlqmqr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Junio C Hamano wrote:

>> +static int clone_submodule(struct module_clone_data *clone_data)
>> +{
>> +	char *p;
>> +	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
>> +	char *sm_alternate = NULL, *error_strategy = NULL;
>> +	struct child_process cp = CHILD_PROCESS_INIT;
>>  
>>  	if (!is_absolute_path(clone_data->path)) {
>> +		struct strbuf sb = STRBUF_INIT;
>> +
>>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>>  		clone_data->path = strbuf_detach(&sb, NULL);
>
> This looks like a roundabout way to say xstrfmt().

Yes, I can fix this and others while I'm at it, but a lot of things like
that in this code are funny uses of APIs that we could improve.

I think it's probably best to just leave these for now.

But I also don't mind adding another commit to this already large series
to search/replace the relevant strbuf_detach() with xstrfmt()....

Just let me know...
