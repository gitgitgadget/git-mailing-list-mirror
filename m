Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ECC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A6E208FE
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVnK+6KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKXTeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKXTeT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:34:19 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C5C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:34:19 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a15so34325edy.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CEU2UaiaKWjZ29Ghx3KbSk8pqR2pwRI3WtsSkivUiUA=;
        b=iVnK+6KPuH583GTaewrh9f9yu27bA+hKrq+WzNXydIPTEfrhYP0H09xeqJmkiMIBx/
         O7Wz7hLcVB19pSA77V4M5pCi0dpVdZuCEQUjLNZcnPIhyemAi+fVXrCWRLyHye2vbzra
         RBv8VqdoHqBa81PYkY+tuBY2lKlq7KEXNpUJlstn5IOMrKPPkcMbjwzvMzhQDxYjgjhY
         wmxYuPqZVfyjd3Hhmvqi7gZiO+mv4DbIp0bySlQgUrRiUgeITv2pyMXx0JizWRSswcyr
         xycg27VsxdwZ6tr76gXLopXgqgqhQOKdyFC8N2qcf+fE80cYDxeuJRkR+1LloKF8loPA
         4M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEU2UaiaKWjZ29Ghx3KbSk8pqR2pwRI3WtsSkivUiUA=;
        b=DkG9lKrJuGJxcar7xflXFFLuPdXvpFZqV0Y2l5EvgzUdVRfrt0mC/YXTFSOUtp5y5v
         nyoojIhUD0Cq1pCOdFjfGMLJbqOnDONqM+4OKxlGI5exzQZWdPB9yF5KwompC1PIWvUy
         ey+j9UChMvSMflBTu/LmmBke6CZmx+q2zh1kztvepqMcOD0AcqYfTYvPYBcOEqgNmBgo
         uCYiXn9LLE8h4FKSd5WXvhqiFcAmyA6X8t4SgdGRpGr745ppfiPXR6zGa2XuyMWx79UW
         lKzGPyPRUAzVysUfNQYW7OqkDSrhGt2BSl5eoGOLFcph0QKIaMyitgcHYoZFR2XTef9k
         l54A==
X-Gm-Message-State: AOAM530C4gWIY/HJeCkVaiqESTlNaUhyO/7+X6sYzGOuYAq9hJU48nFT
        jkARbTaHHdH4jrS0M22Pbdk=
X-Google-Smtp-Source: ABdhPJygILZ8crksavtvnLlMQtGnX8kpY6oy7IqJp5v0+OHkKcINCL8MG4fgjbBEi1UaFBd7S1ddmQ==
X-Received: by 2002:a50:9e05:: with SMTP id z5mr19724ede.231.1606246458206;
        Tue, 24 Nov 2020 11:34:18 -0800 (PST)
Received: from szeder.dev (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id zm12sm7333106ejb.62.2020.11.24.11.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 11:34:17 -0800 (PST)
Date:   Tue, 24 Nov 2020 20:34:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/13] Rewrite the remaining merge strategies from
 shell to C
Message-ID: <20201124193417.GD8396@szeder.dev>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 12:53:02PM +0100, Alban Gruin wrote:
> In a effort to reduce the number of shell scripts in git's codebase, I
> propose this patch series converting the two remaining merge strategies,
> resolve and octopus, from shell to C.  This will enable slightly better
> performance, better integration with git itself (no more forking to
> perform these operations), better portability (Windows and shell scripts
> don't mix well).
> 
> Three scripts are actually converted: first git-merge-one-file.sh, then
> git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
> are converted, but they also are modified to operate without forking,
> and then libified so they can be used by git without spawning another
> process.

> This series is based on 306ee63a70 (Eighteenth batch, 2020-09-29).

This patch series should be based on top of 722fc37491 (help: do not
expect built-in commands to be hardlinked, 2020-10-07) (in
v2.29.0-rc1), because without the fix in that commit we don't get the
list of available merge strategies when building with
SKIP_DASHED_BUILT_INS=YesPlease:

  $ make clean
  [...]
  $ SKIP_DASHED_BUILT_INS=YesPlease make
  [...]
  $ git merge -s help
  Could not find merge strategy 'help'.
  Available strategies are:.

Our completion script relies on this to list available strategies, and
a test in 't9902-completion.sh' fails without that fix.

