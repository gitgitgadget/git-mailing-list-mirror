From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Ignoring remote branches.
Date: Wed, 12 May 2010 05:25:12 -0500
Message-ID: <20100512102512.GA17810@progeny.tock>
References: <9F4F3DE1-59FE-4D27-A40E-81856BF95C9D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 12:25:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC97g-00051v-2H
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 12:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab0ELKY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 06:24:58 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:49683 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0ELKY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 06:24:57 -0400
Received: by gxk27 with SMTP id 27so13372gxk.1
        for <git@vger.kernel.org>; Wed, 12 May 2010 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0MBsG2ZjALs0cqvT0Tr9aca/ozKfdCtAlAsft+f9YPk=;
        b=j0lg/+sjVN2Ar7hEbfcNzwL/GCsX8vnaD4cx6GLyaOx+B35V7njtk652vKaIJ6Powt
         1f1EG7f6GXeau02vX2FifH2Mqz4hQJP5Wowwxx5lwjMtM+yWeIGFlhiyHfnCr4IAFbuh
         PYXS0Dq30S5Sy0WT7wEWpRTPWRP/Z+Lk7DM1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mc7EfYa4wMIkIsk95CuiEMTatgAECj9dBkC6EHca6DrvjsNSvailL9TzKNUGiEpMAc
         5r0jXNAKg82IgKwXs9FYyt2X2REixkywT8FAfwPYjR0X/RLgjICzCsbh5VApGUQmJxcd
         27w0m1NR4bcE0C4kWb5UZPUrKkNxt7HdFfT5U=
Received: by 10.150.243.17 with SMTP id q17mr13473876ybh.103.1273659895676;
        Wed, 12 May 2010 03:24:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4816ywh.8.2010.05.12.03.24.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 03:24:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9F4F3DE1-59FE-4D27-A40E-81856BF95C9D@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146936>

Hi Steven,

Steven Michalske wrote:

> I want to track new branches, so specifying the branches I want
> to fetch is tedious.
>=20
> Any workarounds to ignore all branches that match *.stgit

I would suggest using =E2=80=98git ls-remote=E2=80=99 and =E2=80=98git =
fetch=E2=80=99 to grab just the
branches you want.

  #!/bin/sh
  set -e

  : ${remote=3Dorigin}
  : ${options=3D--dry-run}
  script=3D'!/\.stgit$/ s'
  script=3D"${script}#.*\\trefs/heads/\\(.*\\)\$"
  script=3D"${script}#git fetch $options $remote "
  script=3D"${script} refs/heads/\\1:refs/remotes/$remote/\\1"
  script=3D"${script}#p"

  eval "$(git ls-remote "$remote" | sed -n "$script")"

I am not sure how to generalize this: a pre-fetch hook that can reject
some branch names?  a fetchregexp configuration item?

 [remote "origin"]
	url =3D git://git.example.com/repo.git/
	fetchregexp =3D "refs/heads/\([^.]*\):refs/remotes/origin/\1"

Maybe we can solve some similar problems at the same time.

Thanks,
Jonathan
