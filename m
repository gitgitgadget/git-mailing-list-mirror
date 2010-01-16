From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] rm: only refresh entries that we may touch
Date: Sat, 16 Jan 2010 17:58:41 +0700
Message-ID: <fcaeb9bf1001160258w476be063s595568afef088f42@mail.gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
	 <1263481341-28401-2-git-send-email-pclouds@gmail.com>
	 <7v8wbyiry4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 11:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW6Mm-0007Jb-3X
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 11:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab0APK6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 05:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358Ab0APK6n
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 05:58:43 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:65378 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab0APK6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 05:58:42 -0500
Received: by pxi12 with SMTP id 12so1639579pxi.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=83MCj6OBQk8sNvPpxOkFlB5NrJu+4CjPWMpOaxgfwAU=;
        b=NAuPG+JdgIQoKDo9/Y38RvEb8aSQGCtT+ouKkLrZExK4roYTsuJtwjDYg7PRXR6a08
         HZETtRE/Ia1y9hbUicoPk5gSHifpoA/pm6fmSY9S11cyvUPmt/z6YQ74qNSdiFcgiCQ+
         tiWidje+KKWJ6FPNwwB8sNMNPrqjs/3lM9OLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EVn6aBfn48yVJnbeeQ2j0fLba8qLdGYYjFnpYrNEOXWZDZQz+rH2arn5dyL0JBvM9/
         0oGY4PRfpXNO2rHOX/MV5BoUWe98MEAtqptilvXHIvPysGUtmPR8Q6jpxSwld3/YAnYj
         8VHVjM6AGmb00+lA3YzHXS0cDzJCuPAI5tsbs=
Received: by 10.115.38.40 with SMTP id q40mr2004865waj.95.1263639521486; Sat, 
	16 Jan 2010 02:58:41 -0800 (PST)
In-Reply-To: <7v8wbyiry4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137219>

On 1/16/10, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>  > diff --git a/builtin-rm.c b/builtin-rm.c
>  > index 57975db..4cac3d1 100644
>  > --- a/builtin-rm.c
>  > +++ b/builtin-rm.c
>  > @@ -169,7 +169,6 @@ int cmd_rm(int argc, const char **argv, const =
char *prefix)
>  >
>  >       if (read_cache() < 0)
>  >               die("index file corrupt");
>  > -     refresh_cache(REFRESH_QUIET);
>  >
>  >       pathspec =3D get_pathspec(prefix, argv);
>  >       seen =3D NULL;
>  > @@ -181,6 +180,7 @@ int cmd_rm(int argc, const char **argv, const =
char *prefix)
>  >               struct cache_entry *ce =3D active_cache[i];
>  >               if (!match_pathspec(pathspec, ce->name, ce_namelen(c=
e), 0, seen))
>  >                       continue;
>  > +             refresh_cache_entry(ce, 1);
>
>
> Why does this pass "1" instead of "0"?  The existing code does not gi=
ve
>  refresh_cache() REFRESH_REALLY bit, and a patch that is marked as a =
pure
>  optimization should pass 0.  If you really mean it, please spell it =
as
>  CE_MATCH_IGNORE_VALID and justify why it is a good change in a separ=
ate
>  patch.

"refresh_cache(REFRESH_QUIET);" does pass "0" indeed. Can you please
change it to "0"? Thanks.
--=20
Duy
