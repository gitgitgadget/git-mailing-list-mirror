Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3368A20193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755446AbcKBWlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:41:05 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33199 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbcKBWlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:41:04 -0400
Received: by mail-qk0-f170.google.com with SMTP id x190so34806115qkb.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UQdbdtNQaNNViwSdXfHijNLv7LRSGMFlJvdMsjE526s=;
        b=Pbw/8en/cpEQhzMi0g9gooELGIwq6oGFm1Zn84tOcozx4D4MS6sSCULtX2R+Wj4Fjy
         +FbI3MS3dXpyFoZwRjjQp/LSr8uMs1uU6gHrImKF/dThFucXrRnzinCp3b/VzorDdRXW
         kZao9Y2VC94S9R18H2nt4omHofrpQWUvKVG/lTGcrl3nsZTRrwqfrTmPaJ/Su020VaCz
         fNN3scETnCIhLvkws8CanO4tguk5OOo98aIyd9JhvlZIxwrh392VMGXuNpC8EiT6xj4Z
         lVTbsCBL5nJHUN9XtG80MSTanRIbl11dbsgx2ZLBmcu6L32K+EWK24Fhqt2RC3dyfokR
         +1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UQdbdtNQaNNViwSdXfHijNLv7LRSGMFlJvdMsjE526s=;
        b=KHhzBLQLarjFNs0//WEwVeOKR5y9G+KatA5fcoqayPLOMw9W2StISOrrIaQYJYLh1c
         yFpWlFvc2bnM5H8hvQ0p7mc+6smm3DqZD4WcSSKG2X5i8YWT9RovJpUGyVFsLxtKnfdo
         TA+m6TrPLjS2FetR62ScFZJH7ZfW8AmYxsNZ7GBrfakjrVNv1JD7X6Al5ov+SKnt+Rpe
         iAunLg1PbAhxXzpRnIeb7oDD0Q7qvLs/6Gm1UlYgDR1uhKPeUvthuLdxEk1KlWVCsSBQ
         vcq35YAOgjwRmXDsPFnQ1H2ra60QxsVSM+vVGvLFm6MxpR08TmZPLrczC0Zm+/Ir83Nv
         WG0Q==
X-Gm-Message-State: ABUngvca2MUM302IgSwxL5jOjcWE7u6o+FMoJvrcrnzDn02JnW3bWOD9IvOw1CEs44n8MCYon+cmzA3vyKHmUaFV
X-Received: by 10.55.20.164 with SMTP id 36mr5016407qku.86.1478126463258; Wed,
 02 Nov 2016 15:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Wed, 2 Nov 2016 15:41:02 -0700 (PDT)
In-Reply-To: <1478125247-62372-1-git-send-email-bmwill@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Nov 2016 15:41:02 -0700
Message-ID: <CAGZ79kbytopD1UgvU6R0X18Ge6JsJ46K2KQ-SFLh+hu5tprTmA@mail.gmail.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2016 at 3:20 PM, Brandon Williams <bmwill@google.com> wrote:
> Add configuration option 'core.allowProtocol' to allow users to create a
> whitelist of allowed protocols for fetch/push/clone in their gitconfig.
>
> For git-submodule.sh, fallback to default whitelist only if the user
> hasn't explicitly set `GIT_ALLOW_PROTOCOL` or doesn't have a whitelist
> in their gitconfig.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 9 +++++++++
>  git-submodule.sh         | 3 ++-
>  transport.c              | 2 +-
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 27069ac..7f83e40 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -455,6 +455,15 @@ core.sshCommand::
>         the `GIT_SSH_COMMAND` environment variable and is overridden
>         when the environment variable is set.
>
> +core.allowProtocol::
> +       Provide a colon-separated list of protocols which are allowed to be
> +       used with fetch/push/clone.

ok.

> This is useful to restrict recursive
> +       submodule initialization from an untrusted repository.

ok. Though as a user submodules may not spring to mind immediately here.
I think this is generally useful, too. e.g. an admin could put this in
the system wide
config to prevent certain protocols from being used.

> Any protocol not
> +       mentioned will be disallowed

For the regular fetch/clone/pull case. For the submodule case we still
fall back to
the hardcoded list of known good things?

> (i.e., this is a whitelist, not a
> +       blacklist).

That is very explicit, I'd drop it. However this inspires bike
shedding on the name:
What about core.protocolWhitelist instead?

>  If the variable is not set at all, all protocols are
> +       enabled. If the `GIT_ALLOW_PROTOCOL` enviornment variable is set, it is
> +       used as the protocol whitelist instead of this config option.

So the env var is of higher priority than this config.

> +
>  core.ignoreStat::
>         If true, Git will avoid using lstat() calls to detect if files have
>         changed by setting the "assume-unchanged" bit for those tracked files
> diff --git a/git-submodule.sh b/git-submodule.sh
> index a024a13..ad94c75 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -27,7 +27,8 @@ cd_to_toplevel
>  #
>  # If the user has already specified a set of allowed protocols,
>  # we assume they know what they're doing and use that instead.
> -: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
> +config_whitelist=$(git config core.allowProtocol)

So first we lookup the configured protocols.

> +: ${GIT_ALLOW_PROTOCOL=${config_whitelist:-file:git:http:https:ssh}}

Then if they are not configured use the current hard coded white list.

>  export GIT_ALLOW_PROTOCOL
>
>  command=
> diff --git a/transport.c b/transport.c
> index d57e8de..b1098cd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -652,7 +652,7 @@ static const struct string_list *protocol_whitelist(void)
>
>         if (enabled < 0) {
>                 const char *v = getenv("GIT_ALLOW_PROTOCOL");
> -               if (v) {
> +               if (v || !git_config_get_value("core.allowProtocol", &v)) {

This implementation matches what the config promised, I would think.

Do we have any tests for this that could be extended? (Otherwise we'd
maybe want to add a test for both the regular case as well as a forbidden
submodule?)


>                         string_list_split(&allowed, v, ':', -1);
>                         string_list_sort(&allowed);
>                         enabled = 1;
> --
> 2.8.0.rc3.226.g39d4020
>
