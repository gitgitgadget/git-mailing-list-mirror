From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 3/3] config: add core.sharedconfig
Date: Thu, 9 Dec 2010 14:00:54 -0200
Message-ID: <AANLkTinVw+H1OsdJVofiGMkpNAdOjS5n0-HZCGCg3f5g@mail.gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
	<1291907388-9068-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 17:01:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQivV-0003gI-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 17:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab0LIQA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 11:00:57 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:63505 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0LIQA4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 11:00:56 -0500
Received: by bwz16 with SMTP id 16so2820612bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o5FG68yAFIMiU/C1qjXAJj2ulRmOkvmsD9j0Y5sFhlM=;
        b=uFIYfbXN0GhoY8kG61/zX2ps1zHts4ktz+VPZH0EAIuUJDMGnAqwnlSE45UIkCqR1I
         NcSfqQ8EPJFkSGtqGkNAV/O8ZROWG6wX5eD+1TD7smFyg0hIROSdam1oJ7o8qnOeorFs
         BFDt3m1Huue9rP8pUrhgC6KKX4d5FvHbGUt+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sOTf9tgDOD7wEXETszeWkQaA2AfAQGrWVsOFI+DhUKRyiC7dThKd8o4MvGkuFOcQgU
         DQxK2emGThg/ulugeFhbJNxCF8TEaoBz9WnVxLtIdt4A+bSsTCVSVVlF3YSnMS/qNFbz
         e7xK9BpxphZ/VlLdTl572FYHRrsb7dyY4Z0ZM=
Received: by 10.204.84.197 with SMTP id k5mr3466575bkl.175.1291910454797; Thu,
 09 Dec 2010 08:00:54 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Thu, 9 Dec 2010 08:00:54 -0800 (PST)
In-Reply-To: <1291907388-9068-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163291>

2010/12/9 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> core.sharedconfig can take anything that resolves to a blob.
> $GIT_DIR/config will override the shared config. Nested shared
> config is not allowed.
>
> No protection is provided. It's up to the project to maintain good
> config. The config could be in a separate branch that only a few
> people are allowed to push, for example. To be safest, just put SHA-1
> there.
>
> git-fsck and git-prune should learn about this key and protect it fro=
m
> being pruned.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0Hopefully nobody sets core.sharedconfig =3D :path/to/config or =
similar
>
> =C2=A0And I should not open $GIT_DIR/config twice. Well, it does not =
hurt
> =C2=A0much.
>
> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0config.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 ++++++++++++++
> =C2=A0environment.c | =C2=A0 =C2=A01 +
> =C2=A03 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index e83bc2d..e91ce35 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -559,6 +559,7 @@ extern int read_replace_refs;
> =C2=A0extern int fsync_object_files;
> =C2=A0extern int core_preload_index;
> =C2=A0extern int core_apply_sparse_checkout;
> +extern const char *core_shared_config;
>

Why you need to export this string? Isn't it used only in config.c?
