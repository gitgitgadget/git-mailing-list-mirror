From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 5/5] help: respect new common command grouping
Date: Thu, 21 May 2015 14:04:58 -0400
Message-ID: <CAPig+cQ0ExDCoSU_P02on0U+8WXbyGbZecK-4vrUVFp1Mo11hA@mail.gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432229962-21405-6-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:05:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUq8-0007cd-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748AbbEUSE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 14:04:59 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33073 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbbEUSE6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 14:04:58 -0400
Received: by iebgx4 with SMTP id gx4so14313363ieb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=m7x7m+uhs02EjAEUl2OduIYjv2hLlTW1eikqeUmihek=;
        b=d5HLCs1M2i/vtivKO+VDbHVIkhjdgVmUzBYjY+XOAP/8f27zFL9NEAxulncIMYFUV/
         U0hYbqHltUvv47v7WATsIvq9NRj/mR2Fe6NMqDeOpLHTNZQRO/PJfmn3tfS4HYMAEEr2
         nh3YOkfPGrjm6dMylj7Xb+54aMF0Z1qP1YwJg1rc68yr8OUqO+wziq8zR4By0qOtwI5r
         vnV3TwTGe35bc15oy86IyMOF1loN/M53lCJiFVR5jr02N3ikcHINmDncB8kTEFH9acrd
         829bOs9hhdNvNc5bxrpAKRNd32RwfIUY5RaU3TUW61MYdXdkVhzFEQ0fAHTbS4COW6Gz
         oIcw==
X-Received: by 10.107.31.134 with SMTP id f128mr5085148iof.19.1432231498083;
 Thu, 21 May 2015 11:04:58 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 11:04:58 -0700 (PDT)
In-Reply-To: <1432229962-21405-6-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: WwDo7XlKnG9AM8VYvq0pN28GrGk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269631>

On Thu, May 21, 2015 at 1:39 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> 'git help' shows common commands in alphabetical order:
>
> The most commonly used git commands are:
>    add        Add file contents to the index
>    bisect     Find by binary search the change that introduced a bug
>    branch     List, create, or delete branches
>    checkout   Checkout a branch or paths to the working tree
>    clone      Clone a repository into a new directory
>    commit     Record changes to the repository
>    [...]
>
> without any indication of how commands relate to high-level
> concepts or each other. Revise the output to explain their relationsh=
ip
> with the typical Git workflow:
>
> The most commonly used git commands are:

The above line in the commit message does not match the actual output:

    "These are common Git commands used in various situations:"

> start a working area (see also: git help tutorial)
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize [...]
>
> work on the current change (see also: git help everyday)
>    add        Add file contents to the index
>    reset      Reset current HEAD to the specified state
>
> examine the history and state (see also: git help revisions)
>    log        Show commit logs
>    status     Show the working tree status
>
>    [...]
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/help.c b/help.c
> index 2072a87..8f72051 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
>         }
>  }
>
> +static int cmd_group_cmp(const void *elem1, const void *elem2)
> +{
> +       const struct cmdname_help *e1 =3D elem1;
> +       const struct cmdname_help *e2 =3D elem2;
> +
> +       if (e1->group < e2->group)
> +               return -1;
> +       if (e1->group > e2->group)
> +               return 1;
> +       return strcmp(e1->name, e2->name);
> +}
> +
>  void list_common_cmds_help(void)
>  {
>         int i, longest =3D 0;
> +       int current_grp =3D -1;
>
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 if (longest < strlen(common_cmds[i].name))
>                         longest =3D strlen(common_cmds[i].name);
>         }
>
> -       puts(_("The most commonly used git commands are:"));
> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
> +               sizeof(common_cmds[0]), cmd_group_cmp);
> +
> +       puts(_("These are common Git commands used in various situati=
ons:"));
> +
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> +               if (common_cmds[i].group !=3D current_grp) {
> +                       printf("\n%s\n", _(common_cmd_groups[common_c=
mds[i].group]));
> +                       current_grp =3D common_cmds[i].group;
> +               }
> +
>                 printf("   %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name))=
;
>                 puts(_(common_cmds[i].help));
> --
> 2.4.0.GIT
