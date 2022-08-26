Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B886ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 17:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbiHZRCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbiHZRCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 13:02:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F60C7B80
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 10:02:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so2396484pji.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=s34fFa8gbMxwRlxkfbmd26euHFZl0uR+PcbS5zVEnh8=;
        b=iWO8WX5MecFIqoMs/68I86CBzptNBoPg4TvxiHkw0SPsa/xgF4MbqtQ5C7yytocPr6
         OkDtNjQKnJ62sy9LmlUaYGGWOat6DpmvPrel6pNWImF9NFJ8azkdTSldhxb9ELdUQjp8
         uYpuLSAqApVny+tSZhJWQ8TTu0o9mDgL0MH3bJX94nW/vtfKlWtaidGi299/+YYUAecX
         qGctN/Bj7YUO8QmlYFPdEmHESlxgz3d+HtKmagnHDOeaQyGwhZ8Qx6BXKVH9MGcdQcJb
         AHSthwaJrCPYXzI4xp9ne5gtO27D3F33xpxb+LtnMXbJkp/MWck9dV8fIvfpU9z7skT1
         91XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=s34fFa8gbMxwRlxkfbmd26euHFZl0uR+PcbS5zVEnh8=;
        b=livmr/R/bTSBjTWDNbV3c6fAXa+STMMzraZFXjD9S1IQHNk5+xFO0BgijwUykuRytW
         egEwRC84DD1k3DnpbLziPlz81+ECHJbpmV+7auJl5YQCHlC9wBmg3LctwOd5nf01cdUU
         OVAmbVBrEAW7HJ9inUJAZ+LXgMtRzPofm7zlYtCAFgEaZZ61fE6DrOLCBy2Ye7L/cAxW
         FapiFIzKu+UdtA4gJxwok9Ohpjm0ybV1IlIFR8dn+e0tlbREVl2CmpVK4OiK9SnproJ+
         /2+OoX1j4kx0g4pQV5BWuZmKLBcYnJ6z6feqdm1geqxb7VVvRCzCWtDGpmVJ7pacvnS4
         5knA==
X-Gm-Message-State: ACgBeo0hYLxgV67Dq/FKKmYNRtKzQv4viMg4Ju53zpgFIDA/79JJwL1k
        hM3+UtEjoGjHmN5a5ePg5Wc1Bo5nG84=
X-Google-Smtp-Source: AA6agR5xNOpihnKkeGXc9YNVcSSd/sbgMYDlaM6YEyXtueMhycPTPQPSUZ6qIDEYpPXNM6jJbMtjpA==
X-Received: by 2002:a17:90b:4b0c:b0:1f4:ffac:699a with SMTP id lx12-20020a17090b4b0c00b001f4ffac699amr5233580pjb.145.1661533339664;
        Fri, 26 Aug 2022 10:02:19 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x25-20020aa78f19000000b005377c74c409sm1995321pfr.4.2022.08.26.10.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:02:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] range-diff: optionally accept pathspecs
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
        <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
        <a52ad40e0155caf8285b86ec26bbd47cd2240466.1661506770.git.gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 10:02:18 -0700
In-Reply-To: <a52ad40e0155caf8285b86ec26bbd47cd2240466.1661506770.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 26 Aug 2022
        09:39:30 +0000")
Message-ID: <xmqq1qt3ym3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	for (i = 0; i < argc; i++)
> +		if (!strcmp(argv[i], "--")) {
> +			dash_dash = i;
> +			break;
> +		}
> +
> +	if (dash_dash == 3 ||
> +	    (dash_dash < 0 && argc > 2 &&
> +	     !get_oid_committish(argv[0], &oid) &&
> +	     !get_oid_committish(argv[1], &oid) &&
> +	     !get_oid_committish(argv[2], &oid))) {
> +		if (dash_dash < 0)
> +			; /* already validated arguments */
> +		else if (get_oid_committish(argv[0], &oid))
>  			usage_msg_optf(_("not a revision: '%s'"),
>  				       builtin_range_diff_usage, options,
>  				       argv[0]);

Very reasonable.  We won't ever have "--" on the command line as
anything but a dash-dash (i.e. there is no option to the command
that can take any string), and thanks to the previous step, this
addition falls in place very naturally.  Very nicely done.

Will replace.  I _think_ this is ready for 'next', but let's see if
others spot problems for a few days.

THanks.
