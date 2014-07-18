From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 22/31] checkout: support checking out into a new
 working directory
Date: Fri, 18 Jul 2014 00:10:50 -0400
Message-ID: <CAPig+cRJjA3cby-gTUD_-amdd-LhMnQ6f1dyV4qQLPMoFXCm-A@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 06:10:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7zVY-00055t-AA
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 06:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbaGREKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 00:10:52 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34676 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaGREKv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 00:10:51 -0400
Received: by mail-yh0-f45.google.com with SMTP id 29so1937390yhl.32
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 21:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=NR5VNcIBnHtgxglPVUjQobjGG8JxYrRTYcTRa7L+0Gs=;
        b=v7WeD77RNAwhJ5B4vUbZWrn+RBGPvDx7KpbSGHB5h7nm5X733uFOpzKtex6VXx6l1o
         HPMnOQryvoz4+WAwJEYo5hNSfLHc3u/fUyxSSy8jWeu7X19m20Ia1enM5F51CfUJoj8d
         jc2BW5JtX62jxEimhT0HyadWgYPGXE3jnl9G505epsgbTRSMlH5FTVrnZIKkc3aWL1J7
         4yiH8F3r0z0W0B7QdKaTFl2g6UuuJRq6ZXEYJAolnk/zDAvadv+2yfJso9CEKMGEFZXC
         0Tt56VvjBv8m7ChAG03ecEc3TIk7AhrraMPdENJMky65I1pzi61VDxbcAIT9ts2Q66XI
         6iOg==
X-Received: by 10.236.130.77 with SMTP id j53mr2931908yhi.139.1405656651034;
 Thu, 17 Jul 2014 21:10:51 -0700 (PDT)
Received: by 10.170.115.148 with HTTP; Thu, 17 Jul 2014 21:10:50 -0700 (PDT)
In-Reply-To: <1405227068-25506-23-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 6gMimDsXrGECtSMkJK3jFaWOOoI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253793>

On Sun, Jul 13, 2014 at 12:50 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> "git checkout --to" sets up a new working directory with a .git file
> pointing to $GIT_DIR/repos/<id>. It then executes "git checkout" agai=
n
> on the new worktree with the same arguments except "--to" is taken
> out. The second checkout execution, which is not contaminated with an=
y
> info from the current repository, will actually check out and
> everything that normal "git checkout" does.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/g=
itrepository-layout.txt
> index 0f341fc..543d874 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -249,6 +249,13 @@ modules::
>         directory is ignored if $GIT_COMMON_DIR is set and
>         "$GIT_COMMON_DIR/modules" will be used instead.
>
> +repos::
> +       Contains worktree specific information of linked
> +       checkouts. Each subdirectory contains the worktree-related
> +       part of a linked checkout. This directory is ignored

s/ignored/ignored if/

> +       $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/repos" will be
> +       used instead.
> +
>  SEE ALSO
>  --------
>  linkgit:git-init[1],
