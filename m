Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D1AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB696113C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhIHTF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIHTF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:05:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56FC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:04:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h16so6846820lfk.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dGAJAoZvKQ6A3M40JSXLeP5B6ATvoDu3ZIdqnQfoNIM=;
        b=kW65Ga0McWAjg/EtfGkk+PF5IFnqyAMpyeD9UV6LYn+u2u6V0XeRjLi86I3bwM8AjX
         CVNYrnaZmofB0YGz2dgqQ7+Mm8rsK8vQuaTXT4QtlYC1jXolsK2djRSx3qzeDzmZmD/L
         sN29/GKm/xuxaBiUEp4KkAepgZwWPbl0Ci+b7gaxnPgPCwZrScX8/C3w7aOSbcX5SDWE
         fO+J+E4JmwU8B/+9Z16uqpVvGMtZZ+pfBb1X1cY1RUtMsxA/OYJ8Des383W7jxJQTvPD
         k6A0Qx8kLDHwVXhMDv8EdIBikhmHCiZ4zNcPrQIkniMAqo84KUsI8DEH0VCmSnenGrL/
         mDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=dGAJAoZvKQ6A3M40JSXLeP5B6ATvoDu3ZIdqnQfoNIM=;
        b=f1KCUIUMx3/40o1n5yCsyJznDeowxJ2y4hyYkyIX1VxpHd+cdzHsL7lG7rRwNFm/Bs
         N3B6ETPN7t/JbF9g3Mi61piiaZcKxC7E/K7x0Vp2w29/H7klrxChWbTeWpM26ypOlygB
         Us54/BJxYpBxlQD0ZEOqmHf7fKTBlzAIGKEoRjMB4Z5zDzGJEVQ0aERfc+gnxyEneitR
         8SQWxZW7ZoKkWhm3hMp0uRVFU+zOCb+tnzzcCYKwfAo3/vWQ3TNvLpLDOLYCTtMQWpiE
         /l1eFhtY5+Mi5jlk0ZTNmMPjLH/jpfJntiHyIDD2FYv5NlLqYI2Edoht14gVOVzccrf2
         NjFQ==
X-Gm-Message-State: AOAM533ZthTKiOloh4nWAxp3aBWBUuRydUep4d7xyHhOx9RqCoPhE745
        FrKNQGetqnytIZbyAWYYSTI/2zqkAlw=
X-Google-Smtp-Source: ABdhPJzJW/EvF1D7ZZK7IAAxYkUMpUYy/fnF05XlDHhvI9Lpkj64y0iJRU9CaWs+YMPQ+m4tx2oNyA==
X-Received: by 2002:a19:700b:: with SMTP id h11mr3592799lfc.180.1631127888495;
        Wed, 08 Sep 2021 12:04:48 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d7sm327165ljc.129.2021.09.08.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:04:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru>
        <cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org>
Date:   Wed, 08 Sep 2021 22:04:46 +0300
In-Reply-To: <cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org> (Johannes Sixt's
        message of "Wed, 8 Sep 2021 19:23:52 +0200")
Message-ID: <87pmtiopm9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 08.09.21 um 15:43 schrieb Sergey Organov:
>> Besides, nobody yet told us why gitk uses --cc option in invocation of
>> 'diff-index' in the first place. Does it actually *rely* on particular
>> undocumented behavior of "diff-index --cc", or is it just a copy-paste
>> *leftover*?
>
> No, it is not a left-over. The thing is,
>
> - there is one point in the code where gitk adds options -p -C --cc (and
> more) to the command line (around line 8034),
>
> - and there is a totally different point in the code where it is decided
> whether diff-index, diff-tree, or diff-files is invoked (proc diffcmd
> around line 7871).
>
> IOW, Gitk expects that these option combinations can always be passed to
> all three commands.

I see, but the problem here is that while diff-files and diff-tree both
accept --cc according to their documentation, diff-index does not. This
means that, strictly speaking, gitk makes a mistake treating all 3
commands universally with respect to command-line arguments when it uses
--cc.

>
> Gitk does not want to look at a commit and then decide which incarnation
> of the command it wants to use (--cc vs. -p) depending on whether it is
> a merge commit or not. This decision is delegated to command that is
> invoked.

The problem is not in the kind of commit, the problem is in the command
being invoked. diff-index doesn't support --cc according to its
documentation, and thus gitk relies on undocumented behavior of
diff-index. It might well be the case that it just happened to be
"working", thus nobody cared.

> Therefore, silent fall-back from --cc to -p in case of non-merge
> commits or non-conflicted index is absolutely necessary.

I didn't change semantics of --cc, so this thing was not broken at all.
I just disabled the --cc option in diff-index command, to match the
documentation.

As a side note, in fact Git does no "silent fall-back from --cc to -p in
case of non-merge commits", even though the behavior could be indeed
seen like this. Instead, --cc implies -p, and, as --cc does not
otherwise affect treating of non-merge commits, only -p is left active
for them. Once again, this has not been recently changed, so does not
need to be fixed.

Thanks,
-- Sergey Organov
