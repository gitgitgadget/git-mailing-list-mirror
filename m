From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 21:48:57 +0700
Message-ID: <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com> <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org> <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 15:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfZLq-0003BJ-JM
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 15:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab1ASOt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jan 2011 09:49:29 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61835 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab1ASOt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 09:49:29 -0500
Received: by eye27 with SMTP id 27so424853eye.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=278SkbalzBEq++wGql49e4QeX5QjL2yX0xqvwA0FXgQ=;
        b=Hq9MrAh4GDGwh+6X9TwbVGDB7Ud/de+Nw6lGtJZwyanMma0IugAAkUS/5TfrB/XIgw
         DsLw1Q9qpUp+RdDXNiF3KMqQSAZn0RG/ZWC1COfR+1E+hmcz1Eykej2EG/W6HfbjNv5V
         MnHWEyaAq22qglDV2YHxCW81xzL7Usg3BOkj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A/6fRZ4KH7WzU5Alqv35o9QZJ2PvWu911TjQrYfi0HRgDiIm01mM1eaqqTcGPhHlXp
         NZRgCuVG0X6snkGkqHhUY8pAnISIDhDJK6A68AvKfPgyiv+GuEOdpPymo65FF6FUQlCs
         DIccFPIDKv1ggg7ZKxrGHrIbkWtWOAUfzro2o=
Received: by 10.216.51.67 with SMTP id a45mr2642025wec.19.1295448567705; Wed,
 19 Jan 2011 06:49:27 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 19 Jan 2011 06:48:57 -0800 (PST)
In-Reply-To: <20110119124230.GD23222@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165271>

2011/1/19 Jonathan Nieder <jrnieder@gmail.com>:
> @@ -411,6 +411,16 @@ static const char *setup_discovered_git_dir(cons=
t char *gitdir,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_repository_format_gently(gitdir,=
 nongit_ok))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>
> + =C2=A0 =C2=A0 =C2=A0 /* Accept --work-tree to support old scripts t=
hat played with fire. */
> + =C2=A0 =C2=A0 =C2=A0 if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_w=
ork_tree_cfg) {

Can we leave git_work_tree_cfg out? If this code is to support misused
scripts, then $GIT_WORK_TREE alone ought to be enough. I don't think
any scripts would use core.worktree. Most of worktree headache comes
from core.worktree, not $GIT_WORK_TREE. Granted though the situation
is better now that we don't set worktree in setup_git_directory().

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning("pretendin=
g GIT_DIR was supplied alongside GIT_WORK_TREE");

What if core.worktree is set, not $GIT_WORK_TREE? In my opinion

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset !=3D le=
n && !is_absolute_path(gitdir))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 gitdir =3D xstrdup(make_absolute_path(gitdir));

The behavior regarding relative $GIT_WORK_TREE before nd/setup series
is inconsistent. If setup_git_directory() is used, work_tree is
relative to user's cwd. In other cases, when get_git_work_tree() is
called, work_tree is made absolute relative to _current_ cwd (usually
at discovered work_tree root). Which way do you want to keep?
--=20
Duy
