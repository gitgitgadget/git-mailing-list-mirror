Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0169C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D12087E
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnpPH/uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgJFUqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgJFUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:46:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21ADC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 13:46:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so6582pfa.10
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1mDfEXLNjdvXlfeUNWqTOOnzT3hOq+T2knfmfWKypc=;
        b=lnpPH/uHmv6Qyew/4Ffwsz26wNHLEWmLHZWe9688WzzBOAoLS4tyrV29jcIsPQE63d
         ZJXghIyZ0Xf7Opn8fH/8vfS516v+JtLh+51EXckvVrLEfcX3N/T/ZeUywAAtZKZMjf8c
         BxSCJ66+owHdMaan1zBS1MfYsgiTLfmb7PJXTu5zpG2fdaO6/Ve4dQp0JANi4dGFjssT
         bPsHlNKDWdotwhJu3ES0h2YwTEAXTlxYG4FzqY96s0z36wGCv65bqLI7OtUtGn+7VwIW
         k23ZXOpT9GepBn8NKSwf+Go2dNGeWjh6Yiw8lXCSkofI9wMsajEahUvnh43Z27hG9UpV
         Mu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1mDfEXLNjdvXlfeUNWqTOOnzT3hOq+T2knfmfWKypc=;
        b=anrKbZz2kCjwgJqxp/9tNeUdVXjbEJyUf+/ftEr6A69O/1P9LJdQY/MDsXqpVwsiuU
         uZ9sMauXaQefzqLtavQu5nPI3V1eufjlCjHSIoKh6f7eXJXTGv+e9f8RgiTxnrhnYPRm
         DFQiVtt6VENGvxyM8n9TOvpsYf/zbEzplECh6grikQtjim4iM8gpNoG1le/KdyU3kntG
         YvtUYD7IQLPjsje/mmyB6YwirQZiYuBepiMXr6lxjQDUoWdk9Rv3m+VnrMxVZKkQ5M9I
         oU95X9BKo0L6mNXprp66o7AMOh6bpDa5DJ8YFsKlXPcjb6hklGhgZHVWr978ZLRkjtNk
         1TGw==
X-Gm-Message-State: AOAM532hfMrcLJbDIB7fMCktYREWxD5r5lRxRcRC4OV91GNwr52btbJo
        w6YA4CIIPrdoXVY2M2reRv4q1w==
X-Google-Smtp-Source: ABdhPJx07g0H4M+JCWb2O7AmAnMZymEi9oD/jQoziJdI3VhzRnHoDkS+0k0pPsP9ReKSYSmT7vlYTg==
X-Received: by 2002:a63:2503:: with SMTP id l3mr23813pgl.324.1602017173265;
        Tue, 06 Oct 2020 13:46:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id z6sm78105pfg.12.2020.10.06.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:46:12 -0700 (PDT)
Date:   Tue, 6 Oct 2020 13:46:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/9] hook: add list command
Message-ID: <20201006204608.GL331156@google.com>
References: <20200909004939.1942347-4-emilyshaffer@google.com>
 <20200923230451.1279511-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923230451.1279511-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 04:04:51PM -0700, Jonathan Tan wrote:
> 
> >   $ git hook list pre-commit
> >   ~/baz/from/hookcmd.sh
> >   ~/bar.sh
> 
> In the tests below, there is a "local:" prefix (or similar). It's
> clearer if the commit message has that too.
> 
> Also, looking at a later commit, the "list" command probably should
> include the legacy hook if it exists.

Have added it as a separate patch for v5, hopefully that will make more
sense.

> 
> > +static void emplace_hook(struct list_head *pos, const char *command)
> > +{
> > +	struct hook *to_add = malloc(sizeof(struct hook));
> > +	to_add->origin = current_config_scope();
> > +	strbuf_init(&to_add->command, 0);
> > +	/* even with use_shell, run_command() needs quotes */
> > +	strbuf_addf(&to_add->command, "'%s'", command);
> > +
> > +	list_add_tail(&to_add->list, pos);
> > +}
> 
> It might be odd to a programmer reading this that an existing "struct
> hook" with the same name is not reused - the scanning of the list done
> in hook_config_lookup() could probably go here instead.

Sure, done.

> 
> > +test_expect_success 'git hook list orders by config order' '
> > +	setup_hooks &&
> > +
> > +	cat >expected <<-EOF &&
> > +	global:	$ROOT/path/def
> > +	local:	$ROOT/path/ghi
> 
> Will the "global" strings etc. be translated? If yes, it's probably not
> worth it to align the paths in this way.

Asked more offline. Jonathan was saying that translation might result in
scope name + tab character leaving the path in different columns
depending on the scope anyways, so there's no point in using a tab
character instead of a space character here. That seems reasonable; I'll
switch.

 - Emily

