From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git ls-files unreliable?
Date: Fri, 2 Apr 2010 22:54:28 +0200
Message-ID: <n2p81b0412b1004021354z1ca4f6b4sa4400b484d97b46e@mail.gmail.com>
References: <20100402180842.GA5798@twister.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 22:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxnsz-0007i5-AT
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 22:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab0DBUya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 16:54:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41357 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab0DBUy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 16:54:29 -0400
Received: by gyg13 with SMTP id 13so1166186gyg.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=yGmot4l2gT5Izd5/aXH+fK/brC9LXIvneFPQx7fvpVU=;
        b=ABCCfSzRb64PzFQAmTkMS+YALl/8cCIB+FWbhuO63KjKtngkOro5zk12G/dJN9Ox83
         GajzpR272LZ5JLiV3MqNUJ59Mo1FqmJOQSy/cK9BnvVtNVk5pSb7Qy7Ub1of247TFPvw
         ilAxOzpf0zEYdbDW9iJrGCPmmvGNLDJEr4abM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=T/d9Nw8sMYUgm2xO/+xOYOczOm9zv3Rbp0Q+nZJXW+OoNvugF8+uXeA/TFEsCxz2Wa
         FJa3XpdcQUcf+2ckyyvfRDyaiclW9iR9RnX1VjUGk3lmaJbpwZoBC91hTQBisYaUEm/N
         RF6mfnLNgqWsVOn1h1zTth1+/ADX2oNnO/Z50=
Received: by 10.100.96.15 with HTTP; Fri, 2 Apr 2010 13:54:28 -0700 (PDT)
In-Reply-To: <20100402180842.GA5798@twister.home>
Received: by 10.101.4.27 with SMTP id g27mr6514794ani.221.1270241668162; Fri, 
	02 Apr 2010 13:54:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143850>

On Fri, Apr 2, 2010 at 20:08, Gabor Gombas <gombasg@digikabel.hu> wrote=
:
> Hi,
>
> I want to verify from a script that the working directory is clean. S=
ome
> time ago Linus suggested to use "git diff --quiet --cached" followed =
by

In your script, you seem to have missed the "diff" part

> "git ls-files --exclude-standard -o -d -m -u". But:
>
> $ git status
> # On branch git_workdir_check
> # Your branch is ahead of 'origin/master' by 1 commit.
> #
> # Changes to be committed:
> # =C2=A0 (use "git reset HEAD <file>..." to unstage)
> #
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 ../../../test
> #
> # Changed but not updated:
> # =C2=A0 (use "git add <file>..." to update what will be committed)
> # =C2=A0 (use "git checkout -- <file>..." to discard changes in worki=
ng
> # =C2=A0 directory)
> #
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 ../../../test
> #

Here. Were is your call to "git diff --cached"?

> $ git ls-files --exclude-standard -o -d -m -u
> $ echo $?
> 0

This is correct.

> So there _were_ uncommitted changes, "git status" showed them, but "g=
it
> ls-files" did not.

Because it is not supposed to. The command "git ls-files" just shows
the files not known to git. You have to parse the output. Not that it
is complicated in this particular case: you consider the workdir unclea=
n
on any output.

> Restriction: any solutions must work with git versions as old as 1.5.=
4.

It probably will, but please check "git diff --cached" exit code.
It may be always 0, in which case you'll have to fallback to
output parsing here too.
