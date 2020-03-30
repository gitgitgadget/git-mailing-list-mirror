Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129AC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 05:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECE820733
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 05:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGVNkH0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgC3FWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:22:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43202 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgC3FWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 01:22:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id v23so6265106ply.10
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dF8pizz18MkLbTbInXlnO/kK3CFl9DTfQQYMEQ2RK3E=;
        b=rGVNkH0AibxHrIDzf4epc6zqK0yh+3BiPXm+5V1qR9dB4yYAidDhCubpyljxCaWRdX
         mYU3p/0RcgHdpPY8ALKjT9MzdGmsNlzRn7GQPwlFaBrNjrsOqKxijJC1k1H4D4wg6nf6
         qo4gAQBW+7jiB7q/XnpdNtKWQLs9smpGnohlY3n9fgVbtXpo/h8M3NgZqLEBqZMdeSwO
         64BgcY77YbV7/ySZbmOGBAZ+NySVdrUX7IenM+tjU2Iqhq1wyaUkRMYtI8Z/+ulwhHva
         oCggmOvQSTC2xktduHqQ6i5fmguXB1knjTpkRcHNXCrvmr24Xl6MQOG1/kDk4goWWOgt
         jpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dF8pizz18MkLbTbInXlnO/kK3CFl9DTfQQYMEQ2RK3E=;
        b=rXmf4D26ln0jLO69W4Z9j6VMomJRHiS+eNc63dLuplVW6W+evckXhv14/BP4RLvu4q
         lrhPVCEKuCQBy5KvlMDJrJZzf17fT6+LGLP4B8K39Sonqv4voFdplTsERjqRNrz2yiIY
         hGzQXVmOe5CkNFado3bG9XvbkRD2MuaouXIdl7MGJ8/1B9rt6s2sD1YhTSmbWarKfh8i
         F6bavISaMKZ1rR0ToIS0/R1LBeKOtJtVU12YRmU34NeazGO+s50yu/u0LLm1R4Mcrzo2
         DRSXKH6IhCrYRRjiMykUlertDmLK8bybsanGGlaLEk03tJZSU2GGMv5u+rARnCHjD210
         UZPA==
X-Gm-Message-State: ANhLgQ33f4mwBTTVoM89A54o0+aVS0rjWSTag1tY4M+CXQu3ihg7xsZm
        jaNMtUgIb37k4RgJEAdnEic=
X-Google-Smtp-Source: ADFU+vuGH0fZysRjXK/ro7jCfRCV9udlsWND4tWtqU0M6ACE9KtSUml01mW5d7Ekf7GboD8gyk7/Tw==
X-Received: by 2002:a17:90b:3583:: with SMTP id mm3mr14137021pjb.123.1585545752130;
        Sun, 29 Mar 2020 22:22:32 -0700 (PDT)
Received: from localhost ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id w27sm9214672pfq.211.2020.03.29.22.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 22:22:31 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:22:29 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
Message-ID: <20200330052229.GA786@danh.dev>
References: <20200309205523.121319-1-jonathantanmy@google.com>
 <20200330040621.13701-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200330040621.13701-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-29 21:06:21-0700, Jonathan Tan <jonathantanmy@google.com> wrote:
> When rebasing against an upstream that has had many commits since the
> original branch was created:
> 
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
> 
> it must read the contents of every novel upstream commit, in addition to
> the tip of the upstream and the merge base, because "git rebase"
> attempts to exclude commits that are duplicates of upstream ones. This
> can be a significant performance hit, especially in a partial clone,
> wherein a read of an object may end up being a fetch.
> 
> Add a flag to "git rebase" to allow suppression of this feature. This
> flag only works when using the "merge" backend.
> 
> This flag changes the behavior of sequencer_make_script(), called from
> do_interactive_rebase() <- run_rebase_interactive() <-
> run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
> (indirectly called from sequencer_make_script() through
> prepare_revision_walk()) will no longer call cherry_pick_list(), and
> thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
> means that the intermediate commits in upstream are no longer read (as
> shown by the test) and means that no PATCHSAME-caused skipping of
> commits is done by sequencer_make_script(), either directly or through
> make_script_with_merges().
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> This commit contains Junio's sign-off because I based it on
> jt/rebase-allow-duplicate.
> 
> This does not include the fix by Đoàn Trần Công Danh. If we want all
> commits to pass all tests (whether run by Busybox or not) it seems like
> we should squash that patch instead of having it as a separate commit.
> If we do squash, maybe include a "Helped-by" with Đoàn Trần Công Danh's
> name.

Hi Jonathan,

Feel free to squash it in.


-- 
Danh
