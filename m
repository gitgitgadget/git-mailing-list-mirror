From: Dennis Heidsiek <dennis.heidsiek@gmail.com>
Subject: [BUG] git fetch --all --tags doesn't fetch remote branches, only
 tags
Date: Tue, 01 Jan 2013 01:43:09 +0100
Message-ID: <50E2311D.8080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 02:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpqHQ-0007n1-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 02:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3AAAnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 19:43:17 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:60253 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab3AAAnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 19:43:16 -0500
Received: by mail-bk0-f47.google.com with SMTP id j4so5543222bkw.6
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 16:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=glqjPXv86G5Xpdgmd1jvChGRCUar2xnQnt0ZkB8tLg8=;
        b=won+FV10EGJdRf6CltYRowexRsRoODm6ce5BTlxiguRwGd5Pmn9LIvRl2CMcYF0X0S
         CTtDfIDmpIYKNj/ZvCewbT+xHVCVF80onYrd65NfGQD+WuSU8SGsanR8URpmZInlO4Cy
         OCTKvEngsHbhA3XJMmVvnnSaUkrBBz9F08Tw+xNFPtbWd5hxFkcFHhxwrRtVgIljSRHX
         HZjwHcJFE87lacvRVhRxgPfwSgNCJ6POlbss4ndpzvIIEIR5kFgKA0krrs0oE/U2jHLY
         StrEO8jI19fjDfqxfj1yi/zCJK8JHjyB/R9xbYysZoeoJvmJd40irWqMxL/VKwD75Yu7
         IAFA==
X-Received: by 10.204.7.92 with SMTP id c28mr19684714bkc.86.1357000994293;
        Mon, 31 Dec 2012 16:43:14 -0800 (PST)
Received: from [192.168.178.20] (p57AEC654.dip0.t-ipconnect.de. [87.174.198.84])
        by mx.google.com with ESMTPS id o7sm28469887bkv.13.2012.12.31.16.43.11
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 16:43:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212373>

Dear Git community,


i think there may be a bug in the fetch command: The command

> $ git fetch --all --tags
> Fetching origin

doesn=E2=80=99t fetch new commits from origin/master, while i see via t=
he web browser of my remote repository that they exist. The same with v=
erbose:

> $ git fetch --all --tags --verbose
> Fetching origin
> From git://repo.or.cz/wortliste
>  =3D [up to date]      Trennmuster-20071020 -> Trennmuster-20071020
>  =3D [up to date]      Trennmuster-20071223 -> Trennmuster-20071223
>  =3D [up to date]      Trennmuster-20080601 -> Trennmuster-20080601
>  =3D [up to date]      dehyph-exptl-v0.1 -> dehyph-exptl-v0.1
>  =3D [up to date]      dehyph-exptl-v0.11 -> dehyph-exptl-v0.11
>  =3D [up to date]      dehyph-exptl-v0.12 -> dehyph-exptl-v0.12
>  =3D [up to date]      dehyph-exptl-v0.12.1 -> dehyph-exptl-v0.12.1
>  =3D [up to date]      dehyph-exptl-v0.13 -> dehyph-exptl-v0.13
>  =3D [up to date]      dehyph-exptl-v0.20 -> dehyph-exptl-v0.20
>  =3D [up to date]      dehyph-exptl-v0.22 -> dehyph-exptl-v0.22
>  =3D [up to date]      dehyph-exptl-v0.23 -> dehyph-exptl-v0.23

Only if i omit the --tags commit, fetch does what i expect:

> $ git fetch --all --verbose
> Fetching origin
> remote: Counting objects: 13, done.
> remote: Compressing objects: 100% (8/8), done.
> remote: Total 8 (delta 5), reused 0 (delta 0)
> Unpacking objects: 100% (8/8), done.
> From git://repo.or.cz/wortliste
>    7c71430..176027b  master     -> origin/master
>  =3D [up to date] Keine-Haupttrennstellen-in-zweisilbigen-W=C3=B6rter=
n -> origin/Keine-Haupttrennstellen-in-zweisilbigen-W=C3=B6rtern
>  =3D [up to date]      python-skripts -> origin/python-skripts

I think this may be a bug; i=E2=80=99m using my git alias fa =3D fetch =
--all --tags --verbose quite often, and it worked in previous versions =
of Git.

=46innally, i=E2=80=99m using Git 1.8.0.3  under Ubuntu 10.04.4 LTS x86=
_64 via this PPA: https://launchpad.net/~git-core/+archive/ppa

Thank you for your time reading this and of cause a happy new year!


With best greetings,
Dennis Heidsiek


PS: I=E2=80=99m no subscriber of the Git mailing list.
