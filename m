From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 05/21] commit: convert to use parse_pathspec
Date: Sat, 12 Jan 2013 14:54:04 -0800
Message-ID: <CANiSa6hSgYcGAYCfWu5wkQyaKF9R2SME2LmJ-Qt+uvpBQU2qBw@mail.gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
	<1357903275-16804-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 23:54:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu9yA-0001ah-70
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 23:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab3ALWyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 17:54:06 -0500
Received: from mail-ia0-f180.google.com ([209.85.210.180]:54631 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab3ALWyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 17:54:05 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so1197934iae.39
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 14:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HQEeagXkX5tcmVG1Wx50HMdM5WtdDtQeoI53CY/yxx0=;
        b=KwIKhOHYFdmNyrAl/pm0YQLsqm+/HGRXnb4vHIaGrq4gS1vnR3LuA9IOBwgA9i9hWZ
         4BZjsMUQdSUy1AXz7mJ1HauelwVXg5NCidlGUTzE0AsOqQjoGjYkJ25Geif34oexKxlq
         KOmBAhkxESx8APT8KyUQFs853eL7o7/A6mRn7A2gCe3Dg2DSQPxAdWdXBECnB1XEWIVe
         gD4akfZjxSA26shOQMWWFdU8EAp/Qm88UpGhgpe1LKMN6Ga5/+3LAH/19KNHWcAY99F9
         PjuowNdqwjQ1eZ1le8CeAcGeNIgTXqGoqSS3uIWWgfG9yaFUDyY/Gxcbp66pD2VLaK0O
         f2/A==
Received: by 10.50.42.169 with SMTP id p9mr3132520igl.17.1358031244468; Sat,
 12 Jan 2013 14:54:04 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Sat, 12 Jan 2013 14:54:04 -0800 (PST)
In-Reply-To: <1357903275-16804-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213312>

On Fri, Jan 11, 2013 at 3:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>
> diff --git a/cache.h b/cache.h
> index e52365d..a3c316f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -476,6 +476,9 @@ extern int ie_modified(const struct index_state *=
, struct cache_entry *, struct
>  /* Pathspec magic */
>  #define PATHSPEC_FROMTOP    (1<<0)
>
> +/* Pathspec flags */
> +#define PATHSPEC_EMPTY_MATCH_ALL (1<<0) /* No args means match every=
thing */
> +
>  struct pathspec {
>         const char **raw; /* get_pathspec() result, not freed by free=
_pathspec() */
>         int nr;
> diff --git a/setup.c b/setup.c
> index 6e960b9..a26b6c0 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -280,6 +280,9 @@ void parse_pathspec(struct pathspec *pathspec,
>         if (!entry && !prefix)
>                 return;
>
> +       if (!*argv && (flags & PATHSPEC_EMPTY_MATCH_ALL))
> +               return;
> +
>         /* No arguments with prefix -> prefix pathspec */
>         if (!entry) {
>                 static const char *raw[2];

I was surprised not to find these two hunks in 02/21. If they were
there, you wouldn't have to explain in the log message of that patch
that "flags" is for future-proofing. Also, "*argv" is written "entry"
in the surrounding conditions.
