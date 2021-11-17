Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6CC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1FD61BA2
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhKQRyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbhKQRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 12:54:53 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8AEC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:51:54 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m11so3647122ilh.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tLl7YCD0Sx8Bgnb9WrIu1TsIJahW/uQYBaLrbSgNsRc=;
        b=ZPqNpPAH5wyUEUNLveGHZL4Anah83TryIIaubWIl0s/i2BTvd6O+B2qnASvEbaQ12g
         GxLAfdDzBrGuPiRSMPC4or8OWPRuar0tNcyAxcWajKlmr/B+dGGtMp7sPeJZtSptY1wk
         28f0TLoGXdbctyg3Z+ZkBTFccmK5gXb6qoqEbHHh/Lv1j012KiC8ChUCXFz+uVcc9l0h
         dP2BlNk3h8V5GqC3nX6p1sZyxIKySgRdQ7UNlyEDiKgN0wKWOHuHP0qXUVVbDuGK0agH
         Mm2t17CQFUu/2+cOzE+4BiTcb5x1AVovjpG0VieZmYCte+c8fbzXEno+63z27oPVsrlv
         Br0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tLl7YCD0Sx8Bgnb9WrIu1TsIJahW/uQYBaLrbSgNsRc=;
        b=lc3u6GdLUt/43eHeQX3F4J1I45hOV9DMgMGYTeUCl0YBhcYwhpFWTKi57eTrJ5fcpv
         IgNF/npoziGFaHzrVNWdM5ADkzbdxPTMWtOI+vNzJuYeFcAMcoaEK4ltdtsADqvjzvO3
         Riv0mXl1UG9BsxDsdb1xSLkhfA/l4O58m7EXpOKuNnlSm7OGjKE800hFVwZu5OY8KfYC
         kxy1ffx5VwdZRHmZZJnVn8q6IJ4rBfwwfe+T+qGlPQBfng5QsXgkvTBKsIJ+gJ/K5pyd
         4saMGfpFEb706ZAiIxd/jg8tkGjyLQfPWTBX1vsv2P09nNIGfYq3KTXW5jSsuc6ttSQ+
         4RMQ==
X-Gm-Message-State: AOAM532PxahgOLTeqK264FHyUYsfP6RudCcNYJzyPAnXxe2gEhl/ZG8F
        YM5N5NBX70SuZA9OS7EwNHuw0UkEYMtZoRQe
X-Google-Smtp-Source: ABdhPJywTliUAijKr8AgUkd0TnqdVw0hSpc5FnRKD2GDUNVfkOi/anwTo4SjPOi3XWyczs7T/imwbg==
X-Received: by 2002:a05:6e02:1706:: with SMTP id u6mr1160389ill.300.1637171514027;
        Wed, 17 Nov 2021 09:51:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f15sm379766ila.68.2021.11.17.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:51:53 -0800 (PST)
Date:   Wed, 17 Nov 2021 12:51:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: support non ssh-* keytypes
Message-ID: <YZVBODo2BgrXd8XK@nand.local>
References: <20211117162727.650857-1-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211117162727.650857-1-fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 05:27:27PM +0100, Fabian Stelzer wrote:
> The user.signingKey config for ssh signing supports either a path to a
> file containing the key or for the sake of convenience a literal string
> with the ssh public key. To differentiate between those two cases we
> check if the first few characters contain "ssh-" which is unlikely to be
> the start of a path. ssh supports other key types which are not prefixed
> with "ssh-" and will currently be treated as a file path and therefore
> fail to load. To remedy this we move the prefix check into its own
> function and add the other key types. "ssh -Q key" can be used to show a
> list of all supported types.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  gpg-interface.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 3e7255a2a9..dd1df9f4ee 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -707,6 +707,16 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  	return 0;
>  }
>
> +/* Determines wether key contains a literal ssh key or a path to a file */

Nit: s/wether/whether.

I had to re-read this comment before I realized that the "or a path to a
file" isn't checked by this function, but is what we assume to be true
if this function returns 0.

So I don't think anything you wrote there is wrong, but it may be
clearer to just say "Returns 1 if `key` contains a literal SSH
key, 0 otherwise."

> +static int is_literal_ssh_key(const char *key) {
> +	return (
> +		starts_with(key, "ssh-") ||
> +		starts_with(key, "ecdsa-") ||
> +		starts_with(key, "sk-ssh-") ||
> +		starts_with(key, "sk-ecdsa-")
> +	);
> +}

The outer-most parenthesis are unnecessary, but help with line wrapping.
Equally OK would have been:

    return starts_with(...) ||
      starts_with(...) ||

and so on, but it doesn't matter much one way or the other.

> +
>  static char *get_ssh_key_fingerprint(const char *signing_key)
>  {
>  	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
> @@ -719,7 +729,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
>  	 * With SSH Signing this can contain a filename or a public key
>  	 * For textual representation we usually want a fingerprint
>  	 */
> -	if (starts_with(signing_key, "ssh-")) {
> +	if (is_literal_ssh_key(signing_key)) {

This (and all other replacements) are straightforward and exhaustive. It
would be nice to see an additional test confirming that we treat, for
e.g., literal ECDSA keys correctly.

Thanks,
Taylor
