Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87ABC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C460231
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhCAWFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244933AbhCAWEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:04:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE7CC061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 14:03:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v62so20315570ybb.15
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 14:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AqmyodcHCWwqvdEgHev5icSZ5SOw1KXBs+XTKdSdY9M=;
        b=GQ4lPss9yfa6dPZfiGLhwp3whmjZlHZ11EW+zXTsgC6XhTJWXX/8/L9c4m7UD4lHfq
         tNKkWoH720A2PTb5DKVxakE5zXtORUXdK09h5t3zJuMily/H8BZpr6NMOGjrTPGxtX8d
         ri4hbhcOAzNBbXuZuQz4ouQHDOYkSYeceTea6nrUEA7gjUVdHEeUNnlB+W410yB8KSaw
         NqUt1QbEeuPuwV4kDp5YnVpPdsBMHZf2ExOu+OHQvrEkDNgvXATnhxziDoDg59fLNL80
         XDOWI+BUO89GvU1lKFqwpcQOj4SaLk0RDxPNHGIzM3/hmCFuftqcYCBYxRLB5E+yq9iC
         U4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AqmyodcHCWwqvdEgHev5icSZ5SOw1KXBs+XTKdSdY9M=;
        b=ki5OEg4NuES9YXKEfgDB8QF2O5haSt48eC+HYF72/bsSZV932pAHe2jb6cC1jpltkC
         C+XdvslJ+FtJuEpZqyqTcbfzuInejzREAAk4pabHimdPwoBlmDmshwwu8jbik77xABK0
         r3WBTQgM+NabtxVaGw3xPwcJAHMI4350WfXyNqPAWi/wRHQo/JbNiuAQIeUloR/iLdS5
         ixHjw2qgdFL9R2pHkFGgKoKlPCNHPnATuipc1xPcNoA5vLbnBJ3ez2S0qD7vxbFLRX0z
         Y6aszEbjrXotQcDpJBwKP1MOe1LLphVm/vhL9rnXEDSC/HX+M4213ZMG8Psrh7suWkLt
         1hdQ==
X-Gm-Message-State: AOAM533uFX8IuS4X1CBKYlFqd8iEGwStWz5qpmsSHa1AYn64NVnq4Pyb
        b0FaIK7foxxkA7fFRFKUvWoATljrIv6D3c181fMR
X-Google-Smtp-Source: ABdhPJy/VqxrPTaAmFMIERbRlSSwesTHoD/J2QAPDtMOCGzzeWkyhPciBiahWmc/izuLhK52+0mQTu/aUyjFtuxfxGGB
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7356:: with SMTP id
 o83mr25075335ybc.170.1614636202873; Mon, 01 Mar 2021 14:03:22 -0800 (PST)
Date:   Mon,  1 Mar 2021 14:03:19 -0800
In-Reply-To: <xmqq35xo7yzy.fsf@gitster.g>
Message-Id: <20210301220319.3426185-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq35xo7yzy.fsf@gitster.g>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v4] builtin/clone.c: add --reject-shallow option
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmx.de, lilinchao@oschina.cn,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This may reject to clone from a shallow repository, but at this
> point the bulk of the tranfer from the origin repository has already
> happened, no?  Rejecting after transferring many megabytes feels a
> bit too late.  That is one of the reasons why I kept hinting that
> the transport layer needs to be taught an option to reject talking
> to a shallow counterpart if we want to add this feature [*1*].

Extending the transport layer in this way might not be too difficult in
the case of native (SSH, git://) protocols and using protocol v0, since
handshake() in transport.c (called indirectly from
transport_get_remote_refs()) writes shallow information to a data
structure that we could potentially expose for the caller to use (before
it calls transport_fetch_refs(). I couldn't see how remote-using
protocols (e.g. HTTP) communicate shallow information, though
(remote-curl.c seems to just keep it for itself), so that will be a more
difficult task. And of course there's the matter of protocol v2, which I
discuss below.

> [Footnote]
> 
> *1* Looking at Documentation/technical/pack-protocol.txt, "git
>     fetch" seem to learn if the repository is shallow immediately
>     upon contacting "upload-pack" during the Reference Discovery
>     phase (we'd see 'shallow' packets if they are shallow). I
>     suspect that the right solution would be to teach the codepath
>     on the "git fetch" side that accepts, parses, and acts on this
>     packet to optionally stop communication and error out when the
>     caller asks not to talk with a shallow repository.

This is true with protocol v0, but protocol v2 bundles all shallow
information (whether coming from the fact that the remote is shallow or
the fact that the fetcher specified --depth etc.) and sends them
together with the packfile. It may be possible to stop packfile download
(saving bandwidth on the client side, at least) once such information is
returned, though.
