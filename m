From: =?utf-8?Q?Peter_H=C3=BCfner?= <p.huefner@e-confirm.de>
Subject: Re: git on vagrant shared folder
Date: Mon, 20 Jul 2015 09:26:46 +0200
Message-ID: <CD7F4720-BC1F-4382-9EF7-00E7F3A5C60C@e-confirm.de>
References: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de> <20150714183215.GG7613@paksenarrion.iveqy.com> <CAGZ79kbBKzbjbg5u7A7BgnV1JF=5A+-gb0OdYs11g6kx_UQu_A@mail.gmail.com> <xmqq7fq05a2v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 09:26:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH5TT-0000Po-SX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 09:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbbGTH0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2015 03:26:52 -0400
Received: from mailrelay4.qsc.de ([195.158.160.129]:42953 "EHLO
	mailrelay4.qsc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbbGTH0v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 03:26:51 -0400
Received: from s029.bre.qsc.de ([195.90.7.69]) by mailgate4.qsc.de;
 Mon, 20 Jul 2015 09:26:48 +0200
Received: from [192.168.53.205] (unknown [212.84.220.117])
	by s029.bre.qsc.de (Postfix) with ESMTPSA id DEA4036C0053;
	Mon, 20 Jul 2015 09:26:46 +0200 (CEST)
In-Reply-To: <xmqq7fq05a2v.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.2102)
X-cloud-security-sender: p.huefner@e-confirm.de
X-cloud-security-recipient: git@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mailgate4 with 577F41490001
X-cloud-security-connect: s029.bre.qsc.de[195.90.7.69], TLS=1, IP=195.90.7.69
X-cloud-security: scantime:.3443
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274318>

Junio is absolutely right. I wasn=E2=80=99t trying to commit that file =
directly. The error comes up when I want to change the config via git c=
onfig or when I clone the repo.
I also know that a shared folder is not a very friendly environment, bu=
t it is the best solution for our situation here.
We recognized the error first time in the beginning of july, so the cha=
nge done in june 30 seems to be a reason.
I will stay up to date and try it with newer git versions.


Mit freundlichen Gr=C3=BC=C3=9Fen
=20
Peter H=C3=BCfner
=2E........................................................
e=C2=B7confirm GmbH ..
Travel.Software.Training.Consulting
=20
Gesch=C3=A4ftsf=C3=BChrer: Roman Borch und Michael Posthoff
HRB 35653B   Steuernummer 37/211/10880
10119 Berlin Linienstr. 214
=20
Tel.  +49 (0) 30 28 00 28 24=20
=46ax. +49 (0) 30 28 00 28 28
=20
www.e-confirm.de
=2E....................................................................=
=2E...........................

> Am 16.07.2015 um 18:41 schrieb Junio C Hamano <gitster@pobox.com>:
>=20
> Stefan Beller <sbeller@google.com> writes:
>=20
>>>> A few weeks ago we weren=E2=80=99t able to clone and get an error:=
 could
>>> not commit /vagrant/.git/config file. Manually we were able to
>>> change that file and also the clone command works outside the share=
d
>>> folder.
>>>=20
>>> Why are you trying to commit a file inside the .git dir? Files in t=
hat
>>> dir should not be commited (and I'm pretty sure there was a patch a=
bout
>>> this a while ago). The .git/config file for example is local to eac=
h git
>>> repo and should not be commited.
>>=20
>> Actually it is considered a security risk, see
>> http://article.gmane.org/gmane.linux.kernel/1853266
>=20
> I do not think Peter meant to "git add .git/config && git commit" by
> referring to the 'could not commit config file' error message he
> saw; you two are going in a wrong direction.
>=20
>    $ git grep 'could not commit'
>    config.c: error("could not commit config file %s", config_filename=
);
>=20
> I do share Fredrik's suspicion that the virtual filesystem the
> Ubuntu guest is trying to write to is at fault, but I never used
> "vagrant shared", and I do not know in what specific way their
> filesystem is not behaving as we expect.
>=20
> Applying 7a64592c (config.c: fix writing config files on Windows
> network shares, 2015-06-30) might be an interesting thing to try.
> Some filesystems do not want to rename a file that has mmaped region
> still active, which is my blind guess.
>=20
