From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 11/12] ref-filter: introduce contents_atom_parser()
Date: Thu, 4 Feb 2016 19:22:17 -0500
Message-ID: <CAPig+cQ+jsAdJSB6J_P8h+zDbiGpr4JGv=Vj1vEMSLdHERi0pw@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRUAJ-0000oj-57
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbcBEAWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 19:22:19 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33392 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbcBEAWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 19:22:18 -0500
Received: by mail-vk0-f67.google.com with SMTP id c3so35347vkb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 16:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hMNmFSePp9tU2cfGrFUbkFtPigbVX0GVnU5kLqFxOK8=;
        b=yz+L6HyOT7J5yVPeA2BwleGZrUgnbmKeeF2uWkdlfYoDLpPesMc4CkzI2aPPfR1nNO
         i6h0OcX3gOyOtpBdThCjvcDn9+89SWWUxSi9+6VD9mkylQzDKtCdnr3/GwZ4Hsa07hHn
         NBiGfxvXao+yG1QvqYn6ev7LkbLVvemvga8zLX24GGeYgZktZjij+AEjfz6zxjUlDlAX
         RbNU0rIucpv+5zdsgdIFmo4n/niuIS7cVB5F+H442Wh+gMSLPyh2cg8pwdJ4wzRhDMGe
         8zmoSn9U9vlpUrRFxaiMUSh2lyI3KizexwYVQxEWA1tEOxEAdMb7TF7ESmBMI3oqtzq/
         zAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hMNmFSePp9tU2cfGrFUbkFtPigbVX0GVnU5kLqFxOK8=;
        b=XBSgKHv274VGKXCb4iwvWhrpPFLSNTLaCqGAcRJ9mKcTGbjB+LOHqiUXdWOGGw16o8
         rL7IMtCm+3J4DEiJaQq1u5/pYzsh/tHR4lzb8E9OdYR3I7PFakILiarPsg5r8hvFFrM/
         Qp1uHUN/hIGlhCwHwfqgDuPWYRmGFMZDkADaiIcYhsiw/NFx+EqWEF+RGa9PaWIB01zu
         RDCjwF3QqVOlzR7drdrB2QKYUicFOv5k0qJCqwTRZklJ/84pXNaOkYbr/kcqoPPr+/zR
         ZTo0bSMe8VlftauKrvE9AiWnuw/s7goMTKGZKLUfC38hElIsRmDWFcRaZIHzhC9qmQW3
         Cy5w==
X-Gm-Message-State: AG10YOTUYfr44//shkREMm8lB669SC/bRn5j9oTMgxPz4rnLlhZmVYxiO+NvKtcNRKhXbryTEe1PV9ggjl5xTg==
X-Received: by 10.31.182.143 with SMTP id g137mr7462496vkf.45.1454631737743;
 Thu, 04 Feb 2016 16:22:17 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 16:22:17 -0800 (PST)
In-Reply-To: <1454262176-6594-12-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 0o1dANS8zNS-iYVkA4V8Cv_AnwI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285530>

On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce contents_atom_parser() which will parse the '%(contents)'
> atom and store information into the 'used_atom' structure based on the
> modifiers used along with the atom. Also introduce body_atom_parser()
> and subject_atom_parser() for parsing atoms '%(body)' and '%(subject)'
> respectively.

These latter two parsers are conceptually distinct from introduction
of the %(contents) parser, thus could be done in a follow-on patch or
two (though I don't care strongly enough to insist upon it).

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -66,6 +70,38 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
> +static void body_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +       if (arg)
> +               die("%%(body) atom does not take arguments");

None of the other error messages bothers saying "atom" literally
following a %(foo). For consistency, this likely should say merely:

    %(body) does not take arguments

> +       atom->u.contents.option = C_BODY_DEP;
> +}
> +
> +static void subject_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +       if (arg)
> +               die("%%(subject) atom does not take arguments");

Ditto.

> +       atom->u.contents.option = C_SUB;
> +}
> @@ -733,19 +763,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>
>         for (i = 0; i < used_atom_cnt; i++) {
>                 const char *name = used_atom[i].name;
> +               struct used_atom *atom = &used_atom[i];

Not a big deal, but if you re-order these two lines, then the second,
which extracts name, could do so from the variable declared by the
first:

    struct used_atom *atom = &used_atom[i];
    const char *name = atom->name;

>                 struct atom_value *v = &val[i];
> -               const char *valp = NULL;
>                 if (!!deref != (*name == '*'))
>                         continue;
>                 if (deref)
>                         name++;
>                 if (strcmp(name, "subject") &&
>                     strcmp(name, "body") &&
> -                   strcmp(name, "contents") &&
> -                   strcmp(name, "contents:subject") &&
> -                   strcmp(name, "contents:body") &&
> -                   strcmp(name, "contents:signature") &&
> -                   !starts_with(name, "contents:lines="))
> +                   !starts_with(name, "contents"))
>                         continue;

This changes behavior in that it will also now match
"contentsanything", whereas the original was much more strict. Is that
desirable? (Genuine question.)

>                 if (!subpos)
>                         find_subpos(buf, sz,
