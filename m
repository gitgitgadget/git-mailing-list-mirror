From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive: tar.umask ignored
Date: Thu, 14 Apr 2011 20:04:57 +0200
Message-ID: <4DA73749.40303@lsrfire.ath.cx>
References: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com>	<4DA497B7.706@lsrfire.ath.cx> <BANLkTinEFPZoaUAc+8F1sPGE636u1vDOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jacek Masiulaniec <jacek.masiulaniec@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:05:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQvX-000534-2A
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 20:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933734Ab1DNSFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 14:05:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:37474 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933729Ab1DNSFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 14:05:30 -0400
Received: from [192.168.2.103] (p4FFDB5E2.dip.t-dialin.net [79.253.181.226])
	by india601.server4you.de (Postfix) with ESMTPSA id AD0EC2F803B;
	Thu, 14 Apr 2011 20:05:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTinEFPZoaUAc+8F1sPGE636u1vDOZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171531>

Am 12.04.2011 22:39, schrieb Jacek Masiulaniec:
> On 12 April 2011 19:19, Ren=E9 Scharfe<rene.scharfe@lsrfire.ath.cx>  =
wrote:
>> The local setting of tar.umask does not affect the archive created a=
t the
>> remote end.  If your "remote" repository is in fact located on the s=
ame
>> machine and accessed with the same user then of course settings in
>> ~/.gitconfig will take effect.
>=20
> I've eventually realised this by reading the source code.  The comman=
d
> I actually needed was:
>=20
>    cd /repo/website.git&&  git -c tar.umask=3D0022 archive HEAD

Yes, there's no point in using --remote if you can read the files direc=
tly.
I assumed you did that to make the command easier to reproduce by avoid=
ing
to set up a git daemon etc..

> Can't comment on the proposed diff without getting better handle on
> the whole system, but my knee-jerk reaction would be to resist the
> urge to add more switches.  Maybe the existing -c switch could be mad=
e
> to cooperate with --remote, or maybe the documentation could be edite=
d
> to make it clearer that -c and --remote are not related in the way I
> had originally assumed.

Yes, the documentation should be updated first.

-- >8 --
Subject: archive: document limitation of tar.umask config setting

The local value of the config variable tar.umask is not passed to the
other side with --remote.  We may want to change that, but for now just
document this fact.

Reported-by: Jacek Masiulaniec <jacek.masiulaniec@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-archive.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index f2b8684..9c750e2 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -98,7 +98,8 @@ tar.umask::
 	tar archive entries.  The default is 0002, which turns off the
 	world write bit.  The special value "user" indicates that the
 	archiving user's umask will be used instead.  See umask(2) for
-	details.
+	details.  If `--remote` is used then only the configuration of
+	the remote repository takes effect.
=20
 ATTRIBUTES
 ----------
