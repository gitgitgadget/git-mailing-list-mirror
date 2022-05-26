Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC2EC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 03:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbiEZDEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiEZDEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 23:04:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED622A5006
        for <git@vger.kernel.org>; Wed, 25 May 2022 20:04:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a17so374724plb.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 20:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MCTS8ASco0NBBSMh0ZQME7z7D0UBZLEQnExiSF8b9Q0=;
        b=cVDVe9UhSwepzH17f5Nj0xLYugSUmJN1iENelALW52kDHTct1XlcEi2gBT7ETW6SJF
         oD7eAgZ3BoHY+r4S7rBztk6VZFaw9NUdmWDZWmtlaXM5V019xRoDTdQDw+ZDUPZbTYpG
         rq6E3205pqmyoRcm2xcr2hLNKhiin3UiLxxZqwsMeS+Y3GOZ1C8t+rCO0WLd8DbGtyeq
         AHta7NB58Wzc0WpNyenjL7Xw1CWqzJruX3dsXQYiIAq81ME18dlI0hDsCjt9C3SdMf74
         P678bl/4J6H4cz+WW407SII5stm+1Q/RuQImwj7Ct9ZlBbC4xZW1UqGEj9CG5BiRZcsf
         yb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MCTS8ASco0NBBSMh0ZQME7z7D0UBZLEQnExiSF8b9Q0=;
        b=XT1aS2Mw/76h9SLlb2eLkpyEjaK9rjgIQHsd3/RAde0oqD39w+Ma/HPaVm2/L1zJ4/
         iLlvBUJ41ecCwp/H/Le41pWJiMqD33IX+EuGE5CPWaA+Qcc4LwRUgValInFvXJYTkTPP
         WPqRcaH6nL01JcYphpduY15/+KhN7acNSmx29+eZKVaQOEv/i3+dgDGUeNxcMvthgAot
         YdWCbn4z44csVa6rrIqqnEq1HD1rgdLXbi5sqNu2xtZ8QPl5tIHgf6hEKkaycVyfEgP+
         n2uc+1yBSIMfnA/2jgz+nVq1qbmWZlfaqwfSAM6EKfmWbKbXzIKlmdPsJogfmhqRoVm7
         54rA==
X-Gm-Message-State: AOAM533613/BjRV+AM/to7va+6EG9zSClC20yKOaS8S5pfWW7BPcCoUU
        aB6pI4tQShXT+9qF8DrHIxo=
X-Google-Smtp-Source: ABdhPJw/L6iSGgtKFvHdYfPd7pH8+8M1WwsJBfMzDUrtIr7JssvMfhQRKPWpKIg6JZnV2AzQNn/+0Q==
X-Received: by 2002:a17:90a:e7cb:b0:1df:8481:9469 with SMTP id kb11-20020a17090ae7cb00b001df84819469mr282055pjb.195.1653534245420;
        Wed, 25 May 2022 20:04:05 -0700 (PDT)
Received: from localhost (subs03-180-214-233-8.three.co.id. [180.214.233.8])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b005184031963bsm136039pfd.85.2022.05.25.20.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 20:04:04 -0700 (PDT)
Date:   Thu, 26 May 2022 10:04:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 3/3] trace2: emit "signal" events after calling BUG()
Message-ID: <Yo7uIG6JOx2lHOqE@debian.me>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <RFC-patch-3.3-b099a3a4a96-20220525T234908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-3.3-b099a3a4a96-20220525T234908Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 02:30:44AM +0200, Ævar Arnfjörð Bjarmason wrote:
>  `"exit"`::
> -	This event is emitted when git calls `exit()`.
> +	This event is emitted when git calls `exit()`. This event will
> +	be produced for all regular ending of the git process, but it
> +	might also exit via a "signal".
>  +

The second 'this' can be elided, thus says "This event is emitted ...
and will be produced ...".

>  ------------
>  {
> @@ -435,7 +437,7 @@ only present on the "start" and "atexit" events.
>  `"atexit"`::
>  	This event is emitted by the Trace2 `atexit` routine during
>  	final shutdown.  It should be the last event emitted by the
> -	process.
> +	process, unless it was aborted (see "signal").
>  +

Looks OK.

> @@ -452,8 +454,11 @@ completed.)
>  
>  `"signal"`::
>  	This event is emitted when the program is terminated by a user
> -	signal.  Depending on the platform, the signal event may
> -	prevent the "atexit" event from being generated.
> +	signal, which includes git itself calling abort(3). Depending
> +	on the platform, the signal event may prevent the "exit"
> +	and/or "atexit" events from being generated. E.g. if BUG() was
> +	invoked we'll emit an "error" event followed by a "signal"
> +	event, and nothing else.
>  +

So in case of BUG() trigger, there may not be exit event due to user
signal right? I'm expecting system (not user) signal in that case.

-- 
An old man doll... just what I always wanted! - Clara
