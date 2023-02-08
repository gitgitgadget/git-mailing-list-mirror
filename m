Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84282C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjBHVMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHVMh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:12:37 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8552DE50
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:12:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ki19-20020a17090ae91300b00232cba666bbso347635pjb.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lF2zeMO7CvlI8/PDft9dWMjQrN4eAln4DqLfZHZ91w=;
        b=p9hqYxk9etUQ4jECGVxrEgGapfXhWA6RB2NEDUIrkXJxEn/rcmIQYkypAkgZm7HT16
         Fg9szsaQ6oTEB0/9TOMsYdSmw8e/x4E3etOdeLe3BT+WVwQgFHFmo0s9qSKWmz0ts941
         bF3G/wOUXxAMBs++GlIf0Qpy1gcz3pv6o3Ln50pEWITwF9ei6cBtKr7x5Da5GvkzfbjG
         7bxu68h/eOpR2VyoV0+9cSdayUOQdWhKpemDZrz3ThKa8KIIc0Cly8+US50QPhkN8ACu
         tn78/xg9W95xTi2/XVbix3jX4guC/pkas+iLxots5TFKZFnqYmBukJTVdoMBzKM0c6Fu
         uo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lF2zeMO7CvlI8/PDft9dWMjQrN4eAln4DqLfZHZ91w=;
        b=HZSKY5Go/A6HRJXR15ajtxKw0G/jwIuwtKmzyo8KAGt4kLl+8YRT9MYzms+NWZZ6Mk
         Qgpbf0mtrJCJM+grzjIIOJO1v69CNI7naHBd6xsT661baOJHQyNiFJPjEY8BCyhtqK1Y
         aSHQ1lInXqu5KdsMnv0YhOy3bsvhaeV0R2dp/LsZPi3EO6HSjyS+svkKGQljdZe2oXFm
         uHRosNsdsQhL/9BP6j+x/RY931bR47Mextp2MyArrApPZTgcvyesrCTIRcuCr1NoELRO
         KjqrSGy+4OGDgMX0EbInRbW40hMCiMNMQjqXn9WwATpOO4C5itu3MCmRn08BrSMUg9Se
         goWQ==
X-Gm-Message-State: AO0yUKX3uHZ//12RJeAwAGq4NyTr35srb9Bh+KEnpiN5uCUI6FjTyAHL
        mpVuYRWuodshV93aMXWGpSU=
X-Google-Smtp-Source: AK7set/04SmxTj67V/OY8WzSZHZIJu3jKLnSHXP6pFBHfVUW2P++dFzhAQnR10jzS9z24tvvFlnSSA==
X-Received: by 2002:a17:903:182:b0:193:2bed:3325 with SMTP id z2-20020a170903018200b001932bed3325mr10232960plg.15.1675890756220;
        Wed, 08 Feb 2023 13:12:36 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b0019601b73e33sm11486261plk.30.2023.02.08.13.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/5] hook API: support passing stdin to hooks,
 convert am's 'post-rewrite'
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
        <patch-v2-3.5-3d3dd6b900a-20230208T191924Z-avarab@gmail.com>
Date:   Wed, 08 Feb 2023 13:12:35 -0800
In-Reply-To: <patch-v2-3.5-3d3dd6b900a-20230208T191924Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Feb
 2023 20:21:13
        +0100")
Message-ID: <xmqqy1p7q2t8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Convert the invocation of the 'post-rewrite' hook run by 'git am' to
> use the hook.h library. To do this we need to add a "path_to_stdin"
> member to "struct run_hooks_opt".
>
> In our API this is supported by asking for a file path, rather
> than by reading stdin. Reading directly from stdin would involve caching
> the entire stdin (to memory or to disk) once the hook API is made to
> support "jobs" larger than 1, along with support for executing N hooks
> at a time (i.e. the upcoming config-based hooks).

OK, that is a sensible plan to spool and dup/tee the input to
children.  It may not be necessary yet at this step, but it is very
good to be thinking ahead.

Looking good.
