Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EAAC433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 02:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiENCve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiENCvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 22:51:32 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0D508125
        for <git@vger.kernel.org>; Fri, 13 May 2022 17:52:42 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id r4-20020ab06604000000b00360317232f6so4492252uam.6
        for <git@vger.kernel.org>; Fri, 13 May 2022 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SfRpF9GVkVdRGby/98utHShd9vD3xlZBAwXpvE5LsUY=;
        b=QnOIMlXY/Ur2oMqiRnViQ9bAKrMDDK2og+I+sYBmVvLL7SC5kaX0HxkWHjeoQZvwQE
         R43Mmg5jcwz5jYHwC/lL4XSgHjMgl+nyWE332n5yN710dpJ4UaHbcS5AwjRvFaa6SJun
         bd0n8S6hsSSHmP6Oiq3tJ2wewhCBPgctckPrKhcpY1Zh5HDA6kO+1C3Z+IhZ+ca66JeR
         HSjRzcio8FB7M8jYeOfe732QL6MkYcNuU1C8OvMO4+9Aywp1S38ttgASGs/cy4R3UgZ4
         YxGppx3Yoq/wtbOktrn9IT1SJb6QDxknOVDDKomAGyKXohgtHkZKJIXfEeHGDzobFk4N
         2gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SfRpF9GVkVdRGby/98utHShd9vD3xlZBAwXpvE5LsUY=;
        b=oKs4tJcE2aia6MeqfncWOyYW7YJjIehC4fGUuvYIHslQG2cr8BfeO3Xv2760Yd/+MX
         o4i8K13U6IVqXiMbEdtd6LAZkwffKZDldNtnR6HOAZWjOd72E4PLOxivmDPgkuN8staL
         +ASj9tU4dEgOdOjZqPxbeUdozeR1MSS/WXXmtHuZMWSUmxjopc74sFuR4x+7Cu0cUNyh
         gESiTMWBcit28d3tVjCm0pLk++/oB84swMcNYsfXwFe9yBgEUxMD2OKSFEvIZJlATAc+
         wlQE8YOVigkUOY7lx/yw938ixsvDNnU8iBg6siPlTSuQfgKCsR/6xSd0WDiKDWdWo4pJ
         jjCQ==
X-Gm-Message-State: AOAM531gBPLg1ZkH0hfeFFpA2b7fLjWk8+awAwVY6KSmWztTEB9/vKHG
        6oQMb+AWPgaKS2Aw+rbKo4A2s3WKibTXcA==
X-Google-Smtp-Source: ABdhPJzOqf0bDM2qTYOi7lxDfR6jNH+mQXBC05LHesD49ijoVGO07ijUspe0oSaZoRBWbcItXEIt/mzsKoGE2A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a53:b0:510:a045:b92e with SMTP
 id h19-20020a056a001a5300b00510a045b92emr6665932pfv.64.1652487339143; Fri, 13
 May 2022 17:15:39 -0700 (PDT)
Date:   Fri, 13 May 2022 17:15:37 -0700
In-Reply-To: <xmqq1qxfbqtq.fsf@gitster.g>
Message-Id: <kl6la6blj7fa.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g> <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qxfbqtq.fsf@gitster.g>
Subject: Re: Bugreport - submodules are fetched twice in some cases
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> FWIW, without "--all", we do not make an extra fetch at all, with
> the current code or with code as ancient as v2.5.0

Aha, the reason why I wasn't able to override "--recurse-submodules" is
that I didn't notice add_options_to_argv() was setting
"--recurse-submodules" for each of the 'inner' fetch-es in
fetch_multiple().

So a PoC fix might look like this

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed..d42646e68c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1856,10 +1856,6 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--force");
 	if (keep)
 		strvec_push(argv, "--keep");
-	if (recurse_submodules == RECURSE_SUBMODULES_ON)
-		strvec_push(argv, "--recurse-submodules");
-	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
-		strvec_push(argv, "--recurse-submodules=on-demand");
 	if (tags == TAGS_SET)
 		strvec_push(argv, "--tags");
 	else if (tags == TAGS_UNSET)
@@ -1942,8 +1938,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 			return errcode;
 	}
 
-	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc",
-		     "--no-write-commit-graph", NULL);
+	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc", "--no-write-commit-graph", "--recurse-submodules=false", NULL);
 	add_options_to_argv(&argv);
 
 	if (max_children != 1 && list->nr != 1) {
@@ -2271,6 +2266,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = fetch_parallel_config;
 
 		add_options_to_argv(&options);
+		if (recurse_submodules == RECURSE_SUBMODULES_ON)
+			strvec_push(&options, "--recurse-submodules");
+		else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+			strvec_push(&options, "--recurse-submodules=on-demand");
 		result = fetch_submodules(the_repository,
 					  &options,
 					  submodule_prefix,
