Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C9BECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 06:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH2Gq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiH2Gq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 02:46:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04092715A
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 23:46:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q15so1907720pfn.11
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=7KnrG6oAVmBdVa2+ZEhPnjw0xi3Jju76IOM1MG7Wgs4=;
        b=bm5F83UdUca/Cu12S3tPEk3+mDe0MMPmrHU3s31hbtyCOvcIzXeaKLMTs6Ofz7AGPO
         760gFTm2kVNPGQ2jWLcN+qQVoDKfFhRsrQHUKg+JHFmK9h4fiR+Q3VBlfLNFn+jkMjWw
         jbsnPj8d3BWaSXnzXMMItgZ9lSXKI3wWcLBQnNSNmp6TyD/euPMavIqNjSw1+UHFu72D
         6s1wAhRVY6ScTuYYPcRsnejvJfKqZbUxEEMX3RT8+F6by5NIE/BAlmAjLq9owYMR4ZWI
         /TU+hghFbIDQGfFarCUUH5qW5e3sZQK9bZIchHYHGw5ntLhA5pFuRNahszZqKiFeXkCL
         QfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=7KnrG6oAVmBdVa2+ZEhPnjw0xi3Jju76IOM1MG7Wgs4=;
        b=kuWvvyKt5hybJKOj/eMDIkgBMgCfXA4cqP26IkPzfDeII/z+YAY8PnGyRV+UEXRurx
         m8lmyLV5Gfoh4f1tyOyBdJA+wkSfKSlS/4jclVVNUOf/RvsOIp2z+Dq+1YOXoelxWNHb
         Wy9W+NI8GstiSKYx7af+mzLUXr+eZdb79RDZarVw+/Cqfye9skvRGQe73b8KUDH9tuj5
         B2+/hP5PdFwg3Hq+f0aGhpnzmBKnr2KUxjI4ugiNq6LIQ9rzc0k/cAAIeSR1dpX3up43
         C7cVmNgN39apcr1skemXO71hq9tcYwekL4eam2hbtkYdbYPPFNtGSCRepZmv2+F/ToSD
         awqA==
X-Gm-Message-State: ACgBeo3mdoTtO8eJv9GwTEsA4hklNc8egsULaCC0oazCe0lYwKv4fAjH
        t7FdAMwUEcuveSSgQG/ZRI7GOiW40Ag=
X-Google-Smtp-Source: AA6agR69Mka5ONPmcmz/tlv0IA4GhEcBzI2LJPv/1WlEl3XYFiLhKx//7s6RPEmWJzGwF6vE4425Cw==
X-Received: by 2002:aa7:888d:0:b0:538:328b:2ffb with SMTP id z13-20020aa7888d000000b00538328b2ffbmr4191121pfe.82.1661755584252;
        Sun, 28 Aug 2022 23:46:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m21-20020a63f615000000b0042b435c6526sm5680352pgh.79.2022.08.28.23.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:46:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@FreeBSD.org>
Subject: Re: [PATCH v2] gc: use temporary file for editing crontab
References: <20220823010120.25388-1-sandals@crustytoothpaste.net>
        <20220828214143.754759-1-sandals@crustytoothpaste.net>
Date:   Sun, 28 Aug 2022 23:46:23 -0700
Message-ID: <xmqqmtbnr1hc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> While cron is specified by POSIX, there are a wide variety of
> implementations in use.

I would innsert: 

    "git maintenance" assumes that the "crontab" command can be fed
    from its standard input the new contents and the syntax to do so
    is not to have any filename argument, as POSIX describes.
    However,

here and downcase "O" in "On FreeBSD".

> On FreeBSD, the cron implementation
> requires a file name argument: if the user wants to edit standard
> input, they must specify "-".  

> However, this notation is not
> specified by POSIX, allowing the possibility that making such a
> change may break other, less common implementations.

And to avoid two However's in a row, perhaps

    Unfortunately, POSIX systems do not have to interpret "-" on the
    command line of crontab as a request to read from the standard
    input.  Blindly adding "-" on the command line would not work as
    a general solution.

> Since POSIX tells us that cron must accept a file name argument, let's
> solve this problem by specifying a temporary file instead.  This will
> ensure that we work with the vast majority of implementations.
>
> Note that because delete_tempfile closes the file for us, we should not
> call fclose here on the handle, since doing so will introduce a double
> free.
>
> Reported-by: Renato Botelho <garga@FreeBSD.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Changes from v1:
>
> * Use `goto out;` in additional places.
> * Fix broken test.
> * Use `delete_tempfile`.
> * Improve commit message to mention `fclose` rationale.

Yup.  All nicely done.

>  builtin/gc.c            | 39 +++++++++++++++++++++++----------------
>  t/helper/test-crontab.c |  4 ++--
>  2 files changed, 25 insertions(+), 18 deletions(-)

Will queue.  Thanks.
