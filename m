From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] branch -d: refuse deleting a branch which is currently
 checked out
Date: Tue, 29 Mar 2016 14:57:14 -0400
Message-ID: <CAPig+cQPFzgEgdNUJSa9baUvc4BuJp8BHOLA88QJqW8N3hE8AQ@mail.gmail.com>
References: <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
	<1459244319-21241-1-git-send-email-k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:57:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akypM-0007O0-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbcC2S5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:57:16 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36061 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbcC2S5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:57:15 -0400
Received: by mail-vk0-f67.google.com with SMTP id z68so3495894vkg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=mq6EtEIGI9AzcjOIxLm9njNBhJNFt7wkNIypILgllLk=;
        b=ntem59tc0MOBJ3RHc3mQfNizln9QjCSt7EnGR9THrhvvlBTZNX8lOf792YFUniU4Td
         5YDIQNnBd8EXUKWtOon3Y5hbsfDgsTKv+E06Cj9ucJ7U+zTWqCpcLcWG5RKjZELu/j+w
         /ZMbxYZeevgwSyqoh+ACidyg68ZTbd5DQ6Jc7B6vSVXFaqJs4SZLghEJXyhaTSqUMTQj
         78jOQMJWJD/jqEiu3Xf1i3Oqg6tk0jMBdxw6fBlcWlm7GbVXHskRibtlAvj4xMrSW5Xz
         4aso5Iemw5IBeJ7yp5Ay3h6NGVCPUmdTSrj35YGZhOcNBgUvPKct13RWI9AsoC7Qdggn
         e68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mq6EtEIGI9AzcjOIxLm9njNBhJNFt7wkNIypILgllLk=;
        b=k/vJpvz6YSasdrX/JzO1lW9aeKxsGdGh/vm283iOf5tEwIi5/SyeVxTJVmu0hTtgcr
         jOXB/SG1ZM/22NhY17gYQ3O0B6suXxZXjIEp2YRrUlhWChuYOSvVINJfNB+6qnLm2WPt
         9Py21qG4zFCE/akkUJRKIXdN5SHhu10v+z78ErbqROBPfvhfvwAG4FlT5G2AKPsGaLHf
         Q8an2yH+y1JyX+XErSzQ+fw+YW8YPE9jSWhy7A+kreAN7Tt2kJqKtwO2Ac2EMLATTyQ1
         hvPCi7bL1583tGn5xw1ax6cC7adrJ4QmA9L+9wm7O1Lq5pKtDB6+2aZ4VrW8l3P93Aqu
         HLPQ==
X-Gm-Message-State: AD7BkJLBNdHEiyUoNapQxglMtHB/e+DaPcwDM4IfcueTJEAsfzaAM1dvP+4F/+K+Xj4URv0o1/kOCxjRFQeUmg==
X-Received: by 10.176.6.193 with SMTP id g59mr2226561uag.67.1459277834210;
 Tue, 29 Mar 2016 11:57:14 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 11:57:14 -0700 (PDT)
In-Reply-To: <1459244319-21241-1-git-send-email-k@rhe.jp>
X-Google-Sender-Auth: RWghh6bItTqqNNu3NcQcxHjYJT8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290160>

On Tue, Mar 29, 2016 at 5:38 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> When a branch is checked out by current working tree, deleting the
> branch is forbidden. However when the branch is checked out only by
> other working trees, deleting incorrectly succeeds.
> Use find_shared_symref() to check if the branch is in use, not just
> comparing with the current working tree's HEAD.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---
> Changes from v2:
> - Amended commit message
> - Dropped "which is" from error message

Thanks, this version addresses my previous review comments and is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> The previous versions of the patch are:
> - [v1] http://thread.gmane.org/gmane.comp.version-control.git/289413/focus=289932
> - [v2] http://thread.gmane.org/gmane.comp.version-control.git/289413/focus=290027
>
>  builtin/branch.c  | 22 ++++++++++++++--------
>  t/t3200-branch.sh |  6 ++++++
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7b45b6bd6b80..8885d9f8e2cd 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -20,6 +20,7 @@
>  #include "utf8.h"
>  #include "wt-status.h"
>  #include "ref-filter.h"
> +#include "worktree.h"
>
>  static const char * const builtin_branch_usage[] = {
>         N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
> @@ -215,16 +216,21 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                 int flags = 0;
>
>                 strbuf_branchname(&bname, argv[i]);
> -               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
> -                       error(_("Cannot delete the branch '%s' "
> -                             "which you are currently on."), bname.buf);
> -                       ret = 1;
> -                       continue;
> -               }
> -
>                 free(name);
> -
>                 name = mkpathdup(fmt, bname.buf);
> +
> +               if (kinds == FILTER_REFS_BRANCHES) {
> +                       char *worktree = find_shared_symref("HEAD", name);
> +                       if (worktree) {
> +                               error(_("Cannot delete branch '%s' "
> +                                       "checked out at '%s'"),
> +                                     bname.buf, worktree);
> +                               free(worktree);
> +                               ret = 1;
> +                               continue;
> +                       }
> +               }
> +
>                 target = resolve_ref_unsafe(name,
>                                             RESOLVE_REF_READING
>                                             | RESOLVE_REF_NO_RECURSE
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index a89724849065..508007fd3772 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -403,6 +403,12 @@ test_expect_success 'test deleting branch without config' '
>         test_i18ncmp expect actual
>  '
>
> +test_expect_success 'deleting currently checked out branch fails' '
> +       git worktree add -b my7 my7 &&
> +       test_must_fail git -C my7 branch -d my7 &&
> +       test_must_fail git branch -d my7
> +'
> +
>  test_expect_success 'test --track without .fetch entries' '
>         git branch --track my8 &&
>         test "$(git config branch.my8.remote)" &&
> --
> 2.8.0.rc4.17.g02aa164.dirty
