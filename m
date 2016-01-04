From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4.py: add support for filetype change
Date: Mon, 4 Jan 2016 22:16:03 +0000
Message-ID: <CAE5ih78Jb9u8FKNd5hoWkWVFsZJBa2_dqaQ1G1SKtjm8Ec4J6Q@mail.gmail.com>
References: <1451904764-338-1-git-send-email-romain.picard@oakbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git-owner@vger.kernel.org
To: Romain Picard <romain.picard@oakbits.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGDQO-0005QG-A0
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 23:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbcADWQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 17:16:09 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33919 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbcADWQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 17:16:04 -0500
Received: by mail-io0-f181.google.com with SMTP id 1so122696326ion.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 14:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OpqJ0Y0+2aGawpnCHx2cbJhE9LwONoDigGrdKf6dXjM=;
        b=Tt4Xb3GpJMy9cV9Gii3D4Wd+nbs722tw5488HkaoQ7XGu+ABmV56Z+3uroWPnbWh6W
         eo0W8bcg3uye6HoPT+vMhcB8eI7tnpyzJSKcJksq/YxHtl3YMUxBbJVYLJB1KonTpbqC
         XZdf/7SvZBSlfO28geauu5f6xERCiOiH7uV6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OpqJ0Y0+2aGawpnCHx2cbJhE9LwONoDigGrdKf6dXjM=;
        b=iL3Lhe+08SzvWkYHY+3/H/fxed/SLKfipDfPPKXMsne/0O3I0wWzh4/rxvwybTjYIf
         EmHvBH/kfq97k4zWTV6jlloiH0wAV8m+UsBe+k2IQjZnYUFqPflSgQ5pFw9ZEAEeF5CJ
         9LQ1LgcCmGcP6iixN/3xKsGfhDbO4kDOh15WzOU7caBGibOvKW+xKW+smK0yGWLBIOtA
         qRN4SSwFBP1XSiUC3XzPKL6hETMGj3yxE5IArZOG73H6zRa4XuXNDaUN4yw0mk+1EUzq
         1+XCwbM6dU4tg3dLN/NtVZvAQdjxfG03i9wtzJZYRwFzSBdIgFel8gO0KU0PJL06Uy81
         XeQw==
X-Gm-Message-State: ALoCoQlU6fIukugf/ShZH6Cy4MoEU18O4H8ZpHcdGpMhkUArv3gIqQUIm2cgQaGw+IUDrlqibds2kbPET02zen/smRQzaiClhw==
X-Received: by 10.107.19.203 with SMTP id 72mr95012107iot.41.1451945763541;
 Mon, 04 Jan 2016 14:16:03 -0800 (PST)
Received: by 10.79.66.65 with HTTP; Mon, 4 Jan 2016 14:16:03 -0800 (PST)
In-Reply-To: <1451904764-338-1-git-send-email-romain.picard@oakbits.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283329>

On 4 January 2016 at 10:52, Romain Picard <romain.picard@oakbits.com> wrote:
> After changing the type of a file in the git repository, it is not possible to
> "git p4 publish" the commit to perforce. This is due to the fact that the git
> "T" status is not handled in git-p4.py. This can typically occur when replacing
> an existing file with a symbolic link.
>
> The "T" modifier is now supported in git-p4.py. When a file type has changed,
> inform perforce with the "p4 edit -f auto" command.

Looks good to me, thanks for adding the test. I think the test needs
to say what the terms of the copyright are (GPL, etc) but other than
that it looks good.

Thanks
Luke

>
> Signed-off-by: Romain Picard <romain.picard@oakbits.com>
> ---
>  git-p4.py                         |  9 +++--
>  t/t9827-git-p4-change-filetype.sh | 69 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100755 t/t9827-git-p4-change-filetype.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index a7ec118..b7a3494 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -240,8 +240,8 @@ def p4_add(f):
>  def p4_delete(f):
>      p4_system(["delete", wildcard_encode(f)])
>
> -def p4_edit(f):
> -    p4_system(["edit", wildcard_encode(f)])
> +def p4_edit(f, *options):
> +    p4_system(["edit"] + list(options) + [wildcard_encode(f)])
>
>  def p4_revert(f):
>      p4_system(["revert", wildcard_encode(f)])
> @@ -1344,6 +1344,7 @@ class P4Submit(Command, P4UserMap):
>
>          diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
>          filesToAdd = set()
> +        filesToChangeType = set()
>          filesToDelete = set()
>          editedFiles = set()
>          pureRenameCopy = set()
> @@ -1404,6 +1405,8 @@ class P4Submit(Command, P4UserMap):
>                      os.unlink(dest)
>                      filesToDelete.add(src)
>                  editedFiles.add(dest)
> +            elif modifier == "T":
> +                filesToChangeType.add(path)
>              else:
>                  die("unknown modifier %s for %s" % (modifier, path))
>
> @@ -1463,6 +1466,8 @@ class P4Submit(Command, P4UserMap):
>          #
>          system(applyPatchCmd)
>
> +        for f in filesToChangeType:
> +            p4_edit(f, "-t", "auto")
>          for f in filesToAdd:
>              p4_add(f)
>          for f in filesToDelete:
> diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
> new file mode 100755
> index 0000000..b0a9f62
> --- /dev/null
> +++ b/t/t9827-git-p4-change-filetype.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Romain Picard
> +#
> +
> +test_description='git p4 support for file type change'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'create files' '
> +       (
> +               cd "$cli" &&
> +               p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
> +               cat >file1 <<-EOF &&
> +               This is a first file.
> +               EOF
> +               cat >file2 <<-EOF &&
> +               This is a second file whose type will change.
> +               EOF
> +               p4 add file1 file2 &&
> +               p4 submit -d "add files"
> +       )
> +'
> +
> +test_expect_success 'change file to symbolic link' '
> +       git p4 clone --dest="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git config git-p4.skipSubmitEdit true &&
> +
> +               rm file2 &&
> +               ln -s file1 file2 &&
> +               git add file2 &&
> +               git commit -m "symlink file1 to file2" &&
> +               git p4 submit &&
> +               p4 filelog -m 1 //depot/file2 >filelog &&
> +               grep "(symlink)" filelog
> +       )
> +'
> +
> +test_expect_success 'change symbolic link to file' '
> +       git p4 clone --dest="$git" //depot@all &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git config git-p4.skipSubmitEdit true &&
> +
> +               rm file2 &&
> +               cat >file2 <<-EOF &&
> +               This is another content for the second file.
> +               EOF
> +               git add file2 &&
> +               git commit -m "re-write file2" &&
> +               git p4 submit &&
> +               p4 filelog -m 1 //depot/file2 >filelog &&
> +               grep "(text)" filelog
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 2.6.4
>
