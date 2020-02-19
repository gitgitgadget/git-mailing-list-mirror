Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150F2C5ACC5
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE50C208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AB8twDg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBSXHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:07:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45473 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 18:07:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so840119pfg.12
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 15:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cd1dR2axYLINdIkBKy0TwTVDmd4gehqtEtNHHqBtbM8=;
        b=AB8twDg5y+Nswwl+dOgXVJj9p40Hp7/aJHq6aLn72AAEfb081VMMG7jsezaHOkb4I4
         TT0C+DzJp7Sk7ATk/hbuwKvdsTH400dE8DlmGPYAozhhaownx/I1udtWjEgdY1+kBvgh
         TzoJ9heCnhxuuTzyBPsKQkz0oJCLGJLryemsl1YmpoBlV9//uQ1vRRRLlv6ZPDOwxJpY
         Ci2e1ua3KVeOQpb/PbsboyK9h8z7ScXNC+OIrvoSiKI3O6vtEQ/auag6HsH9wXbRSU10
         JafVaC82T/6YnKpEmSnFw7EgARbNDkvFRJTA2OX5mx+OCMihvOZCjhvIvsz1uRUw48mh
         0M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cd1dR2axYLINdIkBKy0TwTVDmd4gehqtEtNHHqBtbM8=;
        b=DHT5KrXJGOKEglabzgZ87wGgsSVbNZc6aevjFSO9Furxnl7YNE92UmJmvR0F+uhNxd
         ON+yTzT7XKouiEq0uWAg5JDf3w3kiRE2dhD1WXZJnLRU+NKgpgRNyQQSRCZ8DtEr01Ah
         esJjPVPfo8/cJCLzSRmQpTd4jOJxBr6dzd/J8/cZfrzBMsndidf+70pWzg/YTdocsrpe
         CP7oaAHbX7fnG9CTpa1IMRozO+EZIJqDH+EdTbxacLajVyjUtTdvAvaQ4Py6xEDzNuwn
         80rsEjjpXJW5/5jDiWzTxkgGIk7fYXxrE/25Z7v5SmK+2fXoC2Jkbk+qeTFyCtLxifPB
         InzQ==
X-Gm-Message-State: APjAAAViKn/7CQHIoXFtuYP66UKn84gvjRbxgi/Cy7SkTVMmZEnP3JGI
        ig3e0xsI6ijWLBhjteKP88zBd5r9QjE=
X-Google-Smtp-Source: APXvYqxJkrdwoFi1yArIgFopayUcvqX0u1uxs//hwyP0nueuK9TcxyP4Ht2hfLwClkxUVRgaKtz/9g==
X-Received: by 2002:a63:1e1d:: with SMTP id e29mr30558743pge.347.1582153623948;
        Wed, 19 Feb 2020 15:07:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u11sm848061pjn.2.2020.02.19.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 15:07:03 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:06:59 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200219230659.GA79731@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-4-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2002191515310.46@tvgsbejvaqbjf.bet>
 <xmqq7e0ih5zr.fsf@gitster-ct.c.googlers.com>
 <20200219215231.GA26221@google.com>
 <xmqqtv3mcjpv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv3mcjpv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 02:09:48PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > launch_specified_editor() has a handful of exit points, of three kinds:
> >  1. return error(something)
> >  2. raise(sigsomething)
> >  3. return 0
> >     a. when the editor process closed happily, but the user supplied
> >        NULL instead of a buffer. That is, the user didn't want the
> >        contents of the editor given back to them in a strbuf.
> >     b. when the editor process closed happily and the user's supplied
> >        buffer was filled with the file's contents with no issue.
> >
> > So I think we can check "yes" here.
> 
> Heh.  If we raised a signal to kill ourselves, then we won't be
> returning a value from launch_editor() anyway.  That case won't
> affect the "between returning negation or !!, which is more
> appropriate?" discussion, I think.
> 
> >>  - we MUST NOT care to differenciate different error codes returned
> >>    from launch_editor().  IOW, we must be fine to give the invoker
> >>    of the program only 0 (success) or 1 (unspecified failure).
> 
> I actually think this holds for the codepath.  A failure from
> start_command() returns error(), and finish_command() that waits for
> the spawned editor process to complete yields the exit status from
> the editor, but unless we re-raise the signal that killed the editor
> process to ourselves, we just turn any non-zero exit into "return
> error()", so it is safe to say launch_editor() can return either 0
> or -1 and nothing else.  Would we later want to tell callers of
> launch_editor() how/why the editor session failed by returning
> something else?  I do not offhand think of any---we do not even
> differenciate between failure to start (e.g. misspelt command name
> for the editor) and other failures WITH the return value and
> consider it sufficient to tell the user with different error
> message right now.
> 
> So in practice returning -launch_editor() and !!launch_editor()
> would not make any difference, I would think.

Then, let's do the least surprising thing. I'll switch it to !! for the
next reroll.
