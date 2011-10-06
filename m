From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv3 2/5] Learn to handle gitfiles in enter_repo
Date: Thu, 6 Oct 2011 14:11:03 +1100
Message-ID: <CACsJy8BiZ7Ey95BOf4p-zwysyYwEY6WectRaj-GqnFvgDNTtZw@mail.gmail.com>
References: <4E8C5C2E.50309@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 05:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBeN8-0006Hg-65
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 05:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933239Ab1JFDLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 23:11:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38443 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1JFDLe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 23:11:34 -0400
Received: by bkbzt4 with SMTP id zt4so2888485bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NlfA4cArApBvjJJdoRP9BydQ1Xpg+NAWWi9mv75prSI=;
        b=c/FAjs1vEGBVFMZVID6unQSyIe4ODAifZj4saPjaZNLaxF+EPa4OcYNiE6+Oj1oJBu
         WpCAdtXdSRFMy85wAqGrkX4xUtHCAbaFbCCj/cEn6ZNPF+H5IKeX5thHUzgoDOwvC/qD
         DfGkTUOZM8dLYpIe75aO6iu6/+2zXdUIT/Hps=
Received: by 10.204.137.72 with SMTP id v8mr170785bkt.43.1317870693094; Wed,
 05 Oct 2011 20:11:33 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 20:11:03 -0700 (PDT)
In-Reply-To: <4E8C5C2E.50309@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182921>

On Thu, Oct 6, 2011 at 12:31 AM, Phil Hord <hordp@cisco.com> wrote:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!suffix[i] || =
chdir(used_path))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!suffix[i])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gitfile =3D read_g=
itfile(used_path) ;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gitfile)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strcpy(used_path, gitfile);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (chdir(used_pat=
h))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D valid=
ated_path;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

This is room for improvement, the patch is fine as it is now. We could
improve error reporting here. If .git file points to nowhere, we get
"not a repository-kind of message. Except daemon.c, enter_repo()
callers always die() if enter_repo() returns NULL. We could move the
die() part (with improved error message) into enter_repo().

We could update enter_repo(const char *, int) to enter_repo(const char
*, int, int gently). If gently is 1, we never die() nor report
anything (ie. what we're doing now). daemon.c will need this, the rest
of callers will be happy with gently =3D 0.
--=20
Duy
