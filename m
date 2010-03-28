From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] builtins: reset startup_info->have_run_setup_gitdir when 
	unsetting up repository
Date: Sun, 28 Mar 2010 09:11:21 +0200
Message-ID: <fcaeb9bf1003280011r4c25a076t22d8759de31c3e3f@mail.gmail.com>
References: <1269681184-1992-1-git-send-email-pclouds@gmail.com> 
	<1269681184-1992-2-git-send-email-pclouds@gmail.com> <20100327223813.GA5809@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 09:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvmf9-0007uu-Q2
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 09:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab0C1HLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 03:11:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:45945 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab0C1HLl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Mar 2010 03:11:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2953762qwh.37
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Jir5tRGku7MjYOrY4KomDQ38Gz5nJs4zsC03RYxPRzA=;
        b=vRyPMFhtXJBlwqyc18E7qO2pRJLameIqpiqfN6hymh4Vh1hnR0qG2tEkIV1RTXkwz2
         FjR96+R23zyyZNwf1nJoC8v69gBV3+kRwtetD7Yj2j12K3+KTrxsRT7e3qBFxn+Kx0Hp
         pPgxZdWJnb+KUAu4KxHfL6CCU0kXbdnFKq1Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GC8SmCOcOyHR54OuJn+qNaQo21pZnUVjDong+Wl1a3qM+6FTFUmf+8SCTExH/pg+de
         Y65axwJpmwqAt2EMGd4MgKXP1fFnxzibknJmOwE3cZixpegZikWvUnYa44UNxQXBxrHb
         zZUi3rTRvyYeh7WK3m6uX+oQLIWqOIvvwKYyg=
Received: by 10.229.221.195 with HTTP; Sun, 28 Mar 2010 00:11:21 -0700 (PDT)
In-Reply-To: <20100327223813.GA5809@progeny.tock>
Received: by 10.229.98.129 with SMTP id q1mr2729757qcn.100.1269760301120; Sun, 
	28 Mar 2010 00:11:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143380>

2010/3/27 Jonathan Nieder <jrnieder@gmail.com>:
> Hi again,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> While at it, also reset repository_format_version to zero. When
>> omitted, the format should be understood as the last supported
>> version, i.e. zero. This is probably only used by "git init" or "git
>> clone".
> [...]
>> =C2=A0 =C2=A0 =C2=A0 /* Initialized in check_repository_format_versi=
on() */
>> - =C2=A0 =C2=A0 repository_format_version =3D 0xFF;
>> + =C2=A0 =C2=A0 repository_format_version =3D 0;
>
> Good change, but wrong justification in my opinion.
>
> v0.99.9l^2~54 (init-db: check template and repository format.,
> 2005-11-25) taught =E2=80=98git init-db=E2=80=99 to make sure that
>
> =C2=A0repository_format_version <=3D GIT_REPO_VERSION
>
> before initializing a new repository. =C2=A0repository_format_version=
 was
> being explicitly initialized globally to 0 at the time, presumably to
> ensure tests like this always succeed when no repository format versi=
on
> is declared (or in other words, the repository format for repositorie=
s
> initialized before git v0.99.9l^2~56 is zero by convention). =C2=A0As=
 a happy
> side effect, that default takes care of the =E2=80=9Cno pre-existing =
repository=E2=80=9D
> case here.
>
> The explicit initialization was removed in commit v1.4.3-rc1~230 (rem=
ove
> unnecessary initializations, 2006-08-15), since according to ANSI C i=
t
> is redundant.
>
> So I think the convention is not =E2=80=9Cif in doubt, the repository=
 has
> version GIT_REPO_VERSION=E2=80=9D but =E2=80=9Cif the repository lack=
s a
> core.repositoryversion setting, it must be really old=E2=80=9D.

Makes sense. Thanks. Will leave a note at the initialization to reduce
history digging time for other people.
--=20
Duy
