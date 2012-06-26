From: Left Right <olegsivokon@gmail.com>
Subject: Fwd: [bug report, possibly] Multiple pushes with passwords in URL
Date: Tue, 26 Jun 2012 21:43:22 +0300
Message-ID: <CAJQBtg=XN1Txsp8Q3C=GgxyZQvCK3vAJouJkXfZgwtG9hvuubw@mail.gmail.com>
References: <CAJQBtg=yg_T=Vfq--9oivbbK86bxqLONTOBSRA+wSp2iiHGaTA@mail.gmail.com>
	<CAJQBtg=-drwKEU2iSDeUWZPbO+OENNL-rDMoy6XYPrnzFV1VyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 20:43:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjajb-0007Ni-4U
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758623Ab2FZSnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 14:43:24 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40885 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562Ab2FZSnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 14:43:22 -0400
Received: by gglu4 with SMTP id u4so240316ggl.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=oKWrmgyXMSI3mhkRxmD+wMRvM44uQcJ+JriFp2ZqnCo=;
        b=Em5MzOwX3DOFhhuCNUDho1ez9yyRDkpwB1GHFPGBHOV0RkCfqfEmtKNilKEaK9EzCp
         P+gOZwiKHl0EknGPRf8/lSVVcsZtwFkXe6lfBGbRjiAr8u9AS/4ofKyYOPlq3j/ywup/
         YaZmylXULOhMBHQhyr8ZjOI6aJPJkXYHeyUD6dBXRk2omrGfcpiSrTeMBdxhTdINQui2
         S23wK8sD1Afxpw/Asuu1aaG6kBeqCVsto1gX9+WoraED4fwj1KF3pHxtvExSo//bZBGW
         5U1iXt1kknixphIWKe0nCDZN29ScvIHTsrYQ7SLF5Kd4Y4EJjAWgvJXZAYm0daNQFAve
         qiHQ==
Received: by 10.60.172.209 with SMTP id be17mr17465613oec.16.1340736202123;
 Tue, 26 Jun 2012 11:43:22 -0700 (PDT)
Received: by 10.76.120.45 with HTTP; Tue, 26 Jun 2012 11:43:22 -0700 (PDT)
In-Reply-To: <CAJQBtg=-drwKEU2iSDeUWZPbO+OENNL-rDMoy6XYPrnzFV1VyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200667>

Hello list,
I didn't find a bug tracker and some comments on StackOverflow
suggested I should post to the mailing list... please excuse me if I
followed the wrong info, it's not really easy to find your bug
tracker, if there is one.

I've came across this behavior trying to organize my repository to
push updates to several remote repositories. Here's what I did:

in .git/conf

[core]
repositoryformatversion =3D 0
filemode =3D true
bare =3D false
logallrefupdates =3D true

[remote "github"]
=A0 =A0 =A0 =A0 fetch =3D +refs/heads/*:refs/remotes/origin/*
url =3D https://username1:password1@github.com/some.git

[remote "googlecode"]
=A0 =A0 =A0 =A0 fetch =3D +refs/heads/*:refs/remotes/origin/*
=A0 =A0 =A0 =A0 url =3D https://username2:password2@code.google.com/p/s=
ome/

[remote "origin"]
url =3D https://username1:password1@github.com/some.git
# =A0 =A0 =A0 =A0url =3D https://username2:password2@code.google.com/p/=
some/

[remote "all"]
url =3D https://username1:password1@github.com/some.git
=A0 =A0 =A0 =A0 url =3D https://username2:password2@code.google.com/p/s=
ome/
[branch "master"]
remote =3D origin
merge =3D refs/heads/master

Now, what happens if I try to push origin master:
the commit is sent to the first origin with the credential specified
in the first URL, but then the request to second URL is sent with the
credentials from the first URL. I tried switching them, and the result
is the same. I tried separate push'es to both repositories and it
works fine. I thought there might be something particular about
"origin" and tried moving the list of URLs to "all" - with the exact
same results.

This is kind of frustrating... but this is also a tiny security threat
as you are basically sending the credentials of the users they used at
one site to another... w/o any notice or warning.

That aside, I would be very happy to find some way to save passwords
in some... well... more secure format. Like on the keyring, for
example... .netrc is out of question though because of duplicating
user names :(

Best.

Oleg
