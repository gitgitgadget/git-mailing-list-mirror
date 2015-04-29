From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Wed, 29 Apr 2015 16:47:33 -0700
Message-ID: <CAGZ79kY95mxKWwTPSB0S5c0eux1ButhuvGz91GQUz8WXt1w18w@mail.gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:47:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynbhd-0000AF-28
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 01:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbbD2Xrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2015 19:47:35 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35657 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbD2Xre convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2015 19:47:34 -0400
Received: by igbyr2 with SMTP id yr2so133899876igb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dehvrY+cu2G7hpdnMqr94Bd0s3kA74lpt7En2Lsiw/c=;
        b=lv8FieKIUMB6TqyzKz723d5GlQPbz3xvkitbJItzCQYBXzPKujxTxlapx4cREFhvGi
         pYt7WDvYKjSaTIIS3r4TMIMPWViEqeu7F8oVWFh+bMCYe9dga18MRlrrnBtIWs41ekzP
         +xbKy/v2xWEpXiL4SqhISLQEBoZRrDDiBWA5hHCmB1wFXi+aggqUZRuM2w+D0G0GYa30
         lNfOucgfyW4lENyLkSL3Hhc6brWIOjrlUMw3N/N0fJx+R1d76ifAspXPEnu6xRITPthn
         Z7I+GHiywuq3PjZ5LLb73I1gyXDRuuz/Hzugm+u+c0Vvdt1C2kxkD+bwWlC0Q94DFRlR
         vAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dehvrY+cu2G7hpdnMqr94Bd0s3kA74lpt7En2Lsiw/c=;
        b=X9e88u5t7PLyD1czqmP3Ow7JYiQ3W6QMPwa9PzRaWQXbVzVCi4cgThit5gsX+/UA5E
         gyAgOX9fhoJTe7lRkGxCVuTzf58ed8+NPuxXYJZ8uhqMEaHOthF78ycJxR8zeVeoo/3q
         FQzD/GUvosPM+lMigpckE/XW1llZqxfjerFGuBNzdcuL63gQ7XugMbuEllOrGjbHIUBj
         LV9JBp1BDXCPbSPOxtRCNqIJOlaXnjuO5tqv2X1nKRAm1A2p1PIZ7kRBr8eWQvWcXGDH
         kcvkryysrRKBWMU7E69T5Ia6IrDtqscFgRYnVK57eqYrL5PV+hV0v16UHaYXmurnvFB4
         ge4Q==
X-Gm-Message-State: ALoCoQk++BHOg+ZKRIc7gRbXJaKzzWnFJCheuCa4t8n4yoakSbmH/fQDQCpNeBL5yBJyDRIEWmyH
X-Received: by 10.107.132.223 with SMTP id o92mr2074702ioi.49.1430351253428;
 Wed, 29 Apr 2015 16:47:33 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 29 Apr 2015 16:47:33 -0700 (PDT)
In-Reply-To: <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268037>

On Sat, Apr 25, 2015 at 11:49 PM, Erik Elfstr=C3=B6m <erik.elfstrom@gma=
il.com> wrote:
> read_gitfile will die on most error cases. This makes it unsuitable
> for speculative calls. Extract the core logic and provide a gentle
> version that returns NULL on failure.
>
> The first usecase of the new gentle version will be to probe for
> submodules during git clean.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
>  cache.h | 11 ++++++++-
>  setup.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++----=
----------
>  2 files changed, 75 insertions(+), 18 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 3d3244b..868e4d3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -431,7 +431,16 @@ extern int set_git_dir(const char *path);
>  extern const char *get_git_namespace(void);
>  extern const char *strip_namespace(const char *namespaced_ref);
>  extern const char *get_git_work_tree(void);
> -extern const char *read_gitfile(const char *path);
> +
> +#define READ_GITFILE_ERR_STAT_FAILED 1
> +#define READ_GITFILE_ERR_NOT_A_FILE 2
> +#define READ_GITFILE_ERR_OPEN_FAILED 3
> +#define READ_GITFILE_ERR_READ_FAILED 4
> +#define READ_GITFILE_ERR_INVALID_FORMAT 5
> +#define READ_GITFILE_ERR_NO_PATH 6
> +#define READ_GITFILE_ERR_NOT_A_REPO 7
> +extern const char *read_gitfile_gently(const char *path, int *return=
_error_code);
> +#define read_gitfile(path) read_gitfile_gently((path), NULL)
>  extern const char *resolve_gitdir(const char *suspect);
>  extern void set_git_work_tree(const char *tree);
>
> diff --git a/setup.c b/setup.c
> index 979b13f..c4538ca 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -335,35 +335,53 @@ static int check_repository_format_gently(const=
 char *gitdir, int *nongit_ok)
