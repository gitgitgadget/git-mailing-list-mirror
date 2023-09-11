Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB593CA0EC6
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349473AbjIKVdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjIKJul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 05:50:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7ED116
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 02:50:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so70943741fa.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694425834; x=1695030634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KOIvvSRXwWQIpPElBMWRda+UTAujpMJWkl5JTD52Ywg=;
        b=NexFvf/StiM67LsEbcc3otKjR0u+hCmwqjQDyZ2xksHo/ITDZdaVzsgvXwNBnXKizL
         105glvBBL5spgP7BiaeD8zN3XL+nvkgwW55+Lw7/qpeRSkGBJVBViWKW9N6BNxONwipG
         epbPx3XhIDUbQVsryAmFfo9awJFuChVDSWW3Is7mTLZqFnpjCNAfMETyVWK0NGp8K/Dj
         qHy3dbsXOJgcM351HOS+52dEcZxvmcTjVJi/heZfTL4FAwci6Aee7S78W87aUjxh9gCv
         UGzjFK3rctEqt/6Hr+R06zuiLsRzG141w8inJzguMFVfw2SVjAfYdp7hLmkPna9ZjLpt
         O9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425834; x=1695030634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOIvvSRXwWQIpPElBMWRda+UTAujpMJWkl5JTD52Ywg=;
        b=SRhRhcUzLlhc+9D/pzAGTJbpLu1zcNPGE+2+I5oKbzdZPUl8L4tOgco/EEWTitWf9Z
         1O0YlxSPgtTKRypLd63tnbeuYEh4zS1e/oBBLC5c9aLdlfVUQfr1p5ZXkJ1u3d00nSNA
         50f45EmLGQg+V/gCq5x8xMrvJEHCt1iRRHFhFSMbVkN2s/ywE7jh7BTPSfwDk5SFPVFZ
         w6h5TuiEAPixx3PyKsjV3XrBdh3v+rzGLRt2r46rztS4QU4exx5DWCZFkwWc9MaRT2Wb
         VBb+VrP7m1nQrpS4NDWvPNcr9T0fhLiy5jBmSIh6Ynh3YoLAOtByP9yL5mZDVRy2afZ2
         EUoA==
X-Gm-Message-State: AOJu0YwkdGW4cxSJroReFhVLbRBFssnnkuG6pgZ415ygc0xbszC5w1m4
        AS4u+cyOAzmmqCJGwbNevy1lGpdp4oiCUw==
X-Google-Smtp-Source: AGHT+IEuPxZe4RQ6UM1uCkQkOA4Zf3P3oZ+AxwGQsL7AONqm3kRHiJNKfEayPi3TIzMqoRIJQdwh6Q==
X-Received: by 2002:a2e:9794:0:b0:2bc:d607:4d07 with SMTP id y20-20020a2e9794000000b002bcd6074d07mr7157658lji.11.1694425834090;
        Mon, 11 Sep 2023 02:50:34 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id n12-20020a05600c3b8c00b00402f713c56esm9573965wms.2.2023.09.11.02.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:50:33 -0700 (PDT)
Message-ID: <c64cd85f-f14c-46b7-a0d3-b8e0bfc60053@gmail.com>
Date:   Mon, 11 Sep 2023 10:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
 <xmqqedj8vfht.fsf@gitster.g> <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com>
 <xmqqmsxwtyy3.fsf@gitster.g> <376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com>
 <xmqq8r9gtviv.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8r9gtviv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2023 18:38, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Oh I should have looked more carefully at the existing uses. It looks
>> like it is only my sequencer patch that does
>>
>> 	sigchain_push(SIGINT, SIG_IGN);
>> 	sigchain_push(SIGQUIT, SIG_IGN);
>> 	res = run_command(...);
> 
> Hmph, does it mean this patch would become unnecessary, once you fix
> the above sequence to follow the pattern "to spawn and then ignore"?

Yes, sorry for the confusion. There are a couple of things that I think 
we should address though. Firstly we should change the comment in 
run-command which says execve() resets ignored signals to SIG_DFL to say 
something like

	Preserve the set of ignored signals so that running git via a
	wrapper like nohup works as the user expects

The other thing is that we have some instances where we ignore SIGPIPE 
before calling start_command() which means we're ignoring it in the 
child process as well. For example in gpg-interface.c we have

	sigchain_push(SIGPIPE, SIG_IGN);
	ret = pipe_command(&gpg, sigc->payload, sigc->payload_len, &gpg_stdout, 0,
			   &gpg_stderr, 0);
	sigchain_pop(SIGPIPE);

To fix that one we'd need to change pipe_command() to ignore SIGPIPE 
after calling start_command() or add a flag to struct child_process to 
do to that.

Another example is in upload-pack.c

	/*
	 * If the next rev-list --stdin encounters an unknown commit,
	 * it terminates, which will cause SIGPIPE in the write loop
	 * below.
	 */
	sigchain_push(SIGPIPE, SIG_IGN);

	if (start_command(cmd))
		goto error;

rev-list does not check for errors when writing to stdout unless 
GIT_FLUSH is set in the environment so if parent process exits early 
rev-list will keep going until it thinks it has printed everything.

I think adding a flag to struct child_process to ignore SIGPIPE in the 
parent is probably the best way to avoid problems like this.

Best Wishes

Phillip
