From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Fix strcat() on uninitialized memory
Date: Mon, 14 Jun 2010 12:34:58 -0400
Message-ID: <AANLkTimSFwn1yykyEOTRdHHBYTFUEhxqj2AinjRv9ECC@mail.gmail.com>
References: <alpine.DEB.1.00.1006141032250.2689@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 14 18:35:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCct-00076W-4C
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab0FNQfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 12:35:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47278 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645Ab0FNQe7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 12:34:59 -0400
Received: by gwj15 with SMTP id 15so2557481gwj.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QpYgNfhUY5ZHyO7W8he1WT9ZSo0+5i+4n/e695CColE=;
        b=RCaBnx3uHD9BhAQkQH/UXHJFotf5RmpWwj6X/AFWo/lmmot6KV2hSMiSFMGb63EPlB
         NUYBkrtEPj+Cd4gMW1fzUdJny0pO3TpD8ouuD8Ve24Lcit5GYrB0Heq5LFd5uTSkYYJO
         oL1FGAGh99aliF58rVPnwRb7q5L4g7xGQzABU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=McT3uFiGBT52dIKuhzRlExx8/X6iMlSuuwYGS0OFW7mP5kRyXDaNhQ1Sfy741oaR/D
         5uMK9RgbjarhOJKLheRSBh8WM+NK3gup6oM8SElWnevy7zI2wDftbvCVf18v6h1TrAVt
         +tt4SLohe0Dub08tmIyvdghjSQbUft9IIOv38=
Received: by 10.150.113.12 with SMTP id l12mr6745424ybc.364.1276533298753; 
	Mon, 14 Jun 2010 09:34:58 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Mon, 14 Jun 2010 09:34:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1006141032250.2689@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149124>

Thanks, this was caught last week and patch posted by Thomas:

http://marc.info/?l=3Dgit&m=3D127619546001346&w=3D2

j.

On Mon, Jun 14, 2010 at 12:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Under certain circumstances, this bug would trigger a buffer overflow
> error with libc, and fail test 5516.
>
> Strbufs would have avoided the issue.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> =C2=A0builtin/receive-pack.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 05071c3..1644424 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -569,9 +569,9 @@ static void check_aliased_update(struct command *=
cmd, struct string_list *list)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_cmd->skip_update =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(cmd_oldh, find_unique_abbrev(cmd->o=
ld_sha1, DEFAULT_ABBREV));
> - =C2=A0 =C2=A0 =C2=A0 strcat(cmd_newh, find_unique_abbrev(cmd->new_s=
ha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcpy(cmd_newh, find_unique_abbrev(cmd->new_s=
ha1, DEFAULT_ABBREV));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(dst_oldh, find_unique_abbrev(dst_cm=
d->old_sha1, DEFAULT_ABBREV));
> - =C2=A0 =C2=A0 =C2=A0 strcat(dst_newh, find_unique_abbrev(dst_cmd->n=
ew_sha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcpy(dst_newh, find_unique_abbrev(dst_cmd->n=
ew_sha1, DEFAULT_ABBREV));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rp_error("refusing inconsistent update bet=
ween symref '%s' (%s..%s) and"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " its target =
'%s' (%s..%s)",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->ref_name=
, cmd_oldh, cmd_newh,
> --
> 1.7.1.msysgit.0.2.g2fefc8
>
>
