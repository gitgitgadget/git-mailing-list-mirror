Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C482C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F10960E98
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhH3VLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhH3VLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:11:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:10:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z1so21913998ioh.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PBGS4LuFfTeYUWqNDWZa7jax+qo0kEjEAQKztdyZyK4=;
        b=ymW6XkkEdczaEy9NLcL1OeyTRkNA60wMfi3m4EVFbzK0Xt/mp7SftGQDCDV8i3EF16
         QT/c5zYskQl5sypHJ4Dc7KEFeQYtTMJmbhjdK2GJesoXiWNR4uBVSGnDXXYTfL5irXlP
         23OC2h4H6kciLU56oOvozUYKjh5VPv93ghkk5rVq8SAKqGYxRxjBuB/fatH8BTDCncPz
         4bHc9Y4Hy/nQta3ZdVATRrjTw9jVP8D6pKSNsCJ0bfYGjJZDPB5micZzbtxwpYc9wEti
         lbIRB71J/kbMAuejRuRFTyNnXUfVNDc2KwqiPaqND+OWZdvA5Qiyedcf7dbZ7JMxETN9
         Kqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBGS4LuFfTeYUWqNDWZa7jax+qo0kEjEAQKztdyZyK4=;
        b=nf0u68+prB7PVTRa2xoTgccNKr56RhQNxXPTkTxPm89A6QjEzdJbuzXi7Z7zmtS8M6
         yWmZShOjC6r5G75Wjb2oPrBdZ/wUc3ArvrIm6Yg7zvevwSYg3t1lCczlR02S7Q5b/NHK
         HJA4SPjA9cmQ1VAt2esL7rM1O0SFGTnz9ZLp0L7g87NhahBibcGaCheUKUsd+Ga3A+k6
         5CA7X0TcxqYlTlx7BULEY5e/58vhkDS5Fxk7Lk3grx9BvXy4WYKbdIFQCPb1D5AEhuRr
         FUnLMr/Gdpnvi0IrWepqp4OLtNOI12X1Su9C5IikyVtrmox0m6iYioDacghyVjTKFlo6
         CkVQ==
X-Gm-Message-State: AOAM531cQEKd77xHtTviSm1XLW3LwFTWW1Jfl1x4QTqKZPSjigWrE3mc
        Foc4ioYG8DlQbS9xV28aVIRSiA==
X-Google-Smtp-Source: ABdhPJzhyzTaZBklJ/D5SzTCP4GG8OYEXV6/gUFf2Ogb5Rd3WgK70QMLBVoPyKatpm00e7PM2DUaVA==
X-Received: by 2002:a5d:8a0e:: with SMTP id w14mr20207108iod.94.1630357839319;
        Mon, 30 Aug 2021 14:10:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g14sm8883674ila.28.2021.08.30.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:10:39 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:10:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/4] RFC: refs: reflog entries aren't written based on
 reflog existence.
Message-ID: <YS1JTuBY0Lq34yP/@nand.local>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <2f11fd7718005d1e94b3139f086134896da202f1.1630334929.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f11fd7718005d1e94b3139f086134896da202f1.1630334929.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 02:48:48PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Before, if we aren't supposed to update reflogs (eg.
> core.logallrefupdates=NONE), we would still write reflog entries if the
> reflog file (.git/logs/REFNAME) existed.
>
> The reftable storage backend cannot distinguish between a non-existing
> reflog, and an empty one. Therefore it cannot mimick this functionality.
>
> In CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com,

This looks like a faithful implementation of that discussion, so I don't
see any problems with the change.

> we came to the conclusion that this feature is probably a remnant from
> the time that reflogs weren't enabled by default, and it does not need
> to be kept.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/files-backend.c  | 20 +-------------------
>  t/t1400-update-ref.sh |  7 +++----
>  2 files changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e05ada9286d..25f5a4ce777 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1551,6 +1551,7 @@ static int log_ref_setup(struct files_ref_store *refs,
>  	struct strbuf logfile_sb = STRBUF_INIT;
>  	char *logfile;
>
> +	*logfd = -1;
>  	files_reflog_path(refs, &logfile_sb, refname);
>  	logfile = strbuf_detach(&logfile_sb, NULL);
>
> @@ -1565,26 +1566,8 @@ static int log_ref_setup(struct files_ref_store *refs,
>  			else
>  				strbuf_addf(err, "unable to append to '%s': %s",
>  					    logfile, strerror(errno));
> -
>  			goto error;
>  		}
> -	} else {
> -		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
> -		if (*logfd < 0) {
> -			if (errno == ENOENT || errno == EISDIR) {
> -				/*
> -				 * The logfile doesn't already exist,
> -				 * but that is not an error; it only
> -				 * means that we won't write log
> -				 * entries to it.
> -				 */
> -				;
> -			} else {
> -				strbuf_addf(err, "unable to append to '%s': %s",
> -					    logfile, strerror(errno));
> -				goto error;
> -			}
> -		}
>  	}
>
>  	if (*logfd >= 0)

I'm nit-picking, but I think that this conditional could probably be
moved into the if-statement above, since we no longer set logfd anywhere
else. It might read more clearly, and if you're going to resubmit this
series anyway, it would be helpful to pick that up.
> @@ -1592,7 +1575,6 @@ static int log_ref_setup(struct files_ref_store *refs,
>
>  	free(logfile);
>  	return 0;
> -
>  error:
>  	free(logfile);
>  	return -1;
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index de0cf678f8e..52433f6d0d2 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -269,7 +269,7 @@ test_expect_success "(not) changed .git/$m" '
>  '
>
>  rm -f .git/logs/refs/heads/main
> -test_expect_success "create $m (logged by touch)" '
> +test_expect_success "create $m" '
>  	test_config core.logAllRefUpdates false &&
>  	GIT_COMMITTER_DATE="2005-05-26 23:30" \
>  	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
> @@ -315,12 +315,10 @@ test_expect_success 'symref empty directory removal' '
>  	test_path_is_file .git/logs/HEAD
>  '
>
> -TAB='	'
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation

OK, so "Initial Creation" happened in a state where
"core.logAllRefUpdates=false", but we passed "--create-reflog" to force
the behavior anyway.

Then during "Switch", we had a reflog, but again "core.logAllRefUpdates"
is false, and we didn't pass "--create-reflog", so no more updates are
written to the reflog.

That's exactly the test that I would have expected to exist for this
change, and so this LGTM.

Thanks,
Taylor
