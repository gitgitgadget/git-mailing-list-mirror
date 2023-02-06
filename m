Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A3AC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBFWCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFWCM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:02:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE09F10A8C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:02:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d2so9336311pjd.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ll+PsZaYkeCWUxN58bQnaag+P61LXG4MoobactOKgo=;
        b=Tzj5V0IdqnZ70f07eQoWYFHJGYzlAbZTPGvjWuINtM+Nq1LHkPpqXf/J0Z7791M3iw
         5QCQeJzFl3zncBEt4QHqudAdCynPyOM9xyP0h7mN5aYYcgL2ZIqi+AN05kkH41p5ZEfV
         XR35NLvzhy//rVa4Et+v2kQ0KEh+nLeSUy3aF7ko1bZG+lWviH6ZTx7uFwe5lM132C/a
         gj5nyEQAXmUT6FhO9Jt9i5gba8vyT+VoVyWTj6+3NxO28ZLqBH3Um7IVUlSwVyyfxGaP
         MwiRQivjLgUNUGvOANV9WXBnkaJMXMktHasYEcptZLLLWSnGr4S3ylxzeb0LyQzuTj3l
         PBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ll+PsZaYkeCWUxN58bQnaag+P61LXG4MoobactOKgo=;
        b=cGHZLkDYAR1bTvCq7KeE27Tz2S6TMYwMKiQE6suakLE7brSWlPb/bAmGK4dFiGVh4C
         m4mLC4JpJYLaI9VS4JwNm5oJ8E7M2d4P9iF8EL9OFNVUwTayTpAVOgJGcbMgk+sQ403e
         XXAN2s/NkO13HSwvPGlS/VWLH8PYU93Ly8uQIVjqTgK9CuV8s1hM5GJd6avUTlfiI6Es
         p5WQrVFluKlBIs+IrU98rb1tZBivtljQfGvKRwtyR/F5gbD44Z60H/6FrgqI7bmGrjWs
         VVJ9Cup6xvldLeHPW+ZQWen4EuCqLqcAzZAt4GPHrR8nvJVzQG6A8x4TmCkj71N+J89q
         WacA==
X-Gm-Message-State: AO0yUKWPzMDHzjzC5rQNrlFe5S+PeMZhlo/k2Hlc7vB/cFLtEj8gpHVC
        8wRBjGwX4iyrS0YFI6ut2YWjAI4BsgU=
X-Google-Smtp-Source: AK7set9JbpewEAscVj7NijpHub7dzA7p3SKOiNi3hMq7XqiHGFqSYRI1Z14tFDQ/LXl+JefLDM+Vkg==
X-Received: by 2002:a17:902:e548:b0:199:1c4e:7681 with SMTP id n8-20020a170902e54800b001991c4e7681mr373136plf.52.1675720930196;
        Mon, 06 Feb 2023 14:02:10 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b00186a2dd3ffdsm7387225plc.15.2023.02.06.14.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:02:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Abrecht <git-git@nodmarc.danielabrecht.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitweb: fix base url set if PATH_INFO is used, add a /
 at the end.
References: <585496b18c853140144c3e7ae13c0124@abrecht.li>
Date:   Mon, 06 Feb 2023 14:02:09 -0800
In-Reply-To: <585496b18c853140144c3e7ae13c0124@abrecht.li> (Daniel Abrecht's
        message of "Fri, 03 Feb 2023 22:42:13 +0100")
Message-ID: <xmqqsffi4fmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Abrecht <git-git@nodmarc.danielabrecht.ch> writes:

> In HTML, if there is a base tag like `<base href="/a/b">`,
> a relative URL like `c/d` will be resolved by the browser as
> `a/c/d` and not as `a/b/c/d`. But with a base tag like
> `<base href="/a/b/">` it will result in `a/b/c/d`. So by
> adding a slash there, the browser should now search the
> files at the correct location.
>
> Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e66eb3d9ba..acb2cce5f6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4217,7 +4217,7 @@ sub git_header_html {
>  	# the stylesheet, favicon etc urls won't work correctly with path_info
>  	# unless we set the appropriate base URL
>  	if ($ENV{'PATH_INFO'}) {
> -		print "<base href=\"".esc_url($base_url)."\" />\n";
> +		print "<base href=\"".esc_url($base_url)."/\" />\n";

Doesn't this need to be somewhat conditional?  Sites like repo.or.cz
currently give <base href="/" /> presumably because $base_url for
them is '/', and this change will make them show double slashes
instead of a single one, no?
