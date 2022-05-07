Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F0C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 06:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382207AbiEGGSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 02:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbiEGGSf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 02:18:35 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2BF532E9
        for <git@vger.kernel.org>; Fri,  6 May 2022 23:14:49 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-ed9a75c453so9344845fac.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5rUL/0izUMkZPkzKggOKBGpMj5VljOvLO2uBlnQWN4=;
        b=TtSJBpIwk/5d68Tl6UwDC9//GG0GsJ1y7NQ5GnxA1sCw3n12swrQJSioLbks9DZUc6
         nR5PndtIiUYLUKFy06Q15nQGjM2CNMW3ZjayRD0orWXhNVyAl/J+qlHPU0BF7XLW2Nus
         XEokeLA4BJVoG29Hnh0pHU9rcEQASmQOQPj60QP1S3jKNByMzICJDnD/8XQtt/Tu4RTV
         OEp0eUKWnGYgP+PXbc/mNW3cIvO1F2ik1K2f80TJf+RikBLyVhhX/OX5DWXk736YA2EA
         KQbGRUdK640aXsFwu6HApmaX+2p3N+xtCcpYAyciWGm3KmIDcEgoYUfFgRlcDxH/lQ53
         Abrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5rUL/0izUMkZPkzKggOKBGpMj5VljOvLO2uBlnQWN4=;
        b=7QnipLpISTDXRHtXwqMded2jZbuMgxgmdazAND8q19G2jsn/t91bU9Ogl+OXulZge5
         hae1a5i8mIxLcXlwpEluIAEfCupi6UeBpp/Hef+Gpm5Lr1d5Ks47HLVVT+4rWXwIXiW6
         FRrqFACfFD4hxQbwMVEgFjBE7mSBXxNqY1YoPVW3jLakB5RudBVrV+Au10m5O/rJ3at/
         FzIikPZ+nl8/cggonVdUbZ3hkLxMnmWmkJcoAraGq1PBJ5pcZ9X6kNJrceCYkKDs0/zy
         K81KX+7i5wY0ZYAf/x8zPl3Tgctm1EYgQcyWDU2EothN0scQPhzw+XqDmvpqK89Mo+0i
         /3Hw==
X-Gm-Message-State: AOAM533zD3ctUut225mZdnnQ2uQxJczeBr/OpSjMsnww6Co79vQAvAWk
        5oMa94gNvQTpLWriIYvMmj+sJ9HgZrg=
X-Google-Smtp-Source: ABdhPJy9ZAiJ998Oq2FSBGFN64tZRqCOFxZiaAkkRhBD4TvT3TOaYdsc1SAGeHin02oHByIKfGIzCg==
X-Received: by 2002:a05:6870:f206:b0:d6:ca78:94f0 with SMTP id t6-20020a056870f20600b000d6ca7894f0mr3068986oao.4.1651904089197;
        Fri, 06 May 2022 23:14:49 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f7-20020a0568301c2700b0060603221269sm2334297ote.57.2022.05.06.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 23:14:48 -0700 (PDT)
Date:   Fri, 6 May 2022 23:14:47 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] dir.c: avoid gcc warning
Message-ID: <20220507061401.onpbrd35w5xjrrh6@carlos-mbp.lan>
References: <cover.1651859773.git.git@grubix.eu>
 <cd50ec73ddafaaeba04298ae79cbf625cc0d7697.1651859773.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd50ec73ddafaaeba04298ae79cbf625cc0d7697.1651859773.git.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 08:04:05PM +0200, Michael J Gruber wrote:
> Related to -Wstringop-overread.
> 
> In fact, this may be a false positive

Indeed it seems more like a bug[1] in gcc12, probably with their optimizer.

Getting to the bottom of it with a minimized version of the code that would
trigger it would be a good way to help it move forward instead of "fixing"
git's codebase IMHO.

It would be also nice if someone from the gcc team would confirm or deny if
this is indeed something worth waiting for a fix on their side, or would
need some workaround in ours, or maybe even a real fix.

FWIW there is already a workaround of sorts in our codebase since 846a29afb0
(config.mak.dev: workaround gcc 12 bug affecting "pedantic" CI job, 2022-04-15)
so that this warning should be expected when building with DEVELOPER=1 but
it won't break the build as it would normally do.

Carlo

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2075786
