From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: Issue fetching tags error: unable to find eb03b... ; git fsck
 shows no problem...
Date: Wed, 7 Sep 2011 17:30:32 +0100
Message-ID: <CACyv8dfopPtqWxMYwx3wGipc8+v7iPJO4+Esjk51kGuN8BSwuA@mail.gmail.com>
References: <CACyv8dcTi0pG_GPvxD1zoTf6iRG81KbaY43FA-pbxYJz2UVJcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 18:31:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1L2D-0000sp-Ko
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab1IGQae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 12:30:34 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36203 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab1IGQad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:30:33 -0400
Received: by vxj15 with SMTP id 15so496077vxj.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=aWL9RE5he8HZ5OrKdjM0PjXEcokJPLferFhpHFlY0AI=;
        b=Y7/x62lUD+mM7q9ezS4b/WbTzU6vzKs6u2PMAaNmkPn8+FORtEFCDoO+igrl9pBbBL
         ShXT5zmnawNL3qoTPjYHf9Iw1hWUBoeDFWOTzHSck8GKicOAvpijbanGNyWkSxOapQek
         2DwmQRryAC5hp/s/Xz5EmjMvEk3MeNXOAFp00=
Received: by 10.52.30.35 with SMTP id p3mr531108vdh.231.1315413032495; Wed, 07
 Sep 2011 09:30:32 -0700 (PDT)
Received: by 10.220.202.12 with HTTP; Wed, 7 Sep 2011 09:30:32 -0700 (PDT)
In-Reply-To: <CACyv8dcTi0pG_GPvxD1zoTf6iRG81KbaY43FA-pbxYJz2UVJcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180863>

I can get the fetch to work, by removing refs/original in the source re=
po:

bash:jamesb:xl-cbga-20:32942> git fetch --tags old
remote: Counting objects: 35469, done.
remote: Compressing objects: 100% (11562/11562), done.
remote: Total 33792 (delta 18883), reused 30509 (delta 16197)
Receiving objects: 100% (33792/33792), 28.10 MiB | 8.28 MiB/s, done.
Resolving deltas: 100% (18883/18883), completed with 443 local objects.
error: unable to find eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f
fatal: object eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f not found

bash:jamesb:xl-cbga-20:32943> rm -rf ../old_tagsX/.git/refs/original/
bash:jamesb:xl-cbga-20:32944> git fetch --tags old
remote: Counting objects: 1404, done.
remote: Compressing objects: 100% (570/570), done.
remote: Total 1014 (delta 480), reused 659 (delta 233)
Receiving objects: 100% (1014/1014), 1.66 MiB, done.
Resolving deltas: 100% (480/480), completed with 195 local objects.
=46rom ../old_tagsX
 * [new tag]         3.2.0-5    -> 3.2.0-5
=2E..

bash:jamesb:xl-cbga-20:32945> git show eb03ba0f40fb2b6a3287036d851d2506=
e4ea4f8f
commit eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f
Author: (no author) <(no author)@e3bda1c8-b8c7-484d-b8f9-8c0514bc73ff>
Date:   Tue Oct 10 09:44:47 2006 +0000

    This commit was manufactured by cvs2svn to create tag 'releases/3_2=
_0-5'.
=2E..


Note that the object was present all along!

(In old_repo I had done: git filter-branch --prune-empty -- --all)

I have a backup of the repo, and this is repeatable for me, is there
an odd interaction between fetch and refs/original?

Cheers,
James


On 7 September 2011 17:14, James Blackburn <jamesblackburn@gmail.com> w=
rote:
> Hi All,
>
> I've got an error I can't seem to resolve. Fsck reports both my
> repositories are OK, but git fetch --tags tells me it can't find an
> object.
>
> bash:jamesb:xl-cbga-20:32867> git --version
> git version 1.7.6
> bash:jamesb:xl-cbga-20:32864> git remote add old_tags ../old_tags/
> bash:jamesb:xl-cbga-20:32865> git fetch old_tags
> From ../old_tags
> * [new branch] =A0 =A0 =A0master =A0 =A0 -> old_tags/master
> ...
> bash:jamesb:xl-cbga-20:32866> git fetch --tags old_tags
> remote: Counting objects: 33613, done.
> remote: Compressing objects: 100% (11778/11778), done.
> remote: Total 33529 (delta 18473), reused 30013 (delta 15779)
> Receiving objects: 100% (33529/33529), 28.59 MiB | 8.06 MiB/s, done.
> Resolving deltas: 100% (18473/18473), completed with 17 local objects=
=2E
> error: unable to find eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f
> fatal: object eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f not found
>
> git fsck --full shows no errors in old_tags.
> git show eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f in old_tags seems t=
o work:
>
> commit eb03ba0f40fb2b6a3287036d851d2506e4ea4f8f
> Author: (no author) <(no author)@e3bda1c8-b8c7-484d-b8f9-8c0514bc73ff=
>
> Date: =A0 Tue Oct 10 09:44:47 2006 +0000
>
> =A0 =A0This commit was manufactured by cvs2svn to create tag 'release=
s/3_2_0-5'.
>
> =A0 =A0git-svn-id: svn://eng-cbga-2/tools/eclipse/tags/releases/3_2_0=
-5@39
> e3bda1c8-b8c7-484d-b8f9-8c0514bc73ff
>
> diff --git a/org.eclipse.cdt/org.eclipse.cdt.doc.isv/reference/api/al=
lclasses-frame.html
> b/org.eclipse.cdt/org.eclipse.cdt.doc.isv/reference/api/
> allclasses-frame.html
> ...
>
>
> Any ideas how to resolve this?
>
> Cheers,
> James
>
