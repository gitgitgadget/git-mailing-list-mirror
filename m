Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A01C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 17:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjBMRwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 12:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBMRwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 12:52:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325A1EFD2
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 09:52:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso14362417pju.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 09:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNalS/ICFtYgwDDO+Ft9jdbxTXE5jWqb0dZPmwCT234=;
        b=GnY9eN2fmdS8X2GRnaZDwjc45YdmJYhZVXXrzITfh3swhREvSJJtbxHAFEbk/zJavS
         giCxsD0/ml1ibyLOXcmK6nKh5Yf2prxIN71PaZdUj8MM7iNz1bA3G5GTGued/tQW++PJ
         FqjWIH+bd8xRH5BmrGwA7QXWpivSOqW9aVoZlsfS+3Qq4SCxmlyPMqiGd2pCBAvAROmD
         KxEce1S4LYuaIUvLsN8vFe15O5mxjFFhCiomiDBG+L5Fo6qu7C/t6SWrrpZy2APfHfKf
         Dd0E/4XoQYAEzdTyKxvmDWEHY2M2WnZZrZIcAHvnGcbCMP925149F0Gt89JKW/MNNJV5
         8nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kNalS/ICFtYgwDDO+Ft9jdbxTXE5jWqb0dZPmwCT234=;
        b=vrdWCrBM8NPUXvDh2MfaF3Xd0+xu+0B2DVFF6Ne65CI+2nhuGHKJYBOH2err+Ift/h
         pwyrDXHxjjEEwMZU1nZdpytMLehY4aTfLiUuW/gYWx3eut+flopG9J4tWArpqZddBGpU
         9xgtTK8N+WC/ZWKx35zdX/MAf94zsL8lQwq0Ho1ueJHTOa6Q7C8/97nUzULmZeYM/HPF
         WIMaU4Qwkxu3FRcw3sLC3rXh5/CbGF5Neqz3YpvAoNdhdOHiREpI0Ou2neUT20Ca8DR1
         9U6ZlA7bquk4FUAHn8xmHL/5LuHMBCxh8uWuOaGJFQbNgGUB1RMDq/z6H5YvtzH2NLtg
         x4ag==
X-Gm-Message-State: AO0yUKWuW1Z7UZKlvM2bVqT1wXYXaebYA7YTZWzidc4Rxy92VuwVNtkm
        ZmHjpNZ62nP5HL/DBYgAp5I=
X-Google-Smtp-Source: AK7set/2F5ocKsUxeMa/9ZvruPQrWslnejLiAmoGOXrkEwY0JNNGYSgZKl0J9e0OpA20ISGj0rTa4g==
X-Received: by 2002:a17:90b:3b48:b0:233:c8d5:abf1 with SMTP id ot8-20020a17090b3b4800b00233c8d5abf1mr8995624pjb.21.1676310736121;
        Mon, 13 Feb 2023 09:52:16 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id hi1-20020a17090b30c100b00233b1d51879sm5768383pjb.33.2023.02.13.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:52:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        avarab@gmail.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v8 1/6] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
References: <20230207181706.363453-1-calvinwan@google.com>
        <20230209000212.1892457-2-calvinwan@google.com>
        <kl6lo7pyax9q.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 13 Feb 2023 09:52:12 -0800
In-Reply-To: <kl6lo7pyax9q.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 13 Feb 2023 14:34:57 +0800")
Message-ID: <xmqqbklxcv1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> What do we think of the name "duplicate_output"? IMO it made sense in
> earlier versions when we were copying the output to a separate buffer (I
> believe it was renamed in response to [1]), but now that we're just
> calling a callback on the main buffer, it seems misleading. Maybe
> "output_buffered" would be better?

Yeah, we do not even know what the callback does to the data we are
giving it.  The only thing we know is that we have output from the
child, and in addition to the usual buffering we do ourselves, we
are allowing the callback to peek into the buffered data in advance.

If the callback does consume it *and* remove the buffered data it
consumed right away, then as you say, "duplicate" becomes a word
that totally misses the point.  There is no duplication, as the
callback consumed and we no longer has our own copy, either.

If the callback consumes it but leaves the buffered data as-is, and
we would show that once the child finishes anyway, you can say that
we are feeding a duplicate of buffered data to the callback.  The
mechanism could be used merely to count how much output we have
accumulated so far to update the progress-bar, for example, and the
output may be given after the process is done.  But note that we are
not doing an "output" of "buffered" data in such a case.

To me, both "duplicate_output" and "output_buffered" sound like they
are names that are quite specific to the expected use case the
person who proposed the names had in mind, yet it is a bit hard to
guess exactly what the expected use cases they had in mind were,
because the names are not quite specific enough.

> Sidenote: One convention from JS that I like is to name such event
> listeners as "on_<event_name>", e.g. "on_output_buffered".

Thanks for bringing this up.  I agree that "Upon X happening, do
this" is a very good convention to follow.  I think the callback is
made whenever the child emits to the standard error stream, so
"on_error_output" (if we are worried that "error" has a too strong
"something bad happend" connotation, then perhaps "on_stderr_output"
may dampen it) perhaps?
