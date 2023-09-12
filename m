Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC0CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 12:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjILMCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjILMC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 08:02:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C10610D8
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 05:02:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-414b3a1a24aso36206551cf.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694520140; x=1695124940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we3wJM3M8vcMbzsW96soSuQLa+QbrYhkmj5pNcw/KSI=;
        b=nCa4lnytNKZIyebXWoTlWydIWO9BvdFKObTuPQGTOLVAZLehuKUsmpEZaAZPoTvORv
         u4mj6yvvEOoN4rDqTWB/MTBMnd9SMld/641azbWAvCXC5g1KH0v1HkHdwPKbjooC1s2a
         jePh7nWAZOkk2wK3+QzlBadQXaGzMjyhw1WveLMi2l3WN9W75g5KbFOqNlLZLMaFWuTe
         d/m4eWzH1p79kJYh27JyBauwJ4AxKLch66K+HetnZBVMCE4nEgdhmxYX3aKRZ1hHu20j
         jWDyDoC3M7O3O7lJBco+vv2dTkz6GxuAxUrpRBZzI2Wl0Fb9IXLm/dqNEch21QkKSeOJ
         vw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694520140; x=1695124940;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we3wJM3M8vcMbzsW96soSuQLa+QbrYhkmj5pNcw/KSI=;
        b=jwntXNZc7QgGfNITd0zITi5mUW6f7TjDPeRX8pZm30VPImWw0Nh7NHp03tirdRSEd2
         I1JbqtZ/06lgr0BjwtLxsgwZ7vDSPWCl6L5IgZtJY1TdvpbHsNpFWPR37EDwGY/r9yS4
         q4vU+X3hiQsJHCN8/F1Vig3TPPDiczy1q51co6Bs0SMqYRO97LKm0I7Bi2Xolk4PKxIs
         4Y1sVfLDDNiWVohECDG7IJzsoZ5NJSZ46xuYR7ftTOC6O1hPTtKraY6zbMzPWJC9Mnuy
         Y3YC3nA2ZDkymoojXgfY8vBsg2JAbDrcuAhDlaeU+/pAOEGRLZ626ylH9qXXsg+VwfHn
         WMig==
X-Gm-Message-State: AOJu0YwxgE0JNSVaSLzY3B2f1fSIWo5Ot9oLDjKpskipBtG92VEUa6d9
        e2nmsNt1SMzUmhcH2rOyQqo=
X-Google-Smtp-Source: AGHT+IGg8bgbGWf2Uynu6s823aMxW/4zvcTxTU8HaTTKk5M1ZwRm5RBvaG9mOc9rzX/RBbiIkHL1fA==
X-Received: by 2002:ac8:59d6:0:b0:410:8e9f:f082 with SMTP id f22-20020ac859d6000000b004108e9ff082mr15618502qtf.14.1694520139924;
        Tue, 12 Sep 2023 05:02:19 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e8c7:b51a:6c64:3ea6:f949? ([2606:6d00:15:e8c7:b51a:6c64:3ea6:f949])
        by smtp.gmail.com with ESMTPSA id v12-20020ac8578c000000b0040ff6194ef3sm3256111qta.70.2023.09.12.05.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:02:19 -0700 (PDT)
Subject: Re: [PATCH] completion: commit: complete configured trailer tokens
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
 <20230911102017.1927468-1-martin.agren@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <50d4fa5c-8648-a51a-43a0-416d7f2e3df6@gmail.com>
Date:   Tue, 12 Sep 2023 08:02:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230911102017.1927468-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Le 2023-09-11 à 06:20, Martin Ågren a écrit :
> Hi Philippe,
> 
>> Add a __git_trailer_tokens function to list the configured trailers
>> tokens, and use it in _git_commit to suggest the configured tokens,
>> suffixing the completion words with ':' so that the user only has to add
>> the trailer value.
> 
> Makes sense.
> 
> I've never dabbled in the completion scripts, so take the following with
> some salt.
> 
>> +__git_trailer_tokens ()
>> +{
>> +	git config --name-only --get-regexp trailer.\*.key | awk -F. '{print $2}'
>> +}
> 
> The rest of this script uses `__git config` rather than `git config`.
> The purpose of `__git` seems to be to respect options given on the
> command line, so I think we would want to use it here.
> 
> These "." in "trailer." and ".key" will match any character. We also
> don't anchor this at beginning and end. Maybe tighten this a bit and use
> '^trailer\..*\.key$' to behave better in the face of config such as
> this:
> 
> 	[strailer]
> 		skeying = "s"
> 	[trailerx]
> 		keyx = "x"
> 
> Another thing. Consider such a config:
> 
> 	[trailer "q.p"]
> 		key = "Q-p-by"
> 
> The "trailer.q.p.key" config above ends up completing as just "q"
> because of how you use `print $2`. I see that `git commit --trailer=`
> itself is fairly relaxed here, so `--trailer=q` effectively ends up
> picking up "q.p" in the end. Tightening that is obviously out of scope
> here and I have no opinion if the current behavior there is intended.
> But maybe we should be a bit less relaxed here and complete to "q.p"? At
> any rate, it gets weird when you also have "trailer.q.x.key" in your
> config but we still just suggest the one "q".
> 
> I see your patch is in next, but maybe some of this tightening might be
> worthwhile doing on top of it?
> 
> Martin
> 

These are all good suggestions. I'll send a new version with these fixes 
on top.

Thanks,

Philippe.
