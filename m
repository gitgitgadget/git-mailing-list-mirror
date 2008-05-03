From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 1/2] commit: Show committer if automatic
Date: Sat, 3 May 2008 22:28:52 +0200
Message-ID: <8aa486160805031328o7dfae18fnac1bbea7420e0193@mail.gmail.com>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
	 <1209752541-19111-2-git-send-email-sbejar@gmail.com>
	 <7vmyn7tezi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 22:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsOMY-0000X2-AS
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 22:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbYECU2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 May 2008 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbYECU2y
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 16:28:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:43170 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYECU2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2008 16:28:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so177765ywe.1
        for <git@vger.kernel.org>; Sat, 03 May 2008 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YPZFOba39tTzbZP0hb0z1Ony6lhkPlFI0oD2/ETss7A=;
        b=DPEnqI0MZ29zxhtBelOg9MlXeJAER7dp1ItdS4snFcxalvt4azgxeH6J3Ed+FNy7WAkv4mkkYpMbgujRvI3EwdzSr50H/o/3eFjXG9WieoWF5ivFrUkM0zbnBtzWhorS69/kIcGd2wz4NXrV1DCstJQhWNn1hUHKkvfWbbHv08A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AGU8Z1UcTf0trbkx2L8OKe7T9CIyW56mvHzVs9qp5kuytgGdhINXSDC9aFbFoD93p8JyEHloUreS9alvzerl0NU/3bQbrGyLCAPWVLNvXmLgbF5Utigm/zi/TV8YqD/V2XYmdKAoGtgJ9NvExabz0q1DGjPwlzTukfgeR6pWP7U=
Received: by 10.150.69.3 with SMTP id r3mr4720039yba.108.1209846532674;
        Sat, 03 May 2008 13:28:52 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Sat, 3 May 2008 13:28:52 -0700 (PDT)
In-Reply-To: <7vmyn7tezi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81116>

On Sat, May 3, 2008 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Santi B=E9jar <sbejar@gmail.com> writes:

[...]

>
>  >  static int prepare_to_commit(const char *index_file, const char *=
prefix)
>  >  {
>  >       struct stat statbuf;
>  > @@ -448,6 +471,7 @@ static int prepare_to_commit(const char *index=
_file, const char *prefix)
>  >       const char *hook_arg2 =3D NULL;
>  >       const char *author_ident;
>  >       const char *committer_ident;
>  > +     int showed_ident =3D 0;
>  >
>  >       if (!no_verify && run_hook(index_file, "pre-commit", NULL))
>  >               return 0;
>  > @@ -528,6 +552,7 @@ static int prepare_to_commit(const char *index=
_file, const char *prefix)
>  >       strbuf_release(&sb);
>  >
>  >       determine_author_info();
>  > +     git_committer_info(0);
>
>  This call needs a comment to justify it, as it feels wrong to call a
>  function that usually is used for its return string and discard the =
return
>  value.

In the code or in the commit message.

/* To know if the committer ident is automatic */

I did it this way to have the knowledge about the automatic setting in
git_committer_info.

>
>
>  > @@ -558,11 +583,20 @@ static int prepare_to_commit(const char *ind=
ex_file, const char *prefix)
>  >                                        getenv("GIT_COMMITTER_EMAIL=
")));
>  >               if (strcmp(author_ident, committer_ident))
>  >                       fprintf(fp,
>  > -                             "#\n"
>  > -                             "# Author:    %s\n"
>  > -                             "#\n",
>  > +                             "%s"
>  > +                             "# Author:    %s\n",
>  > +                             showed_ident++ ? "" : "#\n",
>  >                               fmt_name(author_name, author_email))=
;
>
>  This part should have been [0/2] as it has been agreed it is a good =
idea.

Sorry, I should have said to this series was on top of:

[PATCHv2 2/3] commit: Show author if different from committer

I'll send a series with this include and the corrections.

Santi
