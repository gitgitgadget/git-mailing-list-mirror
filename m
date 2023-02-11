Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5443C05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBKDLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 22:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKDLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 22:11:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4A5A9F2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 19:10:59 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o75so4726972pfg.12
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 19:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c4nK1Ij3SCP6eSjw+YnW2X5Gpivc33787125RfSuqo=;
        b=JjgC3bAmboeHAlkcSQsY3c3E5FfZNz92xERvQnQBAqxeu9UdHOoYH2sCV6k2txT4LU
         S8Wlrj0DivbK63mUACGCqhyzSujKxOTguDEvhx6JKRGRrUKcc1SX0gr48kEQ61yb+Yhd
         DOZLHNDs8vAKQ4smoH0gcoxBoowExr8/T25E8Q8pdM8sqBpdW1oZS+lPoW4M8MvM1NHH
         IFbY8vTElviV2dk8GOlL4ETwJr5XxJw+QZd0Abdr39XW2yPsvjR2sOpwIKtknnFSE9Qk
         IuVNyzBKY3dAYM4EIzsUlzPLQmDcRV1daFavTzYhKR+4Frya2p600ptTNO0n8OvMEFcI
         QiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6c4nK1Ij3SCP6eSjw+YnW2X5Gpivc33787125RfSuqo=;
        b=AV8cPoBOnCLIrAb5tifFwdlg3qC4IsTkXojkpY89uvrEcxA4TRFhXExW/WM6/qlX8Q
         16v8B5Cbq/1VGCpgSTsjPSY4f4U3+plkoHQJA3Yhif+LOQTfWJIvYEAH7Mo8whPQzrIc
         3UkDjQGVsc/7MSlbaxuON1To/Hi5zm3l7vRJRKsINcYMCQfrcFZLs7dYBCnV3fqK3igA
         SdODC+VxgCU8VyFlL/OFsQOTREIA1VJRSYjNHC2xqokdzvl41XV4gWDEN6UNY3KbfJDT
         vr1Dfl2FF/sGhAdiv9LMsXTWbOwyZLedUpGmUv7JKGb4IuTm0hTWGV33uMgrfSPVlqqt
         0+3Q==
X-Gm-Message-State: AO0yUKUVOCmEZG8AODbCBz3+oSfSoiPWxSYawkkfQ8PQywyMR5p6DLJ/
        qFZOLdXH5jOx9shP+ntFR5MEWp8KvG8=
X-Google-Smtp-Source: AK7set/9FS+2ZLzWFKQhF+uPpWE33+eHUBD6BggciI653R7SWEXKtuDmeMNWdwCkH+qJkWx6zU7dkA==
X-Received: by 2002:a62:3347:0:b0:5a8:482f:c32e with SMTP id z68-20020a623347000000b005a8482fc32emr8855403pfz.27.1676085058510;
        Fri, 10 Feb 2023 19:10:58 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b005921c46cbadsm4000953pfe.99.2023.02.10.19.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 19:10:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jade Lovelace <lists@jade.fyi>
Subject: Re: BUG: git config --global --get ITEM ignores
 ~/.config/git/config when ~/.gitconfig is present
References: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
        <xmqqsffdf0ji.fsf@gitster.g> <xmqqmt5lezi3.fsf@gitster.g>
Date:   Fri, 10 Feb 2023 19:10:57 -0800
In-Reply-To: <xmqqmt5lezi3.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        10 Feb 2023 17:56:20 -0800")
Message-ID: <xmqqzg9kew1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> My gut feeling is that this is merely a bug that we can fix without
> worrying too much about users screaming at us complaining that they
> relied on the current behaviour.  Without --global we do read from
> both, so with with "--global" the behaviour is inconsistent.

So, here is what I think happens, if anybody wants to get their
hands dirty.

builtin/config.c::cmd_config() notices "--global", and
tries to choose between user_config and xdg_config and
picks one.

The choice is stored in given_config_source.file

Eventually, "--get", "--get-all", etc. are handled by calling
builtin/config.c::get_value() and that function eventually calls
config.c::config_with_options().

config.c::config_with_options(), when config_source.file exists,
uses only that file.  There is no facility to say "read from this
one, and also that one".

When the command is called without "--global",
given_config_source.file is not set and in that case,
config.c::config_with_options() does the "config sequence".
This is implemented in config.c::do_git_config_sequence().

What is disturbing about this function is that it knows about two
global configuration files, and finds out about these two files by
calling the same git_global_config() helper function
builtin/config.c::cmd_config() uses.  However, the logic used to
decide if the file(s) are actually attempted to be read (e.g.  it is
not a configuration error to lack ~/.gitconfig) is slightly
different.  Ideally, it would be very nice if the high level caller
in cmd_config() loses the duplicated logic and instead just sets a
single "we are dealing with --global" bit in given_config_source
structure, and config_with_options() is taught to reuse the "we need
to read both of them" logic in do_git_config_sequence() when the bit
is set.


