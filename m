Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF8C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3880461352
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEJGey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJGey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 02:34:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA529C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 23:33:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l13so15288103wru.11
        for <git@vger.kernel.org>; Sun, 09 May 2021 23:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7HXzi6Dy7sACqV3KF3I8WfvxguJRnmBvAZ7zRxGXs5Y=;
        b=M02cZiMQPJA7mh1FN5VxBM2srsFNTSx177iILIH6ACmocNNhIaHHi5oOswWNNb4pn5
         p2QGbyA4/zFJm5cLdRswQjUfTZC6NHuKjHOymoDDPPDmqX+Ge7E1+sQlsp0asu5EwgJV
         zfkV0ysdCIbAZav0y2Kr32w0l4GQG6Gq+k5CLt2dXEkLaDavc5sqzmyTIJngU7yJFf5i
         h2j5dt3om6yODDrv2Afx4Ux7r+oyD+GTa9vEqmn8X13paAq/H1ngcB0o/F2Sr00QZp3E
         oTQWYk3CDmtGI9QpFTXWbIvG9akWj7fSyvKVOozIxJ21QCfzKWMlXT/m+11jiDVcanZj
         AyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7HXzi6Dy7sACqV3KF3I8WfvxguJRnmBvAZ7zRxGXs5Y=;
        b=kJoXzsXjQO0wE+BxG9gu0XG9z9hBnb+3v40lur3eEEFgPj1ani/DD22ZbEisJib/Rt
         g+Z8301SS8Ag3Sq5FV9RgvgKZKPlSzcFEiSZvFzqUzZwewl862n0r4u+qeEUN37FygV4
         HgUaU66ES1d+ve+qUdU94/t0kyDcxx4ncbKEtiMJ5ZFwNmn48B1w1GltcfBPKokWt8Wr
         ZhDNl7VMxrqUbmK1J8+shGVbwU/tp13XtKS0ziFOBbb8f7TZBLhBevfWNKO5Ub6ML+lb
         xBSBq9qjvF1nVI4pvZnll/sjqCrzDmBEZKx5GOfAhPp/w1qwDw0kuexmcmAQOyGTzkwA
         xsjw==
X-Gm-Message-State: AOAM530NtgjG0PN8sxn/b6/+O9tO0jBjwTuOCCxITC1YgSKO0dtuPnC4
        9Bg7PqDPjvcqLv5NImMjnjui6/mtx33yQ+0HpODzfh3QIiA=
X-Google-Smtp-Source: ABdhPJzHgakpmQ8moUOWeX7DkCQQvJOkQf7QA0/9vj46sPWPaL296ObDZ1V5ElvS0Z/fE+Xd/7E2vi/eOD2y3U+xggk=
X-Received: by 2002:a5d:690c:: with SMTP id t12mr18714218wru.292.1620628427339;
 Sun, 09 May 2021 23:33:47 -0700 (PDT)
MIME-Version: 1.0
From:   Thijs Cramer <thijs.cramer@gmail.com>
Date:   Mon, 10 May 2021 08:33:38 +0200
Message-ID: <CAKWuzOrga4eqXhrw11xMsxJCVAPJRTTa7FncNYW5PE5QXCwAJw@mail.gmail.com>
Subject: git-credential-cache inner workings
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During debugging of a nasty recurring GIT code 128 error in our CI/CD
environment, we've found some design choices that have raised some
questions about the inner workings of the credential cache in GIT.
First, a little sketch of the situation.

We are using GitHub Enterprise Cloud on Jenkins using the Github
Branch Source Plugin.
This plugin uses "GitHub Apps" (Service Accounts if you will), which
use Application (Installation) Tokens to authenticate with GitHub. The
tokens are used as regular passwords in this case.

When a Jenkins job starts, it checks out the code from GitHub using
the GIT command line, passing it a token with a lifetime between 45
and 60 minutes remaining (tokens have a max lifetime of 60m). This
token is passed via the GIT_ASKPASS variable to give the commandline
CI/CD job the ability to use the token for subsequent GIT actions
locally during the job.

We are seeing GIT code 128's in rare cases when jobs follow each other
up at a fairly high tempo. The reason is:
https://github.com/git/git/blob/master/http.c#L1637 . This line
'approves' a credential that gives a successful result. This means
that Tokens that have been cached in the git-credential-cache-daemon
will have it's timeout refreshed even though they might expire
shortly.
The credential cache timeout is a user-input timeout, and not a token
timeout, and this structure collides with the functional lifetime of a
token.

There are several solutions to circumvent this issue:
1) We could ask the Plugin that manages the tokens to support managing
the Credential Cache as well. This makes it possible for the plugin to
actively manage tokens and revoke tokens from the cache that have
expired. Downside is that making plugins aware of the cache in git,
might not be a good idea, and there might even be cases where caching
is disabled completely, which would still require the ASKPASS method.
2) We could add an option to the GIT client that has the same
functionality as the ASKPASS variable, but one that takes precedence
before the cache. This way, one can preseed the GIT client with
credentials that will *always* be used, even if there is a cache that
has a credential for the given URL.
3) We could alter the cache daemon (or build a new one) that has more
elaborate options regarding it's timeout. Perhaps a daemon option like
"--keep-timeout-on-approve".
This would mean that if a credential is approved for a second time the
timeout is not refreshed.
Currently the daemon just removes any old credentials from it's cache
and adds the new one without questioning the intention of the user. We
could add a check that tests if the incoming credential is equal to
the currently cached credential, and skip updating the expiration date
if they are the same. (With an exception when receiving a new
password, then we should forcefully update). This means that the
--timeout option from the daemon will become a 'hard' timeout, instead
of a user-action timeout. Of course this should be done with a command
line option on the daemon to not change the default behaviour.

My C is a bit rusty, but I can help with adding one of the features, I
would just like to know some of your thoughts on this issue.

Thanks a lot,

- Thijs
