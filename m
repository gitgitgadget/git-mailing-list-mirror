From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Create a new commit from patches without using any worktree?
Date: Wed, 27 Oct 2010 17:20:32 +0200
Message-ID: <AANLkTimX+j=9pHGb4kN_WsPw4ZO262XSwq5TiOBct6g6@mail.gmail.com>
References: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
	<4CC7EBEA.9070804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7o7-0007Cf-9d
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933653Ab0J0PUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 11:20:34 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59348 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933644Ab0J0PUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 11:20:32 -0400
Received: by qyk10 with SMTP id 10so870068qyk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nTpI+rzf5DGhKh/2o7mImm1C4p5MN88PnYIt2yjXmNY=;
        b=qiPjJc6G2DcKrXK8Cm1pqsN1piPlsG1O1KMkBA2cowzg8GkSpU5llp/XrrxtUw4jFw
         0MIgzfsPR7fD6DQyhsvCJ2ttsitdOKXf5zyPYi/sV7pNnMOOiypke7NWRPRdEReeAx5q
         9tQ91g1DeeKz0BFporKXp7bmrLgcQmscbo0x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VSI0J4q7WJv7d69ZPC5N379D4tgc/r5HTfnmwl+SGEXx0ErkvL6tZsLfj2t815nOx9
         L39caLZWRoV/ooqxLOJf0iyVy315SjK5Y14xeJwamzKUDUaBBzIu3FMPZyZ/43zMQ9ol
         zyf0+z/VlJfnHfzToyr9ga6fAvl9R08xyl5po=
Received: by 10.229.91.77 with SMTP id l13mr6144583qcm.282.1288192832261; Wed,
 27 Oct 2010 08:20:32 -0700 (PDT)
Received: by 10.229.182.209 with HTTP; Wed, 27 Oct 2010 08:20:32 -0700 (PDT)
In-Reply-To: <4CC7EBEA.9070804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160088>

Ha! It works! Thank you so very very much. I've been trying to figure
this out on my own for a while.

BR / Klas

On Wed, Oct 27, 2010 at 11:07 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
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
>
