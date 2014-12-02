From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/19] Add git-list-files, a user friendly version of
 ls-files and more
Date: Mon, 1 Dec 2014 21:50:54 -0500
Message-ID: <CAPig+cQCFkGUqLjvGPLON8D3577ADyBJ2hmQ9girbO5Q1Tn6Eg@mail.gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
	<1417337767-4505-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:51:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvdYM-0006Na-81
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 03:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbaLBCu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 21:50:57 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:54042 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbaLBCuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 21:50:55 -0500
Received: by mail-yh0-f42.google.com with SMTP id v1so5613096yhn.29
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 18:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Aprr+m8wPgoUiMifV3f/J5nfi6OJXz4r4Kz900y4aDU=;
        b=Wb34HlrGiBo2twj0HBALp/oVFa8ktopAkUnbdbCgtz+WawTYbQwPSuq+jqFiU24fnu
         2AnEbalS+LlLwsWyOSY1ozeSwU2nKs6coBNJvICVtIGpJQoGnxC/6WewD/968FkvXXU7
         MsODJPQb1D4yarVqo99NWdNMejrCSf1kCB1PCAwmM0vY2rDR5DApcM6xoIvvBXkzQWmr
         gp90ilnjZtc8IuZRCya1K/G/gQfzqkAc+glQcxqGYgGhDnK4SB5FSi4RBNhsFgaOLBiA
         lyKwy+5zP70uMmJucM5BFdDHsF0oU9YtaVAJNe41TpVBmTuDX7b9utap1NTwUHTOFOhN
         0NTw==
X-Received: by 10.236.8.100 with SMTP id 64mr2676798yhq.112.1417488654675;
 Mon, 01 Dec 2014 18:50:54 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Mon, 1 Dec 2014 18:50:54 -0800 (PST)
In-Reply-To: <1417337767-4505-10-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Sjv1U5mC_gsRKlWqI-Jk-267PpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260525>

On Sunday, November 30, 2014, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>
> This is more user friendly version of ls-files:
>
> * it's automatically colored and columnized
> * it refreshes the index like all porcelain commands
> * it defaults to non-recursive behavior like ls
> * :(glob) is on by default so '*.c' means a.c but not a/b.c, use
>   '**/*.c' for that.
> * auto pager
>
> The name 'ls' is not taken. It is left for the user to make an alias
> with better default options.

I understand that your original version was named git-ls and that you
renamed it to git-list-files in order to leave 'ls' available so users
can create an 'ls' alias specifying their own default options. Would
it make sense, however, to restore the name to git-ls and allow users
to set default options via a config variable instead? Doing so would
make the short-and-sweet git-ls command work for all users
out-of-the-box, which might be well appreciated by Unix users.

More below.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-list-files.txt b/Documentation/git-lis=
t-files.txt
> new file mode 100644
> index 0000000..3039e1e
> --- /dev/null
> +++ b/Documentation/git-list-files.txt
> @@ -0,0 +1,80 @@
> +git-list-files(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-list-files - List files
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git list-files [options] [<pathspec>...]
> +
> +DESCRIPTION
> +-----------
> +List files (by default in current working directory) that are in the
> +index. Depending on the chosen options, maybe only modified files in
> +working tree are shown, or untracked files...
> +
> +OPTIONS
> +-------
> +-c::
> +--cached::
> +       Show cached files (default)

I realize that this mirrors what is in git-ls-files.txt, but:

s/$/./

> +-d::
> +--deleted::
> +       Show cached files that are deleted on working directory

s/$/./

> +-m::
> +--modified::
> +       Show cached files that have modification on working directory

s/$/./

> +-o::
> +--others::
> +       Show untracked files (and only unignored ones unless -i is

s/-i/`-i`/

> +       specified)

s/$/./

> +-i::
> +--ignored::
> +       Show only ignored files. When showing files in the index,
> +       print only those matched by an exclude pattern. When showing
> +       "other" files, show only those matched by an exclude pattern.
> +
> +-u::
> +--unmerged::
> +       Show unmerged files

s/$/./

> +--color[=3D<when>]::
> +--no-color::
> +       Color file names. The value must be `always`, `never`, or
> +       `auto`. `--no-color` is equivalent to
> +       `--color=3Dnever`. `--color` is equivalent to
> +       `--color=3Dauto`. See configuration variable `color.list-file=
s`
> +       for the default settings.
> +
> +--column[=3D<options>]::
> +--no-column::
> +       Display files in columns. See configuration variable column.u=
i

s/column.ui/`column.ui`/

> +       for option syntax. `--column` and `--no-column` without optio=
ns
> +       are equivalent to 'always' and 'never' respectively.
> +
> +--max-depth=3D<depth>::
> +       For each <pathspec> given on command line, descend at most <d=
epth>
> +       levels of directories. A negative value means no limit.
> +       This option is ignored if <pathspec> contains active wildcard=
s.
> +       In other words if "a*" matches a directory named "a*",
> +       "*" is matched literally so --max-depth is still effective.
> +       The default is `--max-depth=3D0`.
> +
> +<pathspec>::
> +       Files to show. :(glob) magic is enabled and recursion disable=
d
> +       by default.
> +
> +SEE ALSO
> +--------
> +linkgit:git-ls-files[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
