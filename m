From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-svn: fix fetch with deleted tag
Date: Sat, 14 Aug 2010 14:52:48 +0000
Message-ID: <AANLkTinpLUyQP=6XktduWAmSHg3CgcT3Y7cMJ9FQ4by_@mail.gmail.com>
References: <1281794831-33347-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sat Aug 14 16:53:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkI6V-0006xK-DB
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 16:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab0HNOwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 10:52:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45686 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab0HNOwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 10:52:50 -0400
Received: by gxk23 with SMTP id 23so1396160gxk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sGOSGPxhkB6Z0RJZOYbQaeWvxTVPv55C6tb/V8CP4Bg=;
        b=v7ZujYEEuNnfYstXMx0HRPFO8mGKqXMCnrcbBUS6lXLXcIkgTVVWzonR47NWd5Da5V
         CKTxFSX1HR0PlGuRsRIg/TQNVQvwN798cTC4SQKSAjUGgZxEZZny9dq7+Mdu9edKH4nF
         7j0TBSwi/m56uiXFqkvfebVN0AwM31VlM2/FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AzL2Fasm6YiUjWmsqK8hRVromqf80uZndXUbh6I/z4LQhIn9pjdKqsIsxLczE/KhJX
         NkCsugnGLI43NsQiVj2SgpqkJxrIyxCkpsSXo6QxNqxrudLlXUIn3rt/ZD8PoYB+y7x7
         FDdY8jF4np25OFYEeCgZUkh+tyMSYJX8gxaG8=
Received: by 10.231.15.195 with SMTP id l3mr2877891iba.188.1281797568934; Sat,
 14 Aug 2010 07:52:48 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 07:52:48 -0700 (PDT)
In-Reply-To: <1281794831-33347-1-git-send-email-ddkilzer@kilzer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153562>

On Sat, Aug 14, 2010 at 14:07, David D. Kilzer <ddkilzer@kilzer.net> wr=
ote:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 my ($url, undef, undef) =3D ::cmt_metadata($max_commit);

This can just be:

    my ($url) =3D ::cmt_metadata($max_commit);

Perl will throw the extra arguments away for you.

> +test_expect_success 'setup svn repo' '
> + =C2=A0 =C2=A0 =C2=A0 mkdir -p import/trunk/subdir &&
> + =C2=A0 =C2=A0 =C2=A0 mkdir -p import/branches &&
> + =C2=A0 =C2=A0 =C2=A0 mkdir -p import/tags &&
> + =C2=A0 =C2=A0 =C2=A0 echo "base" > import/trunk/subdir/file &&

Junio usually prefers the ">foo" style to "> foo".

> + =C2=A0 =C2=A0 =C2=A0 cd svn_project &&
> +
> + =C2=A0 =C2=A0 =C2=A0 echo "trunk change" >> subdir/file &&
> + =C2=A0 =C2=A0 =C2=A0 svn_cmd ci -m "trunk change" subdir/file &&
> +
> + =C2=A0 =C2=A0 =C2=A0 svn_cmd switch "$svnrepo/branches/mybranch/tru=
nk" &&
> + =C2=A0 =C2=A0 =C2=A0 echo "branch change" >> subdir/file &&
> + =C2=A0 =C2=A0 =C2=A0 svn_cmd ci -m "branch change" subdir/file &&
> +
> + =C2=A0 =C2=A0 =C2=A0 cd .. &&

If you use a subshell here it'll cd back for you.

> +++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +
> +test_description=3D'git svn fetch deleted tag 2'

Any reason not to include both of these in the same file? Just to
avoid having to manually reset the repository?

</nitpicks>
