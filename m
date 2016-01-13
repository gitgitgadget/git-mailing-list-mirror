From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3] git-p4.py: add support for filetype change
Date: Wed, 13 Jan 2016 07:02:57 +0000
Message-ID: <CAE5ih78XSq5kFmmOYKCw0zF-NEgWH8+HS-0cHse_-mGR8r355A@mail.gmail.com>
References: <1452602627-8402-1-git-send-email-romain.picard@oakbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git-owner@vger.kernel.org
To: Romain Picard <romain.picard@oakbits.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:03:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFSS-0001ht-B2
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbcAMHC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 02:02:59 -0500
Received: from mail-ig0-f196.google.com ([209.85.213.196]:32926 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcAMHC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:02:58 -0500
Received: by mail-ig0-f196.google.com with SMTP id h5so2638671igh.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 23:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KI4deYLwfIVBX88xl6+54oHdXUA0QxW7j94uP0l1WZY=;
        b=dm4GqGamhLGX0O7qxK5KBFpf7H/Ihzpp7CHTUyOdVpEqQH/ozLcJp36w/bOIfwLroT
         7CCmHK6PTR6hUkEzGy7Q4+fiqLrOG8PvhDNa+Lx+qP+7ZVR7y8DfdgI4i4PJvOF07unQ
         uDwoNSBsf8cZ4edGlImjFM6gbEAdKeIC3el/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KI4deYLwfIVBX88xl6+54oHdXUA0QxW7j94uP0l1WZY=;
        b=kkBueIvaz+9F4tB/Ftp0AOz0SH1+gQTHV9+ipwYYtuhvA7iaZT66Chgu9SF15T04nn
         6U6rhFMFoaoKhzK/qdmV+p5Kva/mjOqXiiR3BuFp4oT8fomzeZNkbowoAk6wKRecelX+
         L2QrxvVGSEFSq+VcYUI3lCYzVKXhVZQxiYHLTrJ0uyDtI2/jiiiGaVMPzcJWnDvI/V4u
         XfZL/6+5Y/ZRtkt/BvZnhwlauRxec5KmAh74yPzrJzf9dOCmCIv5uDqXfg0EU7o+g8VQ
         6JWPvpbtgI8oS41ySE3RYCEWfngxmxYeYRPS7PfK3x+FPwA3yOPQpdM5TNcuosg0d27C
         +xcg==
X-Gm-Message-State: ALoCoQmPdDG+OoMDOvmuSxzlWYux4E6ncbBTtCKhv7vIg+3bGDxUZe92hk8w9MlqAQPuQ3r2oejN922dWrO4HpxoINvqq7cHIA==
X-Received: by 10.50.4.101 with SMTP id j5mr22383273igj.47.1452668577520; Tue,
 12 Jan 2016 23:02:57 -0800 (PST)
Received: by 10.79.66.65 with HTTP; Tue, 12 Jan 2016 23:02:57 -0800 (PST)
In-Reply-To: <1452602627-8402-1-git-send-email-romain.picard@oakbits.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283889>

On 12 January 2016 at 12:43, Romain Picard <romain.picard@oakbits.com> wrote:
> After changing the type of a file in the git repository, it is not possible to
> "git p4 publish" the commit to perforce. This is due to the fact that the git
> "T" status is not handled in git-p4.py. This can typically occur when replacing
> an existing file with a symbolic link.
>
> The "T" modifier is now supported in git-p4.py. When a file type has changed,
> inform perforce with the "p4 edit -f auto" command.

Looks good to me, thanks.

Ack.

>
> Signed-off-by: Romain Picard <romain.picard@oakbits.com>
> ---
>  git-p4.py                         |  9 ++++--
>  t/t9827-git-p4-change-filetype.sh | 66 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 2 deletions(-)
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
> index 0000000..7433998
> --- /dev/null
> +++ b/t/t9827-git-p4-change-filetype.sh
> @@ -0,0 +1,66 @@
> +#!/bin/sh
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
> +               text without any funny substitution business
> +               EOF
> +               cat >file2 <<-EOF &&
> +               second file whose type will change
> +               EOF
> +               p4 add file1 file2 &&
> +               p4 submit -d "add files"
> +       )
> +'
> +
> +test_expect_success SYMLINKS 'change file to symbolic link' '
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
> +test_expect_success SYMLINKS 'change symbolic link to file' '
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
