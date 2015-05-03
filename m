From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] help.c - group common commands by theme
Date: Sun, 3 May 2015 15:44:33 -0400
Message-ID: <CAPig+cS1K0uZy1-MxKCqyi7Vy5kXYN2Qm-AC4s0YyY5Oe948CA@mail.gmail.com>
References: <554405D5.9080702@gmail.com>
	<55456990.6000509@gmail.com>
	<55456A91.3040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 21:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yozoe-00041K-0v
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 21:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbbECTog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 15:44:36 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36138 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbECToe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2015 15:44:34 -0400
Received: by iebrs15 with SMTP id rs15so117960705ieb.3
        for <git@vger.kernel.org>; Sun, 03 May 2015 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CRSxt5iO5H1OXe4U4Nn8C+eUNvGs4aCzqu/nL8AYTNM=;
        b=olJkVqY8Dq8rCQGLwrkoaS/+K+FYTcKY07Y///Om+2l5VVjCNXyiJ5EARih1Gcu9Nz
         wdgt4fghwnGuojsgTri6RGmjIy9S+aX85iO2Oa5NOVcNgZVu8T+CkwaSY6Sx7En6ktY0
         ck/SutEvc8XRV92EgwrRJoqyNgimRPasSMnEw+o3GaIJDLh2Nl+iwQh/azdqcyXi9buG
         gL42b7iOdLsjrUCdNeYRNGYX0D7ALk90lI0v7y80oafSEOeZNv0nicLL7fQXXx3lElZj
         1/MNz7k7c6Jx5ifwVHhEbwGC+lB1ukAwcKQddI0B0a9WLOTUBBJmH1W9o1pTh6QEAlM/
         BJOg==
X-Received: by 10.42.207.206 with SMTP id fz14mr24911979icb.34.1430682273784;
 Sun, 03 May 2015 12:44:33 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 12:44:33 -0700 (PDT)
In-Reply-To: <55456A91.3040408@gmail.com>
X-Google-Sender-Auth: HgQUHj3dfQMqFJCN-W0SQRdz86Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268286>

On Sat, May 2, 2015 at 8:23 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> When 'git help' is called, a list of common commands are printed:
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
> Instead of a less than optimal alphabetical order, print those
> commands in theme-related groups:
>
> The most commonly used git commands are:
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize an exist=
ing one
>
>    log        Show commit logs
>    show       Show various types of objects
>    status     Show the working tree status
>
>    add        Add file contents to the index
>    mv         Move or rename a file, a directory, or a symlink
>    reset      Reset current HEAD to the specified state
>    rm         Remove files from the working tree and from the index
>    [...]
>
> To achieve this, qsort the common_cmds array by group name,
> then print those common commands, skipping a line between each group.

Just a minor observation regarding the final paragraph (feel free to ig=
nore):

This level of detail is probably overkill. The overall intent of the
change has already been spelled out nicely via the examples, so
mentioning qsort() is unnecessary since it's a mere implementation
detail; one which a reader can easily discover by reading the patch
proper. Likewise, the example "new output" already shows clearly the
blank line between groups, so there is no need to mention it in prose.

If I was composing the commit message, I'd probably drop the final
paragraph altogether and rephrase something like this:

    'git help' shows common commands in alphabetical order like this:

        <current output>

    without any indication of how commands relate to high-level
    concepts or each other. Revise the output to group commands by
    concept, like this:

        <revised output>

More below.

> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/help.c b/help.c
> index 2072a87..2169a59 100644
> --- a/help.c
> +++ b/help.c
> @@ -218,17 +218,38 @@ void list_commands(unsigned int colopts,
>         }
>  }
>  +/* sort the command name struct by group name */
> +int cmd_group_cmp(const void *elem1, const void *elem2)
> +{
> +       struct cmdname_help *cmd1 =3D (struct cmdname_help*) elem1;
> +       struct cmdname_help *cmd2 =3D (struct cmdname_help*) elem2;

As this is C rather than C++, you can drop the cast.

Also, if you were to keep the cast, the prevailing style in git code
is to insert a space before the '*' and to drop the space after the
')'.

> +       return strcmp(cmd1->group, cmd2->group);
> +}
> +
>  void list_common_cmds_help(void)
>  {
>         int i, longest =3D 0;
> +       char *current_grp =3D NULL;
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 if (longest < strlen(common_cmds[i].name))
>                         longest =3D strlen(common_cmds[i].name);
>         }
>  +      /* sort common commands by group (i.e, beginner's relevance) =
*/
> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
> +               sizeof(struct cmdname_help), cmd_group_cmp);

Slightly more maintenance free would be sizeof(common_cmds[0]) instead
of sizeof(struct cmdname_help).

>         puts(_("The most commonly used git commands are:"));
>         for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> +

Style: Drop this blank line.

> +               /* skip a line each time we encounter a new command g=
roup */
> +               if (current_grp !=3D NULL && strcmp(common_cmds[i].gr=
oup,
> current_grp))
> +                       printf("\n");

This chunk of code is pretty well self-explanatory, so the comment
isn't really adding anything. A comment which merely repeat what the
code itself already says is typically considered distracting rather
than illuminating, thus it could (and probably should) be dropped. The
same observation probably applies to the comment preceding the qsort()
invocation, as well.

=46inally, elsewhere in this source file, a blank line is emitted with
the more idiomatic putchar('\n') rather than printf("\n").

> +
> +               current_grp =3D common_cmds[i].group;
> +
>                 printf("   %s   ", common_cmds[i].name);
>                 mput_char(' ', longest - strlen(common_cmds[i].name))=
;
>                 puts(_(common_cmds[i].help));
> --
> 2.4.0
