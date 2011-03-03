From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Wed, 2 Mar 2011 22:48:00 -0500
Message-ID: <AANLkTi=nFMDHR5WL=TiFmshFkxLMF9N4dNEjqw+r7wyh@mail.gmail.com>
References: <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net> <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net> <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
 <vpqmxlea7w1.fsf@bauges.imag.fr> <AANLkTi=UX7VNH+biFgn0FQawP-ttCjW2D7SMf2n6XB6w@mail.gmail.com>
 <20110301210852.GB21429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 04:48:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuzWg-0001VK-3N
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 04:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126Ab1CCDsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 22:48:23 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46052 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758133Ab1CCDsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 22:48:21 -0500
Received: by vxi39 with SMTP id 39so670867vxi.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 19:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=PTocsrPnygHDumfq4ZAbmw403bPg2agoQYeUeZHcKHo=;
        b=RiizDeLj5IkqTXYsc/KVGl0dW3sodFloGCn7mBzF//HP7qTWbrRYut5R0Ha2ytMmg4
         eYaeZndM/1+tW6Qo6xsmaWm6CiCcDfNNCj+R/Yotv3aWl027Bi91NO1XpUCyGnjl+Qpv
         MMn7ZkNjp4Bof+DwNtVMRO/yts8uZF/FIOVkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bOH1vCz+5qYOIMoavMaSTT/l/OVuL6r3dpODvcOtAK8Wyi6pSLlxXZwMGS/fSOrUea
         gqhpoLH9zriKtO1E42z5DOAyaH83JeS6hnvc0ovJ8o012B2pqvWyR399Z1b1Ja3dg1IN
         kpxEAWo+IKcKAwDidUlb8fpHCWVIlKDwsqZ34=
Received: by 10.220.5.129 with SMTP id 1mr151328vcv.169.1299124100217; Wed, 02
 Mar 2011 19:48:20 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Wed, 2 Mar 2011 19:48:00 -0800 (PST)
In-Reply-To: <20110301210852.GB21429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168370>

On Tue, Mar 1, 2011 at 4:08 PM, Jeff King <peff@peff.net> wrote:
>
> I think this is the cheap hack that you want:
>
> diff --git a/dir.c b/dir.c
> index 168dad6..fb6d306 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1236,6 +1236,29 @@ void setup_standard_excludes(struct dir_struct=
 *dir)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_excludes_from_file(dir, excludes_f=
ile);
> =A0}
>
> +static int rmdir_on_broken_cifs(const char *path)
> +{
> + =A0 =A0 =A0 struct stat sb;
> + =A0 =A0 =A0 if (stat(path, &sb) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Oh well, hopefully if we can't stat =
it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it is already gone or we don't hav=
e
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* permissions to screw it up anyway.=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rmdir(path);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (rmdir(path) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it worked, nothing to restore */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* maybe remove this conditional if you can trigger
> + =A0 =A0 =A0 =A0* the problem with other types of errors */
> + =A0 =A0 =A0 if (errno !=3D ENOTEMPTY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 if (chmod(path, sb.st_mode) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("we probably just screwed up th=
e permissions of %s",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path);
> + =A0 =A0 =A0 return -1;
> +}
> +
> =A0int remove_path(const char *name)
> =A0{
> =A0 =A0 =A0 =A0char *slash;
> @@ -1249,7 +1272,7 @@ int remove_path(const char *name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0slash =3D dirs + (slash - name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*slash =3D '\0';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (rmdir(dirs) =3D=3D 0 && (slash=
 =3D strrchr(dirs, '/')));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (rmdir_on_broken_cifs(dirs) =3D=
=3D 0 && (slash =3D strrchr(dirs, '/')));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(dirs);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
>
> Totally untested, of course. But hey, it compiles, so it must be good=
=2E
>
> -Peff
>

It seems to be working!  I've tried it with 'git rm' and when pulling
deletions.

I imagine that race condition can happen if files in the directory are
being modified while git does an rmdir?  If that's the case then I'm
not too worried.  There is only one other programmer that might be
working with me at the same time on an infrequently used directory.

Thank you everyone for the excellent help!

I modified the patch with some extra paranoia and replaced the other
rmdir instance in that file:

diff -crB git-1.7.3.4/dir.c git-1.7.3.4-new/dir.c
*** git-1.7.3.4/dir.c	Wed Mar  2 13:00:54 2011
--- git-1.7.3.4-new/dir.c	Wed Mar  2 14:25:10 2011
***************
*** 994,999 ****
--- 994,1022 ----
  	return ret;
  }

+ static int rmdir_on_broken_cifs(const char *path)
+ {
+        struct stat sb;
+        if (stat(path, &sb) < 0) {
+                /* Oh well, hopefully if we can't stat it
+                 * it is already gone or we don't have
+                 * permissions to screw it up anyway. */
+                return rmdir(path);
+        }
+        if (rmdir(path) =3D=3D 0) {
+                /* it worked, nothing to restore */
+                return 0;
+        }
+        /* maybe remove this conditional if you can trigger
+         * the problem with other types of errors */
+        if (errno !=3D ENOTEMPTY)
+                return -1;
+        if (chmod(path, sb.st_mode) < 0)
+                warning("we probably just screwed up the permissions o=
f %s",
+                        path);
+        return -1;
+ }
+
  int remove_dir_recursively(struct strbuf *path, int flag)
  {
  	DIR *dir;
***************
*** 1037,1043 ****

  	strbuf_setlen(path, original_len);
  	if (!ret)
! 		ret =3D rmdir(path->buf);
  	return ret;
  }

--- 1060,1066 ----

  	strbuf_setlen(path, original_len);
  	if (!ret)
! 		ret =3D rmdir_on_broken_cifs(path->buf);
  	return ret;
  }

***************
*** 1066,1072 ****
  		slash =3D dirs + (slash - name);
  		do {
  			*slash =3D '\0';
! 		} while (rmdir(dirs) =3D=3D 0 && (slash =3D strrchr(dirs, '/')));
  		free(dirs);
  	}
  	return 0;
--- 1090,1096 ----
  		slash =3D dirs + (slash - name);
  		do {
  			*slash =3D '\0';
! 		} while (rmdir_on_broken_cifs(dirs) =3D=3D 0 && (slash =3D strrchr(=
dirs, '/')));
  		free(dirs);
  	}
  	return 0;
