Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1D8C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3584060BD3
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbhIBOsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbhIBOsC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:48:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A908C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 07:47:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g22so3240434edy.12
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Fiq2gMEQXL9hahaTl5Kpk29ff20zcsGFjFrWxTr8LS4=;
        b=QVEBTOqDWSWSidz8IWrPSwUeOYRMs7F5EqXRiR1caNpP//CZ3oxfspdQrFOwRGtcgc
         HNZDlxpbC1GRPI+j91E4yROtqIKXbUUFMmdejN6XdA5/xI1kaHRTni3sa/tjafIq9r7Z
         Pq8quAF1oLRpCHFdj9IGYIKqQoGdgM2y7lRPQ7nB/xkAq4Qkewz+T6iDs7gYJEttGixy
         XFMOMrAhJ3eedt56sk9itFvAHkZ7pdY31hdp2VGEEcBISRr3l9RVbQcPo/NQoQJH/zhW
         3KcHzZNaSzuIh5sX/VWbsDRBFN3/KAvwAr8P4R33RoTRx8o7V6KJbB9YJdXv65I5PnkK
         WIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Fiq2gMEQXL9hahaTl5Kpk29ff20zcsGFjFrWxTr8LS4=;
        b=CgJLEurMQ3IByDnVIQiia3o0m9s1P9RE5KhCWShzwakgv9AdHyHkd+nY0aJoJtLrzM
         mo7JGoRM/1n2eXsEoDdnvPF3s0ShVYpOCMwrJhYC5FsH2sj9nnRI1hK5EOC5YNJDc9KP
         zlWLEUdtOgyHYt7f3LMZQEPvlgJeY9GzUGYCFM6EWre4LwfXN6e8UYt06VmPGERkMwKF
         QS1AECNai0D8M9QwyApZqrXmCbu00mhXgP3HJ0KGRyo2S3ieu1whgSrOapvdrBc2ljYV
         pEpJApU79U21eB8wZxjPuHAPXGKu4D2kChQNVcr5TCGHH7AURanCz/X7MziMDlXdEgX3
         ZDjw==
X-Gm-Message-State: AOAM533iYz7GGwwd5lFcBU0jdKVbereUMT20HMAsqYTY5/fF1hhM0A4l
        omwyOFFd4cp8443Ouqu+98U=
X-Google-Smtp-Source: ABdhPJylSTH3gbrMFQI5afD+92x3zmslRo/r95fYtfqKgiGH6scX2hMKHHxPZDkL4l+Uk66HElPvyQ==
X-Received: by 2002:a05:6402:2816:: with SMTP id h22mr3950945ede.146.1630594022961;
        Thu, 02 Sep 2021 07:47:02 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm1277318ejo.60.2021.09.02.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:47:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Thu, 02 Sep 2021 16:34:43 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
Message-ID: <87lf4f9gre.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:

>  git-rebase--preserve-merges.sh | 1057 --------------------------------

You could, but certainly don't have to, squash in the below. I.e. this
is the last user of eval_ngettext!

I mentioned in <87r1e8v26x.fsf@evledraar.gmail.com> that I'd recently
come up with pretty much the same diff, that was because I was seeing
how much of the shellscript gettext support I could rip out.

This is a major step to getting a whole section of git's shellscript
support infrastructure out-of-tree, i.e. git-sh-i18n.sh, and the
sh-i18n--envsubst built-in helper.

If I then merge mirucam/git-bisect-work-part4-v6 &
gitster/ar/submodule-run-update-procedure along with this we'll have a
relatively small amount of gettext-in-sh code left, which should be
entirely gone before too long. Yay!

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index e3d9f4836db..a15c0620db6 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -51,12 +51,6 @@ gettext_without_eval_gettext)
 		)
 	}
 
-	eval_ngettext () {
-		ngettext "$1" "$2" "$3" | (
-			export PATH $(git sh-i18n--envsubst --variables "$2");
-			git sh-i18n--envsubst "$2"
-		)
-	}
 	;;
 *)
 	gettext () {
@@ -70,12 +64,6 @@ gettext_without_eval_gettext)
 		)
 	}
 
-	eval_ngettext () {
-		(test "$3" = 1 && printf "%s" "$1" || printf "%s" "$2") | (
-			export PATH $(git sh-i18n--envsubst --variables "$2");
-			git sh-i18n--envsubst "$2"
-		)
-	}
 	;;
 esac
 

