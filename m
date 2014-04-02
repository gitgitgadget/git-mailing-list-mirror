From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: do not trust stat info if lstat() fails
Date: Wed, 02 Apr 2014 11:15:24 -0700
Message-ID: <xmqq38hvvbr7.fsf@gitster.dls.corp.google.com>
References: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
	<1396012689-22480-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeU1-000348-FV
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbaDBSP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Apr 2014 14:15:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932687AbaDBSP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 14:15:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EDBE7784A;
	Wed,  2 Apr 2014 14:15:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N/DIbWIyXMTw
	g4yeGfPQT3W9gxM=; b=Ph5CmWgrJwKH7LrXvqyLEnu3TWazq+SMbZvx+1ad3O93
	jzBQVCUIKGDjHq5Ev1LBLNAHmwMwH5NmTgwYmIBsehLPMCTToG8YLsb4oB4XUe0F
	CgDOth3KdglKwZgDu0yhCc0BHT0WhNZVLY5aeB6wVMf3znfyTgBbqtEu5yfXm40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PK8lHN
	6M6nFojPRut503UTlk4WGpqKfD0Jtqh6ifhldLpXcuBVUErPOOim/0EICako/JIN
	Qw+rSXUC5Zs5eAwW4FlZvYUzTWOWKcirHz7/3Yhk0l/Tf4Kd3iqZmbJFPSTOH6M0
	Ea02e1gxJKK56+dEuSdAndz2N/jdtNX1iaM9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E7077849;
	Wed,  2 Apr 2014 14:15:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9ECD77845;
	Wed,  2 Apr 2014 14:15:25 -0400 (EDT)
In-Reply-To: <1396012689-22480-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 28
 Mar 2014 20:18:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C35FD0DE-BA92-11E3-BCB0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245721>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> If 'err' is non-zero, lstat() has failed. Consider the entry modified
> without passing the (unreliable) stat info to ce_modified() in this
> case.
>
> Noticed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, Mar 28, 2014 at 11:04 AM, Eric Sunshine <sunshine@sunshineco=
=2Ecom> wrote:
>  > On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy <pclouds@gmail.com> wrote:
>  >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D lstat(=
ce->name, &st);
>  >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (show_delet=
ed && err) {
>  >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 show_ce_entry(tag_removed, ce);
>  >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 shown =3D 1;
>  >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>  >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (show_modif=
ied && ce_modified(ce, &st, 0)) {
>  >
>  > Is it possible for the lstat() to have failed for some reason when=
 we
>  > get here? If so, relying upon 'st' is unsafe, isn't it?
>
>  The chance of random stat making ce_modified() return false is prett=
y
>  low, but you're right. This code is a copy from the old show_files()=
=2E
>  I'll fix it in the git-ls series. Meanwhile a patch for maint to fix
>  the original function.
>
>  builtin/ls-files.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 47c3880..e6bd00e 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -260,7 +260,7 @@ static void show_files(struct dir_struct *dir)
>  			err =3D lstat(ce->name, &st);
>  			if (show_deleted && err)
>  				show_ce_entry(tag_removed, ce);
> -			if (show_modified && ce_modified(ce, &st, 0))
> +			if (show_modified && (err || ce_modified(ce, &st, 0)))
>  				show_ce_entry(tag_modified, ce);
>  		}
>  	}

I am guessing that, even though this was discovered during the
development of list-files, is a fix applicable outside the context
of that series.

I do think the patched result is an improvement than the status quo,
but at the same time, I find it insufficient in the context of the
whole codepath.  What if errno were other than ENOENT and we were
told to show_deleted (with or without show_modified)?  We would end
up saying the path was deleted and modified at the same time, when
we do not know either is or is not true at all, because of the
failure to lstat() the path.

Wouldn't it be saner to add tag_unknown and do something like this
instead, I wonder?

 builtin/ls-files.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..af2ce99 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,6 +46,7 @@ static const char *tag_killed =3D "";
 static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
+static const char *tag_unknown =3D "";
=20
 static void write_name(const char *name)
 {
@@ -249,7 +250,7 @@ static void show_files(struct dir_struct *dir)
 		for (i =3D 0; i < active_nr; i++) {
 			const struct cache_entry *ce =3D active_cache[i];
 			struct stat st;
-			int err;
+
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
 			    !ce_excluded(dir, ce))
 				continue;
@@ -257,11 +258,15 @@ static void show_files(struct dir_struct *dir)
 				continue;
 			if (ce_skip_worktree(ce))
 				continue;
-			err =3D lstat(ce->name, &st);
-			if (show_deleted && err)
-				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
+			errno =3D 0;
+			if (lstat(ce->name, &st)) {
+				if (errno !=3D ENOENT && errno !=3D ENOTDIR)
+					show_ce_entry(tag_unknown, ce);
+				else if (show_deleted)
+					show_ce_entry(tag_removed, ce);
+			} else if (show_modified && ce_modified(ce, &st, 0)) {
 				show_ce_entry(tag_modified, ce);
+			}
 		}
 	}
 }
@@ -533,6 +538,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		tag_killed =3D "K ";
 		tag_skip_worktree =3D "S ";
 		tag_resolve_undo =3D "U ";
+		tag_unknown =3D "! ";
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
