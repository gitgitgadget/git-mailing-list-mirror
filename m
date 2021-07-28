Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 23:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F436101B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 23:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhG1XE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhG1XE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 19:04:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE337C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 16:04:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id p1-20020a17090a3481b029017757e8c762so1688555pjb.1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oJTbDEmURVlwSoQ9k8O9zcru7EnjbhohbvZekdpz6fE=;
        b=GXb2B4WBaIoopyxhNVnwPvjRLeeO9+EYIXEmT9mY1ZqXfpo/fj+ZxUI7rVK9ncSgjt
         GKENolfmNeJGWZfEYOkMMHowKXMgCxNqI6db9CrwzzyzpTL0wAXYs8qq587232hdxStT
         28bqQUy7j5u6xh0pGYGonPdoIj9knA/bmvTi9/3HC7tQ3lJFx2++xp67sifoxod92i9+
         usCZXSOmwIkBwP9fkTFbhqxFlIeb+MPJDPeJJm551nF7ycdS5azH/1ABDMbTl76PLLMd
         iHENDvmnGJDs0zKBypivVwjGPt/bHMXao8uJkY7VOv0sQyBGcacHa5qBkayaWM3vzxZ2
         nUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oJTbDEmURVlwSoQ9k8O9zcru7EnjbhohbvZekdpz6fE=;
        b=eW09irCARU0ny9EJ4pO03AeC2n++f/mfNNH3Xk1ooz+gWrFvxqVfJBBFqtYj0PyR9S
         ImIP1OVMU/aSauH2Nj96tOXIDktkJ9Et9eKmeRjoM5sfgs9W1RxLgC1cwoj12fUeyjvx
         54IYsbqHq6tltoxknAYV1H+UCV2oglH0tIWZpk0E7nIpXpTP9JfHHSYdE+aMCn8moyAl
         FZXkWFUV3tRtvDKv0z9dW1miiJTeui+H/CuhnjnjzkLjh7hCQY3eIg6wBXLJbLAO3pJQ
         4xIbUszNFYxKjE0o6L7SY5K9NsG9iecGw2i8NanawZsxQMTms9krcqEtgnJ3+LtkTlmo
         HK2w==
X-Gm-Message-State: AOAM533MzPnK4AozEBs1Dh3DajnBZRnHdOtyxMCaeohYtZ+224tX6e1Y
        QZ8cj2MRR0TjYtFKts+030A39EUqQ31RAb41HGRK
X-Google-Smtp-Source: ABdhPJwJ56P8pSawByFfLj/u2ADavU+5JQL942xCxxHFg4g78Q49Xn4bpEpIO84KoRefoSINni9rET0H6vZwghwdeiRj
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:cd47:0:b029:329:714e:cce2 with
 SMTP id o68-20020a62cd470000b0290329714ecce2mr2124783pfg.22.1627513494184;
 Wed, 28 Jul 2021 16:04:54 -0700 (PDT)
Date:   Wed, 28 Jul 2021 16:04:52 -0700
In-Reply-To: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
Message-Id: <20210728230452.2719333-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify signatures
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, fs@gigacodes.de,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> to verify a ssh signature we first call ssh-keygen -Y find-principal to
> look up the signing principal by their public key from the
> allowedSignersFile. If the key is found then we do a verify. Otherwise
> we only validate the signature but can not verify the signers identity.

Is this the same behavior as GPG signing in Git?

> Verification uses the gpg.ssh.allowedSignersFile (see ssh-keygen(1) "ALLOWED
> SIGNERS") which contains valid public keys and a principal (usually
> user@domain). Depending on the environment this file can be managed by
> the individual developer or for example generated by the central
> repository server from known ssh keys with push access. If the
> repository only allows signed commits / pushes then the file can even be
> stored inside it.

Storing the allowedSignersFile in the repo is technically possible even
if the repository does not allow signed commits/pushes, right? I would
reword the last sentence as "This file is usually stored outside the
repository, but if the repository only allows signed commits/pushes, the
user might choose to store it in the repository".

> Using SSH CA Keys with these files is also possible. Add
> "cert-authority" as key option between the principal and the key to mark
> it as a CA and all keys signed by it as valid for this CA.

Is this functionality provided by SSH? I don't see "cert-authority"
anywhere in the diff below.

Also, I notice that the tests are all provided at the end. I think that
it would be better for the tests to be incrementally provided along with
the commit that introduces the relevant functionality, so it is clearer
to the reviewers how it is supposed to work (and also for us to observe
test coverage).

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index a34742513ac..62b11c5f3a4 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -131,6 +131,8 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  {
>  	int status = parse_hide_refs_config(var, value, "receive");
>  
> +	git_gpg_config(var, value, NULL);
> +
>  	if (status)
>  		return status;

Check the return value of git_gpg_config() to see if that config was
processed by that function - if yes, we can return early.

> +static void parse_ssh_output(struct signature_check *sigc)
> +{
> +	const char *line, *principal, *search;
> +
> +	/*
> +	 * ssh-keysign output should be:
> +	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
> +	 * Good "git" signature for PRINCIPAL WITH WHITESPACE with RSA key SHA256:FINGERPRINT
> +	 * or for valid but unknown keys:
> +	 * Good "git" signature with RSA key SHA256:FINGERPRINT
> +	 */

Is this "ssh-keysign" or "ssh-keygen" output?

Also, is this output documented to be stable even across locales?

> +	sigc->result = 'B';
> +	sigc->trust_level = TRUST_NEVER;

A discussion of trust levels should also be in the commit message or
user documentation.

> +	if (!strcmp(var, "gpg.ssh.revocationFile")) {

The "F" in "revocationFile" has to be lowercase. (If tests were
included, as I suggested above, it might have been easier to catch
this.)
