Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E311F597
	for <e@80x24.org>; Fri,  3 Aug 2018 21:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeHCXbc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 19:31:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41378 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeHCXbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 19:31:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so1504305ywg.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 14:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okk9u4ASbzPY7WandciKwWOmK3wGDbVZ7ASTgtdYnrI=;
        b=GN6V9Fm+ZQ00at8eeXgiR0UoWbrVFMbXX22jEQWfhc07KwKnKZXqCTQxEqP+iJOM0M
         X9e2lSEv6Ze2E54YeTy70Cv8G7y7biRFoz0+yoTu36AVUu5kvs5qqot1qR8Dw65WvEL9
         BA36aKrhPnjFdqH92dWHKk0LWSbPKDNtfzBEcHlbxMnuSMv7vSCkgGbq02VSv0meZ7N4
         LUPiW3UlN3ilNVM88En6UVsFwRbNhvLpXkNw6YoQxmWV9+E3XhK0T/73QCGmehacIxeG
         hAWaS0xf+UKYYW6QpKPysTssot2wtNt0G3RfOfNb9NrJ3Uue19ng4Wbzybg88781UHlO
         BnNg==
X-Gm-Message-State: AOUpUlEfS4d7Xh2yl5z4tVR1syYAMDiG1FXbRLV9q1T+YQh3m1REtrSd
        gGJI30wTp+3TYak/AHs7PbWIV2kUIutoKkWmPYkJEwbl
X-Google-Smtp-Source: AAOMgpeyjrGLZ4UxwQZTTGjZgvE/qtb2fwBRiSq427I79ookW/gHhPfbL6EM63kay0BSF6ePqS0vmqnygwmYQUZgL58=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr3167553ywk.418.1533332009166;
 Fri, 03 Aug 2018 14:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180803205204.GA3790@sigill.intra.peff.net>
In-Reply-To: <20180803205204.GA3790@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 17:33:17 -0400
Message-ID: <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 4:52 PM Jeff King <peff@peff.net> wrote:
> [...]
> Let's provide a script that builds and installs the manpages
> for two commits, renders the results using "man", and diffs
> the result. Since this is time-consuming, we'll also do our
> best to avoid repeated work, keeping intermediate results
> between runs.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> @@ -0,0 +1,100 @@
> +OPTIONS_SPEC="\
> +doc-diff <from> <to> [-- diff options]

Should this be?

    doc-diff [<options>] <from> <to> [-- <diff-options>]

> +--
> +j      parallel argument to pass to make
> +f      force rebuild; do not rely on cached results
> +"

Should "j" and "f" be "-j" and "-f", respectively?

> +while test $# -gt 0
> +do
> +       case "$1" in
> +       -j)
> +               parallel=${1#-j} ;;
> +       -f)
> +               force=t ;;
> +       --)
> +               shift; break ;;
> +       *)
> +               usage ;;

There doesn't seem to a usage() function defined anywhere (and
OPTIONS_SPEC doesn't seem to be used).

> +       esac
> +       shift
> +done
> +# We'll do both builds in a single worktree, which lets make reuse
> +# results that don't differ between the two trees.

"which lets make reuse"?
