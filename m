Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C9CC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbiA0S7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiA0S7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:59:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79CFC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 10:59:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3894261pjp.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hx5eXAdPh/p7Ch/V6dwS6VYV6TLzTzK3WHjcWmVoGjs=;
        b=BAV0BsIcISrQdeLudRUDNHceSYalLZb+9FAPZtSD4W9uGgGTdSG/a8zYT7EoiJsibL
         ghbb+aW3bfXeYBZXU6D9rXBxd5W4bNKGp7CuNhW7i0khnxwQjxaV6XHmTTqwBXYw3yon
         R4C7FAPySjPbdukZePa8bf9P2qvS8iH/hb+DT7xVCDK75o7DKvu1/vgWgwNnb4470VtW
         BFzKWqydDt9pdh0aycv3G97q4G4eUBCw4FsX09t4usJFrTg8z2/ypYByMdAKQSj05rp3
         Mb0IqwxTSCjmY514sVFHMbkaoto7BS1doVTZQkSEoQ9rUT0UhlApyI/MhxrylavSkErK
         +v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hx5eXAdPh/p7Ch/V6dwS6VYV6TLzTzK3WHjcWmVoGjs=;
        b=RzCBfs36CP+nY9SY5+1WMS+8gHCZnuUGal5z9xqby34ET1Mz9LlzDmX4vZDh5P5Qci
         AN2tZW0x82pxi3OZ295jJyePPcYr78loy5QPRnjFjjXpqEK/KQHSYk1i98Pk7dhQDgo2
         0EAVQDLgyFlJ0yImgcpevzTRBs2ccaGN4x6iihIcvZvtuOrIjKlmeH88H9xrIYcfHjHp
         NVqhK0b0HzqaeA6i8qQRV+CTGgsX29B62ak8Ue/c2+nZQH+srYMHtu/Crb2TP4yrNop/
         TextawFvv+EFNYEPHoCgwevNgAIq1vFa81v+r9nuKpb6RS47Q0yLon6AP5tdmFEiO+iz
         dsBA==
X-Gm-Message-State: AOAM530CGz0b3BthhCbNhNFvbbTIsMouUNlsdeLJrZp5ac+mEHMDL955
        7dsBNsPPCtzwhwXhETT04xP73AXNFb6K160KB+kpD4JJ
X-Google-Smtp-Source: ABdhPJysC8HBU9l/0Sb2QcEMOBbZCchyF386XvCxNAHBNI9FGiNNyMtDSUMfT6thJfQCOynJsLQqSlnmNYlIGcubLRc=
X-Received: by 2002:a17:903:110c:: with SMTP id n12mr4385527plh.163.1643309959367;
 Thu, 27 Jan 2022 10:59:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 10:59:08 -0800
Message-ID: <CABPp-BHeLzinXkX3WgqBNYntJwY_ZAm5D7VdOR7KQahvLOuV=w@mail.gmail.com>
Subject: Re: [PATCH 4/5] scalar: teach `diagnose` to gather loose objects information
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 3:37 PM Matthew John Cheetham via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> When operating at the scale that Scalar wants to support, certain data
> shapes are more likely to cause undesirable performance issues, such as
> large numbers or large sizes of loose objects.

Makes sense.

> By including statistics about this, `scalar diagnose` now makes it
> easier to identify such scenarios.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  contrib/scalar/scalar.c          | 60 ++++++++++++++++++++++++++++++++
>  contrib/scalar/t/t9099-scalar.sh |  2 ++
>  2 files changed, 62 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 690933ffdf3..c0ad4948215 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -686,6 +686,60 @@ static void dir_file_stats(struct strbuf *buf, const char *path)
>         closedir(dir);
>  }
>
> +static int count_files(char *path)
> +{
> +       DIR *dir = opendir(path);
> +       struct dirent *e;
> +       int count = 0;
> +
> +       if (!dir)
> +               return 0;
> +
> +       while ((e = readdir(dir)) != NULL)
> +               if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
> +                       count++;
> +
> +       closedir(dir);
> +       return count;
> +}
> +
> +static void loose_objs_stats(struct strbuf *buf, const char *path)
> +{
> +       DIR *dir = opendir(path);
> +       struct dirent *e;
> +       int count;
> +       int total = 0;
> +       unsigned char c;
> +       struct strbuf count_path = STRBUF_INIT;
> +       size_t base_path_len;
> +
> +       if (!dir)
> +               return;
> +
> +       strbuf_addstr(buf, "Object directory stats for ");
> +       strbuf_add_absolute_path(buf, path);
> +       strbuf_addstr(buf, ":\n");
> +
> +       strbuf_add_absolute_path(&count_path, path);
> +       strbuf_addch(&count_path, '/');
> +       base_path_len = count_path.len;
> +
> +       while ((e = readdir(dir)) != NULL)
> +               if (!is_dot_or_dotdot(e->d_name) &&
> +                   e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
> +                   !hex_to_bytes(&c, e->d_name, 1)) {

You only recurse into directories, ignoring individual files.

> +                       strbuf_setlen(&count_path, base_path_len);
> +                       strbuf_addstr(&count_path, e->d_name);
> +                       total += (count = count_files(count_path.buf));
> +                       strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);

This shows the number of files within a directory.

> +               }
> +
> +       strbuf_addf(buf, "Total: %d loose objects", total);

and this shows the total number of files across all the directories.

But the commit message suggested you also wanted to check for large
sizes of loose objects.  Did that get ripped out at some point with
the commit message not being updated, or is it perhaps going to be
included later?

> +
> +       strbuf_release(&count_path);
> +       closedir(dir);
> +}
> +
>  static int cmd_diagnose(int argc, const char **argv)
>  {
>         struct option options[] = {
> @@ -734,6 +788,12 @@ static int cmd_diagnose(int argc, const char **argv)
>         if ((res = stage(tmp_dir.buf, &buf, "packs-local.txt")))
>                 goto diagnose_cleanup;
>
> +       strbuf_reset(&buf);
> +       loose_objs_stats(&buf, ".git/objects");
> +
> +       if ((res = stage(tmp_dir.buf, &buf, "objects-local.txt")))
> +               goto diagnose_cleanup;
> +
>         if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
>             (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
>             (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
> diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
> index b1745851e31..f2ec156d819 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -77,6 +77,8 @@ test_expect_success UNZIP 'scalar diagnose' '
>         unzip -p "$zip_path" diagnostics.log >out &&
>         test_file_not_empty out &&
>         unzip -p "$zip_path" packs-local.txt >out &&
> +       test_file_not_empty out &&
> +       unzip -p "$zip_path" objects-local.txt >out &&
>         test_file_not_empty out
>  '
>
> --
> gitgitgadget
