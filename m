From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Thu, 03 Mar 2011 22:13:13 +0100
Message-ID: <4D700469.7090807@gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 22:13:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvFpw-0003Dk-Ni
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 22:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281Ab1CCVNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 16:13:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49427 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737Ab1CCVNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 16:13:22 -0500
Received: by fxm17 with SMTP id 17so1542633fxm.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ncXanfM65ArDVfVeqNA7FAW7d9weP3IiAVed5ifI4wc=;
        b=VpLn6PwlyO/5dgkBBTURTa3fWJtyRBDunbNSfHBum049u53ly6lBbsdL6AxXErJYzL
         +Kg/a1tMEE5k84Xm04f94xjjEgqbXejhqP0TsI/SbYRlQIO9p4CTkFn1QPZpYrM2SRNo
         VekxYY7DVHTl9cpok7YMCf/JRxWhmk4KrXXPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fOTRqEBUYOtU9UQHBG5PF3ipuT3LsXgQXHw5cdpTXxBrPBwYDCS7jYyk5a8r3V2Lqs
         iS051BNT1BlB1ar62cpl51OxcwquJNOS3YXSekEPJFcNjm3JE+wlmhXIi0XnUFeDMugf
         kQ+XpdQicyo6mWzKryUwQExbIhHmoHDDviY88=
Received: by 10.223.86.193 with SMTP id t1mr2062322fal.147.1299186801646;
        Thu, 03 Mar 2011 13:13:21 -0800 (PST)
Received: from [192.168.1.101] (aasb42.neoplus.adsl.tpnet.pl [83.5.213.42])
        by mx.google.com with ESMTPS id 21sm839123fav.41.2011.03.03.13.13.20
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 13:13:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168410>

W dniu 03.03.2011 13:43, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy pisz=
e:
> Instead of creating the repository at $GIT_DIR, --real-git-dir will
> tell git to put the repository there, then make $GIT_DIR a .git file
> that points to --real-git-dir.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This makes '.git symbolic link' (what's its official name?) more
>  convenient to use. Previously whenever I need to create a .git link,
>  I need to open docs to see its format. Now all I need to do is

Took me a while to find documentation for .git file format. Probably my
fault, missed the gitrepository-layout link.

Anyway, tried following:
   $ echo path > .git
   $ git info
   fatal: Invalid gitfile format: .git

Maybe one solution is to improve the message - patch attached:
   $ git info
   fatal: Invalid gitfile format: .git
   Use gitdir: <PATH>

=20
>   git init --real-git-dir=3D/where/real/git/is
>   git clone --real-git-dir=3D/where/real/git/is something
>=20
>  I intend to make 'git init --real-git-dir' move current repo to
>  somewhere else if called on existing repo.
>=20
>  Long term I'd like to see a init/clone hook, where I can tell git
>  "when I ask you to create a repo/worktree at foo, put the real repo
>  at ~/git/foo"

Is this needed? As I understand
    git init --real-git-dir=3D/where/real/git/is

should do the same as
    git --git-dir=3D/where/real/git/is && \
    echo "gitdir: /where/real/git/is" > ${GIT_DIR:-.git}=20

The other actions seems to be similarly simple.


>  I could use a better option name too, any suggestions?

I don't understand why is this needed. It's a bit complicated at first =
as well.
Adds extra layer to already existing .gitdir/.gitfile/GIT_DIR/--git-dir


---8<---
=46rom e83caf00dc007b9a2e515bb718f0d9ddb080891e Mon Sep 17 00:00:00 200=
1
=46rom: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Thu, 3 Mar 2011 21:51:34 +0100
Subject: [PATCH] Improve error message when gitfile has wrong format

Add information what format of .git file is expected.

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 021d013..d2d9d0b 100644
--- a/setup.c
+++ b/setup.c
@@ -291,7 +291,7 @@ const char *read_gitfile_gently(const char *path)
 		die("Error reading %s", path);
 	buf[len] =3D '\0';
 	if (prefixcmp(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
+		die("Invalid gitfile format: %s\nUse gitdir: <PATH>", path);
 	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
 		len--;
 	if (len < 9)
--=20
1.7.1


--=20
Piotr Krukowiecki
