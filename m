Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32631C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195286101B
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 08:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhKPINu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhKPINr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 03:13:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D54C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 00:10:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so20159633edd.9
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 00:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=D0vzIkRiOMi8ier6dEr5IoQn3CKcuPjrMntZmuCyJVg=;
        b=FGR29Z2fhJftLdCaSjw+x3of0GqA8fWlUA8KrdlJtR/4Yq5p1clf+zWvzryhy6at+X
         C7ZJNkO9pW7MHiGu6BMWSLmqgupSMk386euCYz0DfKubqKRTm1J+82jL+5Ozw8+FbRfC
         ymdU0i95F0MTm8Ia1IiMqMQ9Jn59PrIWyrkSGD08fcKisatxgdQp3m//P4kDkIeltzim
         pjT6abgjAfnmU5RDscAvqqxXxUzy01lLk8yIbvlJY6+3HsZUCm1J13wrmIDbocrq4sqF
         fSPGMopQMDzlbErlO/fjtTylkZSrK1BrxwfOVfZX1rQUuEQSuqQ4t/opNW73EIXLomMp
         glYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=D0vzIkRiOMi8ier6dEr5IoQn3CKcuPjrMntZmuCyJVg=;
        b=gQTRFo29fZjtPVv8ZrCqN/77O6Q+L+hDxtAPbN0/CJdxMcCF0l72gG6b4bIMYkDEav
         5xX/x2XSrneP2gv537eqfiJc1B9WQfCNNpQcz0XJngQYlJoI4qjQd8v/2ZL2fly8wiH6
         NU7dMciS8hTnxe1AGRPrYu6pxhAlRwKyI2oADtg5e9x0GJ7G1KVVFUobOY+AFUi9UC0v
         YyjA9rnx6tbKz+2pnh9fKuWHM9reBNsTskkDHcVYuN0vWB15uvjjrEOXUWrtXJg72vpf
         j054N1Fmh6mE3IBn1immQx5oVXjIYWP9gDhYEcwlNMXBZWMDRvP4rR/pAtz/wJo5Hr02
         +zMw==
X-Gm-Message-State: AOAM530/VYJhHD1AnTqArWpu8drVwM7r1E+aCtdP6UojqT4jGk6d/MoY
        MxtpNVeP0He1wx3LEoJ6CcJNWItcne5Owg==
X-Google-Smtp-Source: ABdhPJzofE+8VD2+g3aqB0MgxVA+mKBSLEBLsW/JLV08mDY2CvbOjKr3actZHuVfXrPCLQVF/ULMhg==
X-Received: by 2002:a17:906:3a9b:: with SMTP id y27mr7235418ejd.563.1637050247362;
        Tue, 16 Nov 2021 00:10:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e16sm1197615edz.18.2021.11.16.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:10:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmtYE-001J21-Ae;
        Tue, 16 Nov 2021 09:10:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v9 0/9] Implement a batched fsync option for
 core.fsyncObjectFiles
Date:   Tue, 16 Nov 2021 09:02:14 +0100
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
Message-ID: <211116.8635nwr055.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Neeraj K. Singh via GitGitGadget wrote:

>  * Per [2], I'm leaving the fsyncObjectFiles configuration as is with
>    'true', 'false', and 'batch'. This makes using old and new versions of
>    git with 'batch' mode a little trickier, but hopefully people will
>    generally be moving forward in versions.
>
> [1] See
> https://lore.kernel.org/git/pull.1067.git.1635287730.gitgitgadget@gmail.com/
> [2] https://lore.kernel.org/git/xmqqh7cimuxt.fsf@gitster.g/

I really think leaving that in-place is just being unnecessarily
cavalier. There's a lot of mixed-version environments where git is
deployed in, and we almost never break the configuration in this way (I
think in the past always by mistake).

In this case it's easy to avoid it, and coming up with a less narrow
config model[1] seems like a good idea in any case to unify the various
outstanding work in this area.

More generally on this series, per the thread ending in [2] I really
don't get why we have code like this:
	
	@@ -503,10 +504,12 @@ static void unpack_all(void)
	 	if (!quiet)
	 		progress = start_progress(_("Unpacking objects"), nr_objects);
	 	CALLOC_ARRAY(obj_list, nr_objects);
	+	plug_bulk_checkin();
	 	for (i = 0; i < nr_objects; i++) {
	 		unpack_one(i);
	 		display_progress(progress, i + 1);
	 	}
	+	unplug_bulk_checkin();
	 	stop_progress(&progress);
	 
	 	if (delta_list)

As opposed to doing an fsync on the last object we're
processing. I.e. why do we need the step of intentionally making the
objects unavailable in the tmp-objdir, and creating a "cookie" file to
sync at the start/end, as opposed to fsyncing on the last file (which
we're writing out anyway).

1. https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/20211111000349.GA703@neerajsi-x1.localdomain/
