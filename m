From: Cheng Renquan <crquan@gmail.com>
Subject: [RFC] git branch --status ?
Date: Tue, 4 May 2010 02:31:14 +0800
Message-ID: <p2i91b13c311005031131vc876475fn674c0ceffbdb3cf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 03 20:31:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O90QQ-0003y8-KN
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 20:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0ECSbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 14:31:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42606 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab0ECSbV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 14:31:21 -0400
Received: by vws19 with SMTP id 19so1997808vws.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=XL95Er0y4kDPVnJnv4Sv11ISNc1olkRPgoLOJVtT5Yk=;
        b=kXtkIape/pZ6nLf5rI+gXyxBXvstNirCyIuCeLT7zih2/vvMvmZgi1txI1jM1o3Xav
         MB0j6eQjJaODX9PF3dwJ1d87VIXbfgUM8VhPJt66cYSYdmuJwjORJKY+dFNadBNSBokU
         lBUTfvuDSgtLKpnrrr8EqO145hv0J7jElcZc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=MFOY21s3H7c6E8c0tORM+6KibY7M19wZETFkYDOtBIqU5TmsgnKm0ad/5o/bE/Sgcd
         CTE+aSxKjgtIyvOYOkgEyf6sLryZTJsgPEobPlIl5JdG93aasHrwXhaL9jHs9bJGlklR
         FTUeS8She98xRAwGlJgQMPZD17FsNBHBlsBZU=
Received: by 10.220.126.222 with SMTP id d30mr1590525vcs.198.1272911475967; 
	Mon, 03 May 2010 11:31:15 -0700 (PDT)
Received: by 10.220.16.79 with HTTP; Mon, 3 May 2010 11:31:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146249>

Hi, all,
  I'm considering to do a feature patch that is useful for this scenari=
o:

$ git remote -v update
Updating geko-ceph
=46rom git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client
 =3D [up to date]      for-linus  -> geko-ceph/for-linus
 =3D [up to date]      for-next   -> geko-ceph/for-next
 =3D [up to date]      master     -> geko-ceph/master
 =3D [up to date]      rbd        -> geko-ceph/rbd
 =3D [up to date]      unstable   -> geko-ceph/unstable
Updating newd-ceph
=46rom git://ceph.newdream.net/ceph-client
 =3D [up to date]      addr_cleanup -> newd-ceph/addr_cleanup
 =3D [up to date]      auth       -> newd-ceph/auth
 =3D [up to date]      bookkeeper -> newd-ceph/bookkeeper
 =3D [up to date]      cephdev    -> newd-ceph/cephdev
 =3D [up to date]      for-next   -> newd-ceph/for-next
 =3D [up to date]      master     -> newd-ceph/master
 =3D [up to date]      msgr       -> newd-ceph/msgr
 =3D [up to date]      osd-timeout -> newd-ceph/osd-timeout
 =3D [up to date]      pgcache    -> newd-ceph/pgcache
 =3D [up to date]      pgcache2   -> newd-ceph/pgcache2
 =3D [up to date]      pgcache3   -> newd-ceph/pgcache3
 =3D [up to date]      rbd        -> newd-ceph/rbd
 =3D [up to date]      rbd2       -> newd-ceph/rbd2
 =3D [up to date]      reconnect  -> newd-ceph/reconnect
 =3D [up to date]      unstable   -> newd-ceph/unstable
 =3D [up to date]      upstream   -> newd-ceph/upstream

after this kind of remote update, usually we want to know:
1) which remote branch is the latest? (then know which branch is most v=
aluable)
2) the latest commit information of every branch (remote & local) ?

I'd like to use "git branch -a --status" to achieve this feature,
something like:

$ git branch -a --status

git branch -a
  master [%h %an %ad %s]
* new33 [%h %an %ad %s]
  remotes/geko-ceph/for-linus [%h %an %ad %s]
  remotes/geko-ceph/for-next ...
  remotes/geko-ceph/master ...
  remotes/geko-ceph/rbd
  remotes/geko-ceph/unstable
  remotes/newd-ceph/addr_cleanup
  remotes/newd-ceph/auth

So now for everyone here,
1) how do you think it's useful?
2) if some current command with some switches has done the goal?
   (then I don't need to implement it,)
2) if not; which command switch (other than "branch --status") do you p=
refer?
3) implementation suggestions?

Thanks & Cheers,

--
Cheng Renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8), Singapore
