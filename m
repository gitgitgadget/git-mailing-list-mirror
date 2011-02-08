From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH 4/8] git-p4: accommodate new move/delete type in p4
Date: Tue, 8 Feb 2011 09:52:49 +0100
Message-ID: <AANLkTimr3uZQZGo_POvFc_GMj_h0uRXpv8V9vSEydXPB@mail.gmail.com>
References: <20110205224848.GA30963@arf.padd.com>
	<20110205225206.GE30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 09:52:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmjJg-00007y-22
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 09:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab1BHIwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 03:52:51 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38797 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab1BHIwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 03:52:50 -0500
Received: by ywo7 with SMTP id 7so1847713ywo.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hwQYPZqmb6p1PAhMne1PkRJU1cR4wnADxnLqI3XwJ50=;
        b=tXbob1k+K1/vULYS6lYMvZp601mYIQ6K/d0U75C/8ienoRNX/x15loIGuDjCxCevo+
         V775U+C67oL29TVSvKhK6S0U8gpJY181corHAQmtIQCr8cyQ4ZYoixdm+Pm9z3ILyoyo
         UpwZsztR8GpXYmry26lcnRFixY3wXrjVz9bLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g4oekGIs+EQ8a0heFJ0cdFpdAQNg5NV2w8gEXPtEzsco8Dy31znAZd7UR+u9mHETDE
         dSuGlkIIH9p7FvuM1no0nu5mzi4emzY+b8X+H9nzlyo4F//xa3vYQAu5YFM0ypeA1sT8
         VM0KSzfnvebwONpNU8S0SOI0SKNAU4IdhO1WA=
Received: by 10.101.6.12 with SMTP id j12mr10532624ani.46.1297155169673; Tue,
 08 Feb 2011 00:52:49 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Tue, 8 Feb 2011 00:52:49 -0800 (PST)
In-Reply-To: <20110205225206.GE30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166339>

On Sat, Feb 5, 2011 at 11:52 PM, Pete Wyckoff <pw@padd.com> wrote:
> Change 562d53f (2010-11-21) recognized the new move/delete type
> for git-p4 sync, but it can also show up in an initial clone and
> labels output. =C2=A0Instead of replicating this in three places,
> hoist the definition somewhere global.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Acked-By: Tor Arvid Lund <torarvid@gmail.com>

> ---
> =C2=A0contrib/fast-import/git-p4 | =C2=A0 12 +++++++-----
> =C2=A01 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index d2ba215..db19b17 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -834,6 +834,8 @@ class P4Submit(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True
>
> =C2=A0class P4Sync(Command):
> + =C2=A0 =C2=A0delete_actions =3D ( "delete", "move/delete", "purge" =
)
> +
> =C2=A0 =C2=A0 def __init__(self):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Command.__init__(self)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.options =3D [
> @@ -1038,10 +1040,10 @@ class P4Sync(Command):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if includeFile:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filesForCommi=
t.append(f)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if f['action=
'] not in ('delete', 'move/delete', 'purge'):
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
filesToRead.append(f)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if f['action=
'] in self.delete_actions:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 filesToDelete.append(f)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
filesToRead.append(f)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # deleted files...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in filesToDelete:
> @@ -1127,7 +1129,7 @@ class P4Sync(Command):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cleanedFiles =
=3D {}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for info in f=
iles:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if info["action"] in ("delete", "purge"):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if info["action"] in self.delete_actions:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 continue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cleanedFiles[info["depotFile"]] =3D info["rev"]
>
> @@ -1453,7 +1455,7 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if change > newestRevision:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newestRevisio=
n =3D change
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if info["action"] in ("del=
ete", "purge"):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if info["action"] in self.=
delete_actions:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # don't incre=
ase the file cnt, otherwise details["depotFile123"] will have gaps!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #fileCnt =3D =
fileCnt + 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
