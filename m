Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC2C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 15:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDLPpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDLPpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 11:45:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D659E1
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 08:45:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t14so15167864lft.7
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681314318; x=1683906318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49k9/l4oz/9wfWcLAWJZc4IHi8GgaYFRhvhf+XyPPU8=;
        b=iFZt84Kn9bS14621x4xzxszSk4np32sVcWlnSF0xdBULiP+bVUUIK4tJ9LnDAnVZbP
         7JBINu6udcTyLr/h7m6oJ7Fe7pPjXRqkh6PqRetTH77C5NDI7aVoiIwfKWU4MttqtKyl
         hzMWE4IXVbBXLWs5bOGySO7WbgKfLIIOBf2y/KkgobAUI5N2uvLusV/Khj2qxLW3OvGm
         NUV2+T7POVwaVcoV6VX6+xKW3HCznxYe/aKI2M50AL2KcwQOmVdc4pOfGSinuslDL4dm
         qv8FVfL3IZw8XYxJAQvlSvZvsZTP9UIAiVjykiQ/tQQzYQJc+xzv7ictwLV6kYb25FYW
         Bmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681314318; x=1683906318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49k9/l4oz/9wfWcLAWJZc4IHi8GgaYFRhvhf+XyPPU8=;
        b=cMROKuQqTMndKra572rhoqMvnGxIFVr7Dk8x3mmsORS0NdDEi9cEzTYMCQp18se6Ag
         PUBItiadgKDnMsUm9CTXLuDUdey/inRdi/3xNfn5MWlUyWx8XCibByJfNAEMAVC2nJn3
         W7RVNws7kvT3lfs1ZixxKdieZ0x1/9LTF7dly9cOjv9Lpu0RvO+l/dw76ngiOT5U1swv
         Y33O1OjasiPuMY3rpLAiVy0kuCeI9pk0OtlD9tLVRRA/utmH82dO69TDh3B8nSOtN2D4
         EcFaaLSqqHMC3TM4kZ3hPfEFz53AJCHjUi18+QN85VaXaKA+bcaTQtlz5hCU7XXwPOyy
         9t0Q==
X-Gm-Message-State: AAQBX9dmhpJ/35WPzP87lVhySNcynBlDMd4wfYzvLNmv/aKV4BIFWBRM
        7bSCjXWY7GLdqHxqd0wKeIQO/TEMNBOLETP0omyYMidq
X-Google-Smtp-Source: AKy350Z3CxxD1SRBZd78jqUMtGHL1yVRUlg7+XvzilrsNaYqChlUCJUwA6N48ySFIPzwmEIJIovqgd1DINpl1vszYzU=
X-Received: by 2002:a19:ad07:0:b0:4ec:9ec1:dfa3 with SMTP id
 t7-20020a19ad07000000b004ec9ec1dfa3mr965986lfc.7.1681314317867; Wed, 12 Apr
 2023 08:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230412134119.28257-1-markus.heidelberg@web.de>
In-Reply-To: <20230412134119.28257-1-markus.heidelberg@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 Apr 2023 08:45:04 -0700
Message-ID: <CABPp-BH1172tfZn5i0PvNm6Fw5OObKEKCqT1gjTr+hux86TexQ@mail.gmail.com>
Subject: Re: [filter-repo PATCH] convert-svnexternals: fix parsing of wrongly
 transformed SVN revisions
To:     Markus Heidelberg <markus.heidelberg@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 6:42=E2=80=AFAM Markus Heidelberg
<markus.heidelberg@web.de> wrote:
>
> SVN revision numbers from svn:externals property, which are a multiple
> of 1024 (2^10), are transformed by SubGit to contain a binary suffix
> ("k", "m" and "g" have been checked) in .gitsvnextmodules file.
> These aren't valid revision numbers in SVN either.
>
> Examples:
>   1024 -> 1k
>   2048 -> 2k
>   1048576 -> 1m
>   1049600 -> 1025k
>   1073741824 -> 1g
>
> This led to the following error:
>     svn_rev =3D int(parsed_config[section]['revision'])
> ValueError: invalid literal for int() with base 10: '1k'
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>  contrib/filter-repo-demos/convert-svnexternals | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/filter-repo-demos/convert-svnexternals b/contrib/fil=
ter-repo-demos/convert-svnexternals
> index 0c81507..39ff288 100644
> --- a/contrib/filter-repo-demos/convert-svnexternals
> +++ b/contrib/filter-repo-demos/convert-svnexternals
> @@ -254,6 +254,21 @@ def get_absolute_svn_url(svnext_url, svn_root_url):
>
>    return True, svnext_url
>
> +def parse_revision_value(value):
> +  """
> +  Parse the value of key 'revision' from a .gitsvnextmodules file and re=
turn it
> +  as integer.
> +
> +  Used to handle non-numeric values like 1k, 2k, 3k etc. added by SubGit
> +  instead of 1024, 2048, 3072 etc., likewise 1m, 2m, ..., 1g, ...
> +  """
> +  suffix =3D value[-1]
> +  if suffix in "kmg":
> +    mult =3D {"k": 1024, "m": 1024**2, "g": 1024**3}
> +    return int(value[0:-1]) * mult[suffix]
> +  else:
> +    return int(value)
> +
>  def add_submodule_tree_entry(commit, parsed_config, section):
>    """
>    Add a submodule entry to the tree of a Git commit.
> @@ -271,7 +286,7 @@ def add_submodule_tree_entry(commit, parsed_config, s=
ection):
>
>    # Get SVN revision
>    if parsed_config.has_option(section, 'revision'):
> -    svn_rev =3D int(parsed_config[section]['revision'])
> +    svn_rev =3D parse_revision_value(parsed_config[section]['revision'])
>    else:
>      # TODO: revision has to be guessed according to commit timestamp, sk=
ip for now
>      return False
> --
> 2.40.0

Thanks for sending this in!  Applied.
