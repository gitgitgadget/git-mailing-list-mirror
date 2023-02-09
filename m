Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED853C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 23:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBIXF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 18:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBIXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 18:05:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D505EBE3
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 15:05:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 141so2637910pgc.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 15:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5GxIuRLnGfghHM/Yaigj7aShtoa7Ir4FsscU6VmGIc=;
        b=pGGdAOo4N2xDOaMnTZ4dUSY1rF8e63/g3urUwlC6Q/c8Fhc4i7T6cmyKWVJjnDb9dq
         PJprWy/5SrmJnw4GKHhGno+MpW6HaKT5gw+BfuR/nJJ3UY9tbyvFezPw9vOGDXxe9LsK
         JGygA6FLgX3z0ghQEysvlLncS3D1jn68hnQJ+VmPP/wXXLthiaXrBAre1VrkPXvxH2K1
         SaEfdVqgfVgdpHxQg3X6XiVaqj5naOvZRWs4FWw4Vx7loYqcI0Ql+Y36yFfuECTNSPxY
         ieqFoYEql/SB3+U7NrUciLuQhYq8LzMhywAt7LgRGoYagTwD+W9A3idVN2A+3Kp6U0k1
         /gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f5GxIuRLnGfghHM/Yaigj7aShtoa7Ir4FsscU6VmGIc=;
        b=auefKXAzgV7dSWqTJTAGLNU3DMq+Q5BM6P07Qdi0aVbz5cgWSxPn5j2ch3r/JmBRrl
         Cy2PeJiLwtI5qi3wJ2EaFnX0TKy+Gvr93VgIMajXlTgCTjpgZJyT/E7OL5atTcn1x3Y3
         HOUx+h3s+rNVUa6HM4SsO73NvCJyp+veOiwqa2S5vKkYHlm63L3eNFZTnV0o1ZlWS+RM
         wnBdM7xi28Hlys9eVVAc5XKLi46af5jHG0KNNGAYNQNJUF3+6x1yp2meq7yHYm2kt4wu
         bA+iA0otyJ9Daib/F/cPcASXzoTpo21UQ+s0MCSW3vR1lvh95U+SZxDb4T/9GE8H6s65
         40Eg==
X-Gm-Message-State: AO0yUKUn0wm2dYJ2rxlSOf4wqUqgEqdgZ52cDAftTEl5e3pKFe0orqsu
        V3CNT3/tqQFZ9R32B9qMHA0=
X-Google-Smtp-Source: AK7set/CDjc+68O2O6Q8cLMO/5nzjeovxjQvSDb5xPhGardUcUvpdsXlTGsP8cF45Jzpa86wUG/eww==
X-Received: by 2002:aa7:9edc:0:b0:5a8:4eef:4dc5 with SMTP id r28-20020aa79edc000000b005a84eef4dc5mr4457142pfq.10.1675983920966;
        Thu, 09 Feb 2023 15:05:20 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79399000000b0058bba6f06c5sm1978149pfe.8.2023.02.09.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:05:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Abrecht <git-git@nodmarc.danielabrecht.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] gitweb: fix base url set if PATH_INFO is used, add a
 / at the end
References: <20230209222648.z-sqdvWiK7xa-NLagt3B_X_4bFQJBsA8cA06YvgXqWQ@z>
Date:   Thu, 09 Feb 2023 15:05:20 -0800
In-Reply-To: <20230209222648.z-sqdvWiK7xa-NLagt3B_X_4bFQJBsA8cA06YvgXqWQ@z>
        (Daniel Abrecht's message of "Thu, 09 Feb 2023 23:26:48 +0100")
Message-ID: <xmqqfsbel9sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Abrecht <git-git@nodmarc.danielabrecht.ch> writes:

> In HTML, if there is a base tag like `<base href="/a/b">`, a relative
> URL like
> `c/d` will be resolved by the browser as `a/c/d` and not as
> `a/b/c/d`. But with
> a base tag like `<base href="/a/b/">` it will result in `a/b/c/d`.
>
> Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
> ---
>  gitweb/gitweb.perl | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e66eb3d9ba..edcee1652c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -74,6 +74,11 @@ sub evaluate_uri {
>  		}
>  	}
>
> +	# $base_url is later used in the <base> tag as a URL, if it
> doesn't end in a /

It seems an overlog line was wrapped around and broke the patch.

> +	# the browser will strip away the last component for relative URLs.
> +	# Add the / if it's missing.

The above is not an incorrect statement per-se, but if $base were
pointing at the document, we would likely break if we add an extra
slash.  Don't we want to say something like 

	# $base_url at this point points at a directory, not a
        # single document, and later is used in the <base> tag.
        # Make sure it ends in a '/'.  Otherwise, we'd lose the last
        # component when forming a relative URL.

perhaps?

> +	$base_url .= '/' if not $base_url =~ /\/$/;
> +
>  	# target of the home link on top of all pages
>  	our $home_link = $my_uri || "/";
>  }
