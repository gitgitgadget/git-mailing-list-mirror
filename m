Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48FC32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 03:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4BD2073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 03:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfFb3avC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgAGDgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:36:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37398 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGDgo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 22:36:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so22634125plz.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 19:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jftdBC89+cBBY8Y3lUM74WI3YmLclkwF57MbOeAQKJo=;
        b=VfFb3avCaN4Wo/pyws9G3nG/1i52JH/vHY/tJsPoTUFGZ/5Q+cDjtxGhftelsk2DSA
         n2HaYM0n4/7j/8dce9OPBADS7T8ZKsPoyRwdPIguFp/QNlfmdv1KuvHug7V2m2FdzfDW
         t+EnNVPQdObpEDnDFt8Hgf8oCDNQitIxhGu6GxOYUvAC9zMI46zvgpjSqTaWbait6ux/
         9bFN0L+wy+cGnX6uf331LyPiWbiMnpstqWER550C+qh8MCZx6oOx/NdobG+4x58AMhl5
         hQ4WBu4AXDD9d0f3vZlWICX80QVXgadizNb5aOpWVmONviV99P6ZGjKfWbaBheTSl4Jd
         RnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jftdBC89+cBBY8Y3lUM74WI3YmLclkwF57MbOeAQKJo=;
        b=P20BUKsi1ORagGDA08r8pZ8lkG/w2uAkl9gQxVu6nce203OzUr7CQe2Dj0riBt9xU5
         FM/NVU4oLCBoPT091mDDO2LZA3kksfvDcm4BoRdH3IiFAzhS9z77+0u63/Ni+ZuoaWGd
         IfoF+xVCqqT6k3uldMjM3TSrsZ0oc9IqwjPdTxNl8Qtn0uA/x8Ps9WDO+F3jVprhtksa
         XKtosnvaaeYMfIEroA2RClnIVsmingFcvKR508j795+UR/LtrIOKHQx+KMK1h8lFTbsO
         087UpGgXoqIGVEFmqOx9ALGCU9/B2cHa2GdX2ncvUuYoyO40M9x0QPS/nuI+1jffZ8xw
         D82A==
X-Gm-Message-State: APjAAAWaLbIDa5/iID4KnNn86DsHvGPMwiakWF4TgklCaGgBXfNqcyKZ
        ENLYrYUJldxCmc3QI3C/li1WTmnL
X-Google-Smtp-Source: APXvYqxR6NNOvNa7UqtUJ7gxTwIWeJTv/nVmZApSPSpiXtM7EU/H7wj41VMnIHwawW9NwYkZbK2N7A==
X-Received: by 2002:a17:902:8503:: with SMTP id bj3mr106843183plb.180.1578368203754;
        Mon, 06 Jan 2020 19:36:43 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id j14sm72690780pgs.57.2020.01.06.19.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 19:36:42 -0800 (PST)
Date:   Mon, 6 Jan 2020 19:36:39 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
Message-ID: <20200107033639.GH92456@google.com>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
 <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
 <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
 <20200106193253.GA971477@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106193253.GA971477@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> But I thought that was the point of "squash" versus "fixup"? One
> includes the commit message, and the other does not.
>
> I do think "commit --squash" is mostly useless for that reason, and I
> suspect we could do a better job in the documentation about pushing
> people to "--fixup".
>
> But --squash _can_ be useful with other options to populate the commit
> message (e.g., "--edit", which just pre-populates the subject with the
> right "squash!" line but lets you otherwise write a normal commit
> message). If that's the workflow you're using, then I'm sympathetic to
> auto-removing just a "squash!" line, as it's automated garbage that is
> only meant as a signal for --autosquash.

It's a signal for --autosquash and it gives a visual signal to humans
of where the squashed commit came from.

--squash already implies --edit, supporting this kind of workflow.

If we could turn back time and start over, would we want something
like the following?

 1. if someone leaves the squash! message as is, include it as is in
    the commit message without commenting out

 2. if someone edits the squash! commit message to include a body
    describing what is being squashed in, include the squash! line as
    part of the commented marker

 3. if someone leaves the (uncommented) squash! message in after being
    presented with an editor at --autosquash time, reopen the editor
    with some text verifying they really meant to do that

It's rare that concatenated commit messages make sense to be used as
is, especially when trailers (sign-offs, Fixes, etc) are involved.  I
suspect that (3) is more important than (2) here --- we're using the
same space in the editor for input and output, and the result is a
kind of error-prone process of getting the output right.

Since we can't turn back time, one possibility would be to make tools
like "git show --check" notice the squash! lines.  Would that be
useful?

One nice thing about (2) is that it's unlikely to affect scripted use.
Thoughts?

Thanks,
Jonathan
