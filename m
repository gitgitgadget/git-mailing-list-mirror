From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4.py: add support for filetype change
Date: Sat, 26 Dec 2015 10:26:41 +0000
Message-ID: <CAE5ih7-3H=O8GqzGebzKTttwUs=HRA+B+pV85sfWoesAvKXKgg@mail.gmail.com>
References: <1450703365-10427-1-git-send-email-romain.picard@oakbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Romain Picard <romain.picard@oakbits.com>
X-From: git-owner@vger.kernel.org Sat Dec 26 11:27:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCm4D-00057O-Fo
	for gcvg-git-2@plane.gmane.org; Sat, 26 Dec 2015 11:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbbLZK0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2015 05:26:43 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:36299 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbLZK0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 05:26:42 -0500
Received: by mail-io0-f174.google.com with SMTP id o67so272435155iof.3
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=betdyl42GsYLJBAk6IWRs6ljIvOFsJGXJNRcKlFm94E=;
        b=O+fNM1iD/A9RZY7vrAiylO3POEUkSEB2ZUfPYnDRNE+tqoUQzd6L/7M+7onFM/zpts
         fVi/jSMXSuQ2Iyn0ep/LchIdGzqJPyuqjeHZF3Hu6sJ0RMnsJp9bSjHaz9d1UKPL5KTb
         gA09fEYOK6M7KPx3ADQNhDXM76B3XPVoNPCPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=betdyl42GsYLJBAk6IWRs6ljIvOFsJGXJNRcKlFm94E=;
        b=eXLvqmKHUBcW7jFJTKngEfXFetrKvgGsSV1T3PKAwR1MpyagEkJiMtO+v0AxgspFAR
         7CMvO++edbDxYQ9hrIoqKtwyRCQ5x46a4fPh0lXgN8guA4VGtFojtixY2MapizHG5dU8
         YUj8Ok2T+J77KbobUzsGJqVmw1P8YmQ7+QF24jaP852G8Fh9N2OTrLY00h0F4u4Gpr6r
         JdxerFenc7vMy+xmri6VmiyY6DQhZpq4pK19Fmw7t5y7o/Y94c/MfyYYmNXudivwU+Ax
         vxTuB4Ku6D1Qnaq1uU750Z9qls4/hvmbj4iE6VUzYsEvdZWvkspvUtMzq/tjoeFjWx0J
         +Phg==
X-Gm-Message-State: ALoCoQkRZCAywhVONe9/kAO/U7Wcr/N5KHIQU5Gcdgp6xrQ8RO/pIKrR8GnS3SPgSVjGohdo/dvkg1Er7nULvYdW72jTbbZsdA==
X-Received: by 10.107.157.148 with SMTP id g142mr42409338ioe.151.1451125601416;
 Sat, 26 Dec 2015 02:26:41 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Sat, 26 Dec 2015 02:26:41 -0800 (PST)
In-Reply-To: <1450703365-10427-1-git-send-email-romain.picard@oakbits.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282996>

On 21 December 2015 at 13:09, Romain Picard <romain.picard@oakbits.com> wrote:
> After changing the type of a file in the git repository, it is not possible to
> "git p4 publish" the commit to perforce. This is due to the fact that the git
> "T" status is not handled in git-p4.py. This can typically occur when replacing
> an existing file with a symbolic link.
>
> The "T" modifier is now supported in git-p4.py. When a file type has changed,
> inform perforce with the "p4 edit -f auto" command.

Romain,

Thanks for looking at this. It looks like a reasonable change.

Do you think you could add a unit test as well?

Thanks
Luke


>
> Signed-off-by: Romain Picard <romain.picard@oakbits.com>
> ---
>  git-p4.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
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
> --
> 2.6.4
