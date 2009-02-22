From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 5/6] builtin-tag: add sort by date -D
Date: Sun, 22 Feb 2009 20:38:10 +0200
Message-ID: <94a0d4530902221038j6614bfacl223c0fa7b7be396@mail.gmail.com>
References: <e29894ca0902221006j3d602553x15807b41698f51a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJEt-0005WY-Ak
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbZBVSiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbZBVSiN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:38:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:45400 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZBVSiM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:38:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2558006fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7R06SQqY7SIXu1EFCu7ny3X8/NZVoP+rEWzZTOgTTWQ=;
        b=v7+4vOaJTrO4mKdXnAZVebXD6PaWMESF+M6mnQ3f6gLkT+uok6KDld1ZJTypEp9TeQ
         wLRw4EV92zr3rEeSMx0PxWZnaGveTLqfhiVMFsd4MY+rpEfUY0B40wCL8GiGaWAUrfYw
         SOQinAEPHTLEo2l8cqVeulUNaApW81TtjtwaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=avoBlOOWgjO+p4v2wHjZdQhFvoobp206jFGzelhKpZNZmhVu23nYiZRsN0OuOQ7IQa
         mjW4rGewhzPq3JkDgigCVF94tcyNLXxisq2hcXdCczaC5UczCJneM0h12VFwTKrws0h4
         iKFoTGz1dYmumWfCQWFMeydbjAJ0a9Xxx0j8M=
Received: by 10.86.74.4 with SMTP id w4mr2380325fga.69.1235327890104; Sun, 22 
	Feb 2009 10:38:10 -0800 (PST)
In-Reply-To: <e29894ca0902221006j3d602553x15807b41698f51a1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111047>

On Sun, Feb 22, 2009 at 8:06 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
> ---
> =C2=A0builtin-tag.c | =C2=A0162 +++++++++++++++++++++++++++++++++++++=
++++++++------------
> =C2=A01 files changed, 129 insertions(+), 33 deletions(-)
>
> diff --git a/builtin-tag.c b/builtin-tag.c
> index 01e7374..8ff9d03 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -16,7 +16,7 @@
> =C2=A0static const char * const git_tag_usage[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git tag [-a|-s|-u <key-id>] [-f] [-m <msg=
>|-F <file>] <tagname> [<head>]",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git tag -d <tagname>...",
> - =C2=A0 =C2=A0 =C2=A0 "git tag -l [-n[<num>]] [<pattern>]",
> + =C2=A0 =C2=A0 =C2=A0 "git tag -l [-n[<num>] -D] [<pattern>]",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git tag -v <tagname>...",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL
> =C2=A0};

Hmm, the -D option is independent of -n, so "[-D]". Also, it must be do=
cumented.

<snip/>

Wouldn't it make sense to split this patch so the first part adds the
option to filter, even if there are not filters functional, and the
second one adds the date filter?

--=20
=46elipe Contreras
