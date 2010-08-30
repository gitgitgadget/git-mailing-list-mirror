From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 12/13] git-remote-testgit: only push for non-local repositories
Date: Sun, 29 Aug 2010 20:59:45 -0500
Message-ID: <AANLkTimf1S_1Y=E+3bCv6CgoChrxY3gT32crwDGdhbeN@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-13-git-send-email-srabbelier@gmail.com> <20100830014821.GF2305@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptfS-00079y-U3
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299Ab0H3CAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 22:00:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62643 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab0H3CAG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 22:00:06 -0400
Received: by yxp4 with SMTP id 4so126102yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5JeCRz+LiFrHHxWpKfCJqh8jpsMv+0nwatnoDpuBBdY=;
        b=lgxle7SGSuuPA6C+tozckxbwBtJyC/3Dy7TPmmyUlONsA3dC9jdT74l+VNPZZ1PJ0z
         whWlEyEG+Eb1r4E7AegcHTWHEuN7ePsXMqVGhk7z2a7FqVQ604u7IdJY5PMCbAquhCmS
         RZj2W4sXCpeScp9zqlN9O317GuPRqi82LzEt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Zc1XKVazjAVh0SqrWqLMoGBpwJxfwe18AuQSNzDqb34ETF57hAWaozuGIed+MpLtOZ
         vrCEcm9WUccssP2+LgkVwwIVF2Xr1cW5zBKu7LQEPLGQQDnyoG8xhClEkn18tk/2NEnS
         deQISDBDC628pLekGYvWFkNYzGCAc0MmjiNNA=
Received: by 10.150.49.8 with SMTP id w8mr990030ybw.363.1283133605313; Sun, 29
 Aug 2010 19:00:05 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 18:59:45 -0700 (PDT)
In-Reply-To: <20100830014821.GF2305@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154745>

Heya,

On Sun, Aug 29, 2010 at 20:48, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> [warning: I have not read through remote-testgit carefully]
>
> Could you explain further? =C2=A0I see
>
> =C2=A0ERROR: could not find repo at .git/info/fast-import/4dc49bf026b=
65e6a1b28e2457d4d6393af8d382c/.git

The repo in .git/info/... is only there iff the remote repo is not on
disk. If the remote _is_ on disk (i.e., repo.is_local),
`repo.importer.do_import(repo.gitdir)` will have directly updated the
remote. For remotes that are not on disk (i.e., not repo.is_local),
`repo.importer.do_import(repo.gitdir)` will have instead updated a
on-disk clone of the remote, which is stored in .git/info/...

So, to answer your question:

> but I do not know why there should have been a repo there

There should be a repo there only if the remote is not on disk.

> or why we would
> not want to do the equivalent of
>
> =C2=A0git push . refs/testgit/origin/refs/heads/master:refs/heads/mas=
ter

That isn't needed since the importer has already done that.

--=20
Cheers,

Sverre Rabbelier
