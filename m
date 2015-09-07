From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] enter_repo: avoid duplicating logic, use is_git_directory() instead
Date: Mon, 07 Sep 2015 09:33:36 -0700
Message-ID: <xmqq8u8i9okf.fsf@gitster.mtv.corp.google.com>
References: <20150715132552.GA28574@lanh>
	<1440204002-7638-1-git-send-email-pclouds@gmail.com>
	<1440204002-7638-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bjornar@snoksrud.no
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 18:33:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYzMZ-000728-JM
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 18:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbbIGQdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 12:33:42 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34454 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbIGQdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 12:33:38 -0400
Received: by padhy16 with SMTP id hy16so98421895pad.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Fz+gZJxawLYBLbunJ80qZZzWxQ0SDPI7SJjgKw/W/bs=;
        b=zbAI8taVr7sS/mVTk15/PshbDwLN7wz95Sqkw79GGd9AfZDDpcMcqJC88fmoSv31tx
         /dxnIwFUESmoEJ/vUKP4jL4QQn4n0MFtf6LGMBoZk5hF7LOJh3CJkekUzU4gTmjZ2zHa
         pXyjOnHi5FXDtqT82c16ww23Q7CgMpDlA3m/toPJ2RstTb2T23CVya7lKw5pdBheaSGF
         C6Za+cd487TrmztbA6E5YAC0cwqmNN28hj/K7B1rSkyCdHrnqqfAqn8JkKgNca74bw9c
         GC5FeqN8acOE9vCy+MAbYHNYPXbuuc3FYYl0SC4N6Jt3lJGol6hbTt++Qm8IJP8J6pCk
         WPqg==
X-Received: by 10.66.190.135 with SMTP id gq7mr21890063pac.65.1441643617863;
        Mon, 07 Sep 2015 09:33:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:751a:a433:a60b:dba1])
        by smtp.gmail.com with ESMTPSA id bc10sm340384pbd.14.2015.09.07.09.33.36
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 07 Sep 2015 09:33:37 -0700 (PDT)
In-Reply-To: <1440204002-7638-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 07:39:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277469>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The cover letter talks about "local clone", and in this entire
series, I saw new tests only for the local case, but doesn't this
and the next change also affect the case where a Git daemon or a
upload-pack process is serving the remote repository?

And if so, how is that case affected?

>  path.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/path.c b/path.c
> index a536ee3..7340e11 100644
> --- a/path.c
> +++ b/path.c
> @@ -441,8 +441,7 @@ const char *enter_repo(const char *path, int stri=
ct)
>  	else if (chdir(path))
>  		return NULL;
> =20
> -	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D=
 0 &&
> -	    validate_headref("HEAD") =3D=3D 0) {
> +	if (is_git_directory(".")) {
>  		set_git_dir(".");
>  		check_repository_format();
>  		return path;
