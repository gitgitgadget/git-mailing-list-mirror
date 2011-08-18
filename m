From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] fetch-pack: check for valid commit from server
Date: Thu, 18 Aug 2011 14:32:47 -0700
Message-ID: <CAJo=hJvN9W00ncG53933yiqT++QCxGLUqp8KtG=BsvKD81wWyA@mail.gmail.com>
References: <1313674563-12755-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 23:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuADR-0007ws-2M
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 23:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1HRVdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 17:33:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58727 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab1HRVdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 17:33:08 -0400
Received: by bke11 with SMTP id 11so1770767bke.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 14:33:07 -0700 (PDT)
Received: by 10.204.199.65 with SMTP id er1mr607469bkb.219.1313703187177; Thu,
 18 Aug 2011 14:33:07 -0700 (PDT)
Received: by 10.204.135.81 with HTTP; Thu, 18 Aug 2011 14:32:47 -0700 (PDT)
In-Reply-To: <1313674563-12755-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179629>

2011/8/18 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> A malicious server can return ACK with non-existent SHA-1 or not a
> commit. lookup_commit() in this case may return NULL. Do not let
> fetch-pack crash by accessing NULL address in this case.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0However it raises another question, what if the other end retur=
ns a
> =C2=A0valid commit, but not the one in "have" line fetch-pack sent? A=
re we
> =C2=A0OK with that?

Not really. The server is not supposed to return a SHA-1 in the ACK
line unless the client said it first in a have line. So aborting with
an error is reasonable thing for a client to do.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!co=
mmit)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 die("invalid commit %s", sha1_to_hex(result_sha1))=
;

Maybe:

  die("server ACK contained unknown commit %s", sha1_to_hex(result_sha1=
));

is more specific to the problem.


Just curious, did you see this on a particular server somewhere?

--=20
Shawn.