>  /*
>   * Try to read the location of the git directory from the .git file,
>   * return path to git directory if found.
> + *
> + * On failure, if return_error_code is not NULL, return_error_code
> + * will be set to an error code and NULL will be returned. If
> + * return_error_code is NULL the function will die instead (for most
> + * cases).
>   */
> -const char *read_gitfile(const char *path)
> +const char *read_gitfile_gently(const char *path, int *return_error_=
code)
>  {
> -       char *buf;
> -       char *dir;
> +       int error_code =3D 0;
> +       char *buf =3D NULL;
> +       char *dir =3D NULL;
>         const char *slash;
>         struct stat st;
>         int fd;
>         ssize_t len;
>
> -       if (stat(path, &st))
> -               return NULL;
> -       if (!S_ISREG(st.st_mode))
> -               return NULL;
> +       if (stat(path, &st)) {
> +               error_code =3D READ_GITFILE_ERR_STAT_FAILED;
> +               goto cleanup_return;
> +       }
> +       if (!S_ISREG(st.st_mode)) {
> +               error_code =3D READ_GITFILE_ERR_NOT_A_FILE;
> +               goto cleanup_return;
> +       }
>         fd =3D open(path, O_RDONLY);
> -       if (fd < 0)
> -               die_errno("Error opening '%s'", path);
> +       if (fd < 0) {
> +               error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
> +               goto cleanup_return;
> +       }
>         buf =3D xmalloc(st.st_size + 1);
>         len =3D read_in_full(fd, buf, st.st_size);
>         close(fd);
> -       if (len !=3D st.st_size)
> -               die("Error reading %s", path);
> +       if (len !=3D st.st_size) {
> +               error_code =3D READ_GITFILE_ERR_READ_FAILED;
> +               goto cleanup_return;

Sorry for the late review.

So when you jump from here to the cleanup, there is no close(fd) involv=
ed?
I think there are code paths now, which leak fd.

> +       }
>         buf[len] =3D '\0';
> -       if (!starts_with(buf, "gitdir: "))
> -               die("Invalid gitfile format: %s", path);
> +       if (!starts_with(buf, "gitdir: ")) {
> +               error_code =3D READ_GITFILE_ERR_INVALID_FORMAT;
> +               goto cleanup_return;
> +       }
>         while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
>                 len--;
> -       if (len < 9)
> -               die("No path in gitfile: %s", path);
> +       if (len < 9) {
> +               error_code =3D READ_GITFILE_ERR_NO_PATH;
> +               goto cleanup_return;
> +       }
>         buf[len] =3D '\0';
>         dir =3D buf + 8;
>
> @@ -378,11 +396,41 @@ const char *read_gitfile(const char *path)
>                 buf =3D dir;
>         }
>
> -       if (!is_git_directory(dir))
> -               die("Not a git repository: %s", dir);
> +       if (!is_git_directory(dir)) {
> +               error_code =3D READ_GITFILE_ERR_NOT_A_REPO;
> +               goto cleanup_return;
> +       }
>         path =3D real_path(dir);
>
> +cleanup_return:
>         free(buf);
> +
> +       if (return_error_code)
> +               *return_error_code =3D error_code;
> +
> +       if (error_code) {
> +               if (return_error_code)
> +                       return NULL;
> +
> +               switch (error_code) {
> +               case READ_GITFILE_ERR_STAT_FAILED:
> +               case READ_GITFILE_ERR_NOT_A_FILE:
> +                       return NULL;
> +               case READ_GITFILE_ERR_OPEN_FAILED:
> +                       die_errno("Error opening '%s'", path);
> +               case READ_GITFILE_ERR_READ_FAILED:
> +                       die("Error reading %s", path);
> +               case READ_GITFILE_ERR_INVALID_FORMAT:
> +                       die("Invalid gitfile format: %s", path);
> +               case READ_GITFILE_ERR_NO_PATH:
> +                       die("No path in gitfile: %s", path);
> +               case READ_GITFILE_ERR_NOT_A_REPO:
> +                       die("Not a git repository: %s", dir);
> +               default:
> +                       assert(0);
> +               }
> +       }
> +
>         return path;
>  }
>
> --
> 2.4.0.rc3.8.gbb31afb
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
