From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Thu, 12 Nov 2015 15:34:49 -0800
Message-ID: <CAGZ79kb3w7STeEdUtGS8wtQdBznhnSOprwTeOx8Csx2bHXX9Rw@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 00:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx1OL-0005Jy-BK
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 00:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbbKLXex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 18:34:53 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35508 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932557AbbKLXeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 18:34:50 -0500
Received: by ykba77 with SMTP id a77so119995689ykb.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 15:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D1tHQyAn6YIsFwf7IG0/0bVB7pwLP6pjBJQTf1wnzkE=;
        b=eADu7V3ThVTYnUoWf8rQM0t7tBakqqkaH0HEXxsJ7hCt8k/8ywqn5M3knhm5SIddmK
         curGg2+RbK0NDamUThpzqyrFC3iWaMxGRkGsPBmpFfRyEiLPWkG3LsbCmYgfpNFF24fs
         R3t4/APxZw2H7x8bm4Y3csO5qVu4972aqPeESsXW1DgMb06fj9Li1EaKvp90di+OsYwK
         0ccZ9ibuNxo1vnVG2huzKKoaynNKqHr6TG/qMlj3AxSyuPKZ1SYEENFb1YJNBufJLM2G
         6wwEUHTM2mu7ogJ8bCWuShqgdJXMzAxd+FV5VkJTLgiK0qRVFWr6Fazqt4LhClr7Rm1B
         XLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=D1tHQyAn6YIsFwf7IG0/0bVB7pwLP6pjBJQTf1wnzkE=;
        b=T9+xcQvhDGUWUukgl/fjVgvM+YS1IZi6IIXNPXAVFIXgwaeSkM70JvXeHJsvqTNa+b
         /A0Qps5KfVJosbPs5YgY0deUZtdvXMaFzMxFxGrIT5xfHTzNgPNnZUaC+aw0y+Y2MetL
         KSJr+ZxmBhnTiADEnYnPgZr+5ZzR5/KfvIe6Sj/PmiirJWHOEYaRrXMWMo+MmFK6Pmik
         JXLNb2XAyZZIznEph47OklLE9l3QX849QdfdrngFpuOQPQBZv8lyNPSpyn1HH14sUL83
         O8qZ/4w/FHkWtxQqkxNepaMF2TJ6MMH+HnfDz8O7PtH5uT+jlh1DKAgXoHyosvK71x99
         4rhw==
X-Gm-Message-State: ALoCoQm4J+33MYlN3GVRXFenffMN3qpKddWmnr0bzHqeX69Ga9fAj8QwHgdsib2hSMkEf7pjXJeb
X-Received: by 10.129.75.131 with SMTP id y125mr19574736ywa.48.1447371289537;
 Thu, 12 Nov 2015 15:34:49 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Thu, 12 Nov 2015 15:34:49 -0800 (PST)
In-Reply-To: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281221>

On Thu, Nov 12, 2015 at 1:37 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> "git clone --recursive --depth 1 --single-branch <url>" clones the
> submodules successfully. However, it does not obey "--depth 1" for
> submodule cloning.
>
> The following workaround does only work if the used submodule pointer
> is on the default branch. Otherwise "git submodule update" fails with
> "fatal: reference is not a tree:" and "Unable to checkout".
> git clone --depth 1 --single-branch <url>
> cd <repo-name>
> git submodule update --init --recursive --depth 1
>
> The workaround does not fail using the "--remote" flag. However, in that
> case the wrong commit is checked out.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks for writing these tests. :)

> +test_expect_failure shallow-clone-recursive-workaround '
> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
> +       echo $URL &&
> +       git clone --depth 1 --single-branch $URL clone-recursive-workaround &&
> +       (
> +               cd "clone-recursive-workaround" &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines &&
> +               git submodule update --init --recursive --depth 1

Should we prepend the lines with git submodule update with test_must_fail here?

> +       )
> +'
> +
> +test_expect_failure shallow-clone-recursive-with-remote-workaround '
> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
> +       echo $URL &&
> +       git clone --depth 1 --single-branch $URL clone-recursive-remote-workaround &&
> +       (
> +               cd "clone-recursive-remote-workaround" &&
> +               git log --oneline >lines &&
> +               test_line_count = 1 lines &&
> +               git submodule update --init --remote --recursive --depth 1 &&
> +               git status submodule >status &&
> +               test_must_fail grep "modified:" status

Use ! here instead of test_must_fail.

IIUC we use test_must_fail for git commands (to test that git does
return a non null value instead of segfaulting).
But on the other hand we trust grep to not segfault, so just negating
its output is enough here.

> +       )
> +'
> +
> +test_done
> --
> 2.5.1
>
