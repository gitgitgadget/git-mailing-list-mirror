Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB82C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178A24655
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqVGHKmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfLEKTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:19:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38733 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLEKTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 05:19:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so1401820pfc.5
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RGCEb+Lzf3pN8xOLqXhQajap0oKPpD4FKPdFigkcSaY=;
        b=bqVGHKmt2oLMVLmRAKbMqv/VvS2gyTFc9BTHqDXOlUvv8NZwFQuskRZuBLJlagCzMP
         SVXG/Byy4bxqkh6VQ6TnlYJb1/IZchk/alQUZUDustei39VFy7kxWHEW2gE6Lm2WNW1V
         RzT/PoSXHsEAFtEdPTGenIr++taricVwSqL4VWpPN8qeEe5aiw+rnpJhQ7O49h/2hGyo
         bMYSxEAxDnRKP26nt5N1/+X+RLlz5iWKiFgnLmdOKD6hhJ1bXP9L23Yog8ooUAoVvhiv
         Vm2Ye4iVTaMljX0+LT7FHNLAzkefasfIqa0nJQ34pkfISeqQz9aaMFfYk9Wm1+/jwn1w
         dcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RGCEb+Lzf3pN8xOLqXhQajap0oKPpD4FKPdFigkcSaY=;
        b=hMC+g3oNlZhjv4/GWTUDFnFLWVypzGrDEu8khvEmcvQzz68W4u/8km7k8jRwVch5Ae
         hE2njZca7S3H10PJyzqQpTeKcg2c5Tnj4OcGKexujpEmPjSkkUI6xElNC0Aed48XAIfG
         tDCrCTE+5ddVh1o4Oj1p7lAB0t0as7IJRYxIwnNn/vl50B6IOmJ52dkM430U/sRBt8ty
         xTPLS0T0r5cDJ905VTqFeTUexqMpI82Z65l/urCkTQjGr5RTnySHzxDsk2gCqDwVC1C/
         +ucrMqVuiqLVKJUOgzZq/uVbNX0ddkQRoQ251bLCTOzEaL9l4x8eWymUUfkrB257syd8
         VVHw==
X-Gm-Message-State: APjAAAVtIBhqGc17ka9K5dZxLuwUso1dmmdx8MlDUlqFqOSSbgPM7r/d
        wYlacrl/vcuUOLtcDhiAiX4=
X-Google-Smtp-Source: APXvYqyC+Uvey9obx/KrK9KGjOO+dQasXZzYw7WS4lFRXteZKcTXdv2K+8lriSyN826s4DNrUxPAHw==
X-Received: by 2002:a65:530d:: with SMTP id m13mr64231pgq.351.1575541178416;
        Thu, 05 Dec 2019 02:19:38 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id d13sm4307718pjx.21.2019.12.05.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 02:19:37 -0800 (PST)
Date:   Thu, 5 Dec 2019 02:19:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/11] git-p4: select p4 binary by operating-system
Message-ID: <20191205101935.GA315203@generichostname>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <40124269933691796ef57fd8df50f9e740d103b1.1575498577.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40124269933691796ef57fd8df50f9e740d103b1.1575498577.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

First of all, as a note to you and possibly others, I don't have much
(read: any) experience with git-p4. I do have experience with Python and
how git.git generally does things so I'll be reviewing from that
perspective.

On Wed, Dec 04, 2019 at 10:29:27PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> Depending on the version of GIT and Python installed, the perforce program (p4) may not resolve on Windows without the program extension.

Nit: "GIT" should be written as "Git" when referring to the whole
project and "git" when referring to the command. Never in all-caps.

Also, please wrap your paragraphs at 72 characters. I'll say it once
here but it applies to your whole series.

> 
> Check the operating system (platform.system) and if it is reporting that it is Windows, use the full filename of "p4.exe" instead of "p4"
> 
> The original code unconditionally used "p4" as the binary filename.

As a rule of thumb, we want to state the problem first before we state
what we did (and why). I'd move this paragraph up.

> 
> This change is Python2 and Python3 compatible.
> 
> Thanks to: Junio C Hamano <gitster@pobox.com> and  Denton Liu <liu.denton@gmail.com> for patiently explaining proper format for my submissions.

I appreciate the credit but I don't think it's necessary. At _most_, you
could include the

	Helped-by: Junio C Hamano <gitster@pobox.com>
	Helped-by: Denton Liu <liu.denton@gmail.com>

tags before your signoff but I don't think we've done anything to
warrant it.

> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit 9a3a5c4e6d29dbef670072a9605c7a82b3729434)

You should remove this line in all of your commits. The referenced
commit isn't public so the information isn't very useful. Also, try to
not include anything after your signoff so if this hypothetically were
useful information, you'd include it before your signoff.

If it's information that's ephemerally useful for current reviewers but
not for future readers of your commit in the log message, you can
include it after the three hyphens...

> ---
like this and it won't be included as part of the log message.

>  git-p4.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..b2ffbc057b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -75,7 +75,11 @@ def p4_build_cmd(cmd):
>      location. It means that hooking into the environment, or other configuration
>      can be done more easily.
>      """
> -    real_cmd = ["p4"]
> +    # Look for the P4 binary

I don't think this comment is necessary as the code itself is pretty
self-explanatory.

> +    if (platform.system() == "Windows"):
> +        real_cmd = ["p4.exe"]    

You have trailing whitespace here. Try to run `git diff --check` before
committing to ensure that you have no whitespace errors.

Thanks,

Denton

> +    else:
> +        real_cmd = ["p4"]
>  
>      user = gitConfig("git-p4.user")
>      if len(user) > 0:
> -- 
> gitgitgadget
> 
