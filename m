From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Create a new commit from patches without using any worktree?
Date: Wed, 27 Oct 2010 12:28:58 +0200
Message-ID: <AANLkTimykD+2Y9WKs2gXE+1Q2SS=5DaN+Kf4sW2dhegB@mail.gmail.com>
References: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
	<4CC7EBEA.9070804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Klas Lindberg <klas.lindberg@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 12:29:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB3Fj-0000sJ-UL
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 12:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760778Ab0J0K3B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 06:29:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43019 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0J0K27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 06:28:59 -0400
Received: by wwe15 with SMTP id 15so604136wwe.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xbnjt+jqiS6ENAVyuqBrAQMXWtj1yLQBafXu3HUIgbM=;
        b=aroZ+n7ZviPtdrr5iXqjip65XbFprxZVWDN8GpZyCIs27UOuOlFvD9Q0ilIuGfGkqT
         DB0y57V/B5E8GU8hd5Rh1GKg8NZLQQVx/tOTjoBq74GhrVanNMwwY6Csx1zfDC+n/zFh
         X1jazyosbdl3Y9+D1Cl3LanzkWVvjiGwcADaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xS9Qys+Ege2tBQmVPE4lO+Y6XXGV/v3/aGi8ayqXmjADcIdOFyqnm1cQgP1GLhthaS
         f0qDgmEAbCEwx2ymIjplrVQpioIgVw4V4sc1e1c2cpAiQt7b+phUTdU1Yo4qVZsMB29L
         JAotmqUy7TFolPxuh5vwkGIAHOnoBlxl1eqDc=
Received: by 10.227.69.202 with SMTP id a10mr9281557wbj.81.1288175338621; Wed,
 27 Oct 2010 03:28:58 -0700 (PDT)
Received: by 10.227.136.76 with HTTP; Wed, 27 Oct 2010 03:28:58 -0700 (PDT)
In-Reply-To: <4CC7EBEA.9070804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160032>

On Wed, Oct 27, 2010 at 11:07, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 10/27/2010 3:49, schrieb Klas Lindberg:
>> Is there any way to record a new commit based on contents in a patch
>> without going through a worktree?
>
> This script may be a starter. It takes a commit on the command line
> instead of a patch, but it processes that commit as a patch ("diff-tr=
ee -p"),
> so the script should be easy to adapt.
>
> -- Hannes
>
> -- 8< --
> #!/bin/sh
>
> OPTIONS_SPEC=3D"\
> git post to-ref [from-rev]
> --
> "
> . git-sh-setup
>
> while test $# !=3D 0
> do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$1" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--) =C2=A0 =C2=A0 shift; break;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-*) =C2=A0 =C2=A0 usage;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*) =C2=A0 =C2=A0 =C2=A0break;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0shift
> done
>
> FROM=3D$(git rev-parse --verify --symbolic-full-name "$1") || exit
> shift
> if test $# =3D 0; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set -- HEAD
> fi
> test $# =3D 1 || usage
>
> # populate a temporary index
> tmpidx=3D$GIT_DIR/index-post-$$

I think you should honor GIT_INDEX_FILE here, so that you can
guarantee that tmpidx is on the same device as the index file used by
git read-tree.

Bert

> git read-tree --index-output=3D"$tmpidx" "$FROM" || exit
> GIT_INDEX_FILE=3D$tmpidx
> export GIT_INDEX_FILE
> trap 'rm -f "$tmpidx"' 0 1 2 15
>
> git diff-tree -p -M -C "$@" | git apply --cached || exit
>
> newtree=3D$(git write-tree) &&
> newrev=3D$(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval "$(get_author_ident_from_commit "$1")=
"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git-cat-file commit "$1" | sed -e '1,/^$/d=
' |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit-tree $newtree -p "$FROM"
> ) || exit
>
> if git check-ref-format "$FROM"
> then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_reflog_action post
> =C2=A0 =C2=A0 =C2=A0 =C2=A0subject=3D$(git log --no-walk --pretty=3D%=
s "$newrev") &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git update-ref -m "$GIT_REFLOG_ACTION: $su=
bject" "$FROM" $newrev || exit
> fi
> if test -z "$GIT_QUIET"
> then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rev-list -1 --oneline $newrev
> fi
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
