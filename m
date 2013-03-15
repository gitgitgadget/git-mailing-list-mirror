From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 44/45] pathspec: support :(glob) syntax
Date: Fri, 15 Mar 2013 18:11:31 -0400
Message-ID: <CAPig+cTsP2TmoO0MHPZAUB1RZQO3iVAEA11zxxCvcjbGqNeQuQ@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
	<1363327620-29017-45-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 23:12:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGcr2-00058x-MW
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 23:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab3COWLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 18:11:33 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:44015 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129Ab3COWLd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 18:11:33 -0400
Received: by mail-lb0-f175.google.com with SMTP id n3so3201745lbo.34
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qvxGauh5PKAA88JrAafjLkbAnEOWqUPyD/j8YOGoRHc=;
        b=bKfnX4tzDFk1iniwzXtIbHmdJrwUi49kLh/Vvvl+2QhBSAx5UceLXc9HhJrw+nTMI2
         HsTdgyDKiif/5tbbogupppculop1R4GfdG8cKIIui8ymTn0CcFB7n+qYYXKGWAIOSsLO
         pohE940cSt9vbC/L/vzN8yVHaDWUbhMLuVW4ihGtTYYRipy/wI8GrsFi8gnUCLDVHIXF
         ASGLYFswd15hiZlqIB5JIPihlMB3eDs/eNreN1DiSXwgOOhhQ2qJvSPCwQUzVIk7IqSy
         1YhPoSJMMGp0n798aFZ7hHHs0egVXS+++hfLlthbqgQtN1XKnCZ/8KQlcYkVs0ZCrmQp
         Hxcw==
X-Received: by 10.112.88.35 with SMTP id bd3mr3294700lbb.56.1363385491409;
 Fri, 15 Mar 2013 15:11:31 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Fri, 15 Mar 2013 15:11:31 -0700 (PDT)
In-Reply-To: <1363327620-29017-45-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: PhI__kkh_kgsjrFvIMCeQ9EnH0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218265>

On Fri, Mar 15, 2013 at 2:06 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +GIT_GLOB_PATHSPECS::
> +       Setting this variable to `1` will cause git to treat all
> +       pathspecs as glob patterns (aka "glob" magic).

Per recent git -> Git normalization, probably: s/git/Git/

> +
> +GIT_NOGLOB_PATHSPECS::
> +       Setting this variable to `1` will cause git to treat all
> +       pathspecs as literal (aka "literal" magic).

Ditto: s/git/Git/

> @@ -103,6 +105,22 @@ static unsigned prefix_pathspec(struct pathspec_=
item *item,
>         if (literal_global)
>                 global_magic |=3D PATHSPEC_LITERAL;
>
> +       if (glob_global < 0)
> +               glob_global =3D git_env_bool(GIT_GLOB_PATHSPECS_ENVIR=
ONMENT, 0);
> +       if (glob_global)
> +               global_magic |=3D PATHSPEC_GLOB;
> +
> +       if (noglob_global < 0)
> +               noglob_global =3D git_env_bool(GIT_NOGLOB_PATHSPECS_E=
NVIRONMENT, 0);
> +
> +       if (glob_global && noglob_global)
> +               die(_("global 'glob' and 'noglob' pathspec settings a=
re incompatible"));
> +
> +       if ((global_magic & PATHSPEC_LITERAL) &&
> +           (global_magic & ~PATHSPEC_LITERAL))
> +               die(_("global 'literal' pathspec setting is incompati=
able "
> +                     "with all other global pathspec settings"));

s/incompatiable/incompatible/

-- ES
