Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F8C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1462076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYOxT0he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgDVSFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbgDVSFV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 14:05:21 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5402C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:05:19 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id j68so1456684vkj.12
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g9AFTAqzeQgi9dGEZXiN4UMG1niSisRjdMi1Vogv3kk=;
        b=iYOxT0heLmGGtl2wjqo/R+GYy4o60w9U1UXuDityzqGmrC9zl3eabNCvmj8fwrDdg2
         qwfbLSaIVMUFdeZHknJFSv/ibDC0hAdpmfubmWYtcfzcujQyTVl4WLgcaCx0naHPWUy0
         U0THWP+zjUB5ETaRjrNPkV1YCNxg1wqeA+249ppe38ofgq4IBQ9F5LOwnjDloJMTVs0g
         +lJ5G27bkis4HvTVkdMkRmLA2KgeRDZxlGr4NbKA1NmiO7+enEA6CdtVic9sxBEYJT1p
         MW4QT2qILq/uRm1tpMoT7mXP6CwpF/iIS5PHnxZn1UWX8pgpk7KrmBZdWTJUVdejVf0l
         n6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g9AFTAqzeQgi9dGEZXiN4UMG1niSisRjdMi1Vogv3kk=;
        b=UL6V8qLjp8cxl311yITpXUj773aJYQQN8PqNiz1flRt1TyJfuHBLJ19CwsVV9CvZnf
         ulgWEmiKAk/Mzt0ehxBGg6Hlwrg+Xcl+9fdwAsqNbGbG+6jiYYyKSBq9CTqKs402Q9OD
         SBcp/Xq4I4a5vmtQln4o+X6w4WpsxM+D9esr1hU4VXF7sxZCru4HVc0bXhLeJQWxMSdW
         T4DftFmU1n7TxbYM8/FUJq3YFPGiG72VE/U+orXOJl5sVyL9m+jIYuQxglDxKW0aLJX1
         B+y5+9FiaMT0ga0OgqZNWx1rc92rVJItNm2qdhP6lE4LM3KVKGTlZWrKKZ1gq10GJ2Lm
         7Psw==
X-Gm-Message-State: AGi0PuYZsI2/FJXYcRkQMTEg+kMc8KgujqUqeaG1ptah335irVN1EdQ9
        NTzTHrxLey6tPC+886/39DyHnGNObuhM6eW68Opj
X-Google-Smtp-Source: APiQypL0pAdOqWkjELsdTrDCkeDHaN3wgTDll7/CbgK649N5T5ClK8hU8H7uz65Z6IT5+kLJMPrU0hjTBdK3ZDQv8G/1
X-Received: by 2002:ab0:25:: with SMTP id 34mr13630655uai.63.1587578718198;
 Wed, 22 Apr 2020 11:05:18 -0700 (PDT)
Date:   Wed, 22 Apr 2020 11:05:15 -0700
In-Reply-To: <xmqq5zdsmuht.fsf@gitster.c.googlers.com>
Message-Id: <20200422180515.197584-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5zdsmuht.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     me@ttaylorr.com, git@vger.kernel.org, newren@gmail.com,
        jrnieder@gmail.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> > @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
> >> >  	} else {
> >> >  		unlink(git_path_shallow(the_repository));
> >> >  		rollback_lock_file(&shallow_lock);
> >> > +		reset_repository_shallow(the_repository);
> >> >  	}
> >>
> >> Here, we reset only after we realize we cannot write the updated
> >> shallow file.  Intended?
> >
> > Yes, see this earlier discussion I had about it with Jonathan:
> > https://lore.kernel.org/git/20200416020509.225014-1-jonathantanmy@google.com/.
> 
> I did, and then I asked the question, because I couldn't quite get
> if JTan was asking a question similar to the one he asked earlier in
> the message ("do you need a reset in the "else" branch as well?"),
> or if he was saying what he sees there, "the opposite case", was
> good.

Sorry for not being clear. My intention was to ask a question similar to
the earlier one - in this case, and in the previous case, I think that
the reset should happen no matter whether we execute the "if" case or
the "else" case, so we should just put it right after the entire "if"
statement.
