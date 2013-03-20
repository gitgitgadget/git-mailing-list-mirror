From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/45] Add parse_pathspec() that converts cmdline args
 to struct pathspec
Date: Wed, 20 Mar 2013 15:40:41 -0400
Message-ID: <CAPig+cSkxq=3dhgeYNKa9VjqMZkxrpLZEqKP63mAwjziz6m-LA@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
	<1363781779-14947-1-git-send-email-pclouds@gmail.com>
	<1363781779-14947-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:41:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOsu-0005Id-Mm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178Ab3CTTkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 15:40:47 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:51719 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3CTTkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 15:40:43 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so3703592lab.29
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c/5rnEN6vv1080jTpZ+SSIRo4N9l1EgCZQaKG7dhzJU=;
        b=LQWwbU6MkX+rbdUjWXytJGOJdBjR6USNJyMzUTUExX2N+W38g6rTxQIxY8np0/2egi
         I1KaDFqQxVYjzAxSeDYRu770q18PfFpoorZXeaouqwf8wnaDGyqZ/iqsI/KvwASetqIO
         ZJy2X6LV3VLOcWLgrQXh4i4QSRzPVEhbeFP6Jnrhz/jbFQHXRvITIexzqF0oZTkXWMA7
         xP7XGa8I1pcTkTxF22nERIi7jpjiyVjOfelo3rBjJ0LvK1/2tlp9h6/73j+O0tKUiAXp
         U1MDHnsHDmGFqSh6GX86f1nXyjgNvi+ExYP3irFAH7SCjUdKi4Yhk8vrtve9vf3zf+mW
         wblQ==
X-Received: by 10.152.104.199 with SMTP id gg7mr6136690lab.14.1363808441560;
 Wed, 20 Mar 2013 12:40:41 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Wed, 20 Mar 2013 12:40:41 -0700 (PDT)
In-Reply-To: <1363781779-14947-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ZS9GVvTkcpXJf_eeKMQ4yTc5Dx4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218663>

On Wed, Mar 20, 2013 at 8:16 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +static void NORETURN unsupported_magic(const char *pattern,
> +                                      unsigned magic,
> +                                      unsigned short_magic)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       int i, n;
> +       for (n =3D i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +               const struct pathspec_magic *m =3D pathspec_magic + i=
;
> +               if (!(magic & m->bit))
> +                       continue;
> +               if (sb.len)
> +                       strbuf_addstr(&sb, " ");
> +               if (short_magic & m->bit)
> +                       strbuf_addf(&sb, "'%c'", m->mnemonic);
> +               else
> +                       strbuf_addf(&sb, "'%s'", m->name);
> +               n++;
> +       }
> +       /*
> +        * We may want to substitue "this command" with a command

s/substitue/substitute/

> +        * name. E.g. when add--interactive dies when running
> +        * "checkout -p"
> +        */
> +       die(_("%s: pathspec magic not supported by this command: %s")=
,
> +           pattern, sb.buf);
> +}
