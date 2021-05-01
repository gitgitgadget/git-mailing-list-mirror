Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E47C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8FF613EC
	for <git@archiver.kernel.org>; Sat,  1 May 2021 09:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEAJO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 05:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAJO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 05:14:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D5C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 02:13:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so772477edu.10
        for <git@vger.kernel.org>; Sat, 01 May 2021 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kCB2ACd0ZCP8WAS2f/jGDM3LU8QYXzxHuiwU0X1k60k=;
        b=bBKVAnxFDbmrcX8kkdAGWOxtcxTJM7Yc6L9SZ8dEDA5ZKAaRNLH1sYWuTaCNPNXo0c
         YuqE0K22FyfMIWhF5Xda3ggfGbieUGl9CP+kTe4v/QnOYcXcW3W1LyDYqyTSJ1qFehNe
         VLqVEWjhfiie66JNj7iZMb9veuud0Vs/UZobXo2wnVLJXTPfy/tmk1dVSmJ6DeX/hKQ9
         SgBdyWoYRHIn9X9QRQN6GLuHT0a6LwhBDGfIpgRdV8NEivUra07LKijmg4+wY/2TCKUi
         UZGkhOWW4B14zDQf85hc4ciZl+P/fh/eZqv+lwx9RRsu+L52dGchGxJqIP5mcFnkl6BA
         4j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kCB2ACd0ZCP8WAS2f/jGDM3LU8QYXzxHuiwU0X1k60k=;
        b=k23M3uPEzSSOp2sVN89K8o780bCsqlU+ltiatoi6YV0EuOjv6aFI6iu28cVFlGpmUw
         4v0Z7sKWWwrFHAqLPR9jaCzlDNGHLtrYqtQVrwn7OKZO+dUmrVyaLoSqBO2Wni92cj1f
         tyIub37SWcPvmT+YORakNWwq/M20lZpElIlsQNHOXrQnBSVBAsjgFjZRNRppiaW3L7oL
         mRnBd2pOQT/t1mtVNlCtUCduk/gpOICIDs+fcBHNSpc2GTn9G+eHTOh6aTSnm2rUY64c
         LChxD/rhwhk1/8FrVujPRr7KEbvQCeA4gcMR3mHz+1LMuRY0h4iX1haGKmHft1STQ3YA
         nXkA==
X-Gm-Message-State: AOAM532ATichJyekuyaV9qVzbNwOctpRr75I4qEL2+Qy2/VYG4Eae/ur
        KgS4t1qiYfzJQDJWYdXL9lsaa1i0ORw=
X-Google-Smtp-Source: ABdhPJwXhg943Q60xnSpeM1XP9lbMfGDeUllIX6LtO14CwayrYYYELPtoZ2gVMAQFwZlrGyUL0IQpA==
X-Received: by 2002:a50:8a99:: with SMTP id j25mr10360484edj.253.1619860415287;
        Sat, 01 May 2021 02:13:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m2sm4804923edc.10.2021.05.01.02.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 02:13:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
Date:   Sat, 01 May 2021 10:52:09 +0200
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
Message-ID: <87czuayfy9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 30 2021, Derrick Stolee via GitGitGadget wrote:

Now for a comment on the direction...:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Git allows URLs of the following pattern:
>
>   https://username:password@domain/route
>
> These URLs are then parsed to pull out the username and password for use
> when authenticating with the URL. Git is careful to anonymize the URL in
> status messages with transport_anonymize_url(), but it stores the URL as
> plaintext in the .git/config file. The password may leak in other ways.
>
> This is not a recommended way to store credentials, especially
> authentication tokens that do more than simply allow access to a
> repository.
>
> Users should be aware that when they provide a URL in this form that
> they are not being incredibly secure. It is much better to use a

"Incredibly secure"? Security so good you wouldn't believe it if you saw
it ? :)

> credential manager to securely store passwords. Even better, some
> credential managers use more sophisticated authentication strategies
> including multi-factor authentication. This does not stop users from
> continuing to do this.
>
> Some Git hosting providers are working to completely drop
> username/password credential strategies, which will make URLs of this
> form stop working. However, that requires certain changes to credential
> managers that need to be released and sufficiently adopted before making
> such a server-side change.
>
> In the meantime, it might be helpful to alert users that they are doing
> something insecure with these URLs.
>
> Create a new config option, core.allowUsernamePasswordUrls, which is
> disabled by default. If Git attempts to parse a password from a URL in
> this form, it will die() if this config is not enabled. This affects a
> few test scripts, but enabling the config in those places is relatively
> simple.
>
> This will cause a significant change in behavior for users who rely upon
> this username:password pattern. The error message describes the config
> that they must enable to continue working with these URLs. This has a
> significant chance of breaking some automated workflows that use URLs in
> this fashion, but even those workflows would be better off using a
> different mechanism for credentials.

...

> I cannot understate the care in which we should consider this change.
> The impact of this change in a Git release could be significant. We
> should advertise this very clearly in the release notes.

Seems like something more for below-the-"---" than a commit
message. If/when it lands the "consider this change" has already
happened.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     Reject passwords in URLs
>     
>     I received multiple messages "alerting" me to the issue of users
>     supplying server-side tokens into the username:password field of a URL.
>     This is not a secure way to handle these tokens.
>     
>     On the one hand, this is user error: Users should not supply a token to
>     a location where they do not know what will happen to it. In Git's
>     defense, its behavior is completely open about storing the URL in the
>     .git/config file as a plain-text string and users should know that when
>     using this feature.
>     
>     However, users just. keep. doing it.
>     
>     There is some expectation that since this portion of the URL is a
>     password, then Git is responsible for tracking that password securely.
>     I'm not sure we should venture down that road, since we already have a
>     pretty good solution by using the credential helper interface.
>     
>     Here is my best effort to find a compromise here: start failing when
>     parsing a password from a URL like this, with a config option to
>     re-enable the existing behavior.
>     
>     I completely understand if this is too much of a breaking change. I
>     wonder if there is anything we can do to assist users into being more
>     careful with their secrets.

I think a good staring compromise would not be to make long-standing
supported behavior an error, but to use the advise() system to emit some
notice about this.

While I get what problem you're trying to solve in practice, I disagree
with the strong assertion that a user is "doing something insecure" by
definition by using such URLs.

If you trust your FS permissions, and as a local user, ultimately if you
didn't a credential manager wouldn't be much use anyway, and/or
use/don't care (e.g. closed network) about transport security then
having a password in your config is just fine, and doesn't otherwise
compromise security.

Unlike SSH this is a thing that the HTTP protocol supports, so I don't
think it's the place of git to go out of its way by default to break
working URL schemas by making hard breaking assumptions about the user's
workflow.

I think a much better way to address this issue, if it's an issue that
needs to be addressed, is on the server-side. The service operator is in
a much better position to know if URL passwords are a bad idea in their
case (e.g. is the software frequently used in certain ways, is there no
transport security, are we using debug URL tracing etc).

You allude to some of that in your commit message. "Some Git hosting
providers". Some? GitHub? In any case, to me that's further reason we
should hold off on such a change in git.git. Let the big hosting
providers experiment with this, and if e.g. they all decide to stop
supporting this and it therefore becomes less common practice we'll be
better informed about if/what to change in git.git.
