Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFBC00E86
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjITPaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjITPaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:30:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4FA9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:30:11 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6586739cfeeso7409146d6.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695223810; x=1695828610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFRauuxYy07kZPN/lYYY0I7brlqJ5iGXLLQG2jMgNDM=;
        b=fnhRu05Xd93txb0X2neEDUmZ6GcnHM8o04AIEecmWg4Ra43QUE6i9tfjdIZmb5LF/b
         qp/aw6/NPPL5Sl2bTgSKPaGuqUCCRFuW28M0gU7/anFmFDZ2/cje5uSs+l9T4daqDlc+
         d4fSxQdf6YIUeNDiV8aTbMGklv6PI/l1axfUW4w620kXSygnxBzCqTnDpy2rYZqiJKW2
         IwDdVWRrif6LyUr7EMIDfGQWaFutwpsjASiB9v03HqgNRiuJZBYjUaLC+EmqKs2E9zRE
         A38KwmoQLt8vMdQhCrv/t5WBttjijc8edzbp0j3wGgjYnINWeaY9Ccc28rlUBbQlTuUX
         O1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223810; x=1695828610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFRauuxYy07kZPN/lYYY0I7brlqJ5iGXLLQG2jMgNDM=;
        b=pB9j26TI0GEnyEmMfQam+kRhFbj8hWm+QwjSDSFeK+BUrwwtxttz7U3b5wpzGP3quF
         gbESpKUV5nGtuXcb6iAUGn4PRg9/uf3/CoNE4Dyb4xyBb5uyy2DE4g6SFqFrP1MqV6R8
         aNbGwP700sk/7iGsDTnF60JLRFS8g5Q3Kn5QZO/h7tM3MUJDSN02T3GMPy4V4aQOQQRC
         IytlIf7KBAJtObIQPIiRsgDisEFZhu+xh6lWYr9+BuRvE9TIceWHXpj1DqjiP/ISVMHH
         whkFzK0moXjq5QFmDZ4mjq59DnwEHGyatFdG9JXK/YEb3DXSCZaLylLuCIdl5obp4kIn
         ZP3g==
X-Gm-Message-State: AOJu0YzISOQRp5o8KyKSCsVd/Y2m/1Zu4TdZcUTHD8oPpv3IHm0vh/OU
        OKn2kjpDS5Mw7MlUP6aR/JM=
X-Google-Smtp-Source: AGHT+IEfte2Q8bbGjfZrbWV098/Plc1C5/X+Vt+latBvayDJJaXD+7dFjib+mXrqN6kPoGz+c5G6gQ==
X-Received: by 2002:ad4:42b4:0:b0:649:8f20:552e with SMTP id e20-20020ad442b4000000b006498f20552emr2553277qvr.62.1695223810382;
        Wed, 20 Sep 2023 08:30:10 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id j14-20020a0cf50e000000b0065862497fd2sm1347430qvm.22.2023.09.20.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 08:30:09 -0700 (PDT)
Message-ID: <573c6dc5-2102-cb65-8f71-dea37fff0c9b@gmail.com>
Date:   Wed, 20 Sep 2023 11:30:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, git@vger.kernel.org
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
 <20230917192431.101775-1-mlevedahl@gmail.com>
 <mafs01qetq9kk.fsf@yadavpratyush.com>
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <mafs01qetq9kk.fsf@yadavpratyush.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/20/23 09:05, Pratyush Yadav wrote:
> In the past, git-gui has tried to keep backward compatibility with all
> versions of Git, not just the latest ones. v2.36 is relatively new and
> this code would not work for anyone using an older version of Git.
>
> I have largely followed this practice for all the code I have written
> but I am not sure if it is a good idea to insist on it -- especially if
> it would end up adding some more complexity. I would be interested to
> hear what other people think about this.
>
I am not aware of any distribution (Linux, g4w, Mac) shipping anything 
except the git-gui in Junio's tree, which is specific to the git-core 
version, and the git-gui packages require (or are a part of) the same 
version git-core package: no cross-version compatibility of git 
components is assumed. Certainly, folks rolling their own can pull from 
upstream git-gui, but they take the risk of incompatibility with an 
outdated git. Other tools in Junio's tree have already made the switch 
to git-hook (send-email, git-p4) even though they are usually packaged 
separately from git-core, but also version locked to matching git-core.

Updating git-gui's hook execution to match git internals would be more 
complex than what I implemented or what was there before.  For instance, 
I never looked at what git-hook's g4w compatibility code uses to test if 
a hook is present and executable, it wouldn't surprise me to find 
git-gui was missing something there, but who wants to bother? Also, the 
commit language surrounding addition of git-hook is strongly suggestive 
of other changes in configuration coming, meaning more changes to hook 
execution code would be needed that are avoided by using git-hook. Note: 
I have one more patch to send, removing yet another work-around for 
early Cygwin tcl/tk, as more evidence of how many years it takes to 
clean some of this stuff out and the difficulty of keeping git-gui up to 
date.

I had considered the above when creating the patch, and I believe what I 
did is the right approach.

Mark

