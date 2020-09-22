Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BEC4727E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 11:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36E6214F1
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 11:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=klerks-biz.20150623.gappssmtp.com header.i=@klerks-biz.20150623.gappssmtp.com header.b="QU02jRIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVLf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 07:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIVLfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 07:35:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4221C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 04:35:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q13so22309670ejo.9
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=L4nSVAjuxCGWBQVm7eyR+D8Vj9L9uGdd7X9UBPmPDEM=;
        b=QU02jRISjMdZ4Fm6Ac0Vo84sObtHyQuKJP6GlSnyXHmLIby8Bs6xYCpUftxnU0CaD0
         PZVuDFexJU6UzsrpRb0z9WQmP/buGbPjTGoPAMailloi6RSMq24UBxUl1K1nHjZvJeDP
         ifcxR+qmzSfQMUXkm4NPOaZLH46+8+w0bULjnW+eml5cDk4jjI380jlxsMrtIql+1IM7
         TOztPYDO17T+Rs0g15ZsoBljrRB69je3luQeAcKpWxziu8wtb7e5kOyknX7pq6wqd1CM
         Gf5sOhczfRaPVpDuyEXmATeUVgRDa2x/RhX2TK44VyJCXPb+dCMliEzUfLcfwcvhBT+l
         /c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L4nSVAjuxCGWBQVm7eyR+D8Vj9L9uGdd7X9UBPmPDEM=;
        b=kPk3GxQWTRTG2zNkIVEw9s8/E0O5ntyZ9wLFUtULsqNgsYHzzMVErlqYeuqPs91Pub
         MDvBwfoTN4NzzojuIVw4gkBLyGGPhpkAgyatfO+1nUB/xyLzJ26NyTfY6EM46cj6RI9u
         cOZF4tL+xi9a/TOk7bn6pFUu8eQKZiHwP9YtwjUsa7lECYCFpMeFDwkSsdQXzM10RGmz
         fi3/4KRqLtxQUtHgum1S8cvY7+qE+ocxH0eApdt0vd6MwkFjsk+eegYBM3Q0g4tueRyo
         kogUBQYdTmJF0I6wqoBDBWOWjKptXeuKeqmb7iT0N5a41i+mV9dLfBqYoxtBDNu67WvV
         kcYw==
X-Gm-Message-State: AOAM530IG9PbnJHvdzjkmKSKFLkB+hYYr+7U4zJRvlDMWpQz+i+Mj4Mk
        oiesc7FRH2OiQIY8ERHcarjA+H/dZbiGl2rT8Mxy9f//xRzTjG7w
X-Google-Smtp-Source: ABdhPJzQiAeUq6fl2sZNmH2EougJBo7L9uX/yyZnlWebGzARc/qQTLt0HaGDr8EpDWK8iYazryc3dEJSe79sDFM9vlE=
X-Received: by 2002:a17:906:49cd:: with SMTP id w13mr4295143ejv.151.1600774554002;
 Tue, 22 Sep 2020 04:35:54 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 22 Sep 2020 13:35:42 +0200
Message-ID: <CAPMMpoj+UhKCW_k34-cGkiWFghOOu13GhPgA0V-y4ZpLVppuiA@mail.gmail.com>
Subject: Question about fsmonitor and --untracked-files=all
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've got a couple questions about the "fsmonitor" functionality,
untracked files, and multithreading.

Background:

In a repo with:
 * A couple hundred thousand tracked files, and a couple hundred
thousand .gitignored files, across a few thousand directories
 * The --untracked-cache setting, tested and working
 * core.fsmonitor set up with watchman (with the sample integration
script from january)
 * Git version 2.27.0.windows.1

"git status" takes about 2s
"git status --untracked-files=all" takes about 20s

When I turn off "core.fsmonitor", the numbers change to something like:
"git status": 8s
"git status --untracked-files=all": 9s

Using windows' "procmon" to observe git.exe's behavior from outside, I
think I've understood a couple things that surprise me:
1. when you specify "--untracked-files=all", git scans the entire
folder tree regardless of the "fsmonitor" hook
2. when you specify the "fsmonitor" hook, git does any
filesystem-scanning in a single-threaded fashion (as opposed to
multi-threaded without "fsmonitor" / normally)

These two things combine so that with "fsmonitor" set, normal
command-line git status performance is great, but the performance in
tools that eagerly look for untracked files (like "Git Extensions" on
windows) actually suffers - it takes twice as long to run the 'git -c
diff.ignoreSubModules=none status --porcelain=2 -z
--untracked-files=all' command that this UI wants (and blocks on, when
you go to a commit dialog).

Questions:

1. Is there a reason "--untracked-files=all" causes a full directory
tree scan even with the "fsmonitor" hook active, or is this
accidental?
2. Assuming that the full directory tree scan is indeed necessary even
with "fsmonitor" (when requesting all untracked files), could it be
made multithreaded?

(my apologies for the simplistic "outside-in" observations; I don't
feel qualified to attempt to understand the git source code)

Thanks for any help understanding the optimization opportunities here!

Tao Klerks
